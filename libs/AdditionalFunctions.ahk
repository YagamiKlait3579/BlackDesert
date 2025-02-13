;;;;;;;;;; Loading ;;;;;;;;;;

;;;;;;;;;; Variables ;;;;;;;;;;

;;;;;;;;;; Additional functions ;;;;;;;;;;
    fWinGetClientPos(winTitle) {
        if !hWnd := WinExist(winTitle)  {
            MsgBox, 16, fWinGetClientPos, winTitle is wrong
            Return
        }
        VarSetCapacity(WINDOWINFO, 60, 0)
        DllCall("GetWindowInfo", Ptr, hWnd, Ptr, &WINDOWINFO)
        Return { x: x := NumGet(WINDOWINFO, 20, "UInt")
               , y: y := NumGet(WINDOWINFO, 24, "UInt")
               , w: NumGet(WINDOWINFO, 28, "UInt") - x
               , h: NumGet(WINDOWINFO, 32, "UInt") - y }
    }