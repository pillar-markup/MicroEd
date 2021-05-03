Class {
	#name : #MDSyntaxTest,
	#superclass : #TestCase,
	#instVars : [
		'window'
	],
	#category : #'MicroEd-Tests'
}

{ #category : #tests }
MDSyntaxTest >> testGotExtensionWhenIsNotSpecify [
	| syntax |
	syntax := MDSyntax new.
	self assert: syntax extension equals: 'microdown'
]

{ #category : #tests }
MDSyntaxTest >> testGotNameWhenIsNotSpecify [
	| syntax |
	syntax := MDSyntax new.
	self assert: syntax name equals: 'MicroDown'
]

{ #category : #tests }
MDSyntaxTest >> testGotParserWhenIsNotSpecify [
	| syntax |
	syntax := MDSyntax new.
	self assert: syntax parser equals: MicroDownParser
]
