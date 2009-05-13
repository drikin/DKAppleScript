property MAX_VISIT : 20
property START_POSITION : 4
property VISITED_COLOR : "rgb(102, 102, 102)"
property SITE_URL : "http://61.194.39.44/~inu/link/koinu.shtml"

tell application "Safari"
	activate
	try
		-- open InuLink
		my new_window()
		set URL of document 1 to SITE_URL
		my page_loaded(10)
		-- end open InuLink
		
		set the link_count to (do JavaScript "document.links.length" in document 1)
		if the link_count is 0 then
			display dialog "No links in this document." with icon 1 buttons {"Cancel"} default button 1
			return
		end if
		
		set the document_URL to (do JavaScript "document.URL" in document 1)
		set AppleScript's text item delimiters to "/"
		if document_URL is not "about:blank" then
			set the parent_URL to ((text items 1 thru -2 of the document_URL) as string) & "/"
		end if
		set AppleScript's text item delimiters to ""
		
		set the target_links to {}
		if the link_count < MAX_VISIT then
			set MAX_VISIT to link_count
		end if
		
		-- start position is 4 at InuLink
		set i to START_POSITION
		set c to MAX_VISIT
		repeat until c < 1
			set this_URL to (do JavaScript "document.links[" & (i as string) & "]" in document 1)
			set visit to (do JavaScript "document.defaultView.getComputedStyle(document.links[" & (i as string) & "], null).getPropertyValue('color')" in document 1)
			set i to i + 1
			if visit is not VISITED_COLOR then
				-- specific InuLink: remove redirect link 
				set AppleScript's text item delimiters to "?"
				if (count text item of this_URL) > 2 then
					set the this_URL to ((text items 2 thru -1 of the this_URL) as string) & "/"
				end if
				set AppleScript's text item delimiters to ""
				-- end specific InuLink
				
				set the end of the target_links to this_URL
				set c to c - 1
			end if
		end repeat
		
		if the target_links is {} then
			error "There are no links"
			return
		end if
		
		repeat with i from 1 to number of items in the target_links
			set the target_URL to item i of the target_links
			my new_tab()
			set URL of document 1 of application "Safari" to target_URL
		end repeat
		
	on error the error_message number the error_number
		if the error_number is not -128 then
			display dialog the error_message buttons {"OK"} default button 1
		end if
	end try
end tell

on new_tab()
	tell application "Safari" to activate
	tell application "System Events"
		tell process "Safari"
			click menu item "New Tab" of menu "File" of menu bar 1
		end tell
	end tell
end new_tab

on new_window()
	tell application "Safari" to activate
	tell application "System Events"
		tell process "Safari"
			click menu item "New Window" of menu "File" of menu bar 1
		end tell
	end tell
end new_window

on page_loaded(timeout_value) -- in seconds
	delay 2
	repeat with i from 1 to timeout_value
		tell application "Safari"
			if (do JavaScript "document.readyState" in document 1) is "complete" then
				return true
			else if i is timeout_value then
				return false
			else
				delay 1
			end if
		end tell
	end repeat
	return false
end page_loaded
