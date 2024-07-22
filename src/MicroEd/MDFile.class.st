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
MDFile >> basename [
	"Answer a String representing the receiver's file name"

	| dateCreationOfFileReference |
	fileReference ifNil: [ ^ 'Untitled.txt' ].
	dateCreationOfFileReference := DateAndTime now asDate yyyymmdd.
	(fileReference basename includesSubstring:
		 dateCreationOfFileReference) ifFalse: [
		^ dateCreationOfFileReference , fileReference basename ].
	^ fileReference basename 

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
	fileReference := aFileReference
]

{ #category : 'accessing' }
MDFile >> save: aString withExtension: anExtension [

	fileReference asFileReference writeStreamDo: [ :str | 
		str
			nextPutAll: aString ].
	fileReference extension = anExtension asString ifFalse: [ 
		fileReference renameTo:
			self basename , '.' , anExtension asString ].

]
