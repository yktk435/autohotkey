#Requires AutoHotkey v2.0


reverseArray(oArray)
{
    if (oArray.length == 0) {
        return []
    }
    Array := []
    For i, v in oArray {
        Array.Push(oArray[oArray.Length - i + 1])
    }


    return Array
}

_searchArray(value, array, isInArray := false) {
    Loop array.Length {
        if (array[A_Index] == value)
            if (isInArray) {
                return true
            } else {
                return A_Index
            }
    }

    return false
}

searchArray(value, array) {
    return _searchArray(value, array)
}

inArray(value, array) {
    return _searchArray(value, array, true)
}

isApplication(winId) {
    return WinGetTitle(winId) != '' && !inArray(WinGetClass(winId), ['IME', 'MSCTFIME UI'])
}

logger(text) {
    logTime := "[" FormatTime(, "yyyy-MM-dd HH:mm:ss") "]"
    FileEncoding 'UTF-8'
    FileAppend logTime " "  text "    " A_LineFile ":" A_LineNumber "`n",  "\\wsl.localhost\Docker\home\h1yokotsuka\ghq\AutoHotkey\log"
}

; アクティブなウィンドウIDからプロセスのパスを取得する
GetActiveWindowProcessPath() {
    ; アクティブなウィンドウのIDを取得
    WindowID := WinGetID("A") ; "A" はアクティブウィンドウを示す

    ; アクティブなウィンドウのプロセスIDを取得
    PID := WinGetPID("ahk_id " WindowID)

    ; プロセスのパスを取得
    try {
        Path := ProcessGetPath(PID)
    } catch {
        MsgBox("Error: Could not retrieve process path.")
        return
    }
    return Path
}

; 使用例：アクティブなウィンドウのプロセスパスを表示
; AppPath := GetActiveWindowProcessPath()
; logger(AppPath)
