"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestToDoAppApplication,
	#superclass : #PackageManifest,
	#category : #'ToDoApp-Application-Manifest'
}

{ #category : #'code-critics' }
ManifestToDoAppApplication class >> ruleGRBlockFormattingRuleV1FalsePositive [
	^ #(#(#(#RGPackageDefinition #(#'ToDoApp-Application')) #'2021-11-23T15:04:57.656287-03:00') )
]
