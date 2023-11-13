#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetTitleMatchMode, 1

#n::
WinActivate, Create Pull Request Mitra
WinMaximize, Create Pull Request Mitra
Send,admin
if WinExist("Create Pull Request Mitra, Arka / nfocus-front-backend - Bitbucket"){
MsgBox, "Inside"
}
else
{
MsgBox, "Does not exist"
}
SetTitleMatchMode, 3
return

#c::
PixelGetColor, colorIS, 908, 86
if(colorIS="0x2158EB"){
msgBox,matched!
}
return

#d::
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
return