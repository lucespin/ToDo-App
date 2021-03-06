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
	#name : #CategoryTest,
	#superclass : #TestCase,
	#instVars : [
		'aToDo'
	],
	#category : #'ToDoApp-Tests'
}

{ #category : #tests }
CategoryTest >> testCategorizeAToDo [

	| category |

	category := Category named: 'Enhancement'.

	category categorize: aToDo.

	self assert: (category isCategorizing: aToDo)
]

{ #category : #tests }
CategoryTest >> testCreateACategoryWithAName [

	| category |

	category := Category named: 'Enhancement'.

	self assert: category name equals: 'Enhancement'
]

{ #category : #tests }
CategoryTest >> testRemoveCategoryToAToDo [

	| category |

	category := Category named: 'Enhancement'.

	category categorize: aToDo.

	self assert: (category isCategorizing: aToDo).

	category removeCategoryTo: aToDo.

	self deny: (category isCategorizing: aToDo)
]
