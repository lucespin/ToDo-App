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
		'additionButton',
		'editButton',
		'deleteButton'
	],
	#category : #'ToDoApp-Application'
}

{ #category : #styling }
ToDosWebView >> actionsButtonsStyleCommand [

	^ [:style | 
	style
		backgroundColor: '#7724FF';
		color: #white;
		fontWeight: #bold
	]
]

{ #category : #styling }
ToDosWebView >> addButtonStyleCommand [

	^ [:style | 
	style
		backgroundColor: '#57FF7A';
		color: #white;
		fontWeight: #bold
	] 
]

{ #category : #adding }
ToDosWebView >> addColumnTitled: aTitle rendering: aRenderingCommand [

	^ [:column | 
	column
		titled: aTitle applying: [:title | title setStyleTo: self titleStyleCommand ];
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
ToDosWebView >> assignedEmployeeColumn [

	^ self
		addColumnTitled: 'Assigned To'
		rendering: [:toDo | toDo withAssignedEmployeeDo: [:employee | employee name] ifNone: ['Unassigned']]
]

{ #category : #initialization }
ToDosWebView >> completionDateColumn [

	^ self
		addColumnTitled: 'Completion Date'
		rendering: [:toDo | toDo withCompletionDateDo: [:date | date] ifNone: ['Unassigned']]
]

{ #category : #initialization }
ToDosWebView >> deleteActionColumn [

	^ self
		addColumnTitled: ''
		rendering: [deleteButton]
]

{ #category : #initialization }
ToDosWebView >> descriptionColumn [

	^ self addColumnTitled: 'Description' rendering: [:toDo | toDo description]
]

{ #category : #initialization }
ToDosWebView >> editActionColumn [

	^ self
		addColumnTitled: ''
		rendering: [editButton]
]

{ #category : #initialization }
ToDosWebView >> initialize [

	super initialize.

	self
		initializeTableWebView;
		initializeAdditionButton;
		initializeEditActionButton;
		initializeDeleteActionButton 
]

{ #category : #initialization }
ToDosWebView >> initializeAdditionButton [

	additionButton := self componentSupplier
		asynchronicButtonLabeled: 'Add ToDo'
		applying: [:button | button setStyleTo: self addButtonStyleCommand].

	additionButton on trigger
		serverDo: [self session applicationContext
				setCurrentWebViewTo: (ToDoAdditionWebView
								withDescriptionFieldShowing: 'Description'
								andApplying: [] asWebComponentCommand)
			];
		render: self session applicationContext identifiedCurrentWebView
]

{ #category : #initialization }
ToDosWebView >> initializeDeleteActionButton [

	deleteButton := self componentSupplier
		asynchronicButtonLabeled: 'Delete'
		applying: [:button | button setStyleTo: self actionsButtonsStyleCommand].

	deleteButton on trigger
		serverDo: [self session applicationContext
				setCurrentWebViewTo: (self halt)
			];
		render: self session applicationContext identifiedCurrentWebView
]

{ #category : #initialization }
ToDosWebView >> initializeEditActionButton [

	editButton := self componentSupplier
		asynchronicButtonLabeled: 'Edit'
		applying: [:button | button setStyleTo: self actionsButtonsStyleCommand].

	editButton on trigger
		serverDo: [self session applicationContext
				setCurrentWebViewTo: (self halt)
			];
		render: self session applicationContext identifiedCurrentWebView
]

{ #category : #initialization }
ToDosWebView >> initializeTableWebView [

	toDosTable := self componentSupplier tableBuilder
		addColumn: self startDateColumn;
		addColumn: self descriptionColumn;
		addColumn: self completionDateColumn;
		addColumn: self assignedEmployeeColumn;
		addColumn: self editActionColumn;
		addColumn: self deleteActionColumn;
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

{ #category : #initialization }
ToDosWebView >> startDateColumn [

	^ self
		addColumnTitled: 'Start Date'
		rendering: [:toDo | toDo withStartDateDo: [:date | date] ifNone: ['Unassigned']]
]

{ #category : #styling }
ToDosWebView >> titleStyleCommand [

	^ [ :style | 
	  style
		  color: #white;
		  backgroundColor: '#7724FF';
		  textAlign: #center
	  ]
]

{ #category : #accessing }
ToDosWebView >> toDos [

	^ self session applicationContext toDos
]
