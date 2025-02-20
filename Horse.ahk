;;;;;;;;;; Loading ;;;;;;;;;;
    #include %A_Scriptdir%\libs\BaseLibs\Header.ahk
    #IfWinActive, Black Desert
    global PWN := "Black Desert" ; Program window name
    OnExit("BeforeExiting")

;;;;;;;;;; Setting ;;;;;;;;;;

;;;;;;;;;; Variables ;;;;;;;;;;
    A_sleep := NumberOfJerks * 1000 

;;;;;;;;;; Hotkeys ;;;;;;;;;;
    Hotkey, *%StartKey%, BaseScript

;;;;;;;;;; Gui ;;;;;;;;;;
    PlaceForTheText := " Disabled "
    ;--------------------------------------------------
    UpdateDGP({"Transparency" : gTransparency, "Blur" : gBlur, "Scale" : gInterfaceScale})
    GuiInGame("Start", "MainInterface")
        Gui, MainInterface: Add, Text, xm ym, Horse:
        Gui, MainInterface: Add, Text, x+m ym +Center vScriptStatus_Gui cRed +Border, %PlaceForTheText%
        GuiControl, MainInterface: Text, ScriptStatus_Gui, Disabled
    GuiInGame("End", "MainInterface", {"ratio" : [GuiPositionX,GuiPositionY]})
    fSuspendGui("On", "MainInterface")
    if HideTheInterface
        SetTimer, ShowHideGui , 250, -1
Return

;;;;;;;;;; Scripts ;;;;;;;;;;
    BaseScript:
        GuiControl, MainInterface: Text, ScriptStatus_Gui, Enabled
	    GuiControl, MainInterface: +cLime +Redraw, ScriptStatus_Gui
        Send, {Blind}{w Down}{Shift Down}
        lSleep(2000)
        Send, {Blind}{w Up}{Shift Up}
        lSleep(20)
        While GetKeyState(StartKey, "p") {
            for A_Loop, A_key in ["a", "d"] {
                Send, {Blind}{s Down}{%A_key% Down}
                lSleep(20)
                Send, {Blind}{s Up}{%A_key% Up}{f Down}{w Down}
                lSleep(A_sleep)
                Send, {Blind}{f Up}{w Up}
                lSleep(20)
            }
        }
        Send, {Blind}{w Up}{a Up}{s Up}{d Up}{f Up}
        GuiControl, MainInterface: Text, ScriptStatus_Gui, Disabled
        GuiControl, MainInterface: +cRed +Redraw, ScriptStatus_Gui
    Return

;;;;;;;;;; Exit ;;;;;;;;;;
    BeforeExiting() {
        global
        Send, {Blind}{w Up}{a Up}{s Up}{d Up}{f Up}
    }