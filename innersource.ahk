#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

Run chrome.exe --app="https://innersource.{domain}.com/users/arka.mitra/repos/nfocus-front-backend/pull-requests?create&sourceBranch=refs`%2Fheads`%2Fdevelop&targetRepoId=143268"
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