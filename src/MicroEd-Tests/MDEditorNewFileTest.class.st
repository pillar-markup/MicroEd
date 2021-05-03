Class {
	#name : #MDEditorNewFileTest,
	#superclass : #MDEditorFileTest,
	#category : #'MicroEd-Tests'
}

{ #category : #tests }
MDEditorNewFileTest >> testBasename [
	| editor |
	editor := MDEditorNewFile new.
	self assert: editor basename equals: 'newFile'
]

{ #category : #tests }
MDEditorNewFileTest >> testFullname [
	| editor |
	editor := MDEditorNewFile new.
	self assert: editor fullName equals: 'New File has no fullname'
]

{ #category : #tests }
MDEditorNewFileTest >> testIsNew [
	| editor |
	editor := MDEditorNewFile new.
	self assert: editor isNew
]
