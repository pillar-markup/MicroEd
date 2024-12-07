Class {
	#name : 'MDFileNamer',
	#superclass : 'Object',
	#instVars : [
		'separatorString',
		'defaultEmptyName'
	],
	#category : 'MicroEd',
	#package : 'MicroEd'
}

{ #category : 'naming' }
MDFileNamer >> addExtensionIfNeeded: aString [

	aString asFileReference extension isEmpty 
		ifTrue: [ ^ aString, '.md' ]. 
	^ aString
	
]

{ #category : 'accessing' }
MDFileNamer >> defaultEmptyName [

	^ defaultEmptyName 
]

{ #category : 'accessing' }
MDFileNamer >> defaultEmptyName: aString [
	"we may turn it into a sharedVariable to be able to avoid to specify it each time"
	
	defaultEmptyName := aString 
]

{ #category : 'initialization' }
MDFileNamer >> initialize [

	super initialize.
	defaultEmptyName := 'unnamed'.
	separatorString := '_'
]

{ #category : 'instance creation' }
MDFileNamer >> newName [

	^ self newNameBasedOn: self defaultEmptyName
]

{ #category : 'naming' }
MDFileNamer >> newNameBasedOn: aString [
	"Answer a String representing the receiver's file name"
	
	^ self addExtensionIfNeeded: aString
]

{ #category : 'accessing' }
MDFileNamer >> separatorString [

	^ separatorString
]

{ #category : 'accessing' }
MDFileNamer >> separatorString: aString [

	separatorString :=aString
]
