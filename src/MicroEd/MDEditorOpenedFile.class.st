"
I am an editor file that has a filesystem counterpart. 
"
Class {
	#name : 'MDEditorOpenedFile',
	#superclass : 'MDEditorFile',
	#category : 'MicroEd',
	#package : 'MicroEd'
}

{ #category : 'instance creation' }
MDEditorOpenedFile class >> newFromNote: aNTNoteObject [ 
	"Read and set note contents using aNTNoteObject title name as file name"
	
	| fileReference |
	fileReference := (aNTNoteObject title , self fileExtension) asFileReference.
	fileReference exists
		ifFalse: [ ^ self error: fileReference fullName , 'does not exists' ].
	aNTNoteObject contents: fileReference contents.
	^ self new
		file: 	fileReference;
		yourself
]

{ #category : 'accessing' }
MDEditorOpenedFile >> basename [

	^ self file basename
]

{ #category : 'accessing' }
MDEditorOpenedFile >> fullName [

	^ self file fullName
]

{ #category : 'testing' }
MDEditorOpenedFile >> isNew [

	^ false
]

{ #category : 'action' }
MDEditorOpenedFile >> save: aText withExtension: anExtension [

	self file writeStreamDo: [ :str | 
		str
			nextPutAll: aText text asString;
			truncate: aText text asString size ].
	self file extension = anExtension asString ifFalse: [ 
		self file renameTo:
			self file withoutExtension basename , '.' , anExtension asString ].
	^ self
]
