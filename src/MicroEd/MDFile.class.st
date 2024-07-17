"
The class MDFile represents a status to know if there is a file or no. 
"
Class {
	#name : 'MDFile',
	#superclass : 'Object',
	#instVars : [
		'fileReference'
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

{ #category : 'accessing' }
MDFile >> addDateCreationOfFileReference [

	| dateCreationOfFileReference |
	dateCreationOfFileReference := DateAndTime now asDate yyyymmdd.
	(fileReference basename includesSubstring:
		 dateCreationOfFileReference) ifFalse: [
		^ dateCreationOfFileReference , fileReference basename ].
	^ fileReference basename 
]

{ #category : 'accessing' }
MDFile >> basename [
	"Answer a String representing the receiver's file name"
	^ fileReference 
		ifNil: [ String empty ]
		ifNotNil: [ self addDateCreationOfFileReference ]

]

{ #category : 'accessing' }
MDFile >> contents [

	^ fileReference contents  
]

{ #category : 'accessing' }
MDFile >> contents: aContent [

	fileReference contents: aContent
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
MDFile >> extension: anExtension [

	fileReference extension: anExtension
]

{ #category : 'accessing' }
MDFile >> hasFile [ 

	^ fileReference isNotNil 
]

{ #category : 'accessing' }
MDFile >> initializeWithFileReference: aFileReference [

	aFileReference ensureCreateFile.
	aFileReference base
		ifEmpty: [ MDFileHasEmptyNameException exception ]
		ifNotEmpty: [ fileReference := aFileReference ]
]
