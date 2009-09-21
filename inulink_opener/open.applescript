on GetDefaultWebBrowser()
	set _scpt to "export VERSIONER_PERL_PREFER_32_BIT=yes; " & Â
		"perl -MMac::InternetConfig -le " & Â
		"'print +(GetICHelper \"http\")[1]'"
	return do shell script _scpt
end GetDefaultWebBrowser

on ParentPath(this_text)
	set y to 0
	repeat with thisChar in this_text
		set y to y + 1
		set x to the offset of thisChar in ":"
		if x is not 0 then
			set z to y
		end if
	end repeat
	return (text from character 1 to z of this_text)
end ParentPath


-- start main routine here --
global _browser
set _browser to GetDefaultWebBrowser()

set scpt_path to (path to me) as text
set launch_script to ParentPath(scpt_path) & _browser & ".applescript"

run script file launch_script