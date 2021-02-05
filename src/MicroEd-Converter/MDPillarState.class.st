Class {
	#name : #MDPillarState,
	#superclass : #MDConverterState,
	#category : #'MicroEd-Converter'
}

{ #category : #initialization }
MDPillarState >> initializeSyntax [ 
	syntax := MDPillarSyntax new
]

{ #category : #accessing }
MDPillarState >> next [ 

	^ MDMicroDownState new
]
