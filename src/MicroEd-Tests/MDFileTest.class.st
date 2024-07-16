Class {
	#name : 'MDFileTest',
	#superclass : 'TestCase',
	#instVars : [
		'memoryFS',
		'fileExample'
	],
	#category : 'MicroEd-Tests',
	#package : 'MicroEd-Tests'
}

{ #category : 'running' }
MDFileTest >> setUp [

	super setUp.
	memoryFS := FileSystem memory.
	fileExample := memoryFS / 'example.txt'.
	fileExample writeStreamDo: [ :stream |
		stream nextPutAll: 'example file' ]
]

{ #category : 'running' }
MDFileTest >> testMDFileWithFile [

	| file |
	file := MDFile new.
	file fromFile: fileExample.
	self assert: file hasFile.
	self assert: file basename equals: fileExample basename.
	self assert: file extension equals: fileExample extension
]

{ #category : 'running' }
MDFileTest >> testMDFileWithoutFile [

	| file |
	file := MDFile new.
	self assert: file hasFile.
	self assert: file basename isNil
]
