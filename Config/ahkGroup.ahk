#Requires AutoHotkey v2.0


GroupAdd "windowsVim", "ahk_class CASCADIA_HOSTING_WINDOW_CLASS" ; Windows Terminal
GroupAdd "IgnoreApplications", "ahk_class CASCADIA_HOSTING_WINDOW_CLASS" ; Windows Terminal
GroupAdd "IgnoreApplications", "ahk_exe Code.exe" ; Visual Studio Code
GroupAdd "IgnoreApplications", "ahk_exe Cursor.exe" ; Cursor AI Editor

ListLines 0

SetControlDelay 0
SetKeyDelay -1
SetWinDelay 0
SendMode "Input"
