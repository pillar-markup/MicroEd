"
I am a state pattern to switch syntax between **MicroDown** and **Pillar** for now. We can think of adding GitHub Markdown.
"
Class {
	#name : #MDEditorSyntax,
	#superclass : #Object,
	#category : #MicroEd
}

{ #category : #accessing }
MDEditorSyntax >> exampleText [
	^ self subclassResponsibility 
]

{ #category : #accessing }
MDEditorSyntax >> label [
	^ 'Change to ', self next new name, ' syntax'.
]

{ #category : #accessing }
MDEditorSyntax >> name [
	^ self subclassResponsibility 
]

{ #category : #accessing }
MDEditorSyntax >> next [
	^ self subclassResponsibility 
]

{ #category : #parsing }
MDEditorSyntax >> parse: aText [
	^ self parser new parse: aText asString
]

{ #category : #accessing }
MDEditorSyntax >> parser [
	^ self subclassResponsibility 
]

{ #category : #writing }
MDEditorSyntax >> write: aStringOrStream [
	| parsedAsPillar writtenText|
	parsedAsPillar := self parse: aStringOrStream.
	writtenText := self next writer new start: parsedAsPillar; contents.
	^ writtenText
]

{ #category : #accessing }
MDEditorSyntax >> writer [
	^ self subclassResponsibility 
]
