"
I am the status of an editor respect to it's document.

My subclasses distinguish between a **new** text file and an existing **opened** text file.
"
Class {
	#name : 'MDEditorFile',
	#superclass : 'Object',
	#instVars : [
		'file'
	],
	#category : 'MicroEd',
	#package : 'MicroEd'
}

{ #category : 'accessing' }
MDEditorFile >> basename [

	self subclassResponsibility
]

{ #category : 'accessing' }
MDEditorFile >> file [

	^ file
]

{ #category : 'accessing' }
MDEditorFile >> file: aFile [

	file := aFile
]

{ #category : 'accessing' }
MDEditorFile >> fullName [

	self subclassResponsibility
]

{ #category : 'testing' }
MDEditorFile >> isNew [

	self subclassResponsibility
]

{ #category : 'action' }
MDEditorFile >> save: aText withExtension: anExtension [

	file := StSaveFilePresenter new
		title: 'Save Microdown document';
		nameText: 'mydocument.' , anExtension asString;
		extensions: { anExtension }; 
		openModal.
	^ file ifNotNil: [ 
		(MDFile newFromFileReference: file)
			save: aText withExtension: anExtension;
			yourself ]
		ifNil: [ MDFile new ]
]
