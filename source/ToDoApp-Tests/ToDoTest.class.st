Class {
	#name : #ToDoTest,
	#superclass : #TestCase,
	#instVars : [
		'writePrologue'
	],
	#category : #'ToDoApp-Tests'
}

{ #category : #running }
ToDoTest >> setUp [

	writePrologue := ToDo describedBy: 'Write the prologue of Funes, el memorioso'
]

{ #category : #tests }
ToDoTest >> testANewToDoIsOpen [

	| release |

	release := ToDo describedBy: 'Release 2.0 version'.

	self assert: release isOpen.

	self deny: release isInProgress.
	self deny: release isFinished
]

{ #category : #tests }
ToDoTest >> testAssignAnOpenToDoToAnEmployee [

	| aToDo |

	aToDo := ToDo describedBy: 'Preparar equipo de grabación'.

	aToDo assignTo: 'Dexter'.

	aToDo
		withAssignedEmployeeDo: [ :anEmployee | self assert: anEmployee equals: 'Dexter' ]
		ifNone: [ self assert: false ]
]

{ #category : #tests }
ToDoTest >> testAssingToAnEmployeeAFinishedToDoShouldFail [

	| aToDo |

	aToDo := ToDo describedBy: 'Preparar equipo de grabación'.

	aToDo
		assignTo: 'Dexter';
		markAsInProgress;
		markAsFinished.

	self
		should: [ aToDo assignTo: 'Debora' ]
		raise: AssertionFailed
		withMessageText: 'A finished ToDo can''t be reassigned'
]

{ #category : #tests }
ToDoTest >> testAssingToAnEmployeeAnInProgressToDoShouldFail [

	| aToDo |

	aToDo := ToDo describedBy: 'Preparar equipo de grabación'.

	aToDo
		assignTo: 'Dexter';
		markAsInProgress.

	self
		should: [ aToDo assignTo: 'Debora' ]
		raise: AssertionFailed
		withMessageText: 'An in-progress ToDo can''t be reassigned'
]

{ #category : #tests }
ToDoTest >> testCreateAToDoWithDescription [

	| aToDo |

	aToDo := ToDo describedBy: 'Correr 3km'.

	self assert: aToDo description equals: 'Correr 3km'
]

{ #category : #tests }
ToDoTest >> testCreateAToDoWithStartDate [

	| aToDo |

	aToDo := ToDo describedBy: 'Correr 3km' withStartDate: (Date year: 2021 month: 11 day: 21).

	aToDo
		withStartDateDo: [:date | self assert: date equals: (Date year: 2021 month: 11 day: 21)]
		ifNone: [self assert: false]
]

{ #category : #tests }
ToDoTest >> testCreateAToDoWithStartDateAfterCompletionDateShouldFail [

	| aToDo |

	self
		should: [aToDo := ToDo
				describedBy: 'Algo'
				withStartDate: (Date year: 2021 month: 11 day: 21)
				andCompletionDate: (Date year: 2021 month: 11 day: 11)
			]
		raise: AssertionFailed
		description: 'A completion date must be after the start date'
]

{ #category : #tests }
ToDoTest >> testCreateAToDoWithStartDateAndCompletionDate [

	| aToDo |

	aToDo := ToDo
		describedBy: 'Darle mantenimiento a los filtros'
		withStartDate: (Date year: 2021 month: 11 day: 21)
		andCompletionDate: (Date year: 2021 month: 11 day: 25).

	aToDo
		withStartDateDo: [:date | self assert: date equals: (Date year: 2021 month: 11 day: 21)]
		ifNone: [self assert: false].
		
	aToDo
		withCompletionDateDo: [:date | self assert: date equals: (Date year: 2021 month: 11 day: 25)]
		ifNone: [self assert: false]
]

{ #category : #tests }
ToDoTest >> testMarkAsFinishedAnOpenToDoShouldFail [

	| aToDo |

	aToDo := ToDo describedBy: 'Preparar equipo de grabación'.

	aToDo assignTo: 'Dexter'.

	self
		should: [ aToDo markAsFinished. ]
		raise: AssertionFailed
		withMessageText: 'An Open ToDo can''t be finished directy'
]

{ #category : #tests }
ToDoTest >> testMarkAsInProgressIfToDoIsNotAssignedShouldFail [

	| aToDo |

	aToDo := ToDo describedBy: 'Preparar equipo de grabación'.

	self
		should: [ aToDo markAsInProgress ]
		raise: AssertionFailed
		withMessageText: 'ToDo not assigned'
]

{ #category : #tests }
ToDoTest >> testPrintOnAStream [

	| aToDo |

	aToDo := ToDo
		describedBy: 'Iniciar proceso de registro'
		withStartDate: (Date year: 2021 month: 3 day: 5)
		andCompletionDate: (Date year: 2021 month: 3 day: 10).

	self
		assert: aToDo printString
		equals:
			'a ToDo with description: Iniciar proceso de registro. Assigned employee: unassigned. Start date: 5 March 2021. Completion date: 10 March 2021.'.

	aToDo assignTo: 'Carla'.
	self
		assert: aToDo printString
		equals:
			'a ToDo with description: Iniciar proceso de registro. Assigned employee: Carla. Start date: 5 March 2021. Completion date: 10 March 2021.'
]

{ #category : #tests }
ToDoTest >> testWhenDescriptionIsEmptyThenToDoCreationShouldFail [

	self
		should: [ ToDo describedBy: '' ]
		raise: InstanceCreationFailed
		withMessageText: 'A ToDo must have a description.'
]

{ #category : #tests }
ToDoTest >> testWhenMarkAsFinishedAFinishedToDoThenIsFinished [

	writePrologue
		assignTo: 'Jorge Luis Borges';
		markAsInProgress;
		markAsFinished;
		markAsFinished.

	self assert: writePrologue isFinished.

	self deny: writePrologue isOpen.
	self deny: writePrologue isInProgress
]

{ #category : #tests }
ToDoTest >> testWhenMarkAsFinishedAnInProgressToDoThenIsFinished [

	writePrologue
		assignTo: 'Jorge Luis Borges';
		markAsInProgress;
		markAsFinished.

	self assert: writePrologue isFinished.

	self deny: writePrologue isOpen.
	self deny: writePrologue isInProgress
]

{ #category : #tests }
ToDoTest >> testWhenMarkAsInProgressAnAssignedOpenToDoThenIsInProgress [

	writePrologue
		assignTo: 'Aye';
		markAsInProgress.

	self assert: writePrologue isInProgress.

	self deny: writePrologue isOpen.
	self deny: writePrologue isFinished
]

{ #category : #tests }
ToDoTest >> testWhenMarkAsInProgressAnInProgressToDoThenIsInProgress [

	writePrologue
		assignTo: 'Jorge Luis Borges';
		markAsInProgress;
		markAsInProgress.

	self assert: writePrologue isInProgress.

	self deny: writePrologue isOpen.
	self deny: writePrologue isFinished
]
