DGS = exports.dgs


local pedTable = { }
local characterSelected, characterElementSelected, newCharacterButton, bLogout = nil
local startCam2 = startCam
local Eeffects = true

local screenW, screenH = guiGetScreenSize()
local hkChInterfaceShowing = false

selectionScreenID = 0
function Characters_showSelection()
	characters_destroyDetailScreen()
	triggerEvent("onSapphireXMBShow", getLocalPlayer())
	showPlayerHudComponent("radar", false)

	guiSetInputEnabled(false)

	showCursor(true)

	setElementDimension ( getLocalPlayer(), 1 )
	setElementInterior( getLocalPlayer(), 0 )

	for _, thePed in ipairs(pedTable) do
		if isElement(thePed) then
			destroyElement(thePed)
		end
	end

	selectionScreenID = getSelectionScreenID()

	startCam[selectionScreenID] = originalStartCam[selectionScreenID]

    changeNextCharacter(1)

		fadeCamera ( false, 0, 0,0,0 )
		startCam2 = startCam
		local x,y,z,lx,ly,lz = 1263.49609375,-2494.064453125,33.703601837158,1189.240234375,-2561.025390625,35.274036407471
		setCameraMatrix (x,y,z,lx,ly,lz)
		-- setCameraMatrix (originalStartCam[selectionScreenID][1], originalStartCam[selectionScreenID][2], originalStartCam[selectionScreenID][3], originalStartCam[selectionScreenID][4], originalStartCam[selectionScreenID][5], originalStartCam[selectionScreenID][6])
		setTimer(function ()
			fadeCamera ( true, 1, 0,0,0 )
		end, 1000, 1)

		setTimer(function ()
			showCursor(true)
			-- addEventHandler("onClientRender", getRootElement(), Characters_updateSelectionCamera)
			local x1,y1,z1,x1t,y1t,z1t = 1263.49609375,-2494.064453125,33.703601837158,1189.240234375,-2561.025390625,35.274036407471
			local x2,y2,z2,x2t,y2t,z2t = 1374.478515625,-2235.8212890625,24.289236068726,1439.0712890625,-2311.916015625,30.39294052124
			
			smoothMoveCamera(x1,y1,z1,x1t,y1t,z1t,x2,y2,z2,x2t,y2t,z2t,4000)

			-- addEventHandler("onClientRender", getRootElement(), renderNametags)
			-- 
			local bgMusic = getElementData(localPlayer, "bgMusic")
			if not bgMusic or not isElement(bgMusic) then
				local bgMusic = playSound ("http://grizzly-gaming.net/less/neon.mp3", true)
				setSoundVolume(bgMusic, 1)
				setElementData(localPlayer, "bgMusic", bgMusic)				
			end
			--[[
			local selectionSound = playSound ( "selection_screen.mp3")
			setSoundVolume(selectionSound, 0.3)
			setElementData(localPlayer, "selectionSound", selectionSound)
			--]]
		end, 2000, 1)



end

addCommandHandler ( "GetCameraPos", function (    ) 
       local x, y, z, xl, yl, zl = getCameraMatrix (    ) 
       if ( x == 0 or y == 0 or z == 0 ) then return end 
       setClipboard ( " "..x..", "..y..", "..z..", "..xl..", "..yl..", "..zl.." " ) 
end ) 

local sm = {}
sm.moov = 0
sm.object1,sm.object2 = nil,nil
 
local function removeCamHandler()
	if(sm.moov == 1)then
		sm.moov = 0
	end
end
 
local function camRender()
	if (sm.moov == 1) then
		local x1,y1,z1 = getElementPosition(sm.object1)
		local x2,y2,z2 = getElementPosition(sm.object2)
		setCameraMatrix(x1,y1,z1,x2,y2,z2)
	end
end
addEventHandler("onClientPreRender",root,camRender)
 
function smoothMoveCamera(x1,y1,z1,x1t,y1t,z1t,x2,y2,z2,x2t,y2t,z2t,time)
	if(sm.moov == 1)then return false end
	sm.object1 = createObject(1337,x1,y1,z1)
	sm.object2 = createObject(1337,x1t,y1t,z1t)
	setElementAlpha(sm.object1,0)
	setElementAlpha(sm.object2,0)
	setObjectScale(sm.object1,0.01)
	setObjectScale(sm.object2,0.01)
	moveObject(sm.object1,time,x2,y2,z2,0,0,0,"OutQuad")
	moveObject(sm.object2,time,x2t,y2t,z2t,0,0,0,"OutQuad")
	sm.moov = 1
	setTimer(removeCamHandler,time,1)
	setTimer(destroyElement,time,1,sm.object1)
	setTimer(destroyElement,time,1,sm.object2)
	setTimer(stopMovingCam,time,1)
	return true
end


function getCamSpeed( index1, startCam1, endCam1, globalspeed1)
	return (math.abs(startCam1[index1]-endCam1[index1])/globalspeed1)
end
--Check c_login.lua for settings block
function Characters_updateSelectionCamera ()
	local x,y,z = getElementPosition(characterElementSelected)
	local endCam2 = {[0] = {x+2,y+2,z,x,y,z}}
	for var = 1, 6, 1 do
		if not doneCam[selectionScreenID][var] then
			--outputDebugString("if not doneCam[selectionScreenID][var] then")
			if (math.abs(startCam2[selectionScreenID][var] - endCam2[selectionScreenID][var]) > 0.2) then
				if startCam2[selectionScreenID][var] > endCam2[selectionScreenID][var] then
					startCam2[selectionScreenID][var] = startCam2[selectionScreenID][var] - getCamSpeed( var, startCam2[selectionScreenID], endCam2[selectionScreenID], globalspeed)
				else
					startCam2[selectionScreenID][var] = startCam2[selectionScreenID][var] + getCamSpeed( var, startCam2[selectionScreenID], endCam2[selectionScreenID], globalspeed)
				end
			else
				doneCam[selectionScreenID][var] = true
			end
		end
	end
	-- setCameraMatrix (startCam[selectionScreenID][1], startCam[selectionScreenID][2], startCam[selectionScreenID][3], startCam[selectionScreenID][4], startCam[selectionScreenID][5], startCam[selectionScreenID][6])
	-- local x,y,z,lx,ly,lz = 2164.552734375, 1915.5435791016, 78.078399658203, 2163.5952148438, 1915.5278320313, 77.790176391602
	setCameraMatrix (startCam2[selectionScreenID][1], startCam2[selectionScreenID][2], startCam2[selectionScreenID][3], x,y,z)
	if doneCam[selectionScreenID][1] and doneCam[selectionScreenID][2] and doneCam[selectionScreenID][3] and doneCam[selectionScreenID][4] and doneCam[selectionScreenID][5] and doneCam[selectionScreenID][6] then
		stopMovingCam()
	end
end

local screenW, screenH = guiGetScreenSize()
local font = "arial"
local font1 = "default-bold"

function isMouseInPosition ( x, y, width, height )
	if ( not isCursorShowing( ) ) then
		return false
	end
    local sx, sy = guiGetScreenSize ( )
    local cx, cy = getCursorPosition ( )
    local cx, cy = ( cx * sx ), ( cy * sy )
    if ( cx >= x and cx <= x + width ) and ( cy >= y and cy <= y + height ) then
        return true
    else
        return false
    end
end

function table.size(tab)
    local length = 0
    for _ in pairs(tab) do length = length + 1 end
    return length
end

local charCount = 0


function changeNextCharacter(type)
	local characterList = getElementData(getLocalPlayer(), "account:characters")
	if type == 1 then
		if charCount < table.size(characterList) then
			charCount = charCount + 1
		else
			return
		end
	elseif type == 2 then
		if charCount > 1 then
			charCount = charCount - 1
		else
			return
		end
	else
		return
	end
	if isElement(characterElementSelected) then destroyElement(characterElementSelected) end
	selectionScreenID = getSelectionScreenID()
		local x, y, z, rot =  1381.9677734375, -2241.3017578125, 24.380388259888, 40
	if (characterList) then
		-- Prepare the peds
		-- charCount = charCount + 1
		local v = characterList[charCount]
			local thePed = createPed( tonumber( v[9]), x, y, z)
			setPedRotation(thePed, rot)
			setElementDimension(thePed, 1)
			setElementInterior(thePed, 0)
			setElementData(thePed,"account:charselect:id", v[1], false)
			setElementData(thePed,"account:charselect:name", v[2]:gsub("_", " "), false)
			setElementData(thePed,"account:charselect:cked", v[3], false)
			setElementData(thePed,"account:charselect:lastarea", v[4], false)
			setElementData(thePed,"account:charselect:age", v[5], false)
			setElementData(thePed,"account:charselect:gender", v[6], false)
			setElementData(thePed,"account:charselect:faction", v[7] or "", false)
			setElementData(thePed,"account:charselect:factionrank", v[8] or "", false)	
			setElementData(thePed,"account:charselect:race", v[9], false)
			setElementData(thePed,"account:charselect:lastlogin", v[10], false)
			setElementData(thePed,"account:charselect:weight", v[11], false)
			setElementData(thePed,"account:charselect:height", v[12], false)
			setElementData(thePed,"account:charselect:month", v[13], false)
			setElementData(thePed,"account:charselect:day", v[14], false)
			setElementData(thePed,"clothing:id", v[15] or "", false)
			setElementData(thePed,"account:charselect:hoursplayed", v[20], false)
			setElementData(thePed,"account:charselect:money", v[16], false)
			setElementData(thePed,"account:charselect:bankmoney", v[17], false)
			setElementData(thePed,"account:charselect:creationdate", v[19], false)
			local randomAnimation = getRandomAnim( v[3] == 1 and 4 or 2 )
			setPedAnimation ( thePed , randomAnimation[1], randomAnimation[2], -1, true, false, false, false )
			characterElementSelected = thePed
			characterSelected = getElementData(characterElementSelected,"account:charselect:id")
		end
end



function refreshAltsButton2()
    hkChInterfaceShowing = false
	    hk2SetButtonVisible( diseff, false )
	hk2SetButtonVisible( createchar, false )
	hk2SetButtonVisible( logout, false )	
	hk2SetButtonVisible( refresh, false )	
	hk2SetButtonVisible( play, false )
	removeEventHandler("onClientClick", root,selectCharacter_Click)
	Characters_showSelection( )
end

local hkCh_Cked_Text = "على قيد الحياة"

function changeCharacterDx()
	if (hkChInterfaceShowing) then
WindowRect = DGS:dgsCreateRoundRect({{20,false},{20,false},{20,false},{20,false}},tocolor(9, 9, 11,210))
local sX = guiGetScreenSize() 
romcisFont = DGS:dgsCreateFont( "fonts/Samim-Bold.ttf", 10*(sX/1920))
romcisFont1 = DGS:dgsCreateFont( "fonts/Samim-Bold.ttf", 17*(sX/1920))
romcisFont2 = DGS:dgsCreateFont( "fonts/Samim-Bold.ttf", 12*(sX/1920)) 
EditRect = DGS:dgsCreateRoundRect({{10,false},{10,false},{10,false},{10,false}},tocolor(0,0,0,180))
ButtonRect = DGS:dgsCreateRoundRect({{20,false},{20,false},{20,false},{20,false}},tocolor(0,0,0,180))
ButtonRect2 = DGS:dgsCreateRoundRect({{10,false},{10,false},{10,false},{10,false}},tocolor(0,0,0,180))
window = DGS:dgsCreateImage(0.79, 0.08, 0.20, 0.85, WindowRect,true,false)
--DGS:dgsSetVisible(window, false)
edit1 = DGS:dgsCreateEdit(0.23, 0.03, 0.55, 0.04, "N/A.", true, window, tocolor(157, 0, 255, 255), nil, nil, nil, nil, false)
DGS:dgsEditSetReadOnly(edit1, true)
DGS:dgsSetProperty(edit1,"selectColor",tocolor(0, 0, 0, 0))
button1 = DGS:dgsCreateButton(0.06, 0.03, 0.12, 0.04, "<", true, window)
button2 = DGS:dgsCreateButton(0.83, 0.03, 0.12, 0.04, ">", true, window)
edit2 = DGS:dgsCreateEdit(0.06, 0.15, 0.41, 0.03, "Character description:", true, window, tocolor(157, 0, 255, 255), nil, nil, nil, nil, false)
DGS:dgsEditSetReadOnly(edit2, true)
DGS:dgsSetProperty(edit2,"selectColor",tocolor(0, 0, 0, 0))
label1 = DGS:dgsCreateLabel(0.06, 0.21, 0.76, 0.11, "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.", true, window)
DGS:dgsLabelSetHorizontalAlign(label1, "center", true)
DGS:dgsSetProperty(label1,"wordBreak",true)

edit3 = DGS:dgsCreateEdit(0.06, 0.33, 0.41, 0.03, "Money:", true, window, tocolor(157, 0, 255, 255), nil, nil, nil, nil, false)
DGS:dgsEditSetReadOnly(edit3, true)
DGS:dgsSetProperty(edit3,"selectColor",tocolor(0, 0, 0, 0))
label2 = DGS:dgsCreateLabel(0.06, 0.38, 0.41, 0.03, "N/A.", true, window)
edit4 = DGS:dgsCreateEdit(0.53, 0.33, 0.41, 0.03, "Hours:", true, window, tocolor(157, 0, 255, 255), nil, nil, nil, nil, false)
DGS:dgsEditSetReadOnly(edit4, true)
DGS:dgsSetProperty(edit4,"selectColor",tocolor(0, 0, 0, 0)) 
label3 = DGS:dgsCreateLabel(0.54, 0.38, 0.41, 0.03, "N/A.", true, window)
edit5 = DGS:dgsCreateEdit(0.06, 0.44, 0.41, 0.03, "Gender:", true, window, tocolor(157, 0, 255, 255), nil, nil, nil, nil, false)
DGS:dgsEditSetReadOnly(edit5, true)
DGS:dgsSetProperty(edit5,"selectColor",tocolor(0, 0, 0, 0))
edit6 = DGS:dgsCreateEdit(0.53, 0.44, 0.41, 0.03, "Age:", true, window, tocolor(157, 0, 255, 255), nil, nil, nil, nil, false)
DGS:dgsEditSetReadOnly(edit6, true)
DGS:dgsSetProperty(edit6,"selectColor",tocolor(0, 0, 0, 0))
label4 = DGS:dgsCreateLabel(0.06, 0.50, 0.19, 0.03, "N/A.", true, window)
label5 = DGS:dgsCreateLabel(0.54, 0.50, 0.19, 0.03, "N/A.", true, window)
edit7 = DGS:dgsCreateEdit(0.06, 0.55, 0.41, 0.03, "Bank Money:", true, window, tocolor(157, 0, 255, 255), nil, nil, nil, nil, false)
DGS:dgsEditSetReadOnly(edit7, true)
DGS:dgsSetProperty(edit7,"selectColor",tocolor(0, 0, 0, 0))
edit8 = DGS:dgsCreateEdit(0.54, 0.55, 0.41, 0.03, "Weight:", true, window, tocolor(157, 0, 255, 255), nil, nil, nil, nil, false)
DGS:dgsEditSetReadOnly(edit8, true)
DGS:dgsSetProperty(edit8,"selectColor",tocolor(0, 0, 0, 0))
label6 = DGS:dgsCreateLabel(0.06, 0.61, 0.24, 0.03, "N/A", true, window)
label7 = DGS:dgsCreateLabel(0.54, 0.61, 0.24, 0.03, "N/A.", true, window)
edit9 = DGS:dgsCreateEdit(0.06, 0.66, 0.17, 0.03, "Faction:", true, window, tocolor(157, 0, 255, 255), nil, nil, nil, nil, false)
DGS:dgsEditSetReadOnly(edit9, true)
DGS:dgsSetProperty(edit9,"selectColor",tocolor(0, 0, 0, 0))
label8 = DGS:dgsCreateLabel(0.06, 0.71, 0.75, 0.03, "N/A.", true, window)
edit10 = DGS:dgsCreateEdit(0.06, 0.76, 0.26, 0.03, "Creation Date:", true, window, tocolor(157, 0, 255, 255), nil, nil, nil, nil, false)
DGS:dgsSetProperty(edit10,"selectColor",tocolor(0, 0, 0, 0))
DGS:dgsEditSetReadOnly(edit10, true)
label9 = DGS:dgsCreateLabel(0.06, 0.81, 0.71, 0.03, "N/A.", true, window)
button3 = DGS:dgsCreateButton(0.06, 0.93, 0.87, 0.05, "Create a new character!", true, window)
button4 = DGS:dgsCreateButton(0.06, 0.86, 0.87, 0.05, "Play now!", true, window)    

DGS:dgsSetProperty(button1,"image",{ButtonRect2,ButtonRect2,ButtonRect2})
DGS:dgsSetProperty(button2,"image",{ButtonRect2,ButtonRect2,ButtonRect2})
DGS:dgsSetProperty(button3,"image",{ButtonRect,ButtonRect,ButtonRect})
DGS:dgsSetProperty(button4,"image",{ButtonRect,ButtonRect,ButtonRect})
DGS:dgsSetProperty(button1 ,"color",{tocolor(0, 0, 0, 255), tocolor(157, 0, 255, 255), tocolor(0, 0, 0, 255)})
DGS:dgsSetProperty(button2 ,"color",{tocolor(0, 0, 0, 255), tocolor(157, 0, 255, 255), tocolor(0, 0, 0, 255)})
DGS:dgsSetProperty(button3 ,"color",{tocolor(0, 0, 0, 255), tocolor(157, 0, 255, 255), tocolor(0, 0, 0, 255)})
DGS:dgsSetProperty(button4 ,"color",{tocolor(0, 0, 0, 255), tocolor(157, 0, 255, 255), tocolor(0, 0, 0, 255)})
DGS:dgsRoundRectSetColorOverwritten(ButtonRect,false)
DGS:dgsRoundRectSetColorOverwritten(ButtonRect2,false)


DGS:dgsSetFont(label1, romcisFont)  
DGS:dgsSetFont(label2, romcisFont) 
DGS:dgsSetFont(label3, romcisFont) 
DGS:dgsSetFont(label4, romcisFont) 
DGS:dgsSetFont(label5, romcisFont) 
DGS:dgsSetFont(label6, romcisFont) 
DGS:dgsSetFont(label7, romcisFont) 
DGS:dgsSetFont(label8, romcisFont) 
DGS:dgsSetFont(label9, romcisFont) 
DGS:dgsSetFont(edit1, romcisFont) 
DGS:dgsSetFont(edit2, romcisFont) 
DGS:dgsSetFont(edit3, romcisFont) 
DGS:dgsSetFont(edit4, romcisFont) 
DGS:dgsSetFont(edit5, romcisFont) 
DGS:dgsSetFont(edit5, romcisFont) 
DGS:dgsSetFont(edit6, romcisFont) 
DGS:dgsSetFont(edit7, romcisFont) 
DGS:dgsSetFont(edit8, romcisFont) 
DGS:dgsSetFont(edit9, romcisFont) 
DGS:dgsSetFont(edit10, romcisFont) 
DGS:dgsSetFont(button1, romcisFont) 
DGS:dgsSetFont(button2, romcisFont) 
DGS:dgsSetFont(button3, romcisFont) 
DGS:dgsSetFont(button4, romcisFont) 
DGS:dgsSetProperty(edit1,"bgImage",EditRect)
DGS:dgsSetProperty(edit2,"bgImage",EditRect)
DGS:dgsSetProperty(edit3,"bgImage",EditRect)
DGS:dgsSetProperty(edit4,"bgImage",EditRect)
DGS:dgsSetProperty(edit5,"bgImage",EditRect)
DGS:dgsSetProperty(edit5,"bgImage",EditRect)
DGS:dgsSetProperty(edit6,"bgImage",EditRect)
DGS:dgsSetProperty(edit7,"bgImage",EditRect)
DGS:dgsSetProperty(edit8,"bgImage",EditRect)
DGS:dgsSetProperty(edit9,"bgImage",EditRect)
DGS:dgsSetProperty(edit10,"bgImage",EditRect)
DGS:dgsEditSetAlignment(edit1, "center" , "center" )
DGS:dgsEditSetAlignment(edit2, "center" , "center" )
DGS:dgsEditSetAlignment(edit3, "center" , "center" )
DGS:dgsEditSetAlignment(edit4, "center" , "center" )
DGS:dgsEditSetAlignment(edit5, "center" , "center" )
DGS:dgsEditSetAlignment(edit6, "center" , "center" )
DGS:dgsEditSetAlignment(edit7, "center" , "center" )
DGS:dgsEditSetAlignment(edit8, "center" , "center" )
DGS:dgsEditSetAlignment(edit9, "center" , "center" )
DGS:dgsEditSetAlignment(edit10, "center" , "center" )

		local hkUsername = getElementData(localPlayer, "account:username") or "N/A"
		local hkEmail = getElementData(localPlayer, "email") or "N/A"
		local hkCreatedDate = getElementData(localPlayer, "account:registerdate") or "N/A"
		local hkSerial = getElementData(localPlayer, "serial") or "N/A"
	romcis_update()
	end		
end

local effect = nil
function selectCharacter_Click(mouseButton, buttonState, alsoluteX, alsoluteY, worldX, worldY, worldZ, theElement)
if ( source  ==  button3 ) then 
Characters_newCharacter()
DGS:dgsSetVisible(window, false)
outputDebugString ( "button3." )
elseif ( source  ==  button4 ) then 
if (characterElementSelected==nil) then exports["Hk_KSA-Notifications"]:show_box("ليس لديك اي شخصية", "error") return end
 if (getElementData(characterElementSelected, "account:charselect:cked")  == 1) then exports["Hk_KSA-Notifications"]:show_box("You Can't Play With a dead character", "error") return end
Characters_selectCharacter()
DGS:dgsSetVisible(window, false)
outputDebugString ( "button4." )
elseif ( source  ==  button1 ) then 
changeNextCharacter(2)
romcis_update()
if Eeffects == true then
if isElement(effect) then
destroyElement(effect) 
end
effect = createEffect("shootlight", Vector3( getElementPosition( characterElementSelected ) ), 0, 0, 0)
end
elseif ( source  ==  button2 ) then 
changeNextCharacter(1)
romcis_update()
if Eeffects == true then
if isElement(effect) then 
destroyElement(effect) 
end
effect = createEffect("shootlight", Vector3( getElementPosition( characterElementSelected ) ), 0, 0, 0)
end
end
end


function romcis_update()
		if (characterElementSelected~=nil) then
			hkCh_Name = getElementData(characterElementSelected, "account:charselect:name") or "N/A"
			hkCh_Weight = getElementData(characterElementSelected, "account:charselect:weight") or "N/A"
			hkCh_Height = getElementData(characterElementSelected, "account:charselect:height") or "N/A"
			hkCh_Age = getElementData(characterElementSelected, "account:charselect:age") or "N/A"
			hkCh_Money = getElementData(characterElementSelected, "account:charselect:money") or "N/A"
			hkCh_BankMoney = getElementData(characterElementSelected, "account:charselect:bankmoney") or "N/A"
			hkCh_HoursPalyed = getElementData(characterElementSelected, "account:charselect:hoursplayed") or "N/A"
			hkCh_CreationDate = getElementData(characterElementSelected, "account:charselect:creationdate") or "N/A"
			hkCh_Cked = getElementData(characterElementSelected, "account:charselect:cked") or "N/A"
			characterGender = getElementData(characterElementSelected, "account:charselect:gender") or "N/A"
			hkCh_Faction = getElementData(characterElementSelected, "account:charselect:faction") or "N/A"
		else
			hkCh_Name = "N/A"
			hkCh_Weight = "N/A"
			hkCh_Height = "N/A"
			hkCh_Age = "N/A"
			hkCh_Money = "N/A"
			hkCh_BankMoney = "N/A"
			hkCh_HoursPalyed = "N/A"
			hkCh_CreationDate = "N/A"
			hkCh_Cked = "N/A"	
			characterGender = "N/A"	
			hkCh_Faction = "N/A"	
			hkCh_CreationDate = "N/A"
		end
		if (characterGender == 0) then
			hkCh_Gender_Text = "Male"
		else
			hkCh_Gender_Text = "Female"
		end	
	DGS:dgsSetText (edit1, hkCh_Name)
	DGS:dgsSetText (label2 , hkCh_Money)
	DGS:dgsSetText (label3 , hkCh_HoursPalyed)
	DGS:dgsSetText (label5 , hkCh_Age)
	DGS:dgsSetText (label7 , hkCh_Weight)
	DGS:dgsSetText (label4 , hkCh_Gender_Text)
	DGS:dgsSetText (label8 , hkCh_Faction)
	DGS:dgsSetText (label9 , hkCh_CreationDate)
	DGS:dgsSetText (label6 , hkCh_BankMoney)

end

function stopMovingCam()
	--playSound ( "WindowsMillenniumEdition.mp3")
	-- removeEventHandler("onClientRender",getRootElement(),Characters_updateSelectionCamera)
	addEventHandler("onDgsMouseClickUp", root, selectCharacter_Click)
	hkChInterfaceShowing = true
changeCharacterDx()
end

function renderNametags()
	for key, player in ipairs(getElementsByType("ped")) do
		if (isElement(player))then
			if (getElementData(player,"account:charselect:id")) then
				local lx, ly, lz = getElementPosition( getLocalPlayer() )
				local rx, ry, rz = getElementPosition(player)
				local distance = getDistanceBetweenPoints3D(lx, ly, lz, rx, ry, rz)
				if  (isElementOnScreen(player)) then
					local lx, ly, lz = getCameraMatrix()
					local collision, cx, cy, cz, element = processLineOfSight(lx, ly, lz, rx, ry, rz+1, true, true, true, true, false, false, true, false, nil)
					if not (collision) then
						local x, y, z = getElementPosition(player)
						local sx, sy = getScreenFromWorldPosition(x, y, z+0.45, 100, false)
						if (sx) and (sy) then
							if (distance<=2) then
								sy = math.ceil( sy - ( 2 - distance ) * 40 )
							end
							sy = sy - 20
							if (sx) and (sy) then
								distance = 1.5
								local offset = 75 / distance
								dxDrawText(getElementData(player,"account:charselect:name"), sx-offset+2, sy+2, (sx-offset)+130 / distance, sy+20 / distance, tocolor(0, 0, 0, 220), 0.6 / distance, "bankgothic", "center", "center", false, false, false)
								dxDrawText(getElementData(player,"account:charselect:name"), sx-offset, sy, (sx-offset)+130 / distance, sy+20 / distance, tocolor(255, 255, 255, 220), 0.6 / distance, "bankgothic", "center", "center", false, false, false)
							end
						end
					end
				end
			end
		end
	end
end




function Characters_deactivateGUI()
	--removeEventHandler("onClientClick", root,selectCharacter_Click)
	if Eeffects == true then
	    if isElement(effect) then destroyElement(effect) end
	end
	-- removeEventHandler("onClientRender", root, changeCharacterDx)	
	hkChInterfaceShowing = false
end

function Characters_selectCharacter()
	if (characterSelected ~= nil) then
		Characters_deactivateGUI()
		local randomAnimation = getRandomAnim(3)
		setPedAnimation ( characterElementSelected, randomAnimation[1], randomAnimation[2], -1, true, false, false, false )
		cFadeOutTime = 254
		addEventHandler("onClientRender", getRootElement(), Characters_FadeOut)
		fadeCamera ( false, 1, 0,0,0 )
		setTimer(function()
			triggerServerEvent("accounts:characters:spawn", localPlayer, characterSelected)
		end, 1000,1)

	end
end

function Characters_FadeOut()
	cFadeOutTime = cFadeOutTime -3
	if (cFadeOutTime <= 0) then
		removeEventHandler("onClientRender", getRootElement(), Characters_FadeOut)
	else
		for _, thePed in ipairs(pedTable) do
			if isElement(thePed) and (thePed ~= characterElementSelected) then
				setElementAlpha(thePed, cFadeOutTime)
			end
		end
	end
end

function characters_destroyDetailScreen()
	lDetailScreen = { }
	if isElement(wDetailScreen) then
		destroyElement(iCharacterImage)
		destroyElement(bPlayAs)
		destroyElement(wDetailScreen)
		iCharacterImage = nil
		iPlayAs = nil
		wDetailScreen = nil

	end
	for _, thePed in ipairs(pedTable) do
		if isElement(thePed) then
			destroyElement(thePed)
		end
	end
	pedTable = { }
	cFadeOutTime = 0
	if isElement(newCharacterButton) then
		destroyElement( newCharacterButton )
	end
	if isElement(bLogout) then
		destroyElement( bLogout )
	end
end
--- End character detail screen

function characters_onSpawn(fixedName, adminLevel, gmLevel, factionID, factionRank)
	clearChat()
	showChat(true)
	guiSetInputEnabled(false)
	showCursor(false)
    outputChatBox("#ab47bc'' #FFFFFF   [ AN ]  -  Arab Night Community !  #ab47bc ''", 255, 255, 255,true)
    outputChatBox(" ", 255, 255, 255,true)
	outputChatBox("#FFFFFF*#ab47bc " .. fixedName .. "#FFFFFF أنت تلعب بــ", 255, 255, 255,true)
	--outputChatBox("#FFFFFF*#ab47bc   #FFFFFF- كل عام وانتم بخيـــــر .", 255, 255, 255,true)
	outputChatBox("#FFFFFF*#ab47bc F1 #FFFFFF لـ قراءة قوانين وتعليمات الحياة الواقعية اضغط .", 255, 255, 255,true)
	outputChatBox("#FFFFFF*#ab47bc F2 #FFFFFF- إذا كنت تحتاج إلى مساعدة, أرفع ريبورت عن طريق .", 255, 255, 255,true)
	outputChatBox("#FFFFFF*#ab47bc F6 #FFFFFF- الإضافات كـ أشكال (أسلحة,شخصيات,سيارات)اضغط .", 255, 255, 255,true)
	outputChatBox("#FFFFFF*#ab47bc F9 #FFFFFF-  لاخفاء الهود اضغط .", 255, 255, 255,true)
	outputChatBox("#FFFFFF*#ab47bc  https://discord.gg/ann #FFFFFF- للتواصل الاجتمــــاعي الديسكورد الخاص بالشبكة .", 255, 255, 255,true)
	characters_destroyDetailScreen()
	setElementData(getLocalPlayer(), "admin_level", adminLevel, false)
	setElementData(getLocalPlayer(), "account:gmlevel", gmLevel, false)
	setElementData(getLocalPlayer(), "faction", factionID, false)
	setElementData(getLocalPlayer(), "factionrank", factionrank, false)

	-- Adams
	local dbid = getElementDimension(localPlayer)
	triggerServerEvent("frames:loadInteriorTextures", getLocalPlayer(), dbid)
	options_enable()
	--Stop bgMusic + spawning sound fx / maxime
	local bgMusic = getElementData(localPlayer, "bgMusic")
	if bgMusic and isElement(bgMusic) then
		setTimer(startSoundFadeOut, 2000, 1, bgMusic, 100, 30, 0.04, "bgMusic")
	end
	local selectionSound = getElementData(localPlayer, "selectionSound")
	if selectionSound and isElement(selectionSound) then
		destroyElement(selectionSound)
		bgMusic = nil

	end
	
	setTimer(function ()
		local spawnCharSound = playSound("spawn_char.mp3")
		setSoundVolume(spawnCharSound, 0.3)
	end, 2000, 1)
	
end
addEventHandler("accounts:characters:spawn", getRootElement(), characters_onSpawn)

function soundFadeOut(sound, decrease, dataKey)
	if sound and isElement(sound) then
		local oldVol = getSoundVolume(sound)
		if oldVol <= 0 then
			if soundFadeTimer and isElement(soundFadeTimer) then
				killTimer(soundFadeTimer)
				soundFadeTimer = nil
			end
			destroyElement(sound)
			if dataKey then
				setElementData(localPlayer, dataKey, false)
			end
		else
			if not decrease then decrease = 0.05 end
			local newVol = oldVol - decrease
			setSoundVolume(sound, newVol)
		end
	end
end
function startSoundFadeOut(sound, timeInterval, timesToExecute, decrease, dataKey)
	if not sound or not isElement(sound) then return false end
	if not tonumber(timeInterval) then timeInterval = 100 end
	if not tonumber(timesToExecute) then timesToExecute = 30 end
	if not tonumber(decrease) then decrease = 0.05 end
	soundFadeTimer = setTimer(soundFadeOut, timeInterval, timesToExecute, sound, decrease, dataKey)
	setTimer(forceStopSound, 4000, 1, sound, dataKey)
end
function forceStopSound(sound, dataKey)
	if sound and isElement(sound) then
		destroyElement(sound)
		if dataKey then
			setElementData(localPlayer, dataKey, false)
		end		
	end
end

function Characters_newCharacter()
	Characters_deactivateGUI()
	characters_destroyDetailScreen()
		newCharacter_init()
			-- hkSetVisible("Name", true)
	dxbackground = true
end

function playerLogout()
	Characters_deactivateGUI()
	characters_destroyDetailScreen()
	for _, thePed in ipairs(pedTable) do
		destroyElement(thePed, 0)
	end
end

function doWalk() -- RolePlay Walk
    setControlState("walk", true)
end
setTimer(doWalk, 50, 0)
