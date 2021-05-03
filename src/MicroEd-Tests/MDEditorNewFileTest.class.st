Class {
	#name : #MDEditorNewFileTest,
	#superclass : #MDEditorFileTest,
	#category : #'MicroEd-Tests'
}

{ #category : #tests }
MDEditorNewFileTest >> testIsNew [
	| editor |
	editor := MDEditorNewFile new.
	self assert: editor isNew
]
