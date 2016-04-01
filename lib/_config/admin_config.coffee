@AdminConfig =
	name: Config.name
	collections:
		Pdfs:
			color: 'red'
			icon: 'pencil'
			extraFields: ['owner']
			tableColumns: [
				{label: 'Name', name: 'name'}
				{label: 'File', name: 'file'}
				{label: 'User', name: 'author()', template: 'adminUserCell'}
			]
			children: [
				{
					find: () ->
						FormFields.find()
				}
			]
		FormFields:
			color: 'green'
			icon: 'pencil'
			extraFields: ['owner']
			tableColumns: [
				{label: 'Name', name: 'name'}
				{label: 'User', name: 'author()', template: 'adminUserCell'}
			]
	dashboard:
		homeUrl: '/dashboard'
	autoForm:
		omitFields: ['createdAt', 'updatedAt']
