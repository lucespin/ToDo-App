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
ToDoStateTest >> testAFinishedToDoIsFinished [

	self assert: FinishedToDo new isFinished 
]

{ #category : #tests }
ToDoStateTest >> testAFinishedToDoIsNotInProgress [

	self deny: FinishedToDo new isInProgress
]

{ #category : #tests }
ToDoStateTest >> testAFinishedToDoIsNotOpen [

	self deny: FinishedToDo new isOpen
]

{ #category : #tests }
ToDoStateTest >> testAnInProgressToDoIsInProgress [

	self assert: InProgressToDo new isInProgress
]

{ #category : #tests }
ToDoStateTest >> testAnInProgressToDoIsNotFinished [

	self deny: InProgressToDo new isFinished
]

{ #category : #tests }
ToDoStateTest >> testAnInProgressToDoIsNotOpen [

	self deny: InProgressToDo new isOpen
]

{ #category : #tests }
ToDoStateTest >> testAnOpenToDoIsNotFinished [

	self deny: OpenToDo new isFinished
]

{ #category : #tests }
ToDoStateTest >> testAnOpenToDoIsNotInProgress [

	self deny: OpenToDo new isInProgress
]

{ #category : #tests }
ToDoStateTest >> testAnOpenToDoIsOpen [

	self assert: OpenToDo new isOpen
]

{ #category : #tests }
ToDoStateTest >> testAssignAnEmployeeToAFinishedToDoShouldFail [

	self
		should: [ FinishedToDo new assign: cleanTheToilet to: 'Dexter' ]
		raise: AssertionFailed
		withMessageText: 'A finished ToDo can''t be reassigned'
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

	self assert: aToDo isFinished
]
