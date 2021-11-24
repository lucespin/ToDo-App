"
Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:

For the Class part:  State a one line summary. For example, ""I represent a paragraph of text"".

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.


    Implementation Points
"
Class {
	#name : #ToDosWebView,
	#superclass : #WAPainter,
	#instVars : [
		'toDosTable',
		'additionButton'
	],
	#category : #'ToDoApp-Application'
}

{ #category : #adding }
ToDosWebView >> addColumnTitled: aTitle rendering: aRenderingCommand [

	^ [:column | 
	column
		titled: aTitle applying: [:title | title setStyleTo: self titleStyle];
		rendering: aRenderingCommand;
		applyingToEachCell: [:cell | 
			cell
				setStyleTo: [:style | 
					style
						padding: 8 px;
						textAlign: #center
					]
			]
	]
]

{ #category : #initialization }
ToDosWebView >> initialize [

	super initialize.

	self
		initializeTableWebView;
		initializeAdditionButton
]

{ #category : #initialization }
ToDosWebView >> initializeAdditionButton [

	additionButton := self componentSupplier
		asynchronicButtonLabeled: 'Add ToDo'
		applying: [:theButton | ].

	additionButton on trigger
		serverDo: [self session applicationContext
				setCurrentWebViewTo: (ToDoAdditionWebView
								withDescriptionFieldShowing: 'Description'
								andApplying: [] asWebComponentCommand)
			];
		render: self session applicationContext identifiedCurrentWebView
]

{ #category : #initialization }
ToDosWebView >> initializeTableWebView [

	toDosTable := self componentSupplier tableBuilder
		addColumn:
			(self
				addColumnTitled: 'Start Date'
				rendering: [:toDo | toDo withStartDateDo: [:date | date] ifNone: ['Unassigned']]);
				
		addColumn: (self addColumnTitled: 'Description' rendering: [:toDo | toDo description]);
		
		addColumn:
			(self
				addColumnTitled: 'Completion Date'
				rendering: [:toDo | toDo withCompletionDateDo: [:date | date] ifNone: ['Unassigned']]);
				
		addColumn:
			(self
				addColumnTitled: 'Assigned To'
				rendering: [:toDo | toDo withAssignedEmployeeDo: [:employee | employee name] ifNone: ['Unassigned']]);
				
		apply: [:table | table setStyleTo: [:style | style width: '100%']];
		build
]

{ #category : #rendering }
ToDosWebView >> renderContentOn: aCanvas [

	toDosTable changeContentsTo: self toDos.

	aCanvas
		render: toDosTable;
		render: additionButton
]

{ #category : #'Configuring - CSS' }
ToDosWebView >> titleStyle [

	^ [ :style | 
	  style
		  color: 'white';
		  backgroundColor: '#8730FF';
		  textAlign: #center;
		  opacity: '90%'
	  ]
]

{ #category : #accessing }
ToDosWebView >> toDos [

	^ self session applicationContext toDos
]
