Class {
	#name : #Category,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#category : #'ToDoApp-Model'
}

{ #category : #'as yet unclassified' }
Category class >> named: aName [

	^ Category new initializeNamed: aName
]

{ #category : #initialization }
Category >> initializeNamed: aName [
	
	name := aName
]

{ #category : #accesing }
Category >> name [

	^ name
]
