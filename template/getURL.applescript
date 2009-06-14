GetCurrentURL()
on GetCurrentURL()
	tell application "Safari"
		--delay 1
		try
			set theResult to {"", ""}
			set curDoc to (name of document 1 as text)
			set curURL to (URL of document 1 as text)
			set theResult to {curURL, curDoc}
			theResult
		on error
			beep
		end try
	end tell
	return theResult
end GetCurrentURL