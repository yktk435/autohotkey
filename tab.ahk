#Requires AutoHotkey v2.0

global WIN_IDS := []
global CURRENT_PROCESS_NAME := ''
windowChangeEachApp(reverse := true) {
    global WIN_IDS
    global CURRENT_PROCESS_NAME
    ; アクティブウィンドウの情報を取得
    currentWinId := WinGetID("A")
    activeWindow := "ahk_exe" WinGetProcessName("A")
    if !activeWindow
    {
        MsgBox "アクティブウィンドウを取得できませんでした。"
        return
    }

    ; アクティブウィンドウのプロセスIDを取得
    activePID := WinGetPID(activeWindow)
    activeProcessName := "ahk_exe " WinGetProcessName(activeWindow)

    if (CURRENT_PROCESS_NAME != activeProcessName) {
        CURRENT_PROCESS_NAME := activeProcessName
        WIN_IDS := []
        ; 同じプロセスIDを持つすべてのウィンドウをリスト
        for _winId in WinGetList(CURRENT_PROCESS_NAME)
        {
            if (isApplication(_winId) && !inArray(_winId, WIN_IDS)) {
                WIN_IDS.Push(_winId)
            }
        }
    }

    offset := 1
    if (reverse) {
        offset := -1
    } else {

    }
    currentIndex := searchArray(WinGetID(currentWinId), WIN_IDS)

    nextIndex := currentIndex + offset
    if (WIN_IDS.Length < nextIndex) {
        nextIndex := 1
    } else if (nextIndex <= 0) {
        nextIndex := WIN_IDS.Length
    }
    ; 次のウィンドウにフォーカスを移す
    try {
        ; MsgBox WinGetClass(WIN_IDS[nextIndex]) " | " WinGetTitle(WIN_IDS[nextIndex]) ' | ' WinGetProcessName(WIN_IDS[nextIndex])
        WinActivate(WIN_IDS[nextIndex])
    } catch Error as e {
        MsgBox e.Message
        MsgBox "WIN_IDS.Length: " WIN_IDS.Length
        MsgBox "nextIndex: " nextIndex
    }
}

#HotIf GetKeyState('F14', 'P')
Tab::
{
    windowChangeEachApp(false)
}
+Tab::
{
    windowChangeEachApp()
}
#HotIf
