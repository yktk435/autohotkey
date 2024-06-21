Run "notepad.exe"
WinWait "タイトルなし - メモ帳"
Sleep 500
WinHide ; Use the window found by WinWait.
Sleep 1000
WinShow ; WinWait関数で見つかったウィンドウを表示します。
