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
	#name : #ToDoAppHeadingWebView,
	#superclass : #WAPainter,
	#instVars : [
		'potentialTextToDisplay'
	],
	#category : #'ToDoApp-Application'
}

{ #category : #'as yet unclassified' }
ToDoAppHeadingWebView class >> displaying: aPotentialText [

	^ self new initializeDisplaying: aPotentialText
]

{ #category : #'Configuring - CSS' }
ToDoAppHeadingWebView >> headingStyle [

	^ [ :style | 
		style
			textAlign: #center;
			textShadow: '0 0 3px #4907B3';
			color: '#5410B3';
			padding: 20 px;
			opacity: 90 percent
	]
]

{ #category : #initialization }
ToDoAppHeadingWebView >> initializeDisplaying: aPotentialText [
	
	potentialTextToDisplay := aPotentialText
]

{ #category : #rendering }
ToDoAppHeadingWebView >> renderContentOn: aCanvas [

	^ aCanvas
		render:
			(HeadingWebView
				displaying: potentialTextToDisplay 
				withLevel: 1
				applying: [ :heading | heading setStyleTo: self headingStyle ])
]
