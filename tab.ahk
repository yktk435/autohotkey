#Requires AutoHotkey v2.0

global WIN_IDS := []
global CURRENT_PROCESS_NAME := ''
windowChangeEachApp(reverse := true) {
  global WIN_IDS
  global CURRENT_PROCESS_NAME
  logger "CURRENT_PROCESS_NAME " CURRENT_PROCESS_NAME
  ; アクティブウィンドウの情報を取得
  currentWinId := WinGetID("A")
  activeProcessName := "ahk_exe" WinGetProcessName("A")
  if !activeProcessName
  {
    logger('アクティブウィンドウを取得できませんでした。' WinGetProcessName("A"))
    MsgBox "アクティブウィンドウを取得できませんでした。"
    return
  }

  ; アクティブウィンドウのプロセスIDを取得
  activePID := WinGetPID(currentWinId)

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
  } else {
    if (WIN_IDS.Length == 0) {
      for _winId in WinGetList(CURRENT_PROCESS_NAME)
      {
        if (isApplication(_winId) && !inArray(_winId, WIN_IDS)) {
          WIN_IDS.Push(_winId)
        }
      }
    }

    if (WinGetList(CURRENT_PROCESS_NAME).Length != WIN_IDS.Length) {
      RemoveAt := ''
      loop WIN_IDS.Length {
        {
          if (searchArray(WIN_IDS[A_Index], WinGetList(CURRENT_PROCESS_NAME)) == false) {
            RemoveAt := A_Index
          }
        }
      }
      if (RemoveAt != '') {
        WIN_IDS.RemoveAt(RemoveAt)

      }
    }
  }
  logger "WIN_IDS.Length " WIN_IDS.Length

  currentIndex := searchArray(WinGetID(currentWinId), WIN_IDS)
  targetIndex := getNextIndex(WIN_IDS, currentIndex, reverse)

  ; 次のウィンドウにフォーカスを移す
  try {
    ; MsgBox WinGetClass(WIN_IDS[nextIndex]) " | " WinGetTitle(WIN_IDS[nextIndex]) ' | ' WinGetProcessName(WIN_IDS[nextIndex])
    WinActivate(WIN_IDS[targetIndex])
  } catch Error as e {
    ; MsgBox "tab error"
    MsgBox e.Message
    if (e.Message == 'Target window not found') {
      WIN_IDS.RemoveAt(targetIndex)
      WinActivate(WIN_IDS[getNextIndex(WIN_IDS, currentIndex, reverse)])

    }
    ; MsgBox "WIN_IDS.Length: " WIN_IDS.Length
    ; MsgBox "nextIndex: " nextIndex
  }
}

#HotIf GetKeyState('F14', 'P')
Tab:: {
  windowChangeEachApp(false)
}
+Tab:: {
  windowChangeEachApp()
}
#HotIf

getNextIndex(array, currentIndex, reverse) {
  offset := 1
  if (reverse) {
    offset := -1
  }

  nextIndex := currentIndex + offset
  if (array.Length < nextIndex) {
    nextIndex := 1
  } else if (nextIndex <= 0) {
    nextIndex := array.Length
  }

  return nextIndex
}

getWindowIds() {
  ids := []
  ; 同じプロセスIDを持つすべてのウィンドウをリスト
  for _winId in WinGetList(CURRENT_PROCESS_NAME)
  {
    if (isApplication(_winId) && !inArray(_winId, ids)) {
      ids.Push(_winId)
    }
  }
}
