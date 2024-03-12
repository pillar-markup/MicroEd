Class {
	#name : 'MDEditorFileTest',
	#superclass : 'TestCase',
	#category : 'MicroEd-Tests',
	#package : 'MicroEd-Tests'
}

{ #category : 'tests' }
MDEditorFileTest >> testGotFileWhenIsNotSpecify [
	| editor |
	editor := MDEditorFile new.
	self assert: editor file isNil
]

{ #category : 'tests' }
MDEditorFileTest >> testGotFileWhenIsSpecify [
	| editor file |
	editor := MDEditorFile new.
	file := FileSystem memory workingDirectory / 'test.mic'.
	file writeStreamDo: [ :stream | stream nextPutAll: 'test' ].
	editor file: file.
	self assert: editor file equals: file
]
