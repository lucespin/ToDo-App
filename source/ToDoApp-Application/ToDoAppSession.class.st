Class {
	#name : #ToDoAppSession,
	#superclass : #WillowSession,
	#instVars : [
		'applicationContext'
	],
	#category : #'ToDoApp-Application'
}

{ #category : #accessing }
ToDoAppSession >> applicationContext [

	^ applicationContext
]

{ #category : #Controlling }
ToDoAppSession >> startUpApplicationContextFor: aWillowApplication [

	super startUpApplicationContextFor: aWillowApplication.
	applicationContext := ToDoAppApplicationContext new
]
