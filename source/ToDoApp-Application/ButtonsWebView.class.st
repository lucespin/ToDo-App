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

    Instance Variables
	employeesButton:		<Object>
	homeButton:		<Object>
	toDosButton:		<Object>


    Implementation Points
"
Class {
	#name : #ButtonsWebView,
	#superclass : #WAPainter,
	#instVars : [
		'homeButton',
		'employeesButton',
		'toDosButton'
	],
	#category : #'ToDoApp-Application'
}

{ #category : #accessing }
ButtonsWebView >> buttonLabeled: aLabel [

	^ self componentSupplier asynchronicButtonLabeled: aLabel applying: [ :theButton |  ]
]

{ #category : #configuring }
ButtonsWebView >> configureTriggerOf: aButtonWebView toRender: aWebView [

	aButtonWebView on trigger
		serverDo: [ self session applicationContext setCurrentWebViewTo: aWebView ];
		render: self session applicationContext identifiedCurrentWebView
]

{ #category : #configuring }
ButtonsWebView >> configureTriggers [

	self
		configureTriggerOf: homeButton toRender: WelcomeWebView new;
		configureTriggerOf: employeesButton toRender: EmployeesWebView new;
		configureTriggerOf: toDosButton toRender: ToDosWebView new
]

{ #category : #initialization }
ButtonsWebView >> initialize [

	super initialize.
	self initializeButtons
]

{ #category : #initialization }
ButtonsWebView >> initializeButtons [

	homeButton := self buttonLabeled: 'Home'.
	employeesButton := self buttonLabeled: 'Employees'.
	toDosButton := self buttonLabeled: 'ToDos'
]

{ #category : #initialization }
ButtonsWebView >> renderContentOn: aCanvas [

	"Se configuran los triggers en este momento dado que en el #initialize todavía el contexto no está creado.- ebalsamo"

	self configureTriggers.

	aCanvas
		render: homeButton;
		render: employeesButton;
		render: toDosButton
]
