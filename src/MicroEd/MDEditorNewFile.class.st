"
I am an editor ""potential"" file, i.e. a file that actually still wasn't written to filesystem. 
"
Class {
	#name : 'MDEditorNewFile',
	#superclass : 'MDEditorFile',
	#category : 'MicroEd',
	#package : 'MicroEd'
}

{ #category : 'instance creation' }
MDEditorNewFile class >> newFromNote: aNTNoteObject [ 
	"Answer a new <FileReference> using aNTNoteObject"
	
	| fileReference |
	fileReference := (aNTNoteObject title , self fileExtension) asFileReference.
	fileReference writeStreamDo: [ : writeStream |
		writeStream 	<< aNTNoteObject contents ].
	^ self new
		file: 	fileReference;
		yourself
]

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
