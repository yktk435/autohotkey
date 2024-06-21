#Requires AutoHotkey v2.0

#HotIf GetKeyState('F14', 'P')
Tab::
{
    windowChangeEachApp()
}
+Tab::
{
    windowChangeEachApp(false)
}
#HotIf

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
    activeProcessName := "ahk_exe" WinGetProcessName(activeWindow)

    if (CURRENT_PROCESS_NAME != activeProcessName) {
        CURRENT_PROCESS_NAME := activeProcessName
        WIN_IDS := []
        ; 同じプロセスIDを持つすべてのウィンドウをリスト
    }

    for _winId in WinGetList(activeProcessName)
    {
        if (inArray(_winId, WIN_IDS) == false) {
            WIN_IDS.Push(_winId)
        }
    }

    if (reverse) {
        array := reverseArray(WIN_IDS)
    } else {
        array := WIN_IDS
    }

    currentIndex := searchArray(WinGetID(activeWindow), array)

    nextIndex := Mod(currentIndex, array.Length) + 1
    if (WIN_IDS.Length < nextIndex) {
        nextIndex := 1
    }
    ; 次のウィンドウにフォーカスを移す
    WinActivate(array[nextIndex])

}
