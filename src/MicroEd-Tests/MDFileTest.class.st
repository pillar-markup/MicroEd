Class {
	#name : 'MDFileTest',
	#superclass : 'TestCase',
	#instVars : [
		'memoryFS',
		'fileExample',
		'fileWithoutFileReference',
		'toDelete',
		'fileReferenceWithName',
		'mdFile'
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
	mdFile := MDFile new.
	fileExample := memoryFS / 'example.txt'.
	fileReferenceWithName := (memoryFS / 'anotherFile.txt')
		                         ensureCreateFile.
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

	" dans quel cas on voudrait remplacer un fichier.
	peut etre si le fichier en question existe deja. il faut donc penser à réécrire le nom du fichier. "
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
	self assertEmpty: fileWithoutFileReference basename
]

{ #category : 'running' }
MDFileTest >> testMDFileExistingFileWithName [

	| file |
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

{ #category : 'running' }
MDFileTest >> testMDFileHasFileReferenceWithFormatISO [
	
	| file date |
	file := MDFile newFromFileReference: fileReferenceWithName. 
	date := (DateAndTime now asDate) yyyymmdd.
	self assert: (file basename includesSubstring: date)
]
