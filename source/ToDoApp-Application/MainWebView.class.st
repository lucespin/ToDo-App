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
	buttonsWebView:		<Object>
	identifiedCurrentWebView:		<Object>


    Implementation Points
"
Class {
	#name : #MainWebView,
	#superclass : #WAPainter,
	#instVars : [
		'identifiedCurrentWebView',
		'buttonsWebView',
		'headingWebView'
	],
	#category : #'ToDoApp-Application'
}

{ #category : #accessing }
MainWebView >> identifiedCurrentWebView [

	^ identifiedCurrentWebView
]

{ #category : #initialization }
MainWebView >> initialize [

	super initialize.
	self
		initializeButtonsWebView;
		initializeHeadingWebView;
		initializeIdentifiedCurrentWebView
]

{ #category : #initialization }
MainWebView >> initializeButtonsWebView [

	buttonsWebView := ButtonsWebView new
]

{ #category : #initialization }
MainWebView >> initializeHeadingWebView [

	headingWebView := ToDoAppHeadingWebView displaying: 'ToDo Application'
]

{ #category : #initialization }
MainWebView >> initializeIdentifiedCurrentWebView [

	identifiedCurrentWebView := self componentSupplier divisionContainerWrapping: [ :aCanvas | 
		                            aCanvas render: self session applicationContext currentWebView ]
		                            applying: [  ].

	identifiedCurrentWebView beIdentifiable
]

{ #category : #rendering }
MainWebView >> renderContentOn: aCanvas [

	aCanvas
		render:
			(self componentSupplier
				divisionContainerWrapping: [ :canvas | 
					canvas
						render: headingWebView;
						render: buttonsWebView;
						render: identifiedCurrentWebView
					]
				applying: [ :div | div addClass bootstrap3 container ])
]
