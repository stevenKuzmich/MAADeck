version:=6.2

;copywrited damit
;MAA flight deck script by superdave27


;Varibles Are the default values loaded if ini is not there or values do not exist
IniRead, xloc, FlightDeckUserSettings.ini, screen, xloc, 0
IniRead, yloc, FlightDeckUserSettings.ini, screen, yloc, 0
IniRead, planeCount, FlightDeckUserSettings.ini, variables, planeCount, 8
IniRead, hours, FlightDeckUserSettings.ini, variables, hours, 24
IniRead, sDelay, FlightDeckUserSettings.ini, variables, sDelay, 350
IniRead, 1Right, FlightDeckUserSettings.ini, plane, 1Right, 0
IniRead, 1Hero, FlightDeckUserSettings.ini, plane, 1Hero, 1
IniRead, 2Right, FlightDeckUserSettings.ini, plane, 2Right, 0
IniRead, 2Hero, FlightDeckUserSettings.ini, plane, 2Hero, 1
IniRead, 3Right, FlightDeckUserSettings.ini, plane, 3Right, 0
IniRead, 3Hero, FlightDeckUserSettings.ini, plane, 3Hero, 1
IniRead, 4Right, FlightDeckUserSettings.ini, plane, 4Right, 0
IniRead, 4Hero, FlightDeckUserSettings.ini, plane, 4Hero, 1
IniRead, 5Right, FlightDeckUserSettings.ini, plane, 5Right, 0
IniRead, 5Hero, FlightDeckUserSettings.ini, plane, 5Hero, 1
IniRead, 6Right, FlightDeckUserSettings.ini, plane, 6Right, 0
IniRead, 6Hero, FlightDeckUserSettings.ini, plane, 6Hero, 1
IniRead, 7Right, FlightDeckUserSettings.ini, plane, 7Right, 0
IniRead, 7Hero, FlightDeckUserSettings.ini, plane, 7Hero, 1
IniRead, 8Right, FlightDeckUserSettings.ini, plane, 8Right, 0
IniRead, 8Hero, FlightDeckUserSettings.ini, plane, 8Hero, 1
IniRead, lastFriendSpot, FlightDeckUserSettings.ini, friends, lastFriendSpot, 4
IniRead, firstRunB, FlightDeckUserSettings.ini, variables, firstRunB, 0
IniRead, logDebug, FlightDeckUserSettings.ini, variables, logDebug, 0
IniRead, timeRun, FlightDeckUserSettings.ini, variables, timeRun, 3
IniRead, showXpHerosFirst, FlightDeckUserSettings.ini, variables, showXpHerosFirst, 0
IniRead, lastRregDate, FlightDeckUserSettings.ini, security, lastRregDate, 0
IniRead, lastRegVer, FlightDeckUserSettings.ini, security, lastRegVer, 1
IniRead, ActionButtonWindowX, FlightDeckUserSettings.ini, windows, ActionButtonWindowX, 0
IniRead, ActionButtonWindowY, FlightDeckUserSettings.ini, windows, ActionButtonWindowY, 0
IniRead, SettingsWindowX, FlightDeckUserSettings.ini, windows, SettingsWindowX, 0
IniRead, SettingsWindowY, FlightDeckUserSettings.ini, windows, SettingsWindowY, 0
IniRead, DebugWindowX, FlightDeckUserSettings.ini, windows, DebugWindowX, 0
IniRead, DebugWindowY, FlightDeckUserSettings.ini, windows, DebugWindowY, 0
IniRead, StatusWindowX, FlightDeckUserSettings.ini, windows, StatusWindowX, 0
IniRead, StatusWindowY, FlightDeckUserSettings.ini, windows, StatusWindowY, 0
IniRead, autoRedeploy, FlightDeckUserSettings.ini, variables, autoRedeploy, 1




#SingleInstance force
SetTitleMatchMode, 2
srDelay:=300
clockGreen:=0x0F571D ;0x1C401A
arrowBlue:=0x94570F 
frameBlue:=0xE1AD6F
timeLeft:=606
go:=false
statusMessage:="Inactive"
messageLog:="debug enabled and ready"

GoSub, FirstRunner
GoSub, CheckUpdate
GoSub, RegisterUser

#Persistent  ; Keep the script running until the user exits it.
	Menu, tray, add  ; Creates a separator line.
	Menu, tray, add, MAA Script v%version%, ShowKeyCommandWindow
	;Menu, tray, add, Download latest version, UpdateStandard
return





;-------------------------------------------------Key Commands----------------------------------------
;^+s::
F1::
	GoSub, AutoRun
return

;^+a::
F2::
	GoSub, SingleFlight
return

^+l::
	GoSub, DeleteUserSettings
return

^+d::
	GoSub, DebugWindow
return

;^+p::
F6::
	Pause
	TrayTip,, Play/Pause,10
return

^+W::
 Suspend
 TrayTip,, Disable/Enable Keys,10
return

Pause::
	Suspend
	TrayTip,, Disable/Enable Keys,10
Return

^+e::
	GoSub, ExitHandler	
return
	
;^+z::
F8::
	GoSub, CalibrateScreen
return

;^+e::
F4::
	GoSub, AbortAutoRunTimer
return

;^+w::
F12::
	GoSub, StatWindow
return

;^+x::
F11::
	GoSub, ActionWindow
return

;^+c::
F7::
	GoSub, FarmFriends
return

;^+r::
F5::
	GoSub, ReloadMenuHandler
return 

;^+v::
F9::
	GoSub, SettingsWindow
return

;^+i::
F10::
	GoSub, ShowKeyCommandWindow
return

;!s::
F3::
	GoSub, AbortFlightDeck
return

^+f::
GoSub, openAllWindows
return

^+g::
GoSub, CloseAllWindows
return

^+q::
;ListHotkeys
;ListVars
InputBox, gift ,Gift Choice, What gift do you want to send to all your marvel friends?`nGift Selection(matches window position): `n1 2 3 4`n5 6 7 8,,,,,,,,1
InputBox, count ,Gift Count, How many do you want to send to all your marvel friends?,,,,,,,,1
TrayTip,, Sending %count% gift(s).,10
statusUpdate("Sending Gifts")
loop %count%
{
	debug("Sending " . A_Index . " Gift.")
	clicker(599,313)
	Sleep, 1000
	giftSelect(gift)
	Sleep, 2000
	clicker(821+xloc,331+yloc)
	Sleep, 1000
	clicker(648+xloc,370+yloc)
	Sleep, 1000
	clicker(900+xloc,747+yloc)
	Sleep, 3000
	debug("Gift " . A_Index . " Sent.")
	TrayTip,, Gift %A_Index% Sent.,10
}
TrayTip,, Done sending gift(s).,10
return
;WARNING: refresh browser and clear load screens
^+t::
Send, {Ctrl down}{F5}{Ctrl up}
Sleep,10000
clicker(1198,346)
Sleep,2000
clicker(1190,415)
Sleep,12000
return

;reverse scren calibration
^+s::
MouseGetPos, xpos, ypos 
xposfinal:=xpos+xloc
ypoxfinal:=ypos+yloc
Msgbox, The cursor is at X%xposfinal% Y%ypoxfinal%. 
return

;----------------------------------------------------------SUBS--------------------------------------------------------------------


ReloadMenuHandler:
	Reload
return


CheckUpdate:
	FileDelete, FlightDeckOld.exe
	debug("Running update check")
	TrayTip,, Checking for updates...,10
	UrlDownloadToFile, https://dl.dropboxusercontent.com/s/mikdjr94ij6colu/FlightDeckVersion.ini?token_hash=AAE_LUPzo41dZvBHAu7DzU40vIjSILDRdKJ6vU3qeRXXVQ&dl=1, FlightDeckVersion.ini
	
	
	if ErrorLevel = 1
	{
	MsgBox, ERROR
	}
	if ErrorLevel = 0
	{
		IniRead, serverVersion, FlightDeckVersion.ini, info, version, 1
		IniRead, updateNoteRaw, FlightDeckVersion.ini, info, note, NA
		Transform, updateNote, Deref,  %updateNoteRaw%
		;MsgBox, %serverVersion% %version%
		if (serverVersion <> version) 
		{
		TrayTip,, Update found.,10
updateMessage =
(
An Update is available.  

Current:	v%version% 
New:	v%serverVersion% 

v%serverVersion% patch notes
%updateNote%


Do you want to install the update?
)
			
			MsgBox, 4, MAA Auto Updater Alert, %updateMessage%

			IfMsgBox Yes
			{
				FileMove, FlightDeck.exe, FlightDeckOld.exe, 1
				TrayTip,, Downloading update v%serverVersion%  please wait...,10
				UrlDownloadToFile,https://dl.dropboxusercontent.com/s/5xv7gjw2mn4474q/FlightDeck.exe?token_hash=AAFkN3egLMzXPQrll9K-X5zsZ4QU7qG_ht05MjwJzr8lEg&dl=1, FlightDeck.exe
				if ErrorLevel =1
				{
					FileMove, FlightDeckOld.exe, FlightDeck.exe, 1
					MsgBox, There was a problem downloading the v%serverVersion% update
				}
				TrayTip,, Installing update...,10
				Sleep,5000
				Reload
			}
		;GoSub, ExitHandler
		}
		else
		{
			TrayTip,, No update found.,10
			FileDelete, FlightDeckVersion.ini 	
		}
	}
	else
	{
		TrayTip,, Update check failed,10
	}
	
return
	
return

ExitHandler:
	ExitApp 0
return

Pauser:
	debug("paused triggered")
	pause
return

DeleteUserSettings:
	FileDelete, FlightDeckUserSettings.ini
	GoSub,ReloadMenuHandler
return



CalibrateScreen:
	IfWinActive , Marvel: Avengers Alliance on Facebook, 
	{
		debug("calibrate screen")
		debug("old (" . xloc . "," . yloc . ")")
		MouseGetPos, xpos, ypos
		xloc:=0
		yloc:=0
		xloc:=998-xpos
		yloc:=670-ypos
		debug("new (" . xloc . "," . yloc . ")")
		IniWrite, %xloc%, FlightDeckUserSettings.ini, screen, xloc
		IniWrite, %yloc%, FlightDeckUserSettings.ini, screen, yloc
		TrayTip,, Mouse Position Calibrated `nadjusted by x = %xloc% y = %yloc%,10 
	}
	else
	{
		MsgBox, Can not calibrate screen if Marvel: Avengers Alliance on Facebook is not the active window
	}
return





	
;PixelSearch, Px, Py, 458-xloc, 345-yloc,  1206-xloc, 839-yloc, clockGreen, 5, Fast
;if ErrorLevel
;    MsgBox, That color was not found in the specified region.
;else
    ;MsgBox, A color within 3 shades of variation was found at X%Px% Y%Py%.
	;MouseMove, 828, 638
	;PixelGetColor, color, 828, 638
	;MsgBox This be the color %color%
	



AbortAutoRunTimer:
	debug("timer aborted")
	go:=false
return

AutoRun:
	SetFormat, Float, 0.0
	;converts the hours wanted to run into count of 10 min runs
	loops:=(hours*60)/10
	counter:=1
	timeLeft:=600
	go:=true
	WinWait, Marvel: Avengers Alliance on Facebook, 
	IfWinNotActive, Marvel: Avengers Alliance on Facebook, , WinActivate, Marvel: Avengers Alliance on Facebook, 
	WinWaitActive, Marvel: Avengers Alliance on Facebook, 
	if (checkCalibrationDot())
		{
		loop %loops%{
			;WinWait, Marvel: Avengers Alliance on Facebook, 
			;IfWinNotActive, Marvel: Avengers Alliance on Facebook, , WinActivate, Marvel: Avengers Alliance on Facebook, 
			WinWaitActive, Marvel: Avengers Alliance on Facebook, 
			
				
				
				;Help fight the man and his bot detection
				Random, rand, 1, 30
				srDelay:=sDelay+rand
				statusUpdate("Flight Deck loading `nRun:" . counter)
				TrayTip, ,Starting hero deploy %Counter%, 10,
				timeLeft:=600
				debug("reset")
				debug("Loped hero deploy # " . counter)
				;plane and hero deploys
				if(autoRedeploy = 0 || counter = 1)
				{
					debug("Starting Deploy")
					loop %planeCount%{
					;debug("`n") spacer not needed
		
						planeSelect(A_Index)
						dynamicHeroPicker(A_Index,false)

					}
				}

				
				;click off screen to avert any click disasters
				;Clicker(288,  558)
		
				;The big sleep is 10 min to allow all flights to complete
				;Sleep, 600100
				statusUpdate("Waiting... `nRun:" . counter)
				while timeLeft>0
				{
					if(go)
					{
						timeLeft-=1
						GuiControl,2:,  StatWindowTimer, %timeLeft%
						if(timeLeft<10)
						{
							TrayTip, ,Seconds Left %timeLeft%, 10,
						}
						;try to prevent time out screens from poping up
						if(timeLeft=300)
						{
							debug("prevent timeout screens")
							Clicker(1132,  467)
						}
						Sleep, 1000
					}
					else
					{
						GuiControl,2:,  StatWindowTimer, Aborted
						TrayTip, ,Aborted, 10,
						break
					}
				}
				
				if(go<>true)
				{
					break
				}
				
				TrayTip, ,Deploy %Counter% Done, 10,
				
				
				
				
				;WinWait, Marvel: Avengers Alliance on Facebook, 
				;IfWinNotActive, Marvel: Avengers Alliance on Facebook, , WinActivate, Marvel: Avengers Alliance on Facebook, 
				WinWaitActive, Marvel: Avengers Alliance on Facebook, 
				
				statusUpdate("Completed, now cleaning `nRun:" . counter)
				;timeout screen close click (if it's open it closes it)
				;if the timeout screen is not open mouse clicks on dead space, no worries
				debug("Clearing random timeout windows")
				Clicker(1132,  467)
				Sleep, 1000
				;black knight full screen time out thing
				Clicker(1136,  482)
				Sleep, 1000
				;punisher full screen
				Clicker(1136,  477)
				Sleep, 1000
				;check dot to make sure it's clear
				if (!checkCalibrationDot())
				{
					debug("Clearing timeout window again")
					Clicker(1132,  467)
					Sleep, 1000
					;black knight full screen time out thing
					Clicker(1136,  482)
					Sleep, 1000
					;punisher full screen
					Clicker(1136,  477)
					Sleep, 1000
						if (!checkCalibrationDot())
						{
						break
						}
				}
				;Select 1st plane
				debug("Clearing coins with collect all")
				Clicker(908,  679)
				Sleep, 1000
				
				
				if(autoRedeploy=1)
				{
					debug("Quick re-deploy")
					Clicker(901,742)
					Sleep, 1000
					;Checks for needs training dialog if found dismiss dialog
					checkHeroTrainingScreen()
				}
				else
				{
					;Collect all coins
					debug("Clear all coins")
					Clicker(908,  712)
					Sleep, 1000
					;wait for clear coins to clear off the screen
					Sleep, 7000
				}
				
				
				
				
				;increments run count
				last:=counter
				counter+=1
		
			}
			
		
		
	}
	counter-=1 ;for accounting use
	statusUpdate("Completed run(s):" . counter)
return


SingleFlight:
	WinWait, Marvel: Avengers Alliance on Facebook, 
	IfWinNotActive, Marvel: Avengers Alliance on Facebook, , WinActivate, Marvel: Avengers Alliance on Facebook, 
	WinWaitActive, Marvel: Avengers Alliance on Facebook,
	statusUpdate("Deploying single run")
	if (checkCalibrationDot())
	{
		loop %planeCount%{
			planeSelect(A_Index)
			dynamicHeroPicker(A_Index,true)
		}
	} 

	statusUpdate("Single flight deployed")
return


AbortFlightDeck:
	WinWait, Marvel: Avengers Alliance on Facebook, 
	IfWinNotActive, Marvel: Avengers Alliance on Facebook, , WinActivate, Marvel: Avengers Alliance on Facebook, 
	WinWaitActive, Marvel: Avengers Alliance on Facebook,
	debug("reset")
	debug("Aborting Flights.")
	statusUpdate("Aborting flight deck")
	if (checkCalibrationDot())
	{
		InputBox, abortPlanes ,Are Your Sure?, This will abort all scripts and restart the script.`nHow Many Planes to abort?,,,,,,,,%planeCount%
		if !ErrorLevel
		{
			debug("Abort confirmed for " . abortPlanes . " planes.")
			Random, rand, 1, 80
			srDelay:=sDelay+rand
			
			loop, %abortPlanes%
			{
				debug("Aborting Plane " . abortPlanes)
				planeSelect(A_Index)
				Clicker(766,  743)
				Sleep, srDelay
			}
		}
	} 

	GoSub, AbortAutoRunTimer
	statusUpdate("Flight deck aborted")

return



FarmFriends:
	WinWait, Marvel: Avengers Alliance on Facebook, 
	IfWinNotActive, Marvel: Avengers Alliance on Facebook, , WinActivate, Marvel: Avengers Alliance on Facebook, 
	WinWaitActive, Marvel: Avengers Alliance on Facebook, 
	lastFriendPage+=1
	debug("reset")
	statusUpdate("Friend Farming")
	friendCounter:=1
	loop
	{
		
		PixelSearch, Px, Py, 466-xloc, 922-yloc, 486-xloc, 955-yloc, arrowBlue, 5, Fast
		if ErrorLevel
		{
			loop, %lastFriendSpot%
			{
				debug("Friend: " . friendCounter)
				friendBarSelect(A_index)
				friendScreenGridClick()
				debug("`n")
			}
			
			break
		} 
		else
		{
			loop, 4
			{
				debug("Friend: " . friendCounter)
				friendBarSelect(A_index)
				friendScreenGridClick()
				friendCounter+=1
				debug("`n")
				
			}
		}
		
		friendBarLeft()
	}	
	TrayTip,, Friends Farmed!,10
	statusUpdate("Friend Farm Finished")
return


FirstRunner:
if firstRunB<3
{
	msgcount:=2-firstRunB
	
	GoSub, ShowRulesBox
	GoSub, ShowKeyCommandWindow
	MsgBox, Welcome to The MAA SCRIPT! `nthe proceeding messages will be shown %msgcount% more time(s).
	firstRunB+=1
	IniWrite, %firstRunB%, FlightDeckUserSettings.ini, variables, firstRunB
}
return

RegisterUser:
FormatTime, CurDate,, MMddyyy
if(!(lastRregDate==CurDate && lastRegVer==version)){
	TrayTip, , Registering...
		url:="https://script.google.com/macros/s/AKfycbzDYC4IfpwUQ1g4wtoTZoaqEn0GS3qygk-LxG0OvhATVjNvP-Iw/exec?user_name=" . A_UserName . "&script_version=" . version . "&os=" . A_OSVersion .  "&computer_name=" . A_ComputerName
		UrlDownloadToFile, %url%, FlightDeckRegistration.Log
		if ErrorLevel=1
		{
			TrayTip, , A registration error occured. MAA Script v%version%
		}
		else
		{
			TrayTip, ,MAA Script v%version% Registered `nF10 for keys, 10,
			FileDelete, FlightDeckRegistration.Log 
			IniWrite, %CurDate%, FlightDeckUserSettings.ini, security, lastRregDate
			IniWrite, %version%, FlightDeckUserSettings.ini, security, lastRegVer
		}


		#Persistent  ; Keep the script running until the user exits it.
			Menu, tray, add  ; Creates a separator line.
			Menu, tray, add, MAA Script v%version%, ActionWindow
		return
}
else
{
		TrayTip, ,MAA Script v%version% Loaded `nF10 for keys, 10,
}
return


;-----------------------------------------------------------------------GUI STUFF----------------------------------------------------------------
;============Settings===========
SettingsWindow:
	debug("user settings window open")
	IfWinActive , User Settings
	{
		Gui, 4:destroy
	}
	Gui, 4:+AlwaysOnTop
	Gui, 4:Add, Text,,Plane Count:
	Gui, 4:Add, Text,,Hours To Run:
	Gui, 4:Add, Text,,Click Delay:
	;Gui, 4:Add, Text,,Last Friend Page:
	Gui, 4:Add, Text,,Last Friend Spot:
	Gui, 4:Add, Text,,Single Run Time:
	Gui, 4:Add, Text,,Log Debug Info:
	Gui, 4:Add, Text,,XP Heros 1st:
	Gui, 4:Add, Text,,Collect and Resend:
	Gui, 4:Add, Text,,Screen Offset (X,Y):
	
	;Gui, 4:Add, Text,,Train Hero Spot:
	Gui, 4:Add, Edit,ys vpcount Limit1 Number W30, %planeCount%
	Gui, 4:Add, Edit, vh Limit2 Number W30, %hours%
	Gui, 4:Add, Edit, vs Number W50, %sDelay%
	;Gui, 4:Add, Edit, vlfp Limit2 Number W30, %lastFriendPage%
	Gui, 4:Add, Edit, vlfs Limit1 Number W30, %lastFriendSpot%
	Gui, 4:Add, Edit, vtr Limit1 Number W30, %timeRun%	
	Gui, 4:Add, Checkbox,h20 vshowT Checked%logDebug%
	Gui, 4:Add, Checkbox,h20 vshowXp Checked%showXpHerosFirst% 
	Gui, 4:Add, Checkbox,h20 varedeploy Checked%autoRedeploy%
	Gui, 4:Add, Text,,(%xloc%, %yloc%)
	
	;Gui, Add, Edit, vtp Limit1 Number W30, %trainPage%
	;Gui, Add, Edit, vth Limit2 Number W30, %trainHero%
	Gui, 4:Add, Text,ys,
	Gui, 4:Add, Text,ys,
	Gui, 4:Add, Text,ys section,Plane
	Gui, 4:Add, Text,ys,Pages
	Gui, 4:Add, Text,ys,Hero
	loop, %planeCount%
	{
		right:=%A_index%Right
		hero:=%A_index%Hero
		Gui, 4:Add, Text,xs section W27, %A_index%:
		Gui, 4:Add, Edit, v%A_index%r ys Limit2 Number W30, %right%
		Gui, 4:Add, Edit, v%A_index%h ys Limit1 Number W30, %hero%
	}
	;Gui, 4:Add, Text,xs section,Pages Left:
	;Gui, Add, Edit, vleft ys Limit2 Number W30, %leftPages%
	Gui, 4:Add, Button, default x10 y300 section, &Ok
	Gui, 4:Add, Button, ys, &Apply
	Gui, 4:Add, Button, ys, &Close
	Gui, 4:Add, Button, ys, Reset-&All
	Gui, 4:Add, Button, ys, Reset-&Deploys
	Gui, 4:Add, Button, ys, &HELP
	Gui, 4:Show,x%SettingsWindowX% y%SettingsWindowY%, User Settings
return

4ButtonHELP:
	debug("Settings help Clicked")
	MsgBox, 4096, User Settings HELP, Plane Count = number of planes you have (1-8) `n`nHours TO Run = how many whole hours you want the 10 min flights to run `n`nClick Delay =  the delay in milliseconds between clicks `n`nLast Friend Spot = the position of your last friend on the far left page(4 is the far Left - 1 is the far right)`n`nSingle Run Time = for single flight F1 time selection window first page options 1-4 (1 = top left is 10 min, 4 = bottom right is 2hr) this is used if no time is already selected `n`nLog Debug = Toggle logging debug info during usage Ctrl+Shift+d to show log window. `n`nXP Heros 1st = If checked will select the order by Heros that need xp fist on the hero select box. `n`nCollect and Resend = If checked will use custom hero deploy once, following deploys will use the collect and resend feature 1st plane. `n`n Screen Offset = values from screen calibration (F8) on the white dot on the eagles tale from the filght deck`n`n`nFor F1 or F2`nPlanes = bottom right is 1 the top Left is 8 `nPages = the number of pages to click right assuming you start on the far left (0 is default)`nHero = The far left Hero is 1, the far right is 5 `n`n`nUser Settings Button bar`nOk = saves and closes window `nApply = Saves and leaves window open `nClose = does not save and closes window `nReset-All = restores all settings to default, Reset-Deploys = resets only the custom plane and hero setting `nHELP = well here you are
return

4GuiClose:
GoSub, 4ButtonClose
return

4ButtonOK:
	debug("Settings Ok clicked, saving, exiting")
	GoSub, 4ButtonApply
	Gui, 4:destroy
return

4ButtonApply:
	debug("Settings Apply clicked, saving")
	saveWindowLocation("SettingsWindow", "User Settings")
	;leftPages:=left
	Gui, 4:submit, NoHide
	loop, 8
	{
		%A_index%Right:=%A_index%r
		%A_index%Hero:=%A_index%h
	}
	planeCount:=pcount
	hours:=h
	sDelay:=s
	lastFriendSpot:=lfs
	timeRun:=tr
	logDebug:=showT
	showXpHerosFirst:=showXp
	autoRedeploy:=aredeploy
		if planecount>8 
		{
			planeCount:=8
		}
		else if planeCount<1
		{
			planeCount:=1
		}
	saveSettings()
	TrayTip, ,User Settings Saved, 10,
	Gui, 4:destroy
	GoSub,SettingsWindow
return

4ButtonClose:
debug("Settings Cancel Clicked")
	saveWindowLocation("SettingsWindow", "User Settings")
TrayTip, ,Changes To User Settings aborted, 10,
	Gui, 4:Destroy
return

4ButtonRESET-DEPLOYS:
debug("Settings Reset deploys Clicked")
	;leftPages:=1
	loop, 8
	{
		%A_index%Right:=0
		%A_index%Hero:=1
	}
	saveSettings()
	TrayTip, ,Custom Deploys Reset, 10,
	Gui, 4:destroy
	GoSub,SettingsWindow
return

4ButtonRESET-ALL:
debug("Settings Reset-All Clicked")
	leftPages:=1
	loop, 8
	{
		%A_index%Right:=0
		%A_index%Hero:=1
	}
	planeCount:=8
	hours:=24
	sDelay:=350
	lastFriendSpot:=4
	timeRun:=3
	logDebug:=0
	showXpHerosFirst:=0
	autoRedeploy:=1
	saveSettings()
	TrayTip, ,All User Settings Reset, 10,
	Gui, 4:destroy
	GoSub,SettingsWindow
return
;=====end settings=====


DebugWindow:
	IfWinActive , DebugLog
	{
	Gui, 3:destroy
	}
	if(!logDebug)
	{
		MsgBox, Debug Logging disabled please turn on in settings (F9).
	}	
	else
	{

		Gui,3:+AlwaysOnTop
		Gui, 3:Add, Edit, ReadOnly W250 H600 vDebugView , %messageLog%
		Gui, 3:Add, Button, , &CLOSE
		Gui, 3:Show,x%DebugWindowX% y%DebugWindowY%, DebugLog
	}

	return
	3ButtonCLOSE:
		saveWindowLocation("DebugWindow", "DebugLog")
		WinGetPos, DebugWindowX, DebugWindowY, h , w, DebugLog,
		
		IniWrite, %DebugWindowX%, FlightDeckUserSettings.ini, windows, DebugWindowX
		IniWrite, %DebugWindowY%, FlightDeckUserSettings.ini, windows, DebugWindowY
	Gui, 3:destroy
	return

	3GuiClose:
	GoSub, 3ButtonClose
return




StatWindow:

	debug("Status window opened")
	IfWinActive , Status Window
	{
	Gui, 2:destroy
	}
	Gui, 2:+AlwaysOnTop
	Gui, 2:Add, Text,section, Current Status:
	Gui, 2:Add, Text, -xs w150 h28 vStatusWindowStatus , %statusMessage%
	gui, 2:add, text,-xs w150 h1 0x10, 
	Gui, 2:Add, Text,-xs section, Seconds left for run:
	Gui, 2:Add, Text, w100 ys vStatWindowTimer , NA
	Gui, 2:Add, Button,default x10 y90 section , &Close
	Gui, 2:Add, Button, ys , &Stop-autorun
	Gui, 2:Show,x%StatusWindowX% y%StatusWindowY%,Status Window
return

2ButtonClose:
	saveWindowLocation("StatusWindow", "Status Window")
	Gui, 2:destroy
return

2GuiClose:
GoSub, 2ButtonClose
return

2ButtonStop-autorun:
GoSub, AbortAutoRunTimer
return



ActionWindow:
	IfWinActive , Action Buttons
	{
	Gui, 5:destroy
	}
	Gui, 5:+AlwaysOnTop,
	Gui, 5:Add, Text,, Flight Deck Control
	Gui, 5:Add, Button, gAutoRun w200, Start Autorun
	Gui, 5:Add, Button, gSingleFlight w200, Start Single Flight
	Gui, 5:Add, Button,  w200, Stop-autorun
	Gui, 5:Add, Button, gAbortFlightDeck w200, Abort Flight Deck Deploys
	gui, 5:add, text, w200 h1 0x10
	Gui, 5:Add, Text,, Windows
	Gui, 5:Add, Button, gStatWindow w200, Status
	Gui, 5:Add, Button, gDebugWindow w200, Debug
	Gui, 5:Add, Button, gSettingsWindow w200, Settings
	gui, 5:add, text, w200 h1 0x10
	Gui, 5:Add, Text,, Friends
	Gui, 5:Add, Button, gFarmFriends w200, Farm Friends
	gui, 5:add, text, w200 h1 0x10
	Gui, 5:Add, Text,, Info windows
	Gui, 5:Add, Button, gShowRulesBox w200, Show Rules Authorization
	Gui, 5:Add, Button, gShowKeyCommandWindow w200, Show Key Commands
	gui, 5:add, text, w200 h1 0x10
	Gui, 5:Add, Text,, Script Control
	;Gui, 5:Add, Button, gUpdateStandard w200, Download Latest Update
	Gui, 5:Add, Button, gReloadMenuHandler w200, Reload The Script
	Gui, 5:Add, Button, gExitHandler w200, Exit The Script
	gui, 5:add, text, w200 h1 0x10
	Gui, 5:Add, Button,  w200, &Close
	Gui, 5:Add, Button, gCloseAllWindows w200, &Close All Windows
	Gui, 5:Show,X%ActionButtonWindowX% Y%ActionButtonWindowY%,Action Buttons
return

5ButtonClose:
	saveWindowLocation("ActionButtonWindow", "Action Buttons")
	Gui, 5:destroy
return

5GuiClose:
GoSub, 5ButtonClose
return

CloseAllWindows:
	saveWindowLocation("SettingsWindow", "User Settings")
	saveWindowLocation("DebugWindow", "DebugLog")
	saveWindowLocation("StatusWindow", "Status Window")
	saveWindowLocation("ActionButtonWindow", "Action Buttons")
	
	loop 10
	{
		Gui, %A_index%:destroy
	}
return

openAllWindows:

GoSub, ActionWindow
GoSub, StatWindow
GoSub, DebugWindow
GoSub, SettingsWindow
return

ShowKeyCommandWindow:
	IfWinActive , Key Commands
	{
	Gui, 6:destroy
		}
	Gui, 6:+AlwaysOnTop,
	Gui, 6:Add, Text,section , To Start Go To MAA in Browser
	Gui, 6:Add, Text,-xs Section, 1. F8 ;Ctrl+Shift+z
	Gui, 6:Add, Text,-ys , Calibrates the screen to the dot on the eagles tail
	Gui, 6:Add, Text,-xs section , 2. F9 ;Ctrl+Shift+v
	Gui, 6:Add, Text, ys , Opens the User Settings Window (must be done at least once)
	Gui, 6:Add, Text,-xs section , 3. F1 ;Ctrl+Shift+s
	Gui, 6:Add, Text, ys , Starts the 10 min auto runs
	gui, 6:add, text, -xs w400 h5 0x10

	Gui, 6:Add, Text,section , Flight Deck Commands
	Gui, 6:Add, Text,-xs section , F1 ;Ctrl+Shift+s
	Gui, 6:Add, Text,-ys , Starts the 10 min auto runs
	Gui, 6:Add, Text,-xs section , F4 ; Ctrl+Shift+e
	Gui, 6:Add, Text, ys , Throws flag to stop current auto run timer
	Gui, 6:Add, Text,-xs section , F2 ;Ctrl+Shift+a
	Gui, 6:Add, Text, ys , Single Run (no repeat or auto-clear)
	Gui, 6:Add, Text,-xs section , F3 ;Alt+s
	Gui, 6:Add, Text, ys , Aborts flights on the flight deck (plane count prompt) and stops timer if running
	gui, 6:add, text, -xs w400 h5 0x10

	Gui, 6:Add, Text,section , Windows
	Gui, 6:Add, Text,-xs section, F9 ; Ctrl+Shift+v
	Gui, 6:Add, Text,-ys , Opens the User Settings Window (must be done at least once)
	Gui, 6:Add, Text,-xs section , F12 ;Ctrl+Shift+w
	Gui, 6:Add, Text, ys , Opens script status window
	Gui, 6:Add, Text,-xs section , F11 ;Ctrl+Shift+x
	Gui, 6:Add, Text, ys , Opens Button Comand Window
	Gui, 6:Add, Text,-xs section , F10 ;Ctrl+Shift+i
	Gui, 6:Add, Text, ys , Opens this key command window
	Gui, 6:Add, Text,-xs section , Ctrl+Shift+d
	Gui, 6:Add, Text, ys , Opens Debug window (must be turned on in settings)
	Gui, 6:Add, Text,-xs section , Ctrl+Shift+f
	Gui, 6:Add, Text, ys , Opens All Windows
	Gui, 6:Add, Text,-xs section , Ctrl+Shift+g
	Gui, 6:Add, Text, ys , Closes all windows
	gui, 6:add, text, -xs w400 h5 0x10

	Gui, 6:Add, Text,section , Other Commands
	Gui, 6:Add, Text,-xs section, F7 ;Ctrl+Shift+c
	Gui, 6:Add, Text,-ys , Farms Friends (check settings first)
	Gui, 6:Add, Text,-xs section, F8 ;Ctrl+Shift+z
	Gui, 6:Add, Text,-ys , Calibrates the screen to the dot on the eagles tail
	Gui, 6:Add, Text,-xs section , F5 ;Ctrl+Shift+r
	Gui, 6:Add, Text, ys , Stops and reloads the entire script
	
	Gui, 6:Add, Text,-xs section ,  F6 ;Ctrl+Shift+p
	Gui, 6:Add, Text, ys , Pauses or un-pauses the active running task 
	Gui, 6:Add, Text,-xs section , Pause (key) or Ctrl+Shift+w
	Gui, 6:Add, Text, ys , Disables/Enables other hotkeys (ie returns key bindins to normal use) 
	Gui, 6:Add, Text,-xs section , Ctrl+Shift+e
	Gui, 6:Add, Text, ys , Stops and exits the script
	Gui, 6:Add, Text,-xs section , Ctrl+Shift+l
	Gui, 6:Add, Text, ys , Deletes user's .ini file and reloads script with defaults
	gui, 6:add, text, -xs w400 h5 0x10

	Gui, 6:Add, Text, -xs Section , BTW your fracking owe me!!!
	Gui, 6:Add, Button,  w200, &Close This Window

	Gui, 6:Show, ,Key commands for MAA v%version% 

return

6ButtonCloseThisWindow:
	Gui, 6:destroy
return

ShowRulesBox:
	debug("Rules Window Open")
	MsgBox, 4,IMPORTANT TERMS & RULES, `nEnd User License Agreement! `n`nTERMS:`n-I THE SCRIPT CREATOR AM NOT RESPONSIBLE FOR WHAT HAPPENS WHILE YOU USE THIS TOOL OR WHAT YOU DO IN MAA. `n`n-For you safety please do not share this script! (that means I will hunt you down) `n`n-The script and its contents (except the icon) are the intellectual property of the script writer, any duplication or reuse is strictly prohibited.`n`n-This tool is free to use, if you paid money you were screwed! `n`nRULES FOR BEST RESULTS:`n-The Script will not run if the browser window is maximized but behind other screens `n-Computer must NOT: sleep or turn hard drive off for the script to work `n-Leave Browser running and on the Avengers Alliance Flight Deck.  `nCheck back often, MAA is flash based, the script has no ability to assure proper screens or if the game has timed out or not `n-Screw spelling errors, I don’t care `n-Do not open MAA in another browser or computer it will haut any other running session  `n`n DO YOU AGREE TO THESE TERMS & RULES
	
	;, some custom settings will not be used/break as active window colors are used to preform actions. It is recommended that custom deployments be reset to default if you wish to run background mode. Also allow one run to fully deploy before opening other windows.
	IfMsgBox Yes
	{
	
	}
	else
	{
	GoSub, ExitHandler
	}
Return


;#################################################################### METHODS ####################################################################



checkCalibrationDot()
{
global xloc, yloc
	
	IfWinActive , Marvel: Avengers Alliance on Facebook
	{
		debug("Check Screen Location")
		PixelSearch, Px, Py, 995-xloc, 667-yloc, 1001-xloc, 673-yloc, 0xC2DBFF, 0, Fast
		if ErrorLevel
		{
	
			statusUpdate("Calibration failure")
			MsgBox, 48, SCREEN POSITION ERROR, A screen position error has been detected  `n`nPlease make sure you are scrolled all the way to the top. `nYou may need to Re-calibrate the screen `n(See step 1. on the info screen F10) 
			return false
			;return true
		}
		else
		{
			return true
		}
	}
	else
	{
		return true
	}
}


dynamicHeroPicker(count, singleRun)
{
	global xloc, yloc, srDelay, clockGreen, arrowBlue,frameBlue,timeRun,showXpHerosFirst
	checkGreen:=0x02F746
	;first plane checks for time choice and hero xp sort order
	if count = 1
	{	
		;Auto detect time selection needed
		Sleep, 200
		debug("Check for Green time selection clock")
		PixelSearch, Px, Py, 633-xloc, 484-yloc, 654-xloc, 502-yloc, clockGreen, 5, Fast
		if ErrorLevel=0
		{
		
			debug("Clock detected, picking a time")
			;time set to 10 min
			if (singleRun)
			{
			timePicker(timeRun)
			}
			else
			{
			timePicker(1)
			}
			
		}
		Sleep, 200
		;assures you are on the far left
		
		goFarLeftHeroPage()
		
		;check setting for hero xp
		if showXpHerosFirst = 1
		{
			;if green check not checked then check it on hero select page for ordering by xp hero first
			debug("Xp Hero First is on")
			PixelSearch, Px, Py, 746-xloc, 774-yloc, 758-xloc, 786-yloc, checkGreen, 2, Fast
			if ErrorLevel=1
			{
			debug("Needs Checking")
				Clicker(753,  782)
			}
		}
		
		if showXpHerosFirst = 0 ; if unchecked 
		{
			;check for green check, and un check it
			debug("Checking if Green Check for Xp Hero First is off")
			PixelSearch, Px, Py, 744-xloc, 773-yloc, 759-xloc, 786-yloc, checkGreen, 2, Fast
				if ErrorLevel=0
				{
				debug("Needs Un Checking")
					Clicker(753,  782)
				}
		}

		
		

	}
	

	
	rightHeroSelectPage(%count%Right)
	Sleep, 200*%count%Right
	heroSelect(%count%Hero)
	;Check for green confirm button
	;PixelSearch, Px, Py, 797-xloc, 827-yloc, 865-xloc, 839-yloc, 0x4CE268, 5, Fast
	;if ErrorLevel
	;{
	;	heroSelect(%count%Hero)
	;}

	sendHero()

	;Checks for needs training dialog if found dismiss dialog
	checkHeroTrainingScreen()
}

checkHeroTrainingScreen()
{
global xloc, yloc, srDelay, clockGreen, arrowBlue,frameBlue,timeRun
Sleep, 200
	IfWinActive , Marvel: Avengers Alliance on Facebook
	{
		debug("Check for training dialog")
		PixelSearch, Px, Py, 1035-xloc, 676-yloc, 1041-xloc, 681-yloc, frameBlue, 5, Fast
		if ErrorLevel=0
		{
			debug("Needs Training detected")
			;always ignore
			Clicker(661,  654)
			Sleep, srDelay+100
			;confirm
			Clicker(886,  690)
			Sleep, srDelay+100
		}
	}
}


goFarLeftHeroPage()
{
global xloc, yloc, srDelay, clockGreen, arrowBlue,frameBlue,timeRun
debug("Far left hero page")
		loop{
		debug("Checking for blue left arrow")
			PixelSearch, Px, Py, 500-xloc, 533-yloc, 520-xloc, 561-yloc, arrowBlue, 5, Fast
			if ErrorLevel
			{
			debug("blue arrow not found, done")
				break
			}
			else
			{
			debug("blue arrow found")
				leftHeroSelectPage(1)
			}
		}
}

timePicker(pick)
{
	global xloc, yloc, srDelay
	if (pick=1)
	{
		Clicker(676,  606)
		Sleep, srDelay+100
	}
	else if (pick=2)
	{
		Clicker(977,  607)
		Sleep, srDelay+100
	}
	else if (pick=3)
	{
		Clicker(687,  799)
		Sleep, srDelay+100
	}
	else if (pick=4)
	{
		Clicker(981,  802)
		Sleep, srDelay+100
	}
}
;standard send button click
sendHero()
{
	global xloc, yloc, srDelay
	Clicker(828,  828)
	Sleep, srDelay
}



;how many pages you want to click right on the hero select screen
rightHeroSelectPage(pages)
{
	debug("Hero page right " . pages)
	global xloc, yloc, srDelay
	delayPlus:=0
	loop %pages%
	{	
		Clicker(1143,  546)
		delayPlus+=100
	}
	Sleep, srDelay+delayPlus
}



;how many pages you want to click left on the hero select screen
leftHeroSelectPage(pages)
{
	global xloc, yloc, srDelay
	
	loop, %pages%
	{
		Clicker(516,  546)
	}
	Sleep, srDelay
	
}



;Choose a hero from menu (left 1 to right 5)
heroSelect(heroNumber)
{
	global xloc, yloc, srDelay, arrowBlue
	curX:=0
	curY:=0
	debug("Picking hero: " . heroNumber)
	if (heroNumber=1)
	{
		curX:=593
		curY:=593

	}
	else if (heroNumber=2)
	{
		curX:=712
		curY:=594

	}
	else if (heroNumber=3)
	{
		curX:=831 
		curY:=595

	}
	else if (heroNumber=4)
	{
		curX:=952
		curY:=595

	}
	else if (heroNumber=5)
	{
		curX:=1068
		curY:=593

	}
	;checks if button for hero is blue, if not go to first page, and pick first hero
	;debug("Check for blue hero Select button")
	;Sleep,100
	;PixelSearch, Px, Py, curX-10, curY-10, curX+10, curY+10, 0xE69A15 , 10, Fast  ;0xCE9813
	;if ErrorLevel
	;{
	;	debug("Forcing 1st Hero due to no blue button")
	;	goFarLeftHeroPage()
	;	;Sleep, srDelay+100
	;	curX:=593
	;	curY:=593
	;}

	Clicker(curX,  curY)
	Sleep, srDelay
			
}

;Plane click locations for planes 1-8
planeSelect(planeNumber)
{
	debug("Plane select: " . planeNumber)
	global xloc, yloc, srDelay
	if (planeNumber=1)
	{
		loop, 2{
			Random, rand, 1, 3
			Clicker(902+rand,  726+rand)
			Sleep, srDelay
		}
	}
	else if (planeNumber=2)
	{
		loop, 2{
		Random, rand, 1, 3
			Clicker(874+rand,  701+rand)
			Sleep, srDelay
		}		
	}
	else if (planeNumber=3)
	{
		loop, 2{
		Random, rand, 1, 3
			Clicker(836+rand,  680+rand)
			Sleep, srDelay
		}
	}
	else if (planeNumber=4)
	{
		loop, 2{
		Random, rand, 1, 3
			Clicker(801+rand,  658+rand)
			Sleep, srDelay
		}
	}
	else if (planeNumber=5)
	{
		loop, 2{
		Random, rand, 1, 3
			Clicker(766+rand,  642+rand)
			Sleep, srDelay
		}
	}
	else if (planeNumber=6)
	{
		loop, 2{
		Random, rand, 1, 3
			Clicker(730+rand,  615+rand)
			Sleep, srDelay
		}
	}
	else if (planeNumber=7)
	{
		loop, 2{
		Random, rand, 1, 3
			Clicker(692+rand,  596+rand)
			Sleep, srDelay
		}
	}
	else if (planeNumber=8)
	{
		loop, 2{
		Random, rand, 1, 3
			Clicker(662+rand,  579+rand)
			Sleep, srDelay
		}
	}
}

;######################################### SAVE STUFF
saveSettings(){
	global planeCount, hours, sDelay, lastFriendPage, lastFriendSpot, leftPages, 1Right, 1Hero, 2Right, 2Hero, 3Right, 3Hero, 4Right, 4Hero, plane, 5Right, plane, 5Hero, plane, 6Right, plane, 6Hero, plane, 7Right, plane, 7Hero, plane, 8Right, plane, 8Hero, trainHero, trainPage, logDebug, timeRun, showXpHerosFirst, autoRedeploy
	debug("Saving prefrences")
	
	IniWrite, %planeCount%, FlightDeckUserSettings.ini, variables, planeCount
	IniWrite, %hours%, FlightDeckUserSettings.ini, variables, hours
	IniWrite, %sDelay%, FlightDeckUserSettings.ini, variables, sDelay
	;IniWrite, %lastFriendPage%, FlightDeckUserSettings.ini, friends, lastFriendPage
	IniWrite, %lastFriendSpot%, FlightDeckUserSettings.ini, friends, lastFriendSpot
	IniWrite, %logDebug%, FlightDeckUserSettings.ini, variables, logDebug
	IniWrite, %timeRun%, FlightDeckUserSettings.ini, variables, timeRun
	IniWrite, %showXpHerosFirst%, FlightDeckUserSettings.ini, variables, showXpHerosFirst
	IniWrite, %autoRedeploy%, FlightDeckUserSettings.ini, variables, autoRedeploy
	;IniWrite, %trainPage%, FlightDeckUserSettings.ini, plane, trainPage
	
	;IniWrite, %leftPages%, FlightDeckUserSettings.ini, plane, leftPages
	IniWrite, %1Right%, FlightDeckUserSettings.ini, plane, 1Right
	IniWrite, %1Hero%, FlightDeckUserSettings.ini, plane, 1Hero
	IniWrite, %2Right%, FlightDeckUserSettings.ini, plane, 2Right
	IniWrite, %2Hero%, FlightDeckUserSettings.ini, plane, 2Hero
	IniWrite, %3Right%, FlightDeckUserSettings.ini, plane, 3Right
	IniWrite, %3Hero%, FlightDeckUserSettings.ini, plane, 3Hero
	IniWrite, %4Right%, FlightDeckUserSettings.ini, plane, 4Right
	IniWrite, %4Hero%, FlightDeckUserSettings.ini, plane, 4Hero
	IniWrite, %5Right%, FlightDeckUserSettings.ini, plane, 5Right
	IniWrite, %5Hero%, FlightDeckUserSettings.ini, plane, 5Hero
	IniWrite, %6Right%, FlightDeckUserSettings.ini, plane, 6Right
	IniWrite, %6Hero%, FlightDeckUserSettings.ini, plane, 6Hero
	IniWrite, %7Right%, FlightDeckUserSettings.ini, plane, 7Right
	IniWrite, %7Hero%, FlightDeckUserSettings.ini, plane, 7Hero
	IniWrite, %8Right%, FlightDeckUserSettings.ini, plane, 8Right
	IniWrite, %8Hero%, FlightDeckUserSettings.ini, plane, 8Hero
}
;######################################### FRIEND FARM
friendScreenGridClick(){
global xloc, yloc, clockGreen, arrowBlue,logDebug
PxLast:=0
PyLast:=0
yFactor:=0
trys:=0
clickCount:=0
	debug("Starting Grid Clicking")

	loop{
		
		if clickCount>600
		{
			break
		}
		;from gold deal 551, 341)
		debug("check for green eagle")
		PixelSearch, Px, Py, 458-xloc, 345-yloc, 1206-xloc, 839-yloc, clockGreen, 4, Fast
		if ErrorLevel
		{
		debug("green eagle not found")
			;Sleep, 100
			debug("check for blue wait")
			PixelSearch, Px, Py, 458-xloc, 345-yloc, 1206-xloc, 839-yloc, 0xFEBC5C, 2, Fast  
			if ErrorLevel
			{
			debug("blue not found")
					if trys>3
					{
						if(logDebug){
						debug("Friend farmed (clicks: " . clickCount . ")")
						}
						Sleep, 1000
						break
						
					}
					debug("Re-checking: " . trys)
					trys+=1
				

			
			}
	

		}
		else
		{
		;debug("green eagle found")
		trys:=0
			;if same location found try clicking lower.
			if (PxLast<>0 and PyLast<>0 and yFactor=0)
			{
				pxlp:=PxLast+20
				pxlm:=PxLast-20
				pylp:=PyLast+20
				pylm:=PyLast-20
				if (Px>pxlm and Px<pxlp and Py>pylm and Py<pylp) 
				{
					yFactor:=65

				}
				else
				{
					yFactor:=0
				}
			}
			;MsgBox, px,pxlast= %Px% %PxLast%`npxlp pxlm= %pxlp% %pxlm%  `npy= %Py% %PyLast% `pylp pylm= %pylp% %pylm% `nyFactor= %yFactor% 
			;MouseMove, Px+60, Py
			yOverageCheck:=Py-yloc+yFactor
			if (yOverageCheck>830)
			{
				Py:=829
				yFactor:=0
			}
			
			yFinal:=Py+yFactor
			;MouseMove Px, yFinal
			ControlClick, x%Px% y%yFinal%, Marvel: Avengers Alliance on Facebook
			clickCount+=1
			;Sleep, 100
			PxLast:=Px
			PyLast:=Py
			yFactor:=0
			if(logDebug){
			debug("Click Count: " . clickCount . " @ +" . Px . "," . Py )
			}
			
		}
	}
	;TrayTip, ,Friend farmed (clicks: %clickCount%) Trys: %trys%, 10,
	
	

}

friendBarSelect(friendNumber)
{	
	debug("Friend Bar Position " . friendNumber)
	;used to move mouse of friend select menu
	mouseShift:=65
	global xloc, yloc, sDelay
	if(friendNumber=1)
	{
	MouseClick, left, 814-xloc,  930-yloc
	Sleep, sDelay+100
	Clicker(812,  799)
	Sleep, 100
	MouseMove, 812+mouseShift-xloc,  799-yloc
	
	}
	else if (friendNumber=2)
	{
	MouseClick, left, 745-xloc,  936-yloc
	Sleep, sDelay+100
	Clicker(760,  803)
	Sleep, 100
	MouseMove, 760+mouseShift-xloc,  803-yloc
	
	}
	else if (friendNumber=3)
	{
	MouseClick, left, 680-xloc,  932-yloc
	Sleep, sDelay+100
	Clicker(688,  801)
	Sleep, 100
	MouseMove, 688+mouseShift-xloc,  801-yloc
	
	}
	else if (friendNumber=4)
	{
	MouseClick, left, 617-xloc,  938-yloc
	Sleep, sDelay+100
	Clicker(613,  807)
	Sleep, 100
	MouseMove, 613+mouseShift-xloc,  807-yloc
	Sleep, 1100
	}
	
	Sleep, 1700
}

friendBarLeft(){
	debug("Friend Bar Click Left")
	global xloc, yloc
	Clicker(476,  941)
	Sleep, 1000
}

Clicker(xcord, ycord)
{
	global xloc, yloc
	xfinal:=xcord-xloc
	yfinal:=ycord-yloc
	SetControlDelay -1
	debug("clk: (" . xfinal . "," . yfinal . ")") 
	ControlClick, x%xfinal% y%yfinal%, Marvel: Avengers Alliance on Facebook
}


debug(Message)
{
	global logDebug, xloc, yloc, messageLog

	if(logDebug)
	{
		if(Message = "reset")
		{
			messageLog:="Debug Reset `n"
			Tooltip,
		}
		else
		{
			FormatTime, Time,, HH:mm:ss
			messageLog:= "" . Time . A_tab . Message . "`n" . messageLog
			;MouseMove, 222-xloc, 568-yloc
			;Tooltip, %messageLog%
			GuiControl,3:,  DebugView, %messageLog%
		}
	}
}

saveWindowLocation(ParamName, Title)
{
	global ActionButtonWindowX, ActionButtonWindowY, SettingsWindowX, SettingsWindowY, DebugWindowX, DebugWindowY, StatusWindowX, StatusWindowY,
	WinGetPos, X, Y, h , w, %Title%
	If (X>=0 && Y>=0)
	{
		%ParamName%X:=X
		%ParamName%Y:=Y
		IniWrite, %X%, FlightDeckUserSettings.ini, windows, %ParamName%X
		IniWrite, %Y%, FlightDeckUserSettings.ini, windows, %ParamName%Y
	}
}


statusUpdate(input)
{
	global statusMessage
	statusMessage:=input
	debug("Status Update: " . statusMessage)
	GuiControl,2:, StatusWindowStatus, %statusMessage%
}

isHeroWindowOpen()
{
global xloc, yloc,
debug("Check for open hero window")
PixelSearch, Px, Py, 1151-xloc, 404-yloc, 1178-xloc, 421-yloc, 0xFFBA00, 4, Fast
		if ErrorLevel
		{
			debug("not open")
			return false
			
		}
		else
		{
			debug("is open")
			return true
		}
}




closeHeroWindow()
{
	Clicker(1164,417)
}




giftSelect(gift)
{

	if gift=1
	{
		clicker(629,609)
	}

	if gift=2
	{
		clicker(763,609)
	}

	if gift=3
	{
		clicker(893,609)
	}

	if gift=4
	{
		;odd page has diff loc than others
		clicker(1024,614)
	}

	if gift=5
	{
		clicker(633,814)
	}

	if gift=6
	{
		clicker(763,814)
	}

	if gift=7
	{
		clicker(895,814)
	}
	if gift=8
	{
		clicker(895,814)
	}
}


;############################################################################## END OF LINE ##########################################################################################################
