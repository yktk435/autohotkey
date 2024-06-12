#Requires AutoHotkey v2.0

F14 & Tab:: {
    global counter
    global currentProcessname
    global winIds
    counter++
    MsgBox counter
    currentWinId:=WinGetID('A')
    acctiveProcessName := WinGetProcessName(currentWinId)
    if (currentProcessname != acctiveProcessName) {
        currentProcessname := acctiveProcessName
        winIds := []
        
    }
    MsgBox acctiveProcessName

}

global counter := 0
global currentProcessname := ''
global winIds := []
