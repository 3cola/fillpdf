Router.map ->
  @route "home",
    path: "/"
    layoutTemplate: "homeLayout"

  @route "dashboard",
    path: "/dashboard"
    waitOn: ->
      [
        subs.subscribe 'pdfs'
        subs.subscribe 'formFields'
      ]
    data: ->
      pdfs: Pdfs.find({},{sort: {name: 1}}).fetch()
      formFields: FormFields.find({},{sort: {name: 1}}).fetch()
