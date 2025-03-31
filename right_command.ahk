#Requires AutoHotkey v2.0

; findAppPath(appName) {
;     Found := false

;     ; C:\Program Files を検索
;     Loop Files, "C:\Program Files\*" . appName . "*.exe", "R"
;     {
;         FoundPath := A_LoopFileFullPath
;         Found := true  ; 見つけたらフラグを更新
;         break  ; 最初に見つけた edge.exe を取得してループを終了
;     }

;     ; もし Program Files に見つからなかったら Program Files (x86) を検索
;     if !Found {
;         Loop Files, "C:\Program Files (x86)\*" . appName . "*.exe", "R"
;         {
;             FoundPath := A_LoopFileFullPath
;             Found := true  ; 見つけたらフラグを更新
;             break  ; 最初に見つけた edge.exe を取得してループを終了
;         }
;     }

;     ; 結果を表示または実行
;     if !Found {
;         MsgBox "Microsoft Edge が見つかりませんでした。"
;     } else {
;         MsgBox "見つかったパス: " FoundPath  ; パスを表示
;         ; Run FoundPath  ; 見つかったパスでアプリケーションを実行
;     }
; }

HIDEN_WINDE_IDS := {}
PREV_WIN_ID := {}
; 表示
; MsgBox(APPLICATIONS["name"]) ;
; 削除
; myArray.RemoveAt(2) ; 2番目の要素を削除
; 表示
; for index, value in myArray
; {
;     MsgBox("Index " index ": " value)
; }

SetTitleMatchMode "RegEx"

^Space:: {
    path := "C:\Program Files\Microsoft VS Code\Code.exe"
    exe_name := "Code.exe"
    myWinActivate2(path)
    ; getWinIdFromAppPath
    ;  myWinActivate("ahk_exe " exe_name)
    ; hideToggl("ahk_exe" exe_name)

    return
}

^+Space:: {
    myWinActivate(".*Microsoft​ Edge$")
    return
}

LAlt & Space:: {
    path := 'C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe'
    myWinActivate("ahk_exe WindowsTerminal.exe")
    ; myWinActivate2(path)
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
    ; myWinActivate("ahk_exe thunderbird.exe")
    myWinActivate("^Mail.*")

    return
}

b:: {
    Send("{Space}")
    Send("b")
    return
}

Enter:: SendInput "^{Enter}"
Backspace:: SendInput("{Delete}")

#HotIf

myWinActivate2(appPath) {
    windowId := getWinIdFromAppPath(appPath)
    if (windowId == 'false') {
        Run(appPath)
    } else {
        WinActivate(windowId)
    }
}

; ターミナルの場合はクリックしないとちゃんとしたフォーカスにならない
myWinActivate(arg*) {
    baseMyWinActivate(false, arg*)
}

myWinActivateForCommandPrompt(arg*) {
    baseMyWinActivate(true, arg*)
}

; -----------------------------------------------------------
; 実行ファイルパスから最初にマッチした windowId を探す
; -----------------------------------------------------------
searchWindowIdfromAppPath(appPath) {
    ; 実行中のすべてのウィンドウを調査
    allWindowIds := WinGetList()

    matchingWindowIds := []

    ; 各ウィンドウをループして確認
    for windowId in allWindowIds {
        pid := WinGetPID("ahk_id " windowId) ; ウィンドウIDからプロセスIDを取得
        processPath := ProcessGetPath(pid) ; プロセスIDから実行ファイルのパスを取得

        if (processPath = appPath) {
            return windowId
        }
    }

    return false
}

; 実行ファイルを起動する
; Run appPath

; 実行ファイルが既に起動していたらそれのフォーカス・していないなら起動する
getWinIdFromAppPath(appPath) {
    wondowId := searchWindowIdfromAppPath(appPath)
    if (wondowId = false) {
        return "false"
    }

    return wondowId
}

baseMyWinActivate(requiredClick := false, arg*) {
    if (WinExist(arg*))
    {
        if (requiredClick) {
            WinActivate(arg*)
            WinGetPos(&X, &Y, &Width, &Height, arg*)
            ;コマンドプロンプト用で作ったけど、なぜか window の高さ、幅が取得できないから決め打ちでクリック
            ; Click(((Width - X) // 2) + X, 20)
            ; Click(2000 + X, -1)
        } else {
            WinActivate(arg*)
        }
    } else {
        ; Run(arg*)
        MsgBox "Not running"
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
            MsgBox 'Not running'
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
