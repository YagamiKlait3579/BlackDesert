;;;;;;;;;; Loading ;;;;;;;;;;
    #include %A_Scriptdir%\libs\BaseLibs\Header.ahk
    ;#IfWinActive, 
    ;global PWN := "" ; Program window name

;;;;;;;;;; Setting ;;;;;;;;;;

;;;;;;;;;; Variables ;;;;;;;;;;
    ; A_GameWindow := fWinGetClientPos(PWN)
    ;A_Window := fWinGetClientPos("Black Desert")
    ;global Space_Cords    := [Round(A_Window.w * 0.4949), Round(A_Window.h * 0.0510), Round(A_Window.w * 0.5365), Round(A_Window.h * 0.0835)] ; [950 ,  55, 1030,  90]
    ;global MG_Coords := [Round(A_Window.w * 0.5782), Round(A_Window.h * 0.3520), Round(A_Window.w * 0.5835), Round(A_Window.h * 0.3614)] ; [1110, 380, 1120, 390]
    ;global Captcha_Cords  := [Round(A_Window.w * 0.4012), Round(A_Window.h * 0.3244), Round(A_Window.w * 0.7189), Round(A_Window.h * 0.3705)] ; [770 , 350, 1380, 400]
    global gCaptcha_Cords := []
    A_Width := Round((Captcha_Cords.3 - Captcha_Cords.1) / 10)
    Loop, 10
        gCaptcha_Cords.Push([Captcha_Cords.1 + (A_Width * (A_Index - 1)) - Ceil(5 * gDPI), Captcha_Cords.2, Captcha_Cords.1 + (A_Width * A_Index) + Ceil(5 * gDPI), Captcha_Cords.4])
    ;--------------------------------------------------
    global gLoot_Coords := []
    A_Width  := Round((LS_Coords.3 - LS_Coords.1) / 6)
    A_Height := Round((LS_Coords.4 - LS_Coords.2) / 2)
    Loop, 6
        gLoot_Coords.Push([LS_Coords.1 + (A_Width * (A_Index - 1)), LS_Coords.2, LS_Coords.1 + (A_Width * A_Index), LS_Coords.2 + A_Height])
    Loop, 6
        gLoot_Coords.Push([LS_Coords.1 + (A_Width * (A_Index - 1)), LS_Coords.2 + A_Height, LS_Coords.1 + (A_Width * A_Index), LS_Coords.4])
    ;--------------------------------------------------
    global gLoot_Coords2 := []
    B_Height := Round((LS_Coords.4 - LS_Coords.2) / 10)
    Loop, 6
        gLoot_Coords2.Push([LS_Coords.1 + (A_Width * (A_Index - 1)), LS_Coords.2, LS_Coords.1 + (A_Width * A_Index), LS_Coords.2 + B_Height])
    Loop, 6
        gLoot_Coords2.Push([LS_Coords.1 + (A_Width * (A_Index - 1)), LS_Coords.2 + A_Height, LS_Coords.1 + (A_Width * A_Index), LS_Coords.2 + A_Height + B_Height])
/* 
    fBorder("Test1", {"Coords" : gLoot_Coords[1], "Color" : "Yellow"})
    fBorder("Test2", {"Coords" : gLoot_Coords[2], "Color" : "Yellow"})
    fBorder("Test3", {"Coords" : gLoot_Coords[3], "Color" : "Yellow"})
    fBorder("Test4", {"Coords" : gLoot_Coords[4], "Color" : "Yellow"})
    fBorder("Test5", {"Coords" : gLoot_Coords[5], "Color" : "Yellow"})
    fBorder("Test6", {"Coords" : gLoot_Coords[6], "Color" : "Yellow"})
    ;--------------------------------------------------
    fBorder("Test7", {"Coords" : gLoot_Coords[7], "Color" : "Yellow"})
    fBorder("Test8", {"Coords" : gLoot_Coords[8], "Color" : "Yellow"})
    fBorder("Test9", {"Coords" : gLoot_Coords[9], "Color" : "Yellow"})
    fBorder("Test10", {"Coords" : gLoot_Coords[10], "Color" : "Yellow"})
    fBorder("Test11", {"Coords" : gLoot_Coords[11], "Color" : "Yellow"})
    fBorder("Test12", {"Coords" : gLoot_Coords[12    ], "Color" : "Yellow"})
 */

    ;;;;;;;;;; Hotkeys ;;;;;;;;;;
    Hotkey, *%StartKey%, BaseScript

;;;;;;;;;; Gui ;;;;;;;;;;
    ; 🪝🎣🪨
    PlaceForTheText := "  Tools switching:  "
    ;--------------------------------------------------
    UpdateDGP({"Transparency" : gTransparency, "Blur" : gBlur, "Scale" : gInterfaceScale})
    GuiInGame("Start", "MainInterface")
        Gui, MainInterface: Add, Text, xm ym +Right vT1 HwndStartWinth, %PlaceForTheText%
        GuiControl, MainInterface: Text, T1, Auto fishing:
        Gui, MainInterface: Add, Text, x+m ym +Center vScriptStatus_Gui HwndEndWinth cRed +Border, %PlaceForTheText%
        GuiControl, MainInterface: Text, ScriptStatus_Gui, Disabled
        ;--------------------------------------------------
        A_Width := GuiLineWidth(EndWinth)
        ;--------------------------------------------------
        Gui, MainInterface: Add, Text, xm y+m +Right vT2, %PlaceForTheText%
        GuiControl, MainInterface: Text, T2, Tools switching:
        Gui, MainInterface: Add, Text, % " x+m w" (A_Width / 2) " +Center +Border cLime vToolsSwitching_Gui1",🪝 1
        Gui, MainInterface: Add, Text, % " x+ w" ((A_Width + 1) / 2)  " +Center +Border cFuchsia vToolsSwitching_Gui2", Max: %TS_Amount%
        ;--------------------------------------------------
        Gui, MainInterface: Add, Text, xm y+m +Right vT3, %PlaceForTheText%
        GuiControl, MainInterface: Text, T3, Fish sorting:
        Gui, MainInterface: Add, Text, x+m +Center vFishSorting_Gui +Border, %PlaceForTheText%
        GuiControl, MainInterface: Text, FishSorting_Gui, % (LS_MinRarity = 3) ? "Legendary" : ((LS_MinRarity = 2) ? "Rare" : "All")
        GuiControl, % "MainInterface: +c" ((LS_MinRarity = 3) ? "Yellow" : ((LS_MinRarity = 2)? "Aqua" : "Lime")) " +Redraw", FishSorting_Gui
    GuiInGame("End", "MainInterface", {"ratio" : [GuiPositionX,GuiPositionY]})
    fSuspendGui("On", "MainInterface", {"pos" : "up"})
    if DebugGui {
        GuiInGame("Start", "DebugGui2")
            A_Width := (GuiLineWidth(StartWinth, EndWinth) / 7)
            Gui, DebugGui2: Add, Text, % " xm ym w" A_Width - 1 " +Right vT1", Last`nfish
            Gui, DebugGui2: Add, Text, % " x+m w" A_Width " +Center +Border vLastFish_Gui1 +Section", 🐟
            Loop, 5
                Gui, DebugGui2: Add, Text, % " x+ w" A_Width " +Center +Border vLastFish_Gui" (A_Index + 1), 🐟
            Gui, DebugGui2: Add, Text, % " xs y+ w" A_Width " +Center +Border vLastFish_Gui7", 🐟
            Loop, 5
                Gui, DebugGui2: Add, Text, % " x+ w" A_Width " +Center +Border vLastFish_Gui" (A_Index + 7), 🐟
            WinGetPos, A_X1, A_Y1, A_W1, A_H1, % "ahk_id" MainInterface
        GuiInGame("End", "DebugGui2", {"pos" : [A_X1, A_Y1 + A_H1 + (DGP.Margin.2 * 2) + (DGP.BorderSize * 2), A_W1]})
        ;--------------------------------------------------
        GuiInGame("Start", "DebugGui3")
            A_Width := (GuiLineWidth(StartWinth, EndWinth) / 11) - 1
            Gui, DebugGui3: Add, Text, xm y+m w%A_Width% +Right, Key:
            Gui, DebugGui3: Add, Text, % " x+m w" A_Width " +Center +Border cFuchsia vKey_Gui1", -
            Loop, 9
                Gui, DebugGui3: Add, Text, % " x+ w"  A_Width " +Center +Border cFuchsia vKey_Gui" (A_Index + 1), -
            WinGetPos, A_X1, A_Y1, A_W1, A_H1, % "ahk_id" DebugGui2
        GuiInGame("End", "DebugGui3", {"pos" : [A_X1, A_Y1 + A_H1 + (DGP.Margin.2 * 2) + (DGP.BorderSize * 2), A_W1]})
    }
    if HideTheInterface
        SetTimer, ShowHideGui , 250, -1
Return

;;;;;;;;;; Gui functions ;;;;;;;;;;
    ResetGui(psram) {
        switch psram {
            case "LastFish", "Last Fish" :
                Loop, 12
                    GuiControl, DebugGui2: +cWhite +Redraw, % "LastFish_Gui" A_Index
            case "Key", "Keys":
                Loop, 10
                    GuiControl, DebugGui3: Text, Key_Gui%A_Index%, -
        } 
    }

;;;;;;;;;; Functions ;;;;;;;;;;
    BaseScript() {
        static A_ScriptStatus
        if !A_ScriptStatus {
            A_ScriptStatus := !A_ScriptStatus
            GuiControl, MainInterface: Text, ScriptStatus_Gui, Enabled
            GuiControl, MainInterface: +cLime +Redraw, ScriptStatus_Gui
            SetTimer, Fishing, 1
        } else
            Reload
    }

    ClickOnAnLoot(param) {
        local X1 := param.1 + ((param.3 - param.1) / 2)
        local Y1 := param.2 + ((param.4 - param.2) / 2)
        fSetCursor(X1, Y1)
        lSleep(25)
        fMouseInput("Left")
    }

;;;;;;;;;; Fishing ;;;;;;;;;;
    Fishing() {
        global
        local A_Start, B_Start
        if TS_Flag
            ToolsSwitching()
        lSleep(1000)
        Send, {Blind}{Space Down}
        lSleep(FishingRodCastingTime)
        Send, {Blind}{Space Up}
        TimeStamp(A_Start), TimeStamp(B_Start)
        fBorder("WaitingForFishCatch", {"Coords" : Space_Cords, "Color" : "Yellow", "Size" : 2})
        Loop, {
            if TS_Flag {
                if (TimePassed(A_Start,,"sec") > TS_Time) {
                    TimeStamp(A_Start)
                    ToolsSwitching()
                    lSleep(1000)
                    Send, {Blind}{Space Down}
                    lSleep(FishingRodCastingTime)
                    Send, {Blind}{Space Up}
                }
                if (TimePassed(B_Start,,"sec") > (TS_Time * TS_Amount)) {
                    SetTimer, Fishing, off
                    GuiControl, MainInterface: Text, ScriptStatus_Gui, Error   %A_Hour%:%A_Min%
                    GuiControl, MainInterface: +cRed +Redraw, ScriptStatus_Gui
                    fBorder("WaitingForFishCatch","Destroy")
                    Return 1
                }
            } else if (TimePassed(B_Start,,"sec") > TS_Time) {
                SetTimer, Fishing, off
                GuiControl, MainInterface: Text, ScriptStatus_Gui, Error   %A_Hour%:%A_Min%
                GuiControl, MainInterface: +cRed +Redraw, ScriptStatus_Gui
                fBorder("WaitingForFishCatch","Destroy")
                Return 1
            }
        } Until FindText(,, Space_Cords.1, Space_Cords.2, Space_Cords.3, Space_Cords.4, FT_A_Space, FT_A_Space, FT_Space)
        fBorder("WaitingForFishCatch","Destroy")
        Send, {Blind}{Space}
        lSleep(250)
        fBorder("MiniGame", {"Coords" : MG_Coords, "Color" : "Yellow"})
        Loop 
            PixelSearch,,, MG_Coords[1], MG_Coords[2], MG_Coords[3], MG_Coords[4], "0x"MG_Color, MG_A_Color, Fast RGB
        Until !ErrorLevel
        if MG_Time
            lSleep(MG_Time)
        Send, {Blind}{Space}
        fBorder("MiniGame","Destroy")
        lSleep(2500)
        fCaptcha()
        lSleep(2500)
        LootSorting()
        lSleep(1000)
        ResetGui("Keys")
    }

    fCaptcha() {
        global
        local A_Start, FoundKeys := []
        for A_Loop, A_key in gCaptcha_Cords {
            fBorder("fCaptcha", {"Coords" : A_key, "Color" : "Yellow"})
            TimeStamp(A_Start)
            Loop, {
                for B_Loop, B_key in [FT_W, FT_S, FT_A, FT_D]
                    if FindText(,, A_key[1], A_key[2], A_key[3], A_key[4], FT_A_Text, FT_A_Text, B_key) {
                        FoundKeys.Push((B_Loop = 1) ? "w" : ((B_Loop = 2)? "s" : ((B_Loop = 3) ? "a" : "d")))
                        GuiControl, DebugGui3: Text, Key_Gui%A_Loop%, % FoundKeys[A_Loop]
                        Break, 2
                    }
                if (TimePassed(A_Start) > 100) {
                    fBorder("fCaptcha","Destroy")
                    Break, 2
                }
            } 
            fBorder("fCaptcha","Destroy")
        }
        if FoundKeys.Length()
            for A_Loop, A_key in FoundKeys {
                Send, {Blind}{%A_key%}
                lSleep(50)
            }
    }

    LootSorting() {
        global
        local A_Start, A_Coords, B_Coords, A_Loot := []
        local A_Loop, A_key, B_Loop, B_key
        ResetGui("Last Fish")
        SendInput, {Blind}{Esc}
        lSleep(250)
        SendInput, {Blind}{Esc}
        lSleep(250)
        SendInput, {Blind}{LCtrl}
        lSleep(250)
        Loop, 12 {
            A_Coords := gLoot_Coords[A_Index], B_Coords := gLoot_Coords2[A_Index], A_Loop := A_Index
            fBorder("LootSorting", {"Coords" : A_Coords, "Color" : "Yellow"})
            TimeStamp(A_Start)
            Loop, {
                for B_Loop, B_key in ["Stone", "Key", "Sheet"] {
                    ImageSearch,,, A_Coords[1], A_Coords[2], A_Coords[3], A_Coords[4], % " *" LS_A_Image " HBITMAP:" ReadImages(CheckingFiles(,"BDO_Images.dll"), B_key)
                    if !ErrorLevel {
                        A_Loot.Push(B_key)
                        GuiControl, DebugGui2: +cFuchsia +Redraw, % "LastFish_Gui" A_Loop
                        Break, 2
                    }
                }
                for B_Loop, B_key in [LS_Color_Fish1, LS_Color_Fish2, LS_Color_Fish3] {
                    PixelSearch,,, B_Coords[1], B_Coords[2], B_Coords[3], B_Coords[4], "0x"B_key, LS_A_Color, Fast RGB
                    if !ErrorLevel {
                        A_Loot.Push(B_Loop) 
                        GuiControl, % "DebugGui2: +c" ((B_Loop = 1) ? "Lime" : ((B_Loop = 2)? "Aqua" : "Yellow")) " +Redraw", % "LastFish_Gui" A_Loop
                        Break, 2
                    }
                }
                if (TimePassed(A_Start) > 400) {
                    fBorder("LootSorting","Destroy")
                    Break, 2
                }
            } 
            fBorder("LootSorting","Destroy")
        }
        if FoundKeys.Length()
            for A_Loop, A_key in A_Loot {
                if A_key is integer 
                {
                    if (A_key >= LS_MinRarity)
                        ClickOnAnLoot(gLoot_Coords[A_Loop])
                } else {
                    if (((A_key = "Stone") && LS_StoneFlag) || ((A_key = "Key") && LS_KeyFlag) || ((A_key = "Sheet") && LS_SheetFlag))
                        ClickOnAnLoot(gLoot_Coords[A_Loop])
                }
            }
        lSleep(250)
        fSetCursor(gScreenCenter[1], gScreenCenter[2])
        lSleep(250)
        SendInput, {Blind}{LCtrl}
    }

;;;;;;;;;; Additional functions ;;;;;;;;;;
    ToolsSwitching() {
        global
        static A_Number 
        if (A_Number >= TS_Amount)
            A_Number := 1
        Else
            A_Number ++
        GuiControl, MainInterface: Text, ToolsSwitching_Gui1, 🪝 %A_Number%
        SendInput, {Blind}{%A_Number%}
    }