Class {
	#name : #Employee,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#category : #'ToDoApp-Model'
}

{ #category : #'instance creation' }
Employee class >> named: aPotentialName [

	AssertionChecker refuse: [ aPotentialName isEmpty ]
		because: 'Un empleado debe tener un nombre'
		raising: InstanceCreationFailed.

	^ self new initializeNamed: aPotentialName
]

{ #category : #initialization }
Employee >> initializeNamed: aName [

	name := aName
]

{ #category : #accessing }
Employee >> name [

	^ name
]
