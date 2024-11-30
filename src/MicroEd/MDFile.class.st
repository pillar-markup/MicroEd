"
The class MDFile represents a status to know if there is a file or no. 
"
Class {
	#name : 'MDFile',
	#superclass : 'Object',
	#instVars : [
		'fileReference',
		'nameOfFileReferenceBeforeSaved'
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
			root := MicrodownParser parse: '{
		"author" : "addos" 
		}
		'.
			root metaDataElement
				atKey: 'author' put: (fileReference entry reference path at: 3);
				atKey: 'title' put: nameOfFileReferenceBeforeSaved;
				atKey: 'lastModificationDate' put: fileReference modificationTime asDate yyyymmdd ]
		ifTrue: [
			root metaDataElement
				atKey: 'lastModificationDate'
				put: fileReference modificationTime asDate yyyymmdd].

	self writeFileContentsOf: root. 
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
MDFile >> file [
	^ fileReference
]

{ #category : 'accessing' }
MDFile >> fileReference [ 

	^ fileReference 
]

{ #category : 'accessing' }
MDFile >> hasFile [ 

	^ fileReference isNotNil 
]

{ #category : 'accessing' }
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

{ #category : 'accessing' }
MDFile >> save: aString [

	fileReference asFileReference writeStreamDo: [ :str | 
		str
			nextPutAll: aString ].
	
		

]

{ #category : 'add' }
MDFile >> writeFileContentsOf: aRoot [

	| visitor |
	visitor := MicTextualMicrodownExporter new.
	visitor visit: aRoot.
	fileReference writeStreamDo: [ :stream |
		stream nextPutAll: visitor contents ]
]
