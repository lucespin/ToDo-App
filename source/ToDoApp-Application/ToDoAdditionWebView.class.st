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
	#name : #ToDoAdditionWebView,
	#superclass : #WAPainter,
	#instVars : [
		'descriptionField',
		'startDateField',
		'completionDateField',
		'acceptButton'
	],
	#category : #'ToDoApp-Application'
}

{ #category : #adding }
ToDoAdditionWebView >> addToDo [

	| toDoDescription toDo |

	toDoDescription := descriptionField model.
	toDo := ToDo describedBy: toDoDescription.

	startDateField contents
		ifEmpty: []
		ifNotEmpty: [:dateAsString | toDo setStartDateTo: (Date fromString: dateAsString)].

	completionDateField contents
		ifEmpty: []
		ifNotEmpty: [:dateAsString | toDo setCompletionDateTo: (Date fromString: dateAsString)].

	self session applicationContext addToDo: toDo
]

{ #category : #configuring }
ToDoAdditionWebView >> configureTriggers [

	startDateField on trigger serializeIt.
	descriptionField on trigger serializeIt.
	completionDateField on trigger serializeIt.

	acceptButton on trigger
		disable;
		serverDo: [ 
			self addToDo.
			self session applicationContext setCurrentWebViewTo: ToDosWebView new
			];
		render: self session applicationContext identifiedCurrentWebView
]

{ #category : #initialization }
ToDoAdditionWebView >> dateFieldWithPlaceholder: aPlaceholderText [

	^ self componentSupplier
		dateFieldApplying: [:theField | theField setPlaceholderTo: aPlaceholderText]
]

{ #category : #initialization }
ToDoAdditionWebView >> initialize [

	super initialize.

	self
		initializeFields;
		initializeAdditionButton;
		configureTriggers
]

{ #category : #initialization }
ToDoAdditionWebView >> initializeAdditionButton [

	acceptButton := self componentSupplier asynchronicButtonLabeled: 'Accept'
		                applying: [ :theButton |  ]
]

{ #category : #initialization }
ToDoAdditionWebView >> initializeFields [

	startDateField := self dateFieldWithPlaceholder: 'Start Date'.

	descriptionField := self componentSupplier
		singleLineTextFieldApplying: [:theField | theField setPlaceholderTo: 'Description'].

	completionDateField := self dateFieldWithPlaceholder: 'Completion Date'.
]

{ #category : #rendering }
ToDoAdditionWebView >> renderContentOn: aCanvas [

	aCanvas
		render: startDateField;
		render: descriptionField;
		render: completionDateField;
		render: acceptButton
]
