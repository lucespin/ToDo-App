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
	#name : #ToDoAppTableWebView,
	#superclass : #WAPainter,
	#category : #'ToDoApp-Application'
}

{ #category : #adding }
ToDoAppTableWebView >> addColumnTitled: aTitle rendering: aRenderingCommand [

	^ [ :column | 
	column
		titled: aTitle applying: [ :title | title setStyleTo: self titleStyle ];
		rendering: aRenderingCommand;
		applyingToEachCell: [ :cell | cell setStyleTo: [ :style | style padding: 8 px ] ]
	]
]

{ #category : #rendering }
ToDoAppTableWebView >> renderContentOn: aCanvas [

	| toDosTable |

	toDosTable := TableWebViewBuilder new
		addColumn: (self addColumnTitled: 'Start Date' rendering: [ '23/10/2021' "*"]);
		addColumn: (self addColumnTitled: 'Description' rendering: [ 'Hacer preparativos' "*"]);
		addColumn: (self addColumnTitled: 'Completion Date' rendering: [ '19/05/2022' "*"]);
		addColumn: (self addColumnTitled: 'Assigned To' rendering: [ 'Lala' "*"]);
		apply: [ :table | table setStyleTo: [ :style | style width: '100%' ] ];
		build.

	toDosTable changeContentsTo: #(1 2 3 4). "*"

	aCanvas render: toDosTable
	
	"* Only for showing something"
]

{ #category : #'Configuring - CSS' }
ToDoAppTableWebView >> titleStyle [

	^ [ :style | 
	style
		color: 'white';
		backgroundColor: '#8730FF';
		textAlign: #center;
		opacity: '90%'
	]
]
