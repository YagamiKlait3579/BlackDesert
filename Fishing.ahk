;;;;;;;;;; Loading ;;;;;;;;;;
    #include %A_Scriptdir%\libs\CoreLibsFor_AHK\BaseLibs\Header.ahk
    ;--------------------------------------------------
    #IfWinActive, Black Desert
    global PWN := "Black Desert" ; Program window name
    CheckForUpdates("YagamiKlait3579", "BlackDesert", "main", CheckingFiles("File", False, "Header.ahk"))
    OnExit("BeforeExiting")

;;;;;;;;;; Setting ;;;;;;;;;;

;;;;;;;;;; Variables ;;;;;;;;;; 
    LoadIniSection(CheckingFiles("File", True, "SavedSettings.ini"), "Fishing")
    ;--------------------------------------------------
    global gCellsLastActiveTime := []
    Loop, 10
        gCellsLastActiveTime.Push((CellLastActiveTime%A_Index% ? CellLastActiveTime%A_Index% : 0))
    ;--------------------------------------------------
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

    ErrorChecking()

;;;;;;;;;; Hotkeys ;;;;;;;;;;
    Hotkey, *%StartKey%, Main

    Hotkey, *%TestAllGuiKey%, TestAllGui

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
        Gui, MainInterface: Add, Text, % " x+m +Center +Border c" (TS_Flag ? "Lime" : "Red") " vToolsSwitching_Gui", %PlaceForTheText%
        GuiControl, MainInterface: Text, ToolsSwitching_Gui, % (TS_Flag ? "Slot: " TS_Cells[1] : "Off")
        ;--------------------------------------------------
        Gui, MainInterface: Add, Text, xm y+m +Right vT3, %PlaceForTheText%
        GuiControl, MainInterface: Text, T3, Auto buff:
        Gui, MainInterface: Add, Text, % " x+m +Center +Border c" (AB_Flag ? "Lime" : "Red") " vAutoBuff_Gui", %PlaceForTheText%
        GuiControl, MainInterface: Text, AutoBuff_Gui, % (AB_Flag ? "On" : "Off")
        ;--------------------------------------------------
        Gui, MainInterface: Add, Text, xm y+m +Right vT4, %PlaceForTheText%
        GuiControl, MainInterface: Text, T4, Fish sorting:
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
    if AB_Flag
        SetTimer, UpdatingBuffs, 250, -1
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

    TestAllGui() {
        global
        local A_Loop, A_key
        static B_Gui
        B_Gui := !B_Gui
        if B_Gui {
            fBorder("WaitingForFishCatch", {"Coords" : Space_Cords, "Color" : "Yellow", "Size" : 2})
            fBorder("MiniGame", {"Coords" : MG_Coords, "Color" : "Red"})
            for A_Loop, A_key in gCaptcha_Cords
                fBorder("fCaptcha" A_Loop, {"Coords" : A_key, "Color" : (Mod(A_Loop, 2) ? "Yellow" : "Lime" )})
            for A_Loop, A_key in gLoot_Coords
                fBorder("LootSorting" A_Loop, {"Coords" : A_key, "Color" : "Yellow"})
        } Else {
            fBorder("WaitingForFishCatch","Destroy")
            fBorder("MiniGame","Destroy")
            loop, 10
                fBorder("fCaptcha" A_Index,"Destroy")
            loop, 12
                fBorder("LootSorting" A_Index,"Destroy")
        }
    }

;;;;;;;;;; Functions ;;;;;;;;;;
    Main() {
        static A_ScriptStatus
        if !A_ScriptStatus {
            A_ScriptStatus := !A_ScriptStatus
            GuiInGame("Edit", "MainInterface", {"id" : "ScriptStatus_Gui", "Color" : "Lime", "Text" : "Enabled"})
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

    ErrorChecking() {
        global
        local A_Loop, A_key, B_Loop, B_key
        local HashArray := []
        for A_Loop, A_key in [TS_Cells, AB_Cells]
            for B_Loop, B_key in A_key {
                if ((B_key > 10) || (B_key < 1)) {
                    MsgBox, 16, Error settings fishing, % "Недопустимая ячейка " B_key " в настройках" ((A_Loop = 1) ? "''Tools switching''" : "''Auto buff''") "`nЯчейки должны иметь номер от 1 до 10."
                    ExitApp
                }
                if (A_Loop = 1)
                    HashArray[B_key] := true
            }
        for A_Loop, A_key in AB_Cells {
            if (HashArray.HasKey(A_key)) {
                MsgBox, 16, Error settings fishing, Ячейки в ''Tools switching'' и ''Auto buff'' не должны совпадать!`nСовпадают ячейки № %A_key%
                ExitApp 
            }
        }     
        if (AB_Cells.Count() > AB_Time.Count()) {
            MsgBox, 16, Error settings fishing, % "Не для всех ячеек указан таймер в ''Auto buff''`nКоличество ячеек: " AB_Cells.Count() "`nКоличество таймеров: " AB_Time.Count()
            ExitApp
        }
    }

;;;;;;;;;; Additional functions ;;;;;;;;;;
    UpdatingBuffs() {
        global 
        local A_Loop, A_key
        for A_Loop, A_key in AB_Cells
            if (AB_Time[A_Loop] < WorldTimePassed(gCellsLastActiveTime[A_key],,"sec")) {
                if (A_key = 10)
                    Send, {Blind}{0}
                Else
                    Send, {Blind}{%A_key%}
                gCellsLastActiveTime[A_key] := WorldTimeStamp()
                lSleep(500)
            }     
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
                if (TimePassed(B_Start,,"sec") > (TS_Time * TS_Cells.Count())) {
                    SetTimer, Fishing, off
                    GuiInGame("Edit", "MainInterface", {"id" : "ScriptStatus_Gui", "Color" : "Red", "Text" : "Error   " A_Hour ":" A_Min})
                    fBorder("WaitingForFishCatch","Destroy")
                    Return 1
                }
            } else if (TimePassed(B_Start,,"sec") > TS_Time) {
                SetTimer, Fishing, off
                GuiInGame("Edit", "MainInterface", {"id" : "ScriptStatus_Gui", "Color" : "Red", "Text" : "Error   " A_Hour ":" A_Min})
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
                for B_Loop, B_key in ["Stone", "Key", "Sheet", "Bottle"] { 
                    ImageSearch,,, A_Coords[1], A_Coords[2], A_Coords[3], A_Coords[4], % " *" LS_A_Image " HBITMAP:" ReadImages(CheckingFiles("File", False, "BDO_Images.ini"), B_key)
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
        if A_Loot.Length()
            for A_Loop, A_key in A_Loot {
                if A_key is integer 
                {
                    if (A_key >= LS_MinRarity)
                        ClickOnAnLoot(gLoot_Coords[A_Loop])
                } else {
                    if (((A_key = "Stone") && LS_StoneFlag) || ((A_key = "Key") && LS_KeyFlag) || ((A_key = "Sheet") && LS_SheetFlag) || ((A_key = "Bottle") && LS_BottleFlag))
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
        local A_key
        static A_Number 
        if (A_Number >= TS_Cells.Length())
            A_Number := 1
        Else
            A_Number ++
        GuiControl, MainInterface: Text, ToolsSwitching_Gui, % "Slot: " TS_Cells[1]
        A_key := TS_Cells[A_Number]
        SendInput, {Blind}{%A_key%}
    }

;;;;;;;;;; Exit ;;;;;;;;;;
    BeforeExiting() {
        global
        for A_Loop, A_key in gCellsLastActiveTime
            IniWrite, %A_key% , %OP_SavedSettings%, Fishing, % "CellLastActiveTime" A_Loop
    }