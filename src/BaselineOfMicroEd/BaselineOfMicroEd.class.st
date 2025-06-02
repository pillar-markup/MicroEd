Class {
	#name : 'BaselineOfMicroEd',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfMicroEd',
	#package : 'BaselineOfMicroEd'
}

{ #category : 'baselines' }
BaselineOfMicroEd >> baseline: spec [

	<baseline>
	spec
		for: #common
		do: [ "We need the Extensions group from Microdown to use MicTextualMicrodownExporter"
			spec
				baseline: 'Microdown'
				with: [ spec repository: 'github://pillar-markup/Microdown:dev/src' ].
			spec
				package: 'MicroEd' 
					with: [ spec requires: #( 'Microdown' ) ];
				package: 'MicroEd-Spec' 
					with: [ spec requires: #( 'MicroEd' ) ];
				package: 'MicroEd-Tests' 
					with: [ spec requires: #( 'MicroEd' ) ];
				package: 'MicroEd-Spec-Tests'
					with: [ spec requires: #( 'MicroEd' ) ] ]
]
