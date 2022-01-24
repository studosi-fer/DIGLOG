#NoEnv
#Warn
SendMode Input

^p::
Send, % RegExReplace(clipboard, "\r\n?|\n\r?", "`n")
	return