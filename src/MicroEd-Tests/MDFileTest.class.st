Class {
	#name : 'MDFileTest',
	#superclass : 'TestCase',
	#instVars : [
		'memoryFS',
		'fileExample',
		'fileWithoutFileReference',
		'toDelete'
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
	fileExample := memoryFS / 'example.txt'.
	toDelete add: fileExample. 
	fileExample writeStreamDo: [ :stream |
		stream nextPutAll: 'example file' ]
]

{ #category : 'running' }
MDFileTest >> tearDown [ 

	toDelete
		select: [ :path | memoryFS exists: path ]
		thenDo: [ :path | memoryFS delete: path ].
	super tearDown
]

{ #category : 'running' }
MDFileTest >> testMDFileCreationOverwriteExistingFile [

	
]

{ #category : 'running' }
MDFileTest >> testMDFileCreationWithExistingFile [

	| file |
	file := MDFile new.
	file initializeWithFileReference: fileExample.
	self assert: file hasFile.
	self assert: file basename equals: fileExample basename.
	
]

{ #category : 'running' }
MDFileTest >> testMDFileCreationWithoutExistingFile [

	self assert: fileWithoutFileReference hasFile not.
	self assertEmpty: fileWithoutFileReference basename
]

{ #category : 'running' }
MDFileTest >> testMDFileExistingFileWithName [

	| file fileReferenceWithName |
	fileReferenceWithName := (memoryFS / 'anotherFile.txt') ensureCreateFile.
	toDelete add: fileReferenceWithName.
	file := MDFile new.
	self
		shouldnt: [ file initializeWithFileReference: fileReferenceWithName ]
		raise: MDFileHasEmptyNameException

	"Remove temp file"
]

{ #category : 'running' }
MDFileTest >> testMDFileExistingFileWithoutName [

	| file fileReferenceWithoutName |

	fileReferenceWithoutName := (memoryFS / '.txt') ensureCreateFile.
	toDelete add: fileReferenceWithoutName. 
	file := MDFile new.
	self
		should: [ file initializeWithFileReference: fileReferenceWithoutName ] 
		raise: MDFileHasEmptyNameException 
	
]
