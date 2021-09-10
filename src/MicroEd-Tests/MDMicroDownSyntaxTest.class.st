Class {
	#name : #MDMicroDownSyntaxTest,
	#superclass : #TestCase,
	#instVars : [
		'syntax'
	],
	#category : #'MicroEd-Tests'
}

{ #category : #tests }
MDMicroDownSyntaxTest >> testGotExtensionWhenIsNotSpecify [

	syntax := MDMicroDownSyntax new.
	self assert: syntax extension equals: 'mic'
]

{ #category : #tests }
MDMicroDownSyntaxTest >> testGotNameWhenIsNotSpecify [

	syntax := MDMicroDownSyntax new.
	self assert: syntax name equals: 'MicroDown'
]

{ #category : #tests }
MDMicroDownSyntaxTest >> testGotParserWhenIsNotSpecify [

	syntax := MDMicroDownSyntax new.
	self assert: syntax parser equals: MicroDownParser
]
