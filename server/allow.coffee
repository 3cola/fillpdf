FormFields.allow
	insert: (userId, doc) ->
		Roles.userIsInRole( userId, 'admin')
	update: (userId, doc, fields, modifier) ->
		Roles.userIsInRole( userId, 'admin')
	remove: (userId, doc) ->
		Roles.userIsInRole( userId, 'admin')

Pdfs.allow
	insert: (userId, doc) ->
		Roles.userIsInRole( userId, 'admin')
	update: (userId, doc, fields, modifier) ->
		Roles.userIsInRole( userId, 'admin')
	remove: (userId, doc) ->
		Roles.userIsInRole( userId, 'admin')

Attachments.allow
	insert: (userId, doc) ->
		Roles.userIsInRole( userId, 'admin')
	update: (userId, doc, fieldNames, modifier) ->
		Roles.userIsInRole( userId, 'admin')
	download: (userId)->
		Roles.userIsInRole( userId, 'admin')

Meteor.users.allow
	update: (userId, doc, fieldNames, modifier) ->
		if userId == doc._id and not doc.username and fieldNames.length == 1 and fieldNames[0] == 'username'
			true
		else
			false
