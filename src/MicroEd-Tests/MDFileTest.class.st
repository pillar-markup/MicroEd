Class {
	#name : 'MDFileTest',
	#superclass : 'TestCase',
	#instVars : [
		'memoryFS',
		'fileExample',
		'fileWithoutFileReference',
		'toDelete',
		'fileReferenceWithName'
	],
	#category : 'MicroEd-Tests',
	#package : 'MicroEd-Tests'
}

{ #category : 'running' }
MDFileTest >> setUp [

	super setUp.
	memoryFS := FileSystem memory.
	toDelete := OrderedCollection new.
	fileWithoutFileReference := MDFile new.
	fileExample := memoryFS / 'example.md'.
	fileReferenceWithName := (memoryFS / 'anotherFile.md')
		                         ensureCreateFile.
	toDelete add: fileExample. 
	fileExample writeStreamDo: [ :stream |
		stream nextPutAll: 'example file' ]
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

	| file |
	file := MDFile new.
	file initializeWithFileReference: fileExample.
	self assert: file hasFile.
	
]

{ #category : 'running' }
MDFileTest >> testMDFileCreationWithoutExistingFile [

	self assert: fileWithoutFileReference hasFile not.
]

{ #category : 'running' }
MDFileTest >> testMDFileExistingFileWithName [

	
	| file fileReferenceWithoutName |
	
	fileReferenceWithoutName := (memoryFS / 'name.md') ensureCreateFile.
	toDelete add: fileReferenceWithoutName. 
	file := MDFile new.
	file initializeWithFileReference: fileReferenceWithoutName.
	self assert: (file basename endsWith: 'name.md'). 

	
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
MDFileTest >> testMDFileHasFileReferenceWithFormatISO [
	
	| file date |
	file := MDFile newFromFileReference: fileReferenceWithName. 
	date := DateAndTime now asDate yyyymmdd.
	self assert: (file basename includesSubstring: date).
	self deny: (fileReferenceWithName exists )
]
