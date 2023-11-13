#SingleInstance force ;If this script is already running, terminate it and load a new instance
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

ScanError=0 ;scan again if there is error
launchws2()
SonarscanLabel:
sonarscan()
sonarsuccesscheck()
if(ScanError=1){
ScanError=0
goto SonarscanLabel
}
sonarqube()
innersource()
ExitApp

launchws2()
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

sonarscan()
{
	Sleep 5000
	RunWait,C:\Users\arka.mitra\Desktop\sonarqube.bat
	if WinExist("SonarQube ahk_exe cmd.exe"){
	WinClose, SonarQube ahk_exe cmd.exe
	}
}

sonarsuccesscheck()
{
	sleep 6000
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
}

sonarqube()
{
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
}

innersource(){
	Run chrome.exe --app="https://innersource.{domain}.com/users/Arka.Mitra/repos/nfocus-front-backend/pull-requests?create&sourceBranch=refs`%2Fheads`%2Fdevelop&targetRepoId=143268"
	SetTitleMatchMode,1
	WinWait, Create Pull Request Mitra,,20
	if WinExist("Create Pull Request Mitra, Arka / nfocus-front-backend - Bitbucket"){
	WinActivate
	WinMaximize
	Sleep 500
	Loop
  	{
    	PixelGetColor, Loaded, 908, 86
    	if (Loaded="0x2158EB")
      	break
  	}
	sleep 6000
	Send,{Tab 7} ;CREATE
	Send,{Enter}
	sleep 2000
	Send, {Tab 5} ;CONTINUE
	Send, {Enter}
	WinWait, Pull Request,,20
	WinActivate, Pull Request
	WinMaximize
	Sleep 3000
	MouseClick, Left, 1773, 158 ;TOP RIGHT MERGE
	Sleep 200
	Send, {Tab 3} 
	Send {Enter} ;FINAL MERGE
	Sleep 10000
	WinClose, Pull Request
	}
	WinClose, Create Pull Request Mitra
}
