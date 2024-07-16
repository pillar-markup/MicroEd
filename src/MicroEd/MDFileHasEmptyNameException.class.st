Class {
	#name : 'MDFileHasEmptyNameException',
	#superclass : 'Exception',
	#category : 'MicroEd-Exceptions',
	#package : 'MicroEd',
	#tag : 'Exceptions'
}

{ #category : 'accessing' }
MDFileHasEmptyNameException class >> exception [ 

	^ self signal: 'The file cannot have an empty base'
]
