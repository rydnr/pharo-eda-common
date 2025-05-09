Extension { #name : #DateAndTime }

{ #category : #'*EDAC-Traits' }
DateAndTime >> asYYYYmmddHMS [
	^ String
		streamContents: [ :s | 
			ExtendedDatePrinter new
				printDate: self
				format: #(3 2 1 $- 1 1 2)
				on: s.
			s nextPut: $-.
			self printHMSOn: s separatedBy: $- ]
]
