@Presets = new Meteor.Collection('presets');

Schemas.Pdf_elem = new SimpleSchema
	pdf:
		type: String
		regEx: SimpleSchema.RegEx.Id
		optional: true
		autoform:
			options: ->
				_.map Pdfs.find().fetch(), (p)->
					label: p.name
					value: p._id

	checkedByDefault:
		type: Boolean
		optional: true


Schemas.Presets = new SimpleSchema
	name:
		type:String
		max: 60

	createdAt:
		type: Date
		autoValue: ->
			if this.isInsert
				new Date()

	updatedAt:
		type:Date
		optional:true
		autoValue: ->
			if this.isUpdate
				new Date()

	owner:
		type: String
		regEx: SimpleSchema.RegEx.Id
		autoValue: ->
			if this.isInsert
				Meteor.userId()
		autoform:
			options: ->
				_.map Meteor.users.find().fetch(), (user)->
					label: user.emails[0].address
					value: user._id

	pdfs:
		type: Array
		optional: true

	'pdfs.$':
		type: Schemas.Pdf_elem

Presets.attachSchema(Schemas.Presets)

Presets.helpers
	author: ->
		user = Meteor.users.findOne(@owner)
		if user?.profile?.firstName? and user?.profile?.lastName
			user.profile.firstName + ' ' + user.profile.lastName
		else
			user?.emails?[0].address
