Class {
	#name : #EDACStringTest,
	#superclass : #TestCase,
	#category : #'EDAC-Traits-Tests'
}

{ #category : #tests }
EDACStringTest >> testAsURLWorkWithNonAscii [
	self
		shouldnt:
			[ 'https://s3-eu-west-1.amazonaws.com/mail-templates.core.contestia.nexplore.com/00005/Test challenge 4 María/invitationAccepted_BOTH.tmpl'
				asUrl ]
		raise: ZnCharacterEncodingError
]
