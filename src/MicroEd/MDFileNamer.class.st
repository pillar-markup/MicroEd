"
I represent a file name with the following structure:

- a list of parts separated by a separator where a part can only contain alpha numerical characters.
- finished with an extension
"
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
MDFileNamer >> curateParts: aCollection [
	"aString a name without extension e.g. .md
	Return a string with preserved separated parts but where each part in only alphanumerical."

	| curatedParts curated |
	curatedParts := aCollection collect: [ :part |
		                part select: [ :each | each isAlphaNumeric ] ].
	curated := ''.
	curatedParts
		do: [ :part | curated := curated , part ]
		separatedBy: [ curated := curated , self separatorString ].
	curated ifEmpty: [ curated := self defaultEmptyName ].
	^ curated
]

{ #category : 'initialization' }
MDFileNamer >> curateString: aString [
	"aString a name without extension e.g. .md
	Return a string with preserved separated parts but where each part in only alphanumerical."

	^ self curateParts: (aString splitOn: separatorString) 
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

	^ self addExtensionIfNeeded: (self curateString: (aString withoutSuffix: '.md'))
]

{ #category : 'accessing' }
MDFileNamer >> separatorString [

	^ separatorString
]

{ #category : 'accessing' }
MDFileNamer >> separatorString: aString [

	separatorString :=aString
]
