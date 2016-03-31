/*TODO: Refactoring*/
Router.route('/generate-zip/:_b64routeVal', function () {
  parseB64Route = function(b64routeVal) {
    var atob = Npm.require('atob')
    var routeVal = atob(b64routeVal)
    var parms = routeVal.split('+++')
    var ids = parms[0].split('&&&')
    var formFields = parms[1].split('&&&')
    var formData = {}
    formFields.forEach(function (item,index,array) {
      var formField = item.split(':::')
      var formName = formField[0]
      var formValue = formField[1]
      formData[formName]=formValue
    })
    return [ids, formData]
  }
  mapFields = function (fields) {
    var result = {}
    var offValues = [ "FALSE", "OFF", "NO"]
    fields.map(function(x){
      if (x.mapped_to) {
        var formField = FormFields.findOne({_id:x.mapped_to})
        var toAssign = formData[formField.name]
        if (x.type == 'Button') {
          if (offValues.indexOf(toAssign.toUpperCase()) == -1)
            toAssign = "Off"
          else toAssign = "Yes"
        }
        result[x.name]=(toAssign==undefined?"":toAssign)
      }
    })
    return result
  }
  cleanUpTempFileArray = function(tempFileArray) {
    tempFileArray.map(function (v, i, a) {
      fs.unlinkSync(v)
    })
  }

  var self = this
  var zip = new JSZip()
  var fs = Npm.require('fs')
  var fdf = Npm.require('fdf')
  var pdfs_path = process.env.PWD + '/.meteor/local/cfs/files/attachments/'

  var parseResult = parseB64Route(this.params._b64routeVal)
  var ids = parseResult[0]
  var formData = parseResult[1]
  var tempFDF = []
  var tempPDF = []

  ids.forEach( function (v, i, a) {
    var pdf = Pdfs.findOne(v)
    if (pdf != undefined) {
      var mappedFields = mapFields(pdf.fields)
      var fdfData = fdf.generate(mappedFields)
      tempFDF[i] = pdfs_path + 'data' + (new Date().getTime()) + ".fdf"
      var pdf_attachment = Attachments.findOne({_id: pdf.file})
      var pdf_file = pdfs_path + pdf_attachment.copies.attachments.key
      tempPDF[i] = pdfs_path + pdf_attachment.original.name + '_'+ (new Date().getTime()) + ".pdf"

      fs.writeFileSync( tempFDF[i], fdfData)

      PDFTK.execute([pdf_file, 'fillform', tempFDF[i], 'output', tempPDF[i]], function(err, res) {
        if (err) console.log("error: "+err)

        zip.file(pdf_attachment.original.name, fs.readFileSync(tempPDF[i]))

        //if this is the last pdf to generate
        if (i == a.length - 1) {
          // Generate zip stream
          var output = zip.generate({
            type:        "nodebuffer",
            compression: "DEFLATE"
          })
          // Set headers
          self.response.setHeader("Content-Type", "application/octet-stream")
          self.response.setHeader("Content-disposition", "attachment; filename=fillpdf.zip")
          self.response.writeHead(200)
          // Send content
          self.response.end(output)

          //clean up
          cleanUpTempFileArray(tempFDF)
          cleanUpTempFileArray(tempPDF)
        }
      })
    }
  })
}, {where: 'server'})
