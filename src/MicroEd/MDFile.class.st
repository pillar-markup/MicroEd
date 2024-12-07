"
I'm a kind of file description.
- I have title which is only alphanumeric.
- I use a file namer that creates a file name from the title.
- I have metadata about the file
	- creation date
	- modification date 
"
Class {
	#name : 'MDFile',
	#superclass : 'Object',
	#instVars : [
		'fileReference',
		'nameOfFileReferenceBeforeSaved',
		'fileNamer',
		'title',
		'fileName'
	],
	#category : 'MicroEd',
	#package : 'MicroEd'
}

{ #category : 'instance creation' }
MDFile class >> newFromFileReference: aFileReference [ 
	
	^ self new
		initializeWithFileReference: aFileReference;
		yourself
]

{ #category : 'add' }
MDFile >> addMetaDataElements [

	| root |
	root := MicrodownParser parse: fileReference contents.

	root hasMetaDataElement
		ifFalse: [
			root := MicrodownParser parse: '{ "author" : "addos" }'.
			root metaDataElement
				atKey: 'author' put: (fileReference entry reference path at: 3);
				atKey: 'title' put: nameOfFileReferenceBeforeSaved;
				atKey: 'lastModificationDate'
				put: fileReference modificationTime asDate yyyymmdd ]
		ifTrue: [
			root metaDataElement
				atKey: 'lastModificationDate'
				put: fileReference modificationTime asDate yyyymmdd ].

	self writeFileContentsOf: root
]

{ #category : 'accessing' }
MDFile >> basename [
	"Answer a String representing the receiver's file name"

	| dateCreationOfFileReference |
	fileReference ifNil: [
		nameOfFileReferenceBeforeSaved := 'Untitled'.
		^ nameOfFileReferenceBeforeSaved ].
	
	nameOfFileReferenceBeforeSaved := fileReference basename.
	dateCreationOfFileReference := Date today yyyymmdd.
	(fileReference basename includesSubstring: dateCreationOfFileReference) 
		ifFalse: [ ^ dateCreationOfFileReference , '_' , fileReference basename ].
	^ fileReference basename
]

{ #category : 'accessing' }
MDFile >> contents [

	^ fileReference contents  
]

{ #category : 'accessing' }
MDFile >> contents: aContent [

	fileReference writeStreamDo: [ :stream |
		stream nextPutAll: aContent ]
]

{ #category : 'accessing' }
MDFile >> curateString: aString [

	^ aString select: [ :each | each isAlphaNumeric ]
]

{ #category : 'testing' }
MDFile >> exists [

	^ fileReference exists
]

{ #category : 'accessing' }
MDFile >> extension [

	^ fileReference extension
]

{ #category : 'accessing' }
MDFile >> fileName [

	^ fileName ifNil: [ fileName := fileNamer newNameBasedOn: self title ]
]

{ #category : 'accessing' }
MDFile >> fileNamer: anISOFileNamer [ 
	fileNamer := anISOFileNamer
]

{ #category : 'accessing' }
MDFile >> fileReference [ 

	^ fileReference ifNil: [ fileReference := 'unnamed.md' asFileReference ]
]

{ #category : 'accessing' }
MDFile >> fileReference: aFileReference [

	fileReference := aFileReference
]

{ #category : 'testing' }
MDFile >> hasFile [ 

	^ fileReference isNotNil 
]

{ #category : 'initialization' }
MDFile >> initialize [

	super initialize.
	fileNamer := ISOFileNamer new. 
]

{ #category : 'initialization' }
MDFile >> initializeWithFileReference: aFileReference [
	"Add a file reference in the MDFile"

	| newFileReference |
	aFileReference ensureCreateFile.
	fileReference := aFileReference.
	"Create of a new file reference which has the ISO format with the default extension: 'md' "
	newFileReference := fileReference extension isEmptyOrNil
		                    ifTrue: [ (self basename , '.md') ]
		                    ifFalse: [ self basename ].
	aFileReference delete.

	fileReference := newFileReference asFileReference. 
	fileReference ensureCreateFile. 
]

{ #category : 'saving' }
MDFile >> save: aString [

	fileReference writeStreamDo: [ :str | 
		str nextPutAll: aString ]
	
		

]

{ #category : 'accessing' }
MDFile >> title [

	^ title ifNil: [ title := fileNamer defaultEmptyName ]
]

{ #category : 'accessing' }
MDFile >> title: aString [

	title := self curateString: aString
]

{ #category : 'add' }
MDFile >> writeFileContentsOf: aRoot [

	| visitor |
	visitor := MicTextualMicrodownExporter new.
	visitor visit: aRoot.
	fileReference writeStreamDo: [ :stream |
		stream nextPutAll: visitor contents ]
]
