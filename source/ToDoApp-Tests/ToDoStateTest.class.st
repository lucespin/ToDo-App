Class {
	#name : #ToDoStateTest,
	#superclass : #TestCase,
	#instVars : [
		'cleanTheToilet'
	],
	#category : #'ToDoApp-Tests'
}

{ #category : #running }
ToDoStateTest >> setUp [

	cleanTheToilet := ToDo describedBy: 'Clean the toilet'

]

{ #category : #tests }
ToDoStateTest >> testAssignAnEmployeeToAnInprogressToDoShouldFail [

	self
		should: [ InProgressToDo new assign: cleanTheToilet to: 'Dexter' ]
		raise: AssertionFailed
		withMessageText: 'An in-progress ToDo can''t be reassigned'
]

{ #category : #tests }
ToDoStateTest >> testWhenAFinishedToDoIsMarkedAsFinishedThenNotChange [

	| aToDo |

	aToDo := ToDo describedBy: 'Preparar equipo'.

	aToDo
		assignTo: 'Dexter';
		markAsInProgress;
		markAsFinished.
		
	self assert: aToDo isFinished.
		
	FinishedToDo new markAsFinished: aToDo.
		
	self assert: aToDo isFinished.
]
