Class {
	#name : #ToDoStateTest,
	#superclass : #TestCase,
	#category : #'ToDoApp-Tests'
}

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
