@Pdfs = new Meteor.Collection('pdfs');

Schemas.Field = new SimpleSchema
	name:
		type: String
		optional: true

	type:
		type: String
		optional: true

	mapped_to:
		type: String
		regEx: SimpleSchema.RegEx.Id
		optional: true
		autoform:
			options: ->
				_.map FormFields.find().fetch(), (ff)->
					label: ff.name
					value: ff._id


Schemas.Pdfs = new SimpleSchema
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

Pdfs.after.insert (userId, doc) ->
	Meteor.call "setPdfFields", doc, (error, result) ->
		if error
			console.log "error", error

Pdfs.before.update (userId, doc, fieldNames, modifier, options) ->
	console.log "userId: "+userId
	console.log "doc: "+JSON.stringify(doc)
	console.log "fieldNames: "+JSON.stringify(fieldNames)
	console.log "modifier: "+JSON.stringify(modifier)
	console.log "options: "+JSON.stringify(options)
