Template.dashboard.events({
  'click #generate-zip': function(event, template) {
    event.preventDefault();
    var pdf_ids='';
    template.$('.toggle-checked').each(function() {
      if (this.type=="checkbox" && this.checked==true) {
        if (pdf_ids == '') {
          pdf_ids=this.id;
        } else {
          pdf_ids+='&&&'+this.id;
        }
      }
    });

    var fieldsVal='';
    template.$('.form-control').each(function() {
      if (this.type=="text" && this.value!="") {
        let val = this.id + ':::'+ this.value
        fieldsVal+=(fieldsVal==''?val:'&&&'+val)
      }
    })

    if (pdf_ids != '') {
      let routeVal = btoa(pdf_ids+'+++'+fieldsVal);
      Router.go('/generate-zip/'+routeVal);
    } else {
      sAlert.error("Empty selection: Please select at least one PDF to generate the zip!");
    }
  }
});

Template.presets.events({
  "click .default-selection": function(e, t) {
     return Session.set("preset", null);
  }
})

Template.preset.events({
  "click .preset-selection": function(e, t) {
    return Session.set("preset", this._id);
  }
});

Template.pdfs.helpers({
  pdfs: function() {
    var presetFilter = Session.get("preset")
    var output = []
    if (presetFilter == null) {
      output = Pdfs.find({},{sort: {name: 1}}).fetch()
    } else {
      var preset = Presets.findOne(presetFilter)
      var ids = R.pluck('pdf')(preset.pdfs)
      output = Pdfs.find({_id: {$in: ids}},{sort: {name: 1}}).fetch()
      output.forEach( function(v, i, a) {
        v.checkedByDefault = R.find(R.propEq('pdf', v._id))(preset.pdfs).checkedByDefault;
      })
    }
    return output
  }
});
