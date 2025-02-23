Class {
	#name : 'MDISOFileNamerTest',
	#superclass : 'TestCase',
	#category : 'MicroEd-Tests',
	#package : 'MicroEd-Tests'
}

{ #category : 'tests' }
MDISOFileNamerTest >> testDefaultNameSetDifferently [

	| namer |
	namer := ISOFileNamer new defaultEmptyName: 'Unknown.md'.
	
	self assert: namer newName equals: '2024-12-07_Unknown.md'
]

{ #category : 'tests' }
MDISOFileNamerTest >> testNameWithNameAlreadyTagged [

	| namer priorName name |
	namer := ISOFileNamer new.
	priorName := 'Bla', namer separatorString, 'Unknown.md'.
	name := namer newNameBasedOn: priorName.
	self assert: name equals: priorName
]

{ #category : 'tests' }
MDISOFileNamerTest >> testNewName [

	| namer |
	namer := ISOFileNamer new.
	namer date: (Date readFrom: '2024-11-02' readStream pattern: 'y-m-d').
	
	self 
		assert: (namer newNameBasedOn: 'Unknown.md')  
		equals: '2024-11-02_Unknown.md'
]

{ #category : 'tests' }
MDISOFileNamerTest >> testNewNameWithNoExtension [

	| namer |
	namer := ISOFileNamer new.
	namer date: (Date readFrom: '2024-11-02' readStream pattern: 'y-m-d').
	
	self 
		assert: (namer newNameBasedOn: 'Unknown')  
		equals: '2024-11-02_Unknown.md'
]

{ #category : 'tests - revert' }
MDISOFileNamerTest >> testTitleFromFileName [

	self 
		assert: (ISOFileNamer new extractBaseNameFrom: '2024-11-02_Unknown.md')
		equals: 'Unknown'
]

{ #category : 'tests - revert' }
MDISOFileNamerTest >> testTitleFromFileNameBadDate [

	self
		should: [ (ISOFileNamer new extractBaseNameFrom: 'YYgjghjgjhg_Unknown.md') ]
		raise: DateError 
]

{ #category : 'tests - revert' }
MDISOFileNamerTest >> testTitleFromFileNameBadEndEmpty [

	self
		assert:
		(ISOFileNamer new extractBaseNameFrom: '2024-11-02_.md')
		equals: 'Unknown'
]

{ #category : 'tests - revert' }
MDISOFileNamerTest >> testTitleFromFileNameBadEndNotAlphanumerical [

	self
		assert:
		(ISOFileNamer new extractBaseNameFrom: '2024-11-02_!!/\.md')
		equals: 'Unknown'
]
