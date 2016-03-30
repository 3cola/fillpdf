if(Meteor.isServer){
  Meteor.startup(function(){
    var toKeep = R.uniq(Pdfs.find().map(function(v, i, a){return v.file}))
    console.log("Removing orphans attachments... This will be kept: "+toKeep);
    Attachments.remove({_id: {$nin: toKeep}})
  });
}
