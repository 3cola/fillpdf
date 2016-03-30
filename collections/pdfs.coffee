@Pdfs = new Meteor.Collection('pdfs');

Schemas.Field = new SimpleSchema
	name:
		type: String
		optional: true

	mapped_to:
		type: String
		optional: true

Schemas.Pdfs = new SimpleSchema
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

	file:
		type: String
		autoform:
			afFieldInput:
				type: 'fileUpload'
				collection: 'Attachments'

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

	fields:
		type: Array
		optional: true

	'fields.$':
		type: Schemas.Field

Pdfs.attachSchema(Schemas.Pdfs)

Pdfs.helpers
	author: ->
		user = Meteor.users.findOne(@owner)
		if user?.profile?.firstName? and user?.profile?.lastName
			user.profile.firstName + ' ' + user.profile.lastName
		else
			user?.emails?[0].address
