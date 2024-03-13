Class {
	#name : 'MDEditorOpenedFileTest',
	#superclass : 'MDEditorFileTest',
	#category : 'MicroEd-Tests',
	#package : 'MicroEd-Tests'
}

{ #category : 'tests' }
MDEditorOpenedFileTest >> testBasename [
	| editor file |
	editor := MDEditorOpenedFile new.
	file := FileSystem workingDirectory / 'test.txt'.
	file writeStreamDo: [ :stream | stream nextPutAll: 'this is a text' ].
	editor file: file.
	self assert: editor basename equals: file basename
]

{ #category : 'tests' }
MDEditorOpenedFileTest >> testFullname [
	| editor file |
	editor := MDEditorOpenedFile new.
	file := FileSystem workingDirectory / 'test.txt'.
	file writeStreamDo: [ :stream | stream nextPutAll: 'this is a text' ].
	editor file: file.
	self assert: editor fullName equals: file fullName
]

{ #category : 'tests' }
MDEditorOpenedFileTest >> testIsNew [
	| editor |
	editor := MDEditorOpenedFile new.
	self assert: editor isNew not
]

{ #category : 'tests' }
MDEditorOpenedFileTest >> testSaveWithExtension [
	| editor file text |
	editor := MDEditorOpenedFile new.
	text := SpTextPresenter new.
	text text: 'for test'.
	file := FileSystem workingDirectory / 'test.txt'.
	file writeStreamDo: [ :stream | stream nextPutAll: 'this is a text' ].
	editor file: file.
	editor save: text withExtension: 'mic'.
	self assert: file basename equals: 'test.mic'.
	file delete
	
]
