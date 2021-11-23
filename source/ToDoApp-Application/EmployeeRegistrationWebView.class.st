Class {
	#name : #EmployeeRegistrationWebView,
	#superclass : #WAPainter,
	#instVars : [
		'nameField',
		'acceptButton'
	],
	#category : #'ToDoApp-Application'
}

{ #category : #initialization }
EmployeeRegistrationWebView >> addEmployee [

	| employeeName employee |

	employeeName := nameField model.
	employee := Employee named: employeeName.

	self session applicationContext addEmployee: employee
]

{ #category : #initialization }
EmployeeRegistrationWebView >> configureTriggers [

	nameField on trigger serializeIt.

	acceptButton on trigger
		disable;
		serverDo: [ 
			self addEmployee.
			self session applicationContext setCurrentWebViewTo: EmployeesWebView new
			];
		render: self session applicationContext identifiedCurrentWebView
]

{ #category : #initialization }
EmployeeRegistrationWebView >> initialize [

	super initialize.

	self
		initializeNameField;
		initializeRegistrationButton;
		configureTriggers
]

{ #category : #initialization }
EmployeeRegistrationWebView >> initializeNameField [

	nameField := self componentSupplier singleLineTextFieldApplying: [ :theField | 
		             theField setPlaceholderTo: 'Employee''s name' ]
]

{ #category : #initialization }
EmployeeRegistrationWebView >> initializeRegistrationButton [

	acceptButton := self componentSupplier asynchronicButtonLabeled: 'Add employee'
		                applying: [ :theButton |  ]
]

{ #category : #initialization }
EmployeeRegistrationWebView >> renderContentOn: aCanvas [

	aCanvas
		render: nameField;
		render: acceptButton
]
