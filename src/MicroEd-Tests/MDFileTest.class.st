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
	fileReferenceWithName := (memoryFS / 'anotherFile.md')
		                         ensureCreateFile.
	toDelete add: fileExample.
	fileExample writeStreamDo: [ :stream |
		stream nextPutAll: 'example file' ].

	parser := MicrodownParser new.
]

{ #category : 'running' }
MDFileTest >> tearDown [ 

	toDelete
		select: [ :path | memoryFS exists: path ]
		thenDo: [ :path | path ensureDelete ].
	super tearDown
]

{ #category : 'running' }
MDFileTest >> testMDFileCreationWithExistingFile [

	mdfile initializeWithFileReference: fileExample.
	self assert: mdfile hasFile.
	
]

{ #category : 'running' }
MDFileTest >> testMDFileCreationWithoutExistingFile [

	| fileWithoutFileReference |
	fileWithoutFileReference := MDFile new.
	self assert: fileWithoutFileReference hasFile not.
]

{ #category : 'running' }
MDFileTest >> testMDFileExistingFileWithName [

	
	| fileReferenceWithoutName |
	
	fileReferenceWithoutName := (memoryFS / 'name.md') ensureCreateFile.
	toDelete add: fileReferenceWithoutName. 
	mdfile initializeWithFileReference: fileReferenceWithoutName.
	self assert: (mdfile basename endsWith: 'name.md'). 

	
]

{ #category : 'running' }
MDFileTest >> testMDFileExistingFileWithoutName [

	| file fileReferenceWithoutName |
 	
	fileReferenceWithoutName := (memoryFS / '.md') ensureCreateFile.
	toDelete add: fileReferenceWithoutName. 
	file := MDFile new.
	file initializeWithFileReference: fileReferenceWithoutName.
	self denyEmpty: file basename. 
	
]

{ #category : 'running' }
MDFileTest >> testMDFileHasFileReferenceAddMetaData [

	| root file |
	
	file := memoryFS / 'test2'.
	file ensureCreateFile. 
	mdfile initializeWithFileReference: file. 
	mdfile addMetaDataElements. 
	
	root := MicrodownParser parse: mdfile contents.
	self assert: root hasMetaDataElement.
	
	
]

{ #category : 'running' }
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

{ #category : 'running' }
MDFileTest >> testMDFileHasFileReferenceHasNotMetaData [

	| root file |
	
	file := memoryFS / 'test3'.
	file ensureCreateFile. 
	mdfile initializeWithFileReference: file. 
	root := MicrodownParser parse: mdfile contents.
	self deny: root hasMetaDataElement.
	
	
]

{ #category : 'running' }
MDFileTest >> testMDFileHasFileReferenceWithFormatISO [
	
	| file date |
	file := MDFile newFromFileReference: fileReferenceWithName. 
	date := DateAndTime now asDate yyyymmdd.
	self assert: (file basename includesSubstring: date).
	self deny: (fileReferenceWithName exists )
]
