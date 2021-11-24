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
	acceptButton:		<Object>
	nameField:		<Object>


    Implementation Points
"
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

	acceptButton := self componentSupplier asynchronicButtonLabeled: 'Accept'
		                applying: [ :theButton |  ]
]

{ #category : #initialization }
EmployeeRegistrationWebView >> renderContentOn: aCanvas [

	aCanvas
		render: nameField;
		render: acceptButton
]
