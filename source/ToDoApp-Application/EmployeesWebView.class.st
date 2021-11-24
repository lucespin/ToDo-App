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
	registrationButton:		<Object>
	tableWebView:		<Object>


    Implementation Points
"
Class {
	#name : #EmployeesWebView,
	#superclass : #WAPainter,
	#instVars : [
		'tableWebView',
		'registrationButton'
	],
	#category : #'ToDoApp-Application'
}

{ #category : #accessing }
EmployeesWebView >> addColumnTitled: aTitle rendering: aRenderingCommand [

	^ [ :column | 
	  column
		  titled: aTitle applying: [ :title | title setStyleTo: self titleStyle ];
		  rendering: aRenderingCommand;
		  applyingToEachCell: [ :cell | cell setStyleTo: [ :style | style padding: 8 px ] ]
	  ]
]

{ #category : #accessing }
EmployeesWebView >> employees [

	^ self session applicationContext employees
]

{ #category : #initialization }
EmployeesWebView >> initialize [

	super initialize.
	self
		initializeTableWebView;
		initializeRegistrationButton
]

{ #category : #initialization }
EmployeesWebView >> initializeRegistrationButton [

	registrationButton := self componentSupplier asynchronicButtonLabeled: 'Add Employee'
		                      applying: [ :theButton |  ].

	registrationButton on trigger
		serverDo: [ self session applicationContext setCurrentWebViewTo: EmployeeRegistrationWebView new ];
		render: self session applicationContext identifiedCurrentWebView
]

{ #category : #initialization }
EmployeesWebView >> initializeTableWebView [

	tableWebView := self componentSupplier tableBuilder
		                addColumn:
			                ( self addColumnTitled: 'Name' rendering: [ :employee | employee name ] );
		                build
]

{ #category : #rendering }
EmployeesWebView >> renderContentOn: aCanvas [

	tableWebView changeContentsTo: self employees.

	aCanvas
		render: tableWebView;
		render: registrationButton
]

{ #category : #accessing }
EmployeesWebView >> titleStyle [

	^ [ :style | 
	  style
		  color: 'white';
		  backgroundColor: '#8730FF';
		  textAlign: #center;
		  opacity: '90%'
	  ]
]
