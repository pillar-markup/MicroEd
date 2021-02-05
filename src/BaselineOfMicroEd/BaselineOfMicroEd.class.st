Class {
	#name : #BaselineOfMicroEd,
	#superclass : #BaselineOf,
	#category : #BaselineOfMicroEd
}

{ #category : #baselines }
BaselineOfMicroEd >> baseline: spec [

	<baseline>
	spec for: #'common' do: [
		"Suppose that this is only for P9
			spec baseline: ''Microdown'' with: [
			spec repository: ''github://pillar-markup/Microdown/src'' ]"
		
		spec
			baseline: 'FileDialog'
			with: [ spec repository: 'github://Ducasse/file-dialog/repository' ].

		spec 
			package: 'MicroEd'
			with: [ spec requires: #('FileDialog' 'MicroEd-Converter') ].
		spec 
			package: 'MicroEd-Converter'
			with: [ spec requires: #('FileDialog') ].

	]
]
