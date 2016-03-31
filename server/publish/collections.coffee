# You'll want to replace these functions. They publish the whole
# collection which is problematic after your app grows

# Meteor.publish 'posts', ->
# 	Posts.find()

Meteor.publish 'attachments', ->
	Attachments.find()

Meteor.publish 'user', ->
  Meteor.users.find _id: @userId

Meteor.publish 'formFields', ->
	FormFields.find()

Meteor.publish 'pdfs', ->
	Pdfs.find()
