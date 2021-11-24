Class {
	#name : #CategoriesRepositoryTest,
	#superclass : #TestCase,
	#category : #'ToDoApp-Tests'
}

{ #category : #tests }
CategoriesRepositoryTest >> testAddACategoryToARepository [

	| aCategory aCategoryRepository |
		
	aCategoryRepository := CategoriesRepository new.
	
	self assertEmpty: aCategoryRepository categories.
	
	aCategory := Category named: 'Enhancement'.
	
	aCategoryRepository addCategory: aCategory.

	self withTheOnlyOneIn: aCategoryRepository categories
		do: [ :storedCategory | self assert: storedCategory equals: aCategory ]
]

{ #category : #tests }
CategoriesRepositoryTest >> testCategoriesRepositoryStartsEmpty [

	self assertEmpty: CategoriesRepository new categories
]

{ #category : #tests }
CategoriesRepositoryTest >> testRemoveACategoryOfARepository [

	| aCategory aCategoryRepository |

	aCategoryRepository := CategoriesRepository new.
	
	aCategory := Category named: 'Enhancement'.

	aCategoryRepository addCategory: aCategory.

	aCategoryRepository removeCategory: aCategory.

	self assert: aCategoryRepository categories isEmpty 
]
