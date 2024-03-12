"
I am an editor ""potential"" file, i.e. a file that actually still wasn't written to filesystem. 
"
Class {
	#name : 'MDEditorNewFile',
	#superclass : 'MDEditorFile',
	#category : 'MicroEd',
	#package : 'MicroEd'
}

{ #category : 'accessing' }
MDEditorNewFile >> basename [

	^ 'newFile'
]

{ #category : 'accessing' }
MDEditorNewFile >> fullName [

	^ 'New File has no fullname'
]

{ #category : 'testing' }
MDEditorNewFile >> isNew [

	^ true
]

{ #category : 'action' }
MDEditorNewFile >> save: aText withExtension: anExtension [

	file := StSaveFilePresenter new
		title: 'Save Microdown document';
		nameText: 'mydocument.' , anExtension asString;
		extensions: { anExtension }; 
		openModal.
	file ifNotNil: [ 
		^ MDEditorOpenedFile new
			  file: file;
			  save: aText withExtension: anExtension;
			  yourself ].
	^ self
]
