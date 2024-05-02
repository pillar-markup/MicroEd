Class {
	#name : 'BaselineOfMicroEd',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfMicroEd',
	#package : 'BaselineOfMicroEd'
}

{ #category : 'baselines' }
BaselineOfMicroEd >> baseline: spec [
	<baseline>

	spec for: #'common' do: [
		"Suppose that this is only for P9
			spec baseline: ''Microdown'' with: [
			spec repository: ''github://pillar-markup/Microdown/src'' ]"
		
		spec 
			package: 'MicroEd'.
		spec 	
			package: 'MicroEd-Tests'
			with: [ spec requires: #('MicroEd') ]
	]
]
