Class {
	#name : #ToDosRepositoryTest,
	#superclass : #TestCase,
	#category : #'ToDoApp-Tests'
}

{ #category : #tests }
ToDosRepositoryTest >> testAddAToDoToARepository [

	| aToDo aToDoRepository |
		
	aToDoRepository := ToDosRepository new.
	
	self assertEmpty: aToDoRepository toDos.
	
	aToDo := ToDo describedBy: 'Buy the Corvette'.
	
	aToDoRepository addToDo: aToDo.

	self withTheOnlyOneIn: aToDoRepository toDos
		do: [ :storedToDo | self assert: storedToDo equals: aToDo ]
]

{ #category : #tests }
ToDosRepositoryTest >> testRemoveAFinishedToDoOfARepositoryShouldFail [

	| aToDo aToDoRepository |

	aToDoRepository := ToDosRepository new.

	self assertEmpty: aToDoRepository toDos.

	aToDo := ToDo describedBy: 'Buy the Corvette'.

	aToDo
		assignTo: (Employee named: 'Kam');
		markAsInProgress;
		markAsFinished.

	aToDoRepository addToDo: aToDo.

	self
		should: [aToDoRepository removeToDo: aToDo]
		raise: AssertionFailed
		description: 'The ToDo is not open'
]

{ #category : #tests }
ToDosRepositoryTest >> testRemoveAToDoOfARepository [

	| aToDo aToDoRepository |
		
	aToDoRepository := ToDosRepository new.
	
	self assertEmpty: aToDoRepository toDos.
	
	aToDo := ToDo describedBy: 'Buy the Corvette'.
	
	aToDoRepository addToDo: aToDo.

	aToDoRepository removeToDo: aToDo.

	self assert: aToDoRepository toDos isEmpty 
]

{ #category : #tests }
ToDosRepositoryTest >> testRemoveAnInProgressToDoOfARepositoryShouldFail [

	| aToDo aToDoRepository |

	aToDoRepository := ToDosRepository new.

	self assertEmpty: aToDoRepository toDos.

	aToDo := ToDo describedBy: 'Buy the Corvette'.
	
	aToDoRepository addToDo: aToDo.

	aToDo
		assignTo: (Employee named: 'Kam');
		markAsInProgress.	

	self
		should: [aToDoRepository removeToDo: aToDo]
		raise: AssertionFailed
		description: 'The ToDo is not open'
]

{ #category : #tests }
ToDosRepositoryTest >> testTodosRepositoryStartsEmpty [

	self assertEmpty: ToDosRepository new toDos
]
