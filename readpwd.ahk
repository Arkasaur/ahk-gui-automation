#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

Run,C:\Users\arka.mitra\Desktop\AHK automation\pwd.docx,,Hide
WinWaitActive, Password
Sleep, 1000
Send, password
Send {Enter}
Sleep 3000
Send,^a
Sleep 500
Send,^c
Sleep 500
CLipWait
pwd:=clipboard
Msgbox,%pwd%
WinClose,ahk_exe WINWORD.EXE