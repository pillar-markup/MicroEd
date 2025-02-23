Class {
	#name : 'ISOFileNamer',
	#superclass : 'MDFileNamer',
	#instVars : [
		'date'
	],
	#category : 'MicroEd',
	#package : 'MicroEd'
}

{ #category : 'naming' }
ISOFileNamer >> date [

	^ date ifNil: [ date := Date today ]
]

{ #category : 'naming' }
ISOFileNamer >> date: aDate [

	date := aDate
]

{ #category : 'naming' }
ISOFileNamer >> extractBaseNameFrom: aString [
	"Answer a String representing the receiver's file name"

	| splits |
	splits := aString splitOn: self separatorString.
	"let us see if it is raising an error"
	(DateParser
		 readingFrom: splits first readStream
		 pattern: 'yyyy-mm-dd') parse.
	^ self curateString: (splits second withoutSuffix: '.md').
 
]

{ #category : 'naming' }
ISOFileNamer >> newNameBasedOn: aString [
	"Answer a String representing the receiver's file name with extension."

	| aStringWithExtension |
	aStringWithExtension := self addExtensionIfNeeded: aString.
	^ (aStringWithExtension includesSubstring: self separatorString)
		  ifTrue: [ aStringWithExtension ]
		  ifFalse: [
			  | ymd |
			  ymd := self date yyyymmdd.
			  ymd , self separatorString , aStringWithExtension ]
]
