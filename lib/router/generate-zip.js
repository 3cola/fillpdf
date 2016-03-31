Router.route('/generate-zip/:_b64routeVal', function () {
  var self = this
  var atob = Npm.require('atob')
  console.log("_b64routeVal: "+this.params._b64routeVal);

  var routeVal = atob(this.params._b64routeVal)
  console.log("routeVal: "+routeVal);

  var parms = routeVal.split('+++')
  var ids = parms[0].split('&&&');
  console.log("ids: "+ids);

  var formFields = parms[1].split('&&&')
  console.log("formFields: "+formFields);

  var formData = {}
  formFields.forEach(function (item,index,array) {
    var formField = item.split(':::')
    var formName = formField[0]
    var formValue = formField[1]
    formData[formName]=formValue
    })
  console.log("formData: "+JSON.stringify(formData));

  var zip = new JSZip();
  var fs = Npm.require('fs');
  var fdf = Npm.require('fdf');
  var pdfs_path = process.env.PWD + '/.meteor/local/cfs/files/attachments/';

  console.log("01");

  ids.forEach( function (v, i, a) {
    var res = Pdfs.findOne(v);
    if (res != undefined) {
      console.log("res: "+JSON.stringify(res));
      var fields = res.fields
      var result = {}
      res.fields.map(function(x){
        if (x.mapped_to) {
          var formField = FormFields.findOne({_id:x.mapped_to});
          result[x.name]=formData[formField.name]
        }
      })
      console.log("result: "+JSON.stringify(result));

      var fdfData = fdf.generate(result)
      var tempFDF = pdfs_path + 'data' + (new Date().getTime()) + ".fdf";
      console.log("tempFDF: "+tempFDF);

      var pdf_attachment = Attachments.findOne({_id:res.file});
      var pdf_file = pdfs_path + pdf_attachment.copies.attachments.key;
      console.log("pdf_file: "+pdf_file);
      var tempPDF = pdfs_path + pdf_attachment.original.name + '_'+ (new Date().getTime()) + ".pdf";

      fs.writeFileSync( tempFDF, fdfData)
      console.log("1"+i);

      PDFTK.execute([pdf_file, 'fillform', tempFDF, 'output', tempPDF], function(err2, res2) {
        if (err2) console.log("error: "+err2);
        console.log("res2: "+res2.toString());

        console.log("2"+i);

        zip.file(pdf_attachment.original.name, fs.readFileSync(tempPDF))

        console.log("3"+i);

        if (i == a.length - 1) {
          console.log("40");

          // Generate zip stream
          var output = zip.generate({
            type:        "nodebuffer",
            compression: "DEFLATE"
          })

          // Set headers
          self.response.setHeader("Content-Type", "application/octet-stream");
          self.response.setHeader("Content-disposition", "attachment; filename=pdfs.zip");
          self.response.writeHead(200);

          // Send content
          self.response.end(output);
        }
      })
    }
  });
}, {where: 'server'});
