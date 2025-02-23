Class {
	#name : 'MDFileNamerTest',
	#superclass : 'TestCase',
	#category : 'MicroEd-Tests',
	#package : 'MicroEd-Tests'
}

{ #category : 'tests' }
MDFileNamerTest >> testDefaultName [

	self assert: MDFileNamer new defaultEmptyName equals: 'unnamed'
]

{ #category : 'tests' }
MDFileNamerTest >> testDefaultNameSetDifferently [

	| namer |
	namer := MDFileNamer new defaultEmptyName: 'Unknown'.
	
	self assert: namer newName equals: 'Unknown.md'
]

{ #category : 'tests' }
MDFileNamerTest >> testDefaultNameSetDifferentlyDoesNotInfluenceNewNameBasedOn [

	| namer |
	namer := MDFileNamer new defaultEmptyName: 'Unknown'.

	self assert: (namer newNameBasedOn: 'Toto') equals: 'Toto.md'
]

{ #category : 'tests' }
MDFileNamerTest >> testNameWithNameAlreadyTagged [

	| namer priorName name |
	namer := MDFileNamer new.
	priorName := 'Bla', namer separatorString, 'Unknown'.
	name := namer newNameBasedOn: priorName.
	
	self assert: name equals: priorName
]

{ #category : 'tests' }
MDFileNamerTest >> testNewNameWithNoExtension [

	| name |
	name := MDFileNamer new newNameBasedOn: 'Unknown'.
	self assert: name equals: 'Unknown.md'
]
