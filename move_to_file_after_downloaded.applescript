property target_dir : "~/Dropbox/Torrent"
property target_extension : "torrent"

on adding folder items to this_folder after receiving these_items
	try
		repeat with i from 1 to number of items in these_items
			set this_item to item i of these_items
			set the item_info to the info for this_item
			if (the name extension of the item_info is target_extension) then
				set scriptSrc to "mv " & quoted form of POSIX path of this_item & " " & target_dir
				try
					do shell script scriptSrc
				on error
					display dialog "Error"
				end try
			end if
		end repeat
	on error error_message number error_number
		if the error_number is not -128 then
			tell application "Finder"
				activate
				display dialog error_message buttons {"Cancel"} default button 1 giving up after 120
			end tell
		end if
	end try
end adding folder items to