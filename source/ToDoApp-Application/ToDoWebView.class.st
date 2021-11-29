Class {
	#name : #ToDoWebView,
	#superclass : #WAPainter,
	#instVars : [
		'startDateField',
		'descriptionField',
		'completionDateField'
	],
	#category : #'ToDoApp-Application'
}

{ #category : #accessing }
ToDoWebView class >> errorDescriptionFieldCommand [

	^ [ :field | field setStyleTo: [ :style | style borderColor: 'red' ] ]
]

{ #category : #'instance creation' }
ToDoWebView class >> new [

	^ self
		  withDescriptionFieldSuggesting: 'Description'
		  applying: [  ] asWebComponentCommand
]

{ #category : #'instance creation' }
ToDoWebView class >> newWhenDescriptionIsEmpty [

	^ self
		withDescriptionFieldSuggesting: 'A ToDo must have a description'
		applying: self errorDescriptionFieldCommand
]

{ #category : #'private - instance creation' }
ToDoWebView class >> withDescriptionFieldSuggesting: aSuggestion applying: aComponentCommand [

	^ super new initializeWithDescriptionFieldSuggesting: aSuggestion applying: aComponentCommand
]

{ #category : #configuring }
ToDoWebView >> configureTriggers [

	startDateField on trigger serializeIt.
	descriptionField on trigger serializeIt.
	completionDateField on trigger serializeIt
]

{ #category : #accessing }
ToDoWebView >> dateFieldSuggesting: aPlaceholderText [

	^ self componentSupplier
		dateFieldApplying: [ :theField | theField setPlaceholderTo: aPlaceholderText ]
]

{ #category : #initialization }
ToDoWebView >> initializeCompletionDateField [

	completionDateField := self dateFieldSuggesting: 'Completion Date'
]

{ #category : #initialization }
ToDoWebView >> initializeDescriptionFieldSuggesting: aSuggestion applying: aComponentCommand [

	descriptionField := self componentSupplier
		singleLineTextFieldApplying: [ :theField | (theField setPlaceholderTo: aSuggestion) + aComponentCommand ]
]

{ #category : #initialization }
ToDoWebView >> initializeStartDateField [

	startDateField := self dateFieldSuggesting: 'Start Date'
]

{ #category : #initialization }
ToDoWebView >> initializeWithDescriptionFieldSuggesting: aSuggestion applying: aComponentCommand [

	self
		initializeStartDateField;
		initializeDescriptionFieldSuggesting: aSuggestion applying: aComponentCommand;
		initializeCompletionDateField;
		configureTriggers
]

{ #category : #rendering }
ToDoWebView >> renderContentOn: aCanvas [

	aCanvas
		render: startDateField;
		render: descriptionField;
		render: completionDateField
]

{ #category : #configuring }
ToDoWebView >> updateViewsWith: aToDo [

	aToDo withStartDateDo: [ :aStartDate | startDateField changeModelTo: aStartDate ] ifNone: [  ].

	descriptionField changeModelTo: aToDo description.

	aToDo withCompletionDateDo: [ :aCompletionDate | 
		completionDateField changeModelTo: aCompletionDate ]
		ifNone: [  ]
]

{ #category : #building }
ToDoWebView >> withModelDo: aBlock ifUnable: anotherBlock [

	descriptionField model
		ifEmpty: anotherBlock
		ifNotEmpty: [ :toDoDescription | 
			| toDo |

			toDo := ToDo describedBy: toDoDescription.

			startDateField contents
				ifEmpty: [  ]
				ifNotEmpty: [ :dateAsString | toDo setStartDateTo: (Date fromString: dateAsString) ].

			completionDateField contents
				ifEmpty: [  ]
				ifNotEmpty: [ :dateAsString | toDo setCompletionDateTo: (Date fromString: dateAsString) ].
			aBlock value: toDo
			]
]
