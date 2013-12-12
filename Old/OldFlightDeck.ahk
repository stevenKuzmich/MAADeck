;############################################################################## Info #############################################################################################################
;copywrited damit
;MAA 10 min auto flight deck script by SK

;RULES 
	;Use Chrome Browser
	;Computer must NOT: sleep, auto turn monotor off, or turn harddrive off, 
	;DO NOT CLOSE BROWSER BETWEEN FLIGHTS! There are session settings that will be lost and script will run but not work.
	;Leave Browser running and on the Avengers Alliance Flight Deck.
	;I do not recomend using computer while flights are in progress, 
		;you can try but beware after the set time it will start clicking if you like it or not
	;Once things are running you can try turrning your monitor off using the power button
	;I am not responsible for what happens
	;Check back often, MAA is flash based, the script has no ability to assure propper screens or if the game has timed out or not
	;Screw spelling errors, I dont care
	;Do not open MAA in another browser or computer	
	;For you saftey please do not share this script! (that means i will kill you)
	
;STEPS for 1st run
	;Run script
	;1. Run and adjust Settings Ctrl+Shift+v Saved in FlightDeckUserSettings.ini
	;2. SCRIPT Calibrate to your monitor/chrome Saved in FlightDeckUserSettings.ini upon calibrations
		;Carefuly click your mouse on the white dot on the eagle's tale on the flight deck leave it on the white dot and press Ctrl+Shift+m
	;3. Ctrl+Shift+y make sure in setting you select your training page and training hero (a training hero is one that has full xp and needs training, 
	;there is a very bad dialog box that needs to be turned off
		;Manual MAA Preflight steps in MAA(you will need to do this initial setup flight before running the auto flights for the given browser session) 
		;1. Select any plane
		;2. Select 10 min flights, this script is entirly built around 10 min flights, anything else will be a problem(session remembers your choice)
		;3. Select a hero that needs leveling (AKA max xp but not training) 
			;and when the warning prompts you check the Don't Show this again check box! (session rembers your choice)
		;4. Now Abort the flight and your ready to run the flight
		;5. After this is complete DO NOT CLOSE YOUR BROWSER if you do go through these steps again
	;4. SCRIPT Press Ctrl+Shifts+S to start the run
	;!!!! If things go crazy or you want the timer to stop Ctrl+Shift+r stops everything and reloads script!!!!
;############################################################################## BEGIN #############################################################################################################

;Varibles Are the default values loaded if ini is not there or values do not exist
IniRead, xloc, FlightDeckUserSettings.ini, screen, xloc, 0
IniRead, yloc, FlightDeckUserSettings.ini, screen, yloc, 0
IniRead, planeCount, FlightDeckUserSettings.ini, variables, planeCount, 8
IniRead, hours, FlightDeckUserSettings.ini, variables, hours, 1
IniRead, sDelay, FlightDeckUserSettings.ini, variables, sDelay, 300
IniRead, leftPages, FlightDeckUserSettings.ini, plane, leftPages, 1
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
IniRead, lastFriendPage, FlightDeckUserSettings.ini, friends, lastFriendPage, 0
IniRead, lastFriendSpot, FlightDeckUserSettings.ini, friends, lastFriendSpot, 0
IniRead, trainPage, FlightDeckUserSettings.ini, plane, trainPage, 0
IniRead, trainHero, FlightDeckUserSettings.ini, plane, trainHero, 0
IniRead, firstRun, FlightDeckUserSettings.ini, variables, firstRun, 0


SetTitleMatchMode, 2
srDelay:=300
showRulesBox()
showTheInfoBox()



;Ctrl+Shift+l Delete user FlightDeckUserSettings.INI file and reload script with defaults
^+l::
	FileDelete, FlightDeckUserSettings.ini
	Reload
return



;Ctrl+Shift+z Calibrate to your monitor/chrome 
	;Click your mouse on the white dot on the eagle's tale on the flight deck while leaving it on the white dot press Ctrl+Shift+z	
^+z::
	MouseGetPos, xpos, ypos
	xloc:=0
	yloc:=0
	xloc:=998-xpos
	yloc:=670-ypos
	IniWrite, %xloc%, FlightDeckUserSettings.ini, screen, xloc
	IniWrite, %yloc%, FlightDeckUserSettings.ini, screen, yloc
	MsgBox, Mouse Position Calibrated, adjusted by x = %xloc% y = %yloc%
return
	
	

;Preflight check list assuming you just started your browser and went to marvel alliance.
;you will need to do an initial setup flight before running the auto flights
	;1. Select any plane
	;2. Select 10 min flights (session remembers your choice)
	;3. Select a hero that needs leveling and when the warning prompts you check the Don't Show this again check box! (session rembers your choice)
	;4. Now Abort the flight and your ready to run the flight using the alt+s command below
	;5. After this is complete DO NOT CLOSE YOUR BROWSER if you do go through these steps again 
	
;Ctrl+Shift+s ######################################## run flight deck looped
^+s::
	SetFormat, Float, 0.0
	;converts the hours wanted to run into count of 10 min runs
	loops:=(hours*60)/10
	counter:=1
	loop %loops%{
		;it wont trigger unless the correct window is availible and acctive
		WinWait, Marvel: Avengers Alliance on Facebook, 
		IfWinNotActive, Marvel: Avengers Alliance on Facebook, , WinActivate, Marvel: Avengers Alliance on Facebook, 
		WinWaitActive, Marvel: Avengers Alliance on Facebook, 
		
		;Help fight the man and his bot detection
		Random, rand, 1, 30
		srDelay:=sDelay+rand
		
		;plane and hero deploys
		loop %planeCount%{
			planeSelect(A_Index)
			
			if A_Index = 1
			{
				leftHeroSelectPage(leftPages)
			}
			
			rightHeroSelectPage(%A_Index%Right)
			heroSelect(%A_Index%Hero)
			sendHero()
		}
		
		;click off screen to avert any click disasters
		MouseClick, left,  288-xloc,  558-yloc
		
		;display tooltip with run number
		tooltip Running %Counter% of %loops% `nplease wait...

		;The big sleep is 10 min to allow all flights to complete
		Sleep, 600100
		
		tooltip Run %Counter% of %loops% `nDone!

		
		;remove tooltip and finish run
		WinWait, Marvel: Avengers Alliance on Facebook, 
		IfWinNotActive, Marvel: Avengers Alliance on Facebook, , WinActivate, Marvel: Avengers Alliance on Facebook, 
		WinWaitActive, Marvel: Avengers Alliance on Facebook, 
		tooltip
		
		;timeout screen close click (if it's open it closes it)
		;if the timeout screen is not open mouse clicks on dead space, no worries
		MouseClick, left,  1132-xloc,  467-yloc
		Sleep, 1000
		MouseClick, left,  1132-xloc,  467-yloc
		Sleep, 1000

		;Select 1st plane
		MouseClick, left,  908-xloc,  679-yloc
		Sleep, 1000
		;Collect all coins
		MouseClick, left,  908-xloc,  712-yloc
		Sleep, 1000

		;wait for clear coins to clear off the screen
		Sleep, 7000
		
		;increments run count
		counter+=1
	}
	

	counter-=1 ;for accounting use
	MsgBox, 0, %Counter% Runs Done, The runs are complete
return

;Ctrl+Shift+a ######################################## run flight deck single
^+a::
	loop %planeCount%{
		planeSelect(A_Index)
		
		if A_Index = 1
		{
			leftHeroSelectPage(leftPages)
		}
		rightHeroSelectPage(%A_Index%Right)
		heroSelect(%A_Index%Hero)
		sendHero()
	}
return

;ctrl+shift+r ######################################## reload script
^+r::
	Reload
return 


;Ctrl+Shift+v  ######################################## setup vars
^+v::
	Gui, Add, Text,,Plane Count:
	Gui, Add, Text,,Hours To Run:
	Gui, Add, Text,,Click Delay:
	Gui, Add, Text,,Last Friend Page:
	Gui, Add, Text,,Last Firend Spot:
	Gui, Add, Text,,Train Hero Page Right:
	Gui, Add, Text,,Train Hero Spot:
	Gui, Add, Edit,ys vpc Limit1 Number W30, %planeCount%
	Gui, Add, Edit, vh Limit2 Number W30, %hours%
	Gui, Add, Edit, vs Number W50, %sDelay%
	Gui, Add, Edit, vlfp Limit2 Number W30, %lastFriendPage%
	Gui, Add, Edit, vlfs Limit1 Number W30, %lastFriendSpot%
	Gui, Add, Edit, vtp Limit1 Number W30, %trainPage%
	Gui, Add, Edit, vth Limit2 Number W30, %trainHero%
	Gui, Add, Text,ys,
	Gui, Add, Text,ys,
	Gui, Add, Text,ys section,Plane
	Gui, Add, Text,ys,Pages
	Gui, Add, Text,ys,Hero
	loop, 8
	{
		right:=%A_index%Right
		hero:=%A_index%Hero
		Gui, Add, Text,xs section W27, %A_index%:
		Gui, Add, Edit, v%A_index%r ys Limit2 Number W30, %right%
		Gui, Add, Edit, v%A_index%h ys Limit1 Number W30, %hero%
	}
	Gui, Add, Text,xs section,Pages Left:
	Gui, Add, Edit, vleft ys Limit2 Number W30, %leftPages%
	Gui, Add, Button, default x10 y300 section, &OK
	Gui, Add, Button, ys, &CANCEL
	Gui, Add, Button, ys, RESET-&ALL
	Gui, Add, Button, ys, RESET-&DEPLOYS
	Gui, Add, Button, ys, &HELP
	Gui, Show,, User Settings
return

ButtonHELP:
	MsgBox,  Plane Count = number of planes you have (1-8) `n`nHours TO Run = how many whole hours you want the 10 min flights to run `n`nClick Delay =  the delay in milliseconds between clicks `n`nFor Ctrl+Shift+c`nLast Friend Page = how many times you click the left arrow to reach the end of your friend list `nLast Friend Spot = the position of your last friend (4 is the far Left - 1 is the far right)`n`nFor Ctrl+Shift+c`nTrain Page Right = How many pages to click right to find a hero that needs training (this is to clear "Needs training" dialog) `nTrain Hero = Selects the hero that needs training (The far left Hero is 1, the far right is 5) `n`n`nFor Ctrl+Shift+s or Ctlr+Shift+a`nPlanes = bottom right is 1 the top Left is 8 `nPages = the number of pages to click right assuming you start on the far left `nHero = The far left Hero is 1, the far right is 5 `nPages Left = Based on last hero selected and what page its on after complete `n(best if it matches total of how many pages you can click right)
return

GuiClose:
ButtonOK:
	Gui, Submit  
	leftPages:=left
	loop, 8
	{
		%A_index%Right:=%A_index%r
		%A_index%Hero:=%A_index%h
	}
	planeCount:=pc
	hours:=h
	sDelay:=s
	lastFriendPage:=lfp
	lastFriendSpot:=lfs
	trainPage:=tp
	trainHero:=th
	Gui, Destroy
		if planecount>8 
		{
			planeCount:=8
		}
		else if planeCount<1
		{
			planeCount:=1
		}
	saveSettings()
	Gui, Destroy
return

ButtonCANCEL:
	Gui, Destroy
return
ButtonRESET-DEPLOYS:
	leftPages:=1
	loop, 8
	{
		%A_index%Right:=0
		%A_index%Hero:=1
	}
	saveSettings()
	Gui, destroy
return

ButtonRESET-ALL:
	leftPages:=1
	loop, 8
	{
		%A_index%Right:=0
		%A_index%Hero:=1
	}
	planeCount:=8
	hours:=1
	sDelay:=300
	lastFriendPage:=0
	lastFriendSpot:=0
	trainPage:=0
	trainHero:=0
	saveSettings()
	Gui, destroy
return


;Ctrl+Shift+y ######################################## Setup 10 min Runs 1st time to avoid Needs Training Dialog
^+y::

	Random, rand, 1, 30
	srDelay:=sDelay+rand
	
	planeSelect(1)
	;time
	MouseClick, left,  676-xloc,  606-yloc
	Sleep, srDelay+100
	rightHeroSelectPage(trainPage)
	heroSelect(trainHero)
	sendHero()
	;always ignore
	MouseClick, left,  661-xloc,  654-yloc
	Sleep, srDelay+100
	;confirm
	MouseClick, left,  886-xloc,  690-yloc
	Sleep, srDelay+100
	planeSelect(1)
	;abort
	MouseClick, left,  766-xloc,  743-yloc
	Sleep, srDelay+100
return



;Ctrl+Shift+i ######################################## calls the infor box
^+i::
showTheInfoBox()
return



;Alt+s ######################################## abort runs, all planes must be deployed (or there will be chaos)
!s::
	WinWait, Marvel: Avengers Alliance on Facebook, 
	IfWinNotActive, Marvel: Avengers Alliance on Facebook, , WinActivate, Marvel: Avengers Alliance on Facebook, 
	WinWaitActive, Marvel: Avengers Alliance on Facebook,
	MsgBox, 4,, Are you sure you want to abort all deployed planes?
	IfMsgBox Yes
	{
			tooltip
		Random, rand, 1, 80
		srDelay:=sDelay+rand
		
		loop, %planeCount%
		{
			planeSelect(A_Index)
			MouseClick, left,  766-xloc,  743-yloc
			Sleep, srDelay
		}
	}
		

return

;Ctrl+Shift+g  ######################################## sends bottom 3rd gift currently iso
^+g::

	WinWait, Marvel: Avengers Alliance on Facebook, 
	IfWinNotActive, Marvel: Avengers Alliance on Facebook, , WinActivate, Marvel: Avengers Alliance on Facebook, 
	WinWaitActive, Marvel: Avengers Alliance on Facebook, 
	loop, 10
	{
		;Gift btn
		MouseClick, left,  600-xloc,  315-yloc
		Sleep, 1500
		;iso selection
		MouseClick, left,  892-xloc,  814-yloc
		Sleep, 800
		;All marvel friends
		MouseClick, left,  936-xloc,  358-yloc
		Sleep, 800
		;Slect all
		MouseClick, left,  769-xloc,  404-yloc
		Sleep, 800
		;Send
		MouseClick, left,  1017-xloc,  777-yloc
		Sleep, 1500
	}
return

;Ctrl+Shift+c  ######################################## Friend farm Grid Clicker
^+c::
	WinWait, Marvel: Avengers Alliance on Facebook, 
	IfWinNotActive, Marvel: Avengers Alliance on Facebook, , WinActivate, Marvel: Avengers Alliance on Facebook, 
	WinWaitActive, Marvel: Avengers Alliance on Facebook, 
	lastFriendPage+=1
	loop, %lastFriendPage%
	{
		if(lastFriendPage=A_Index)
			{
			loop, %lastFriendSpot%
			{
				friendBarSelect(A_index)
				friendScreenGridClick()
			}
		} 
		else
		{
			loop, 4
			{
				friendBarSelect(A_index)
				friendScreenGridClick()
			}
		}
		
		friendBarLeft()
	}
	lastFriendPage-=1	
	MsgBox, Friends Farmed!
return




;#################################################################### METHODS ####################################################################
showTheInfoBox()
{
	global planeCount,hours, xloc, yloc, sDelay, leftPages, 1Right, 1Hero, 2Right, 2Hero, 3Right, 3Hero, 4Right, 4Hero, plane, 5Right, plane, 5Hero, plane, 6Right, plane, 6Hero, plane, 7Right, plane, 7Hero, plane, 8Right, plane, 8Hero, lastFriendPage, lastFriendSpot, trainPage, trainHero
	MsgBox, 64, SK's Auto Deck for MAA, WELCOME: `n`n`Go To MAA in Browser`n1. Ctrl+Shift+z   Calibrates the screen to the dot on the eagles tail `n2. Ctrl+Shift+v   To change settings (must be done at least once) `n3. Ctrl+Shift+y   Pre-Flight Deploy Setup (clears "Needs Training" dialog) `n4. Ctrl+Shift+s   Starts the 10 min runs `n`nOther Commands: `nCtrl+Shift+r   STOPS everything and resets the whole script. `nCtrl+Shift+i   To open this info box `nCtrl+Shift+l   Deletes user's .ini file and reloads script with defaults `nAlt+s   Abort all flights  `n`nCtrl+Shift+a   Single Run (no repeat or auto-clear) `nCtrl+Shift+c   Farms Friends (check settings first) `n`n`nBTW you fraking owe me! 
}
;`n`nCURRENT SETTINGS: `nPlanes = %planeCount% `nHours to run = %hours% `nScreen Calibration adjustments x=%xloc%, y=%yloc% `nStandard Click Delay = %sDelay% `nLast Friend Page = %lastFriendPage% `nLast Friend Position = %lastFriendSpot% `nTrain Hero Page Right = %trainPage% `nTrain Hero Position = %trainHero% `n`nFLIGHT DECK SETTINGS: `nHero Selection (plane,page right,hero select) = `n(1,%1Right%,%1Hero%)(2,%2Right%,%2Hero%)(3,%3Right%,%3Hero%)(4,%4Right%,%4Hero%)(5,%5Right%,%5Hero%)(6,%6Right%,%6Hero%)(7,%7Right%,%7Hero%)(8,%8Right%,%8Hero%) `nPages to Click Left after deploy complete = %leftPages% `n`n`nBTW you fraking owe me!

showRulesBox()
{
global firstRun
if firstRun<3
{
	MsgBox, 16,IMPORTANT RULES DAMMIT, `nREAD THESE RULES!`nUse Chrome Browser `nComputer must NOT: sleep, auto turn monotor off, or turn harddrive off, `nDO NOT CLOSE BROWSER BETWEEN FLIGHTS! There are session settings that will be lost and script will run but not work. `nLeave Browser running and on the Avengers Alliance Flight Deck.`nI do not recomend using computer while flights are in progress, `n   you can try but beware after the set time it will start clicking if you like it or not `nOnce things are running you can try turrning your monitor off using the power button `nI am not responsible for what happens `nCheck back often, MAA is flash based, the script has no ability to assure propper screens or if the game has timed out or not `nScrew spelling errors, I dont care `nDo not open MAA in another browser or computer it will hault any other running session `nFor you saftey please do not share this script! (that means i will kill you) 
	firstRun+=1
	IniWrite, %firstRun%, FlightDeckUserSettings.ini, variables, firstRun
}

}

;standard send button click
sendHero()
{
	global xloc, yloc, srDelay
	MouseClick, left,  828-xloc,  824-yloc
	Sleep, srDelay
}



;how many pages you want to click right on the hero select screen
rightHeroSelectPage(pages)
{
	global xloc, yloc, srDelay
	loop %pages%
	{
		MouseClick, left,  1143-xloc,  546-yloc
		Sleep, srDelay+100
	}
}



;how many pages you want to click left on the hero select screen
leftHeroSelectPage(pages)
{
	global xloc, yloc, srDelay
	loop, %pages%
	{
		MouseClick, left,  516-xloc,  546-yloc
		Sleep, srDelay+100
	}
}



;Choose a hero from menu (left 1 to right 5)
heroSelect(heroNumber)
{
	global xloc, yloc, srDelay
	if (heroNumber=1)
	{
		MouseClick, left,  593-xloc,  593-yloc
		Sleep, srDelay
	}
	else if (heroNumber=2)
	{
		MouseClick, left,  712-xloc,  594-yloc
		Sleep, srDelay
	}
	else if (heroNumber=3)
	{
		MouseClick, left,  831-xloc,  595-yloc
		Sleep, srDelay
	}
	else if (heroNumber=4)
	{
		MouseClick, left,  952-xloc,  595-yloc
		Sleep, srDelay
	}
	else if (heroNumber=5)
	{
		MouseClick, left,  1068-xloc,  593-yloc
		Sleep, srDelay
	}
}

;Plane click locations for planes 1-8
planeSelect(planeNumber)
{
	global xloc, yloc, srDelay
	if (planeNumber=1)
	{
		loop, 2{
			Random, rand, 1, 3
			MouseClick, left,  902-xloc+rand,  726-yloc+rand
			Sleep, srDelay
		}
	}
	else if (planeNumber=2)
	{
		loop, 2{
		Random, rand, 1, 3
			MouseClick, left,  873-xloc+rand,  702-yloc+rand
			Sleep, srDelay
		}		
	}
	else if (planeNumber=3)
	{
		loop, 2{
		Random, rand, 1, 3
			MouseClick, left,  836-xloc+rand,  680-yloc+rand
			Sleep, srDelay
		}
	}
	else if (planeNumber=4)
	{
		loop, 2{
		Random, rand, 1, 3
			MouseClick, left,  801-xloc+rand,  658-yloc+rand
			Sleep, srDelay
		}
	}
	else if (planeNumber=5)
	{
		loop, 2{
		Random, rand, 1, 3
			MouseClick, left,  766-xloc+rand,  642-yloc+rand
			Sleep, srDelay
		}
	}
	else if (planeNumber=6)
	{
		loop, 2{
		Random, rand, 1, 3
			MouseClick, left,  730-xloc+rand,  615-yloc+rand
			Sleep, srDelay
		}
	}
	else if (planeNumber=7)
	{
		loop, 2{
		Random, rand, 1, 3
			MouseClick, left,  692-xloc+rand,  596-yloc+rand
			Sleep, srDelay
		}
	}
	else if (planeNumber=8)
	{
		loop, 2{
		Random, rand, 1, 3
			MouseClick, left,  662-xloc+rand,  579-yloc+rand
			Sleep, srDelay
		}
	}
}

;######################################### SAVE STUFF
saveSettings(){
	global planeCount, hours, sDelay, lastFriendPage, lastFriendSpot, leftPages, 1Right, 1Hero, 2Right, 2Hero, 3Right, 3Hero, 4Right, 4Hero, plane, 5Right, plane, 5Hero, plane, 6Right, plane, 6Hero, plane, 7Right, plane, 7Hero, plane, 8Right, plane, 8Hero, trainHero, trainPage
	
	IniWrite, %planeCount%, FlightDeckUserSettings.ini, variables, planeCount
	IniWrite, %hours%, FlightDeckUserSettings.ini, variables, hours
	IniWrite, %sDelay%, FlightDeckUserSettings.ini, variables, sDelay
	IniWrite, %lastFriendPage%, FlightDeckUserSettings.ini, friends, lastFriendPage
	IniWrite, %lastFriendSpot%, FlightDeckUserSettings.ini, friends, lastFriendSpot
	IniWrite, %trainHero%, FlightDeckUserSettings.ini, plane, trainHero
	IniWrite, %trainPage%, FlightDeckUserSettings.ini, plane, trainPage
	
	IniWrite, %leftPages%, FlightDeckUserSettings.ini, plane, leftPages
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
global xloc, yloc
	
	ypoint:=345-yloc
	while ypoint<=(840-yloc){
		xpoint:=455-xloc
		while xpoint<=(1205-xloc){
		MouseClick, left,  xpoint, ypoint
		xpoint+=50
		}
		ypoint+=30
	}
	Sleep, 2000
}

friendBarSelect(friendNumber)
{
	global xloc, yloc, sDelay
	if(friendNumber=1)
	{
	MouseClick, left,  814-xloc,  930-yloc
	Sleep, sDelay
	MouseClick, left,  812-xloc,  799-yloc
	Sleep, 1000
	}
	else if (friendNumber=2)
	{
	MouseClick, left,  745-xloc,  936-yloc
	Sleep, sDelay
	MouseClick, left,  760-xloc,  803-yloc
	Sleep, 1000
	}
	else if (friendNumber=3)
	{
	MouseClick, left,  680-xloc,  932-yloc
	Sleep, sDelay
	MouseClick, left,  688-xloc,  801-yloc
	Sleep, 1000
	}
	else if (friendNumber=4)
	{
	MouseClick, left,  617-xloc,  938-yloc
	Sleep, sDelay
	MouseClick, left,  613-xloc,  807-yloc
	Sleep, 1000
	}
}

friendBarLeft(){
	global xloc, yloc
	MouseClick, left,  476-xloc,  941-yloc
	Sleep, 1000
}

;############################################################################## END OF LINE ##########################################################################################################
