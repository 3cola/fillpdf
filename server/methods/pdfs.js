if(Meteor.isServer){
  Meteor.methods({
    removePdfFields:function(doc){
      check(doc, Object)
      if (Roles.userIsInRole( Meteor.userId(), 'admin')) {
        Pdfs.update({_id: doc._id}, {$unset: {fields: ""}})
      }
    },
    setPdfFields:function(doc){
      check(doc, Object);
      if (Roles.userIsInRole( Meteor.userId(), 'admin')) {
	      var pdfs_path = (process.env.NODE_ENV=='production'?'':process.env.PWD+'/.meteor/local')+'/cfs/files/attachments/' 
        var sourcePDF = pdfs_path + Attachments.findOne(doc.file).copies.attachments.key
        var formObj = Array()
        var fieldObj = {}
        PDFTK.execute([sourcePDF, 'dump_data_fields_utf8'], function(err, res) {
          if (err) throw err;
          var fields = res.toString().split('---').slice(1)
          fields.forEach(function(field){
            fieldObj = {};
            fieldObj['name'] = field.match(/FieldName:([A-Za-z_\t .]+)/)[1].trim();
            fieldObj['type'] = field.match(/FieldType:([A-Za-z\t .]+)/)[1].trim();
            fieldObj['mapped_to'] = '';
            formObj.push(fieldObj);
          });
          Pdfs.update({_id:doc._id}, {$set:{
            fields: formObj
          }});
        });
      }
    }
  });
}
