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
