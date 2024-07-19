#Requires AutoHotkey v2.0

HIDEN_WINDE_IDS := {}
PREV_WIN_ID := {}

SetTitleMatchMode "RegEx"

^Space:: {
    path := "C:\Program Files\Microsoft VS Code\Code.exe"
    exe_name := "Code.exe"
    myWinActivate("ahk_exe " exe_name)
    ; hideToggl("ahk_exe" exe_name)

    return
}

^+Space:: {
    myWinActivate(".*Microsoft​ Edge$")

    return
}

LAlt & Space:: {
    ; myWinActivateForCommandPrompt("ahk_exe powershell.exe")
    hideToggl(true, "ahk_exe powershell.exe")

    return
}


#HotIf GetKeyState('F14', 'P')
s:: {
    myWinActivate("ahk_exe ms-teams.exe")

    return
}

u:: {
    DetectHiddenWindows 1
    list := WinGetList('ahk_exe msedge.exe')
    for _winId in list
    {
        if (isApplication(_winId)) {
            WinShow(_winId)
            WinActivate(_winId)
        }
    }
    DetectHiddenWindows 0
}

h:: {
    myWinActivate("^GitLab.*")

    return
}
g:: {
    myWinActivate("^GitLab.*")
    ; hideToggl(false, "^GitLab.*")

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

myWinActivateForCommandPrompt(arg*) {
    baseMyWinActivate(true, arg*)
}

baseMyWinActivate(requiredClick := false, arg*) {
    if (WinExist(arg*))
    {
        if (requiredClick) {
            WinActivate(arg*)
            WinGetPos(&X, &Y, &Width, &Height, arg*)
            ;コマンドプロンプト用で作ったけど、なぜか window の高さ、幅が取得できないから決め打ちでクリック
            Click(((Width - X) // 2) + X, 20)
        } else {
            WinActivate(arg*)
        }
    } else {
        ; Run(arg*)
        MsgBox "起動してないよ"
    }

}

hideToggl(requiredClick := false, arg*) {
    global HIDEN_WINDE_IDS
    global PREV_WIN_ID
    try {
        if (WinExist(arg*)) {
            _prev_win_id := WinGetID('A')
            if (WinActive(arg*)) {
                hiden(WinGetProcessName(arg*))
                WinGetTitle(_prev_win_id)
                WinActivate(_prev_win_id)
            } else {
                if (requiredClick) {
                    WinActivate(arg*)
                    WinGetPos(&X, &Y, &Width, &Height, arg*)
                    ;コマンドプロンプト用で作ったけど、なぜか window の高さ、幅が取得できないから決め打ちでクリック
                    Click(((Width - X) // 2) + X, 23)
                } else {
                    WinActivate(arg*)
                }
            }

            return
        }

        if (arg.HasProp('process_name')) {
            if (HIDEN_WINDE_IDS.HasProp(arg['process_name'])) {
                show(process_name)

                return
            }
        }

        DetectHiddenWindows 1
        if (WinGetList(arg*).Length > 0) {
            process_name := WinGetProcessName(arg*)

            _prev_win_id := WinGetID('A')

            for _winId in WinGetList(arg*)
            {
                WinShow(_winId)
                WinActivate(_winId)
            }

            if (HIDEN_WINDE_IDS.HasProp(process_name)) {
                HIDEN_WINDE_IDS.DeleteProp(process_name)
            }
            PREV_WIN_ID := _prev_win_id


        } else {
            MsgBox '起動してない'
        }
        DetectHiddenWindows 0

        return

    } catch Error as e {
        MsgBox e.Message e.File ": " e.Line
    }
}

hiden(process_name) {
    HIDEN_WINDE_IDS.%process_name% := []
    for _winId in WinGetList("ahk_exe" process_name)
    {
        WinHide(_winId)
        HIDEN_WINDE_IDS.%process_name%.Push(_winId)
    }

}
show(process_name) {
    ; MsgBox 'hiden 解除'
    for _winId in HIDEN_WINDE_IDS.%process_name%
    {
        WinShow(_winId)
        WinActivate(_winId)
    }
    HIDEN_WINDE_IDS.DeleteProp(process_name)
}
