"
I am a state pattern to switch syntax between **MicroDown** and **Pillar** for now. We can think of adding GitHub Markdown.
"
Class {
	#name : #MDConverterState,
	#superclass : #Object,
	#instVars : [
		'syntax'
	],
	#category : #'MicroEd-Converter'
}

{ #category : #accessing }
MDConverterState >> exampleText [
	^ syntax exampleText
]

{ #category : #initialization }
MDConverterState >> initialize [

	super initialize.
	syntax := self initializeSyntax.
]

{ #category : #initialization }
MDConverterState >> initializeSyntax [
]

{ #category : #accessing }
MDConverterState >> label [
	^ 'Change to ', self next new name, ' syntax'.
]

{ #category : #accessing }
MDConverterState >> name [
	^ syntax name
]

{ #category : #accessing }
MDConverterState >> next [
	"return the next language"
	^ self subclassResponsibility 
]

{ #category : #parsing }
MDConverterState >> parse: aText [
	^ self syntax parse: aText
]

{ #category : #accessing }
MDConverterState >> syntax [ 
	^ syntax
]
