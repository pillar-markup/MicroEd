Class {
	#name : 'MDFileTest',
	#superclass : 'TestCase',
	#instVars : [
		'memoryFS',
		'toDelete',
		'fileReferenceWithName',
		'parser',
		'mdFollowingConventionFile',
		'fileReferenceFollowingConventions'
	],
	#category : 'MicroEd-Tests',
	#package : 'MicroEd-Tests'
}

{ #category : 'running' }
MDFileTest >> setUp [

	| fileNamer |
	super setUp.
	memoryFS := FileSystem memory.

	mdFollowingConventionFile := MDFile new.
	fileNamer := mdFollowingConventionFile fileNamer.
	fileNamer date: (Date readFrom: '2024-11-02' readStream pattern: 'y-m-d').

	fileReferenceFollowingConventions := memoryFS
	                                     /
	                                     (mdFollowingConventionFile
		                                      fileNamer newNameBasedOn:
		                                      'example').

	fileReferenceFollowingConventions writeStreamDo: [ :stream |
		stream nextPutAll: 'example file' ].

	fileReferenceWithName := (memoryFS / 'anotherFile.md')
		                         ensureCreateFile.

	parser := MicrodownParser new
]

{ #category : 'tests - contents' }
MDFileTest >> testContentsIsSaved [
	
	self
		assert: fileReferenceFollowingConventions contents
		equals: 'example file'.

	self
		assert: (memoryFS / '2024-11-02_example.md') contents
		equals: 'example file'
]

{ #category : 'tests - fileReference' }
MDFileTest >> testCreationFromAFileReferenceFollowingTheFileConventions [

	| mdFile |
	mdFile := MDFile new.
	mdFile fileReference: fileReferenceFollowingConventions.
	self assert: mdFile hasFile
]

{ #category : 'tests' }
MDFileTest >> testMDFileCreationWithExistingFile [

	mdFollowingConventionFile fileReference:
		fileReferenceFollowingConventions.
	self assert: mdFollowingConventionFile hasFile
]

{ #category : 'tests' }
MDFileTest >> testMDFileCreationWithoutExistingFile [

	| fileWithoutFileReference |
	fileWithoutFileReference := MDFile new.
	self deny: fileWithoutFileReference hasFile
]

{ #category : 'tests' }
MDFileTest >> testMDFileExistingFileWithName [

	| fileReferenceWithoutName |
	fileReferenceWithoutName := (memoryFS / 'name.md') ensureCreateFile.
	mdFollowingConventionFile fileReference:
		fileReferenceWithoutName.
	self assert:
		(mdFollowingConventionFile fileReference basename endsWith:
			 'name.md')
]

{ #category : 'tests' }
MDFileTest >> testMDFileHasFileReferenceAddMetaData [

	| root file |
	file := memoryFS / 'test2'.
	file ensureCreateFile.
	mdFollowingConventionFile fileReference: file.
	mdFollowingConventionFile addMetaDataElements.

	root := MicrodownParser parse: mdFollowingConventionFile contents.
	self assert: root hasMetaDataElement.
	self assert: (root metaDataElement atKey: 'title') equals: 'unnamed'
]

{ #category : 'tests' }
MDFileTest >> testMDFileHasFileReferenceHasNotMetaData [

	| root file |
	file := memoryFS / 'test3'.
	file ensureCreateFile.
	mdFollowingConventionFile fileReference: file.
	root := MicrodownParser parse: mdFollowingConventionFile contents.
	self deny: root hasMetaDataElement
]

{ #category : 'tests' }
MDFileTest >> testMDFileHasFileReferenceWithFormatISO [
	
	| file |
	file := MDFile new.
	file fileNamer date: (Date newDay: 21 month: 9  year: 1969). 
	self assert: file fileReference basename equals: '1969-09-21_unnamed.md'.
	
]

{ #category : 'tests - title' }
MDFileTest >> testMDFileWithATitle [

	| md | 
	md := MDFile new. 
	md title: 'GreatTitle'.
	self assert: md title equals: 'GreatTitle'
]

{ #category : 'tests - title' }
MDFileTest >> testMDFileWithATitleWithFunnyCharacter [

	| md |
	md := MDFile new.
	md title: '~`Great!Title@Break/TheFile/'.
	self assert: md title equals: 'GreatTitleBreakTheFile'
]

{ #category : 'tests - title' }
MDFileTest >> testMDFileWithATitleWithFunnyCharacterAndIsoFileNamerGeneratesCorrectFileName [

	| md |
	md := MDFile new.
	md fileNamer: (ISOFileNamer new date: (Date readFrom: '2024-11-02' readStream pattern: 'y-m-d') ; yourself).
 
	md title: '~`Great!Title@Break/TheFile/'.
	self assert: md fileName equals: '2024-11-02_GreatTitleBreakTheFile.md'
]

{ #category : 'tests - title' }
MDFileTest >> testMDFileWithAnEmptyTitle [

	| md |
	md := MDFile new.
	md title: ''.
	self assert: md title equals: 'unnamed'
]

{ #category : 'tests - title' }
MDFileTest >> testMDFileWithAnEmptyTitleAndIsoFileNamerGeneratesCorrectFileName [

	| md |
	md := MDFile new.
	md title: ''.
	md fileNamer: (ISOFileNamer new
			 date: (Date readFrom: '2024-11-02' readStream pattern: 'y-m-d');
			 yourself).
	self assert: md fileName equals: '2024-11-02_unnamed.md'
]

{ #category : 'tests - title' }
MDFileTest >> testMDFileWithAnUnsetTitle [

	| md |
	md := MDFile new.
	self assert: md title equals: 'unnamed'
]

{ #category : 'tests - title' }
MDFileTest >> testMDFileWithAnUnsetTitleAndIsoFileNamerGeneratesCorrectFileName [

	| md |
	md := MDFile new.
	md fileNamer: (ISOFileNamer new
			 date: (Date readFrom: '2024-11-02' readStream pattern: 'y-m-d');
			 yourself).
	self assert: md fileName equals: '2024-11-02_unnamed.md'
]
