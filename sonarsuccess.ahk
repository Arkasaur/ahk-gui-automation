#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


	sleep 2000
	Run,chrome.exe --app="http://localhost:9000/admin/background_tasks",,Max
	sleep 3000
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
	WinWaitActive, Background Tasks - Administration
	Sleep 3000
	MouseMove,81,669
	Loop{
		Sleep 500
		MouseClickDrag,Left,81,669,193,669
		Sleep 100
		Send ^c
		ClipWait 
		Sleep 100

		text:=clipboard
		if(text="FAILED"){
		;MsgBox, "OMG, SonarQube failed!"
		ScanError=1
		break
		}
		else if(text="SUCCESS"){
		;MsgBox, "Analysis is done!"
		break
		}
		Sleep 20000
		Send ^r
		Sleep 5000
	}
	WinClose, Background Tasks - Administration
