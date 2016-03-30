@Attachments = new FS.Collection("Attachments",
	stores: [
		new FS.Store.GridFS("attachments")
	]
	filter:
		allow:
			extensions: [
				'pdf'
				'PDF'
			]
		onInvalid: (msg) ->
			if Meteor.isClient
				sAlert.error("Invalid file extension: "+msg)
			else
				console.log "message"+msg
)
