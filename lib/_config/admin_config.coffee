@AdminConfig =
	name: Config.name
	collections:
		Pdfs:
			color: 'red'
			icon: 'file-pdf-o'
			extraFields: ['owner','file']
			tableColumns: [
				{label: 'Name', name: 'name'}
				{label: 'File Name', name: 'pdfFileName()', template: 'adminPdfFile'}
				{label: 'User', name: 'author()', template: 'adminUserCell'}
			]
			children: [
				{
					find: () ->
						FormFields.find()
				}
				{
					find: () ->
						Attachments.find()
				}
			]
			templates:
				new:
					name: 'adminPdfsNew'
				edit:
					name: 'adminPdfsEdit'
		FormFields:
			color: 'green'
			icon: 'pencil-square-o'
			extraFields: ['owner']
			tableColumns: [
				{label: 'Name', name: 'name'}
				{label: 'User', name: 'author()', template: 'adminUserCell'}
			]
		Presets:
			color: 'yellow'
			icon: 'bars'
			extraFields: ['owner']
			tableColumns: [
				{label: 'Name', name: 'name'}
				{label: 'User', name: 'author()', template: 'adminUserCell'}
			]
			children: [
				{
					find: () ->
						Pdfs.find()
				}
			]
	dashboard:
		homeUrl: '/dashboard'
	autoForm:
		omitFields: ['createdAt', 'updatedAt']
