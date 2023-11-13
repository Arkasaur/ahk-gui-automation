#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

Sleep 500
	Run,chrome.exe --app="http://localhost:9000/project/issues?id=aceApp_2&resolved=false&severities=BLOCKER`%2CCRITICAL&types=BUG"
	sleep 4000
	if WinExist("SonarQube ahk_class Chrome_WidgetWin_1"){
	WinMaximize,SonarQube ahk_class Chrome_WidgetWin_1
	sleep 500
	WinActivate
	Send admin
	Send {Tab}
	Sleep 500
	Send ADMIN
	Sleep 500
	Send {Enter}
	}
	else{
	WinMaximize,Issues ahk_exe chrome.exe
	WinActivate
	}
	sleep 6000
	MouseMove,1718,273
	sleep 2000
	MouseClickDrag,Left,1718,273,1789,273
	Sleep 100
	Send ^c
	ClipWait 
	Sleep 100

	text:=clipboard
	if(text!="0issues"){
	MsgBox, "OMG, SonarQube detected bug!"
	Sleep 3000
	ExitApp 
	}

	WinClose,SonarQube ahk_class Chrome_WidgetWin_1
	WinClose,Issues ahk_exe chrome.exe
	Sleep 2000