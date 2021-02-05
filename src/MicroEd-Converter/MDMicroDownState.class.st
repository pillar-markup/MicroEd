Class {
	#name : #MDMicroDownState,
	#superclass : #MDConverterState,
	#category : #'MicroEd-Converter'
}

{ #category : #accessing }
MDMicroDownState >> initializeSyntax [ 
	syntax := MDMicroDownSyntax new
]

{ #category : #accessing }
MDMicroDownState >> next [ 

	^ MDPillarState new
]
