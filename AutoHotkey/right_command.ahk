#Requires AutoHotkey v2.0

SetTitleMatchMode "RegEx"

F14 & z::{
    WinActivate("^ChatGPT.*")

    return 
}

^Space::{
    WinActivate("ahk_exe Code.exe")

    return 
}

+^Space::{
    WinActivate(".*Google Chrome$")

    return 
}

!Space::{
    WinActivate("ahk_exe powershell.exe")

    return 
}
