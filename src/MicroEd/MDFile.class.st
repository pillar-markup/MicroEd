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
		  fileReference: aFileReference;
		  yourself
]

{ #category : 'add' }
MDFile >> addMetaDataElements [

	| root newDoc |
	self fileReference ensureCreateFile.
	root := MicrodownParser parse: self fileReference contents.

	root hasMetaDataElement
		ifFalse: [
"pay attention MD is line based. so the } should be on another line."
			newDoc := MicrodownParser parse: '{ 
"author" : "addos" 
}'.
			root addChild: newDoc children first. 
			"yes the metadata element in the first one.
			The API of Microdown could be better."
			root metaDataElement
				atKey: 'author' 
				put: 'toto for now';
				
				atKey: 'title' 
				put: self title;
				
				atKey: 'lastModificationDate'
				put: self fileReference modificationTime asDate yyyymmdd ]
		ifTrue: [
			root metaDataElement
				atKey: 'lastModificationDate'
				put: self fileReference modificationTime asDate yyyymmdd ].

	self writeFileContentsOf: root
]

{ #category : 'accessing' }
MDFile >> contents [

	^ self fileReference contents
]

{ #category : 'accessing' }
MDFile >> contents: aContent [

	self fileReference writeStreamDo: [ :stream | stream nextPutAll: aContent ]
]

{ #category : 'testing' }
MDFile >> exists [

	^ self fileReference exists
]

{ #category : 'accessing' }
MDFile >> extension [

	^ self fileReference extension
]

{ #category : 'accessing' }
MDFile >> fileName [

	^ fileName ifNil: [ fileName := fileNamer newNameBasedOn: self title ]
]

{ #category : 'accessing' }
MDFile >> fileNamer [

	^ fileNamer
]

{ #category : 'accessing' }
MDFile >> fileNamer: anISOFileNamer [ 
	fileNamer := anISOFileNamer
]

{ #category : 'accessing' }
MDFile >> fileReference [

	^ fileReference ifNil: [
		  fileReference := FileSystem workingDirectory / self fileName ]
]

{ #category : 'accessing' }
MDFile >> fileReference: aFileReference [

	fileReference := aFileReference.
	fileName := aFileReference basenameWithoutExtension. 
]

{ #category : 'testing' }
MDFile >> hasFile [

	"pay attention should not use the lazy accessor."
	
	^ fileReference isNotNil
]

{ #category : 'testing' }
MDFile >> hasTitle [

	^ title isNotNil
]

{ #category : 'initialization' }
MDFile >> initialize [

	super initialize.
	fileNamer := ISOFileNamer new. 
]

{ #category : 'saving' }
MDFile >> save: aString [

	self fileReference writeStreamDo: [ :str | str nextPutAll: aString ]
]

{ #category : 'accessing' }
MDFile >> title [

	^ title ifNil: [ title := fileNamer defaultEmptyName ]
]

{ #category : 'accessing' }
MDFile >> title: aString [

	title := fileNamer curateString: aString
]

{ #category : 'add' }
MDFile >> writeFileContentsOf: aRoot [

	| visitor |
	visitor := MicTextualMicrodownExporter new.
	visitor visit: aRoot.
	fileReference writeStreamDo: [ :stream |
		stream nextPutAll: visitor contents ]
]
