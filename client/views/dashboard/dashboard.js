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
    console.log("pdf_ids: "+pdf_ids);

    var fieldsVal='';
    template.$('.form-control').each(function() {
      if (this.type=="text" && this.value!="") {
        let val = this.id + ':::'+ this.value
        fieldsVal+=(fieldsVal==''?val:'&&&'+val)
      }
    })
    console.log("fieldsVal: "+fieldsVal);


    if (pdf_ids != '') {
      let routeVal = btoa(pdf_ids+'+++'+fieldsVal);
      console.log("routeVal: "+routeVal);

      Router.go('/generate-zip/'+routeVal);
    } else {
      sAlert.error("Empty selection: Please select at least one PDF to generate the zip!");
    }
  }
});
