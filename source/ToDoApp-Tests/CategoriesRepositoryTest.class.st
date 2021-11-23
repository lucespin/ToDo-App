Class {
	#name : #CategoriesRepositoryTest,
	#superclass : #TestCase,
	#category : #'ToDoApp-Tests'
}

{ #category : #tests }
CategoriesRepositoryTest >> testAddACategoryToARepository [

	| aCategory aCategoryRepository |
	
	aCategory := Category named: 'Enhancement'.
		
	aCategoryRepository := CategoriesRepository new.
	
	aCategoryRepository add: aCategory.
	
	self assert: (aCategoryRepository contains: aCategory)
]

{ #category : #tests }
CategoriesRepositoryTest >> testRemoveACategoryOfARepository [

	| aCategory aCategoryRepository |

	aCategory := Category named: 'Enhancement'.

	aCategoryRepository := CategoriesRepository new.

	aCategoryRepository add: aCategory.

	self assert: (aCategoryRepository contains: aCategory).

	aCategoryRepository remove: aCategory.

	self deny: (aCategoryRepository contains: aCategory)
]
