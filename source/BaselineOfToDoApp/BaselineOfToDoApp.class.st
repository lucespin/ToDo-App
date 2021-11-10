Class {
	#name : #BaselineOfToDoApp,
	#superclass : #BaselineOf,
	#category : #BaselineOfToDoApp
}

{ #category : #baselines }
BaselineOfToDoApp >> baseline: spec [

	<baseline>
	spec
		for: #pharo
		do: [ self
				setUpDependenciesIn: spec;
				setUpPackagesIn: spec;
				setUpGroupsIn: spec
			]
]

{ #category : #accessing }
BaselineOfToDoApp >> projectClass [

	^ MetacelloCypressBaselineProject
]

{ #category : #accessing }
BaselineOfToDoApp >> setUpDependenciesIn: spec [

	spec
		baseline: 'Aconcagua' with: [ spec repository: 'github://ba-st/Aconcagua:v8/source' ];
		baseline: 'Chalten' with: [ spec repository: 'github://ba-st/Chalten:v8/source' ];
		baseline: 'Buoy' with: [ spec repository: 'github://ba-st/Buoy:v6/source' ];
		baseline: 'WillowBootstrap'
			with: [ spec repository: 'github://ba-st/Willow-Bootstrap:v13/source' ];
		baseline: 'WillowSpinKit' with: [ spec repository: 'github://ba-st/Willow-SpinKit:v9/source' ]
]

{ #category : #initialization }
BaselineOfToDoApp >> setUpGroupsIn: spec [

	spec
		group: 'Deployment' with: #('ToDoApp-Model' 'ToDoApp-Application');
		group: 'Tests' with: #('ToDoApp-Tests');
		group: 'CI' with: 'Tests';
		group: 'Tools' with: #();
		group: 'Dependent-SUnit-Extensions' with: #();
		group: 'Development' with: #('Tools' 'Tests')
]

{ #category : #initialization }
BaselineOfToDoApp >> setUpPackagesIn: spec [

	spec
		package: 'ToDoApp-Model' with: [ spec requires: #('Aconcagua' 'Chalten' 'Buoy') ];
		package: 'ToDoApp-Tests' with: [ spec requires: 'ToDoApp-Model' ];
		package: 'ToDoApp-Application' with: [ spec requires: 'ToDoApp-Model' ]
]
