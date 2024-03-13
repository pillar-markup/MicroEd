Class {
	#name : 'MDEditorNewFileTest',
	#superclass : 'MDEditorFileTest',
	#instVars : [
		'window'
	],
	#category : 'MicroEd-Tests',
	#package : 'MicroEd-Tests'
}

{ #category : 'tests' }
MDEditorNewFileTest >> testBasename [
	| editor |
	editor := MDEditorNewFile new.
	self assert: editor basename equals: 'newFile'
]

{ #category : 'tests' }
MDEditorNewFileTest >> testFullname [
	| editor |
	editor := MDEditorNewFile new.
	self assert: editor fullName equals: 'New File has no fullname'
]

{ #category : 'tests' }
MDEditorNewFileTest >> testIsNew [
	| editor |
	editor := MDEditorNewFile new.
	self assert: editor isNew
]

{ #category : 'tests' }
MDEditorNewFileTest >> testSaveWithExtension [
	| editor text openFile |
	"add code to click on save"
	
	self flag: 'How to send a performAction to a button in a modal dialog?'.
	^ self skip.

	editor := MDEditorNewFile new.
	text := SpTextPresenter new.
	text text: 'this is a test'.
	openFile := editor save: text withExtension: 'mic'.
	self assert: openFile basename equals: 'my_document.mic'.
	openFile file delete
	
]
