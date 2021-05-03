Class {
	#name : #MDEditorOpenedFileTest,
	#superclass : #MDEditorFileTest,
	#category : #'MicroEd-Tests'
}

{ #category : #tests }
MDEditorOpenedFileTest >> testIsNew [
	| editor |
	editor := MDEditorOpenedFile new.
	self assert: editor isNew not
]

{ #category : #tests }
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
