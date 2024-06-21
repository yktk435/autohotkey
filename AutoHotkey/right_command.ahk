#Requires AutoHotkey v2.0

SetTitleMatchMode "RegEx"

^Space:: {
    path := "C:\Program Files\Microsoft VS Code\Code.exe"
    exeName:="Code.exe"
    myWinActivate("ahk_exe" exeName)

    return
}

^+Space:: {
    myWinActivate(".*Microsoft​ Edge$")

    return
}

LAlt & Space:: {
    myWinActivateWithClick("ahk_exe powershell.exe")

    return
}

#HotIf GetKeyState('F14', 'P')
s:: {
    myWinActivate("ahk_exe ms-teams.exe")

    return
}

h:: {
    myWinActivate("^GitLab.*")

    return
}
g:: {
    myWinActivate("^GitLab.*")

    return
}
z:: {
    myWinActivate("^ChatGPT.*")

    return
}
l:: {
    myWinActivate("ahk_exe thunderbird.exe")

    return
}
#HotIf

; ターミナルの場合はクリックしないとちゃんとしたフォーカスにならない
myWinActivate(arg*) {
    baseMyWinActivate(false, arg*)
}

myWinActivateWithClick(arg*) {
    baseMyWinActivate(true, arg*)
}

baseMyWinActivate(requiredClick := false, arg*) {
    if (WinExist(arg*))
    {
        if (requiredClick) {
            WinActivate(arg*)
            WinGetPos(&X, &Y, &Width, &Height, arg*)
            Click(((Width - X) // 2) + X, ((Height - Y) // 2) + Y)
        } else {
            WinActivate(arg*)
        }
    } else {
        ; Run(arg*)
        MsgBox "起動してないよ"
    }

}
