Class {
	#name : 'MDISOFileNameTest',
	#superclass : 'TestCase',
	#category : 'MicroEd-Tests',
	#package : 'MicroEd-Tests'
}

{ #category : 'tests' }
MDISOFileNameTest >> testDefaultNameSetDifferently [

	| namer |
	namer := ISOFileNamer new defaultEmptyName: 'Unknown.md'.
	
	self assert: namer newName equals: 'Unknown.md'
]

{ #category : 'tests' }
MDISOFileNameTest >> testNameWithNameAlreadyTagged [

	| namer priorName name |
	namer := ISOFileNamer new.
	priorName := 'Bla', namer separatorString, 'Unknown.md'.
	name := namer newNameBasedOn: priorName.
	self assert: name equals: priorName
]

{ #category : 'tests' }
MDISOFileNameTest >> testNewName [

	| namer |
	namer := ISOFileNamer new.
	namer date: (Date readFrom: '2024-11-02' readStream pattern: 'y-m-d').
	
	self 
		assert: (namer newNameBasedOn: 'Unknown.md')  
		equals: '2024-11-02_Unknown.md'
]

{ #category : 'tests' }
MDISOFileNameTest >> testNewNameWithNoExtension [

	| namer |
	namer := ISOFileNamer new.
	namer date: (Date readFrom: '2024-11-02' readStream pattern: 'y-m-d').
	
	self 
		assert: (namer newNameBasedOn: 'Unknown')  
		equals: '2024-11-02_Unknown.md'
]
