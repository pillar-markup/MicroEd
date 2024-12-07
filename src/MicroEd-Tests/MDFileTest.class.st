Class {
	#name : 'MDFileTest',
	#superclass : 'TestCase',
	#instVars : [
		'memoryFS',
		'fileExample',
		'toDelete',
		'fileReferenceWithName',
		'mdfile',
		'parser'
	],
	#category : 'MicroEd-Tests',
	#package : 'MicroEd-Tests'
}

{ #category : 'running' }
MDFileTest >> setUp [

	super setUp.
	memoryFS := FileSystem memory.
	toDelete := OrderedCollection new.
	mdfile := MDFile new.
	
	fileExample := memoryFS / 'example.md'.

	toDelete add: fileExample.
	
	fileExample writeStreamDo: [ :stream |
		stream nextPutAll: 'example file' ].
	
	fileReferenceWithName := (memoryFS / 'anotherFile.md')	ensureCreateFile.
	
	parser := MicrodownParser new
]

{ #category : 'running' }
MDFileTest >> tearDown [ 

	toDelete
		select: [ :path | memoryFS exists: path ]
		thenDo: [ :path | path ensureDelete ].
	super tearDown
]

{ #category : 'tests - contents' }
MDFileTest >> testContentsIsSaved [

	self assert: fileExample contents equals: 'example file'.

	self
		assert: (memoryFS / 'example.md') contents
		equals: 'example file'
]

{ #category : 'tests' }
MDFileTest >> testMDFileCreationWithExistingFile [

	mdfile initializeWithFileReference: fileExample.
	self assert: mdfile hasFile.
	
]

{ #category : 'tests' }
MDFileTest >> testMDFileCreationWithoutExistingFile [

	| fileWithoutFileReference |
	fileWithoutFileReference := MDFile new.
	self assert: fileWithoutFileReference hasFile not.
]

{ #category : 'tests' }
MDFileTest >> testMDFileExistingFileWithName [

	
	| fileReferenceWithoutName |
	
	fileReferenceWithoutName := (memoryFS / 'name.md') ensureCreateFile.
	toDelete add: fileReferenceWithoutName. 
	mdfile initializeWithFileReference: fileReferenceWithoutName.
	self assert: (mdfile basename endsWith: 'name.md'). 

	
]

{ #category : 'tests' }
MDFileTest >> testMDFileExistingFileWithoutName [

	| file fileReferenceWithoutName |
 	
	fileReferenceWithoutName := (memoryFS / '.md') ensureCreateFile.
	toDelete add: fileReferenceWithoutName. 
	file := MDFile new.
	file initializeWithFileReference: fileReferenceWithoutName.
	self denyEmpty: file basename. 
	
]

{ #category : 'tests' }
MDFileTest >> testMDFileHasFileReferenceAddMetaData [

	| root file |
	
	file := memoryFS / 'test2'.
	file ensureCreateFile. 
	mdfile initializeWithFileReference: file. 
	mdfile addMetaDataElements. 
	
	root := MicrodownParser parse: mdfile contents.
	self assert: root hasMetaDataElement.
	
	
]

{ #category : 'tests' }
MDFileTest >> testMDFileHasFileReferenceHasMetaData [

	| root file |
	
	file := memoryFS / 'test2'.
	file ensureCreateFile. 
	mdfile initializeWithFileReference: file. 
	root := MicrodownParser parse: mdfile fileReference contents.
	mdfile addMetaDataElements. 
	
	root := MicrodownParser parse: mdfile contents.
	self assert: root hasMetaDataElement.
	
	mdfile fileReference delete. 
	
	
]

{ #category : 'tests' }
MDFileTest >> testMDFileHasFileReferenceHasNotMetaData [

	| root file |
	
	file := memoryFS / 'test3'.
	file ensureCreateFile. 
	mdfile initializeWithFileReference: file. 
	root := MicrodownParser parse: mdfile contents.
	self deny: root hasMetaDataElement.
	
	
]

{ #category : 'tests' }
MDFileTest >> testMDFileHasFileReferenceWithFormatISO [
	
	| file date |
	file := MDFile newFromFileReference: fileReferenceWithName. 
	date := Date today yyyymmdd.
	self assert: (file basename includesSubstring: date).
	self deny: fileReferenceWithName exists
]

{ #category : 'tests' }
MDFileTest >> testMDFileUnderstandFile [

	mdfile initializeWithFileReference: fileExample.
	self assert: mdfile fileReference class equals: FileReference.
	
]

{ #category : 'tests - contents' }
MDFileTest >> testMDFileWithAEmptyTitle [

	| md |
	md := MDFile new.
	self assert: md title equals: 'unnamed'
]

{ #category : 'tests - contents' }
MDFileTest >> testMDFileWithAEmptyTitleAndIsoFileNamerGeneratesCorrectFileName [

	| md |
	md := MDFile new.
	md fileNamer: (ISOFileNamer new
			 date: (Date readFrom: '2024-11-02' readStream pattern: 'y-m-d');
			 yourself).
	self
		assert: md fileName
		equals: '2024-11-02_unnamed.md'
]

{ #category : 'tests - contents' }
MDFileTest >> testMDFileWithATitle [

	| md | 
	md := MDFile new. 
	md title: 'GreatTitle'.
	self assert: md title equals: 'GreatTitle'
]

{ #category : 'tests - contents' }
MDFileTest >> testMDFileWithATitleWithFunnyCharacter [

	| md |
	md := MDFile new.
	md title: '~`Great!Title@Break/TheFile/'.
	self assert: md title equals: 'GreatTitleBreakTheFile'
]

{ #category : 'tests - contents' }
MDFileTest >> testMDFileWithATitleWithFunnyCharacterAndIsoFileNamerGeneratesCorrectFileName [

	| md |
	md := MDFile new.
	md fileNamer: (ISOFileNamer new date: (Date readFrom: '2024-11-02' readStream pattern: 'y-m-d') ; yourself).
 
	md title: '~`Great!Title@Break/TheFile/'.
	self assert: md fileName equals: '2024-11-02_GreatTitleBreakTheFile.md'
]
