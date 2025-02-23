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

{ #category : 'initialization' }
MDFileNamer >> curateString: aString [

	| curated |
	curated := aString select: [ :each | each isAlphaNumeric ].
	curated ifEmpty: [ curated := self defaultEmptyName ].
	^ curated
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
	"returns a new default file with extension."
	
	^ self newNameBasedOn: self defaultEmptyName
]

{ #category : 'naming' }
MDFileNamer >> newNameBasedOn: aString [
	"Answer a String representing the receiver's file name with extension"

	^ self addExtensionIfNeeded: (self curateString: aString)
]

{ #category : 'accessing' }
MDFileNamer >> separatorString [

	^ separatorString
]

{ #category : 'accessing' }
MDFileNamer >> separatorString: aString [

	separatorString :=aString
]
