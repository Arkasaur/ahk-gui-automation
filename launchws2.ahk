#SingleInstance force ;If this script is already running, terminate it and load a new instance
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

Run C:\Users\Public\pleiades-4.7.2-java-win-64bit-jre_20171225\pleiades\eclipse\eclipse.exe
WinWaitActive, Eclipse Launcher,,10
if WinActive(Eclipse Launcer){ 
ControlSetText, Edit1, C:\Users\Public\new-web\eclipse\workspace_2, Eclipse Launcher
Send {Enter}
}

{
	Run C:\Users\Public\pleiades-4.7.2-java-win-64bit-jre_20171225\pleiades\eclipse\eclipse.exe
	WinWaitActive, Eclipse Launcher,,10
	if WinActive(Eclipse Launcer){ 
	ControlSetText, Edit1, C:\Users\Public\new-web\eclipse\workspace_2, Eclipse Launcher
	Send {Enter}
	}

	WinWaitActive, workspace_2 - Eclipse,,20
	if WinActive(workspace_2 - Eclipse){
	WinMaximize
	sleep 8000
	MouseClick, Right, 81, 163
	sleep 3000
	Send {Down 8}
	Send {Enter}
	WinWaitActive, Login ahk_class #32770,,30
	if WinActive(Login){
	ControlSetText,Edit2,arka.mitra,Login
	RegRead, Password, HKEY_CURRENT_USER\Software\TestKey, MyPass
	ControlSetText,Edit3,%Password%,Login
	Send {Enter}
	WinWaitActive,Pull Result for aceApp,,300
	if WinActive("Pull Result for aceApp"){
	Sleep 2000
	Send {Enter}
	}
	}
	}
	Sleep 2000
	WinClose, workspace_2 - Eclipse
	WinWait, Confirm Exit
	WinActivate
	Sleep 500
	Send {Enter}
}
