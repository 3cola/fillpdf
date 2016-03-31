@FormFields = new Meteor.Collection('formFields')

Schemas.FormFields = new SimpleSchema
	name:
		type:String
		index: 1
		unique: true
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

FormFields.attachSchema(Schemas.FormFields)

FormFields.helpers
	author: ->
		user = Meteor.users.findOne(@owner)
		if user?.profile?.firstName? and user?.profile?.lastName
			user.profile.firstName + ' ' + user.profile.lastName
		else
			user?.emails?[0].address
