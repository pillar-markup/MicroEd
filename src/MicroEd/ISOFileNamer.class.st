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
ISOFileNamer >> newNameBasedOn: aString [
	"Answer a String representing the receiver's file name"
	
	| aStringWithExtension |
	aStringWithExtension := self addExtensionIfNeeded: aString. 
	^ (aStringWithExtension includesSubstring: '_')
		ifTrue: [ aStringWithExtension ]
		ifFalse: [ 
				| ymd  |
				ymd := self date yyyymmdd.
				ymd , self separatorString , aStringWithExtension ]
]
