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

	^ self componentSupplier
		asynchronicButtonLabeled: aLabel
		applying:
			[:theButton | theButton setStyleTo: self buttonStyleCommand]
]

{ #category : #accessing }
ButtonsWebView >> buttonStyleCommand [

	^ [:style | 
	style
		position: #relative;
		left: 80 percent;
		backgroundColor: '#FFA73D';
		color: #white;
		fontWeight: #bold
	]
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
		configureTriggerOf: toDosButton toRender: ToDosDashboardWebView new
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
		render: toDosButton;
		render: employeesButton;
		render: homeButton
]
