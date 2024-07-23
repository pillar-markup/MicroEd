Class {
	#name : 'MDMicroDownSyntaxTest',
	#superclass : 'TestCase',
	#instVars : [
		'syntax'
	],
	#category : 'MicroEd-Tests',
	#package : 'MicroEd-Tests'
}

{ #category : 'tests' }
MDMicroDownSyntaxTest >> testGotExtensionWhenIsNotSpecify [

	syntax := MDMicroDownSyntax new.
	self assert: syntax extension equals: 'md'
]

{ #category : 'tests' }
MDMicroDownSyntaxTest >> testGotNameWhenIsNotSpecify [

	syntax := MDMicroDownSyntax new.
	self assert: syntax name equals: 'MicroDown'
]

{ #category : 'tests' }
MDMicroDownSyntaxTest >> testGotParserWhenIsNotSpecify [

	syntax := MDMicroDownSyntax new.
	self assert: syntax parser equals: MicrodownParser
]
