DGS = exports.dgs

local gui = {}
local curskin = 1
local dummyPed = nil
local languageselected = 1
local selectedMonth1 = "January"
local scrDay = 1

function newCharacter_init()
	DGS:dgsSetInputEnabled(true)
	setCameraInterior(14)
	setCameraMatrix(254.7190,  -41.1370,  1002, 256.7190,  -41.1370,  1002 )
	dummyPed = createPed(217, 258,  -42,  1002)
	setElementInterior(dummyPed, 14)
	setElementInterior(getLocalPlayer(), 14)
	setPedRotation(dummyPed, 87)
	setElementDimension(dummyPed, getElementDimension(getLocalPlayer()))
	fadeCamera ( true , 1, 0,0,0 )
	local screenX, screenY = DGS:dgsGetScreenSize()
        local sX = guiGetScreenSize() 
	romcisFont = DGS:dgsCreateFont( "fonts/Samim-Bold.ttf", 10*(sX/1920))
	romcisFont1 = DGS:dgsCreateFont( "fonts/Samim-Bold.ttf", 13*(sX/1920))
	romcisFont3 = DGS:dgsCreateFont( "fonts/Samim-Bold.ttf", 18*(sX/1920))
	local SlowBlue = DGS:dgsCreateRoundRect({{15,false},{15,false},{15,false},{15,false}},tocolor(9, 9, 11,255))
	ButtonRect = DGS:dgsCreateRoundRect({{15,false},{15,false},{15,false},{15,false}},tocolor(0, 0, 0, 255))
	local MemoRect = DGS:dgsCreateRoundRect({{15,false},{15,false},{15,false},{15,false}},tocolor(130, 130, 130, 200))
	local MemoRect2 = DGS:dgsCreateRoundRect({{10,false},{10,false},{10,false},{10,false}},tocolor(130, 130, 130, 200))
	gui["_root"] = DGS:dgsCreateImage(0.01, 0.13, 0.17, 0.78, SlowBlue, true)
	--DGS:dgsWindowSetSizable(gui["_root"], false)

	gui["lblCharName"] = DGS:dgsCreateLabel(0.68, 0.02, 0.27, 0.02, ": أسم الشخصية", true, gui["_root"])
	DGS:dgsLabelSetHorizontalAlign(gui["lblCharName"], "left", false)
	DGS:dgsLabelSetVerticalAlign(gui["lblCharName"], "center")
	DGS:dgsSetFont(gui["lblCharName"], romcisFont)
	gui["txtCharName"] = DGS:dgsCreateEdit(0.09, 0.05, 0.79, 0.03, "", true, gui["_root"], tocolor(255, 255, 255, 255), nil, nil, nil, nil)
	DGS:dgsEditSetMaxLength(gui["txtCharName"], 32767)
	DGS:dgsSetFont(gui["txtCharName"], romcisFont)
	DGS:dgsSetProperty(gui["txtCharName"],"bgImage",MemoRect2)
	DGS:dgsEditSetAlignment( gui["txtCharName"], "center" , "center" )
--[[	gui["lblCharNameExplanation"] = DGS:dgsCreateLabel(10, 40, 240, 80,"This needs to be in the following format: \n     Firstname Lastname\nFor example: Taylor Jackson.\nYou are not allowed to use famous names.", true, gui["_root"])
	DGS:dgsLabelSetHorizontalAlign(gui["lblCharNameExplanation"], "left", false)
	DGS:dgsLabelSetVerticalAlign(gui["lblCharNameExplanation"], "center")]]--

	gui["lblCharDesc"] = DGS:dgsCreateLabel(0.68, 0.11, 0.27, 0.02, ": وصف الشخصية", true, gui["_root"])
	DGS:dgsLabelSetHorizontalAlign(gui["lblCharDesc"], "left", false)
	DGS:dgsLabelSetVerticalAlign(gui["lblCharDesc"], "center")
	DGS:dgsSetFont(gui["lblCharDesc"], romcisFont)
	gui["memCharDesc"] = DGS:dgsCreateMemo(0.09, 0.14, 0.79, 0.11, "", true, gui["_root"], tocolor(255, 255, 255, 255), nil, nil, nil, nil)
	DGS:dgsSetFont(gui["memCharDesc"], romcisFont)
	DGS:dgsSetProperty(gui["memCharDesc"],"bgImage",MemoRect)
--[[	gui["lblCharDescExplanation"] = DGS:dgsCreateLabel(10, 245, 231, 61, "Fill in an description of your character, for \nexample how your character looks and\nother special remarks. There is a minimum\nof 50 characters.", true, gui["_root"])
	DGS:dgsLabelSetHorizontalAlign(gui["lblCharDescExplanation"], "left", false)
	DGS:dgsLabelSetVerticalAlign(gui["lblCharDescExplanation"], "center")]]--

	gui["lblGender"] = DGS:dgsCreateLabel(0.81, 0.33, 0.14, 0.02, ": الجنس", true, gui["_root"])
	DGS:dgsLabelSetHorizontalAlign(gui["lblGender"], "left", false)
	DGS:dgsLabelSetVerticalAlign(gui["lblGender"], "center")
	DGS:dgsSetFont(gui["lblGender"], romcisFont)
	gui["rbMale"] = DGS:dgsCreateRadioButton(0.47, 0.33, 0.24, 0.02, "ذكر    - ", true, gui["_root"])
	gui["rbFemale"] = DGS:dgsCreateRadioButton(0.19, 0.33, 0.22, 0.02, "أنثى    -  ", true, gui["_root"])
	DGS:dgsRadioButtonSetSelected ( gui["rbMale"], true)
	DGS:dgsSetFont(gui["rbMale"], romcisFont)
	DGS:dgsSetFont(gui["rbFemale"], romcisFont)
	addEventHandler("onDgsMouseClickUp", gui["rbMale"], newCharacter_updateGender, false)
	addEventHandler("onDgsMouseClickUp", gui["rbFemale"], newCharacter_updateGender, false)

	gui["lblSkin"] = DGS:dgsCreateLabel(0.39, 0.41, 0.20, 0.02, "- الشخصية -", true, gui["_root"])
	DGS:dgsLabelSetHorizontalAlign(gui["lblSkin"], "left", false)
	DGS:dgsLabelSetVerticalAlign(gui["lblSkin"], "center")
	DGS:dgsSetFont(gui["lblSkin"], romcisFont)
	gui["btnPrevSkin"] = DGS:dgsCreateButton(0.63, 0.39, 0.29, 0.05, "السابق", true, gui["_root"])
	addEventHandler("onDgsMouseClickUp", gui["btnPrevSkin"], newCharacter_updateGender, false)
	DGS:dgsSetFont(gui["btnPrevSkin"], romcisFont)
	gui["btnNextSkin"] = DGS:dgsCreateButton(0.07, 0.39, 0.29, 0.05, "التالي", true, gui["_root"])
	addEventHandler("onDgsMouseClickUp", gui["btnNextSkin"], newCharacter_updateGender, false)
	DGS:dgsSetFont(gui["btnNextSkin"], romcisFont)

	gui["lblRace"] = DGS:dgsCreateLabel(0.81, 0.29, 0.14, 0.02, ": البشرة", true, gui["_root"])
	DGS:dgsLabelSetHorizontalAlign(gui["lblRace"], "left", false)
	DGS:dgsLabelSetVerticalAlign(gui["lblRace"], "center")
	DGS:dgsSetFont(gui["lblRace"], romcisFont)
	gui["chkBlack"] =  DGS:dgsCreateCheckBox (0.06, 0.29, 0.22, 0.02, "أسود    - ", true, true, gui["_root"] )
	addEventHandler("onDgsMouseClickUp", gui["chkBlack"] , newCharacter_raceFix, false)
	DGS:dgsSetFont(gui["chkBlack"], romcisFont)
	gui["chkWhite"] =  DGS:dgsCreateCheckBox (0.57, 0.29, 0.24, 0.02, "أبيض    - ", false, true, gui["_root"] )
	addEventHandler("onDgsMouseClickUp", gui["chkWhite"] , newCharacter_raceFix, false)
	DGS:dgsSetFont(gui["chkWhite"], romcisFont)
	gui["chkAsian"] =  DGS:dgsCreateCheckBox (0.33, 0.29, 0.21, 0.02, "أسمر    - ", false, true, gui["_root"] )
	addEventHandler("onDgsMouseClickUp", gui["chkAsian"] , newCharacter_raceFix, false)
	DGS:dgsSetFont(gui["chkAsian"], romcisFont)

	gui["lblHeight"] = DGS:dgsCreateLabel(0.75, 0.47, 0.11, 0.02, ": الطول", true, gui["_root"])
	DGS:dgsLabelSetHorizontalAlign(gui["lblHeight"], "left", false)
	DGS:dgsLabelSetVerticalAlign(gui["lblHeight"], "center")
	DGS:dgsSetFont(gui["lblHeight"], romcisFont)

	gui["scrHeight"] =  DGS:dgsCreateScrollBar (0.07, 0.47, 0.60, 0.02, true, true, gui["_root"])
	addEventHandler("onDgsElementScroll", gui["scrHeight"], newCharacter_updateScrollBars, false)
	DGS:dgsSetProperty(gui["scrHeight"], "StepSize", "0.02")

	gui["lblWeight"] = DGS:dgsCreateLabel(0.75, 0.52, 0.10, 0.02, ": الوزن", true, gui["_root"])
	DGS:dgsLabelSetHorizontalAlign(gui["lblWeight"], "left", false)
	DGS:dgsLabelSetVerticalAlign(gui["lblWeight"], "center")
	DGS:dgsSetFont(gui["lblWeight"], romcisFont)

	gui["scrWeight"] =  DGS:dgsCreateScrollBar (0.07, 0.52, 0.60, 0.02, true, true, gui["_root"])
	addEventHandler("onDgsElementScroll", gui["scrWeight"], newCharacter_updateScrollBars, false)
	DGS:dgsSetProperty(gui["scrWeight"], "StepSize", "0.01")

	gui["lblAge"] = DGS:dgsCreateLabel(0.75, 0.57, 0.10, 0.02, ": العمر", true, gui["_root"])
	DGS:dgsLabelSetHorizontalAlign(gui["lblAge"], "left", false)
	DGS:dgsLabelSetVerticalAlign(gui["lblAge"], "center")
	DGS:dgsSetFont(gui["lblAge"], romcisFont)

	gui["scrAge"] =  DGS:dgsCreateScrollBar (0.07, 0.57, 0.60, 0.02, true, true, gui["_root"])
	addEventHandler("onDgsElementScroll", gui["scrAge"], newCharacter_updateScrollBars, false)
	DGS:dgsSetProperty(gui["scrAge"], "StepSize", "0.0120")

	gui["lblDay"] = DGS:dgsCreateLabel(0.75, 0.73, 0.10, 0.02, ": اليوم", true, gui["_root"])
	DGS:dgsLabelSetHorizontalAlign(gui["lblDay"], "left", false)
	DGS:dgsLabelSetVerticalAlign(gui["lblDay"], "center")
	DGS:dgsSetFont(gui["lblDay"], romcisFont)

	gui["scrDay"] =  DGS:dgsCreateScrollBar (0.07, 0.73, 0.60, 0.02, true, true, gui["_root"])
	addEventHandler("onDgsElementScroll", gui["scrDay"], newCharacter_updateScrollBars, false)
	DGS:dgsSetProperty(gui["scrDay"], "StepSize", "0.0125")

	gui["lblMonth"] = DGS:dgsCreateLabel(0.84, 0.63, 0.11, 0.02, ": الشهر", true, gui["_root"])
	DGS:dgsLabelSetHorizontalAlign(gui["lblDay"], "left", false)
	DGS:dgsLabelSetVerticalAlign(gui["lblDay"], "center")
	DGS:dgsSetFont(gui["lblMonth"], romcisFont)

	gui["drpMonth"] =  DGS:dgsCreateComboBox (0.07, 0.62, 0.60, 0.08, "January", true, gui["_root"])
	dgsComboBoxAdjustHeight(gui["drpMonth"], 0.5)
	--DGS:dgsComboBoxAdjustHeight(gui["drpMonth"], 15)
	DGS:dgsComboBoxAddItem(gui["drpMonth"], "January")
	DGS:dgsComboBoxAddItem(gui["drpMonth"], "February")
	DGS:dgsComboBoxAddItem(gui["drpMonth"], "March")
	DGS:dgsComboBoxAddItem(gui["drpMonth"], "April")
	DGS:dgsComboBoxAddItem(gui["drpMonth"], "May")
	DGS:dgsComboBoxAddItem(gui["drpMonth"], "June")
	DGS:dgsComboBoxAddItem(gui["drpMonth"], "July")
	DGS:dgsComboBoxAddItem(gui["drpMonth"], "August")
	DGS:dgsComboBoxAddItem(gui["drpMonth"], "September")
	DGS:dgsComboBoxAddItem(gui["drpMonth"], "October")
	DGS:dgsComboBoxAddItem(gui["drpMonth"], "November")
	DGS:dgsComboBoxAddItem(gui["drpMonth"], "December")
	DGS:dgsSetFont(gui["drpMonth"], romcisFont)
	addEventHandler ( "onDgsComboBoxSelect", root,
		function ( comboBox )
			if ( comboBox == gui["drpMonth"] ) then
				local item = DGS:dgsComboBoxGetSelected ( gui["drpMonth"] )
				selectedMonth1 = tostring ( DGS:dgsComboBoxGetItemText ( gui["drpMonth"] , item ) )
			end
		end, true)



	gui["lblLanguage"] = DGS:dgsCreateLabel(0.85, 0.78, 0.10, 0.02, ": اللغة", true, gui["_root"])
	DGS:dgsLabelSetHorizontalAlign(gui["lblLanguage"], "left", false)
	DGS:dgsLabelSetVerticalAlign(gui["lblLanguage"], "center")
	DGS:dgsSetFont(gui["lblLanguage"], romcisFont)

	gui["btnLanguagePrev"] = DGS:dgsCreateButton(0.07, 0.78, 0.05, 0.02, "<", true, gui["_root"])
	gui["lblLanguageDisplay"] = DGS:dgsCreateLabel(0.27, 0.78, 0.21, 0.02, "English", true, gui["_root"])
	DGS:dgsLabelSetHorizontalAlign(gui["lblLanguageDisplay"], "center", true)
	DGS:dgsLabelSetVerticalAlign(gui["lblLanguageDisplay"], "center", true)
	DGS:dgsSetFont(gui["btnLanguagePrev"], romcisFont)
	DGS:dgsSetFont(gui["lblLanguageDisplay"], romcisFont)

	gui["btnLanguageNext"] = DGS:dgsCreateButton(0.61, 0.78, 0.05, 0.02, ">", true, gui["_root"])
	addEventHandler("onDgsMouseClickUp", gui["btnLanguagePrev"] , newCharacter_updateLanguage, false)
	addEventHandler("onDgsMouseClickUp", gui["btnLanguageNext"] , newCharacter_updateLanguage, false)
	DGS:dgsSetFont(gui["btnLanguageNext"], romcisFont)

	--gui["btnLangs"] = DGS:dgsCreateButton(10, 330, 231, 41, "All Languages", true, gui["_root"])
	--addEventHandler("onDgsMouseClickUp", gui["btnLangs"] , newCharacter_viewAllLangs, false)

	gui["btnCancel"] = DGS:dgsCreateButton(0.05, 0.91, 0.89, 0.05, "الرجوع للخلف ➚", true, gui["_root"])
	addEventHandler("onDgsMouseClickUp", gui["btnCancel"], newCharacter_cancel, false)
	DGS:dgsSetFont(gui["btnCancel"], romcisFont1)

	gui["btnCreateChar"] = DGS:dgsCreateButton(0.05, 0.84, 0.89, 0.05, "أنشاء", true, gui["_root"])
	DGS:dgsSetFont(gui["btnCreateChar"], romcisFont1)
	addEventHandler("onDgsMouseClickUp", gui["btnCreateChar"], newCharacter_attemptCreateCharacter, false)
	newCharacter_changeSkin()
	newCharacter_updateScrollBars()
 
	DGS:dgsSetProperty(gui["btnNextSkin"],"image",{ButtonRect,ButtonRect,ButtonRect}) 
	DGS:dgsSetProperty(gui["btnNextSkin"] ,"color",{tocolor(130, 130, 130, 200), tocolor(0, 98, 255, 200), tocolor(0, 0, 0, 255)})
	DGS:dgsSetProperty(gui["btnPrevSkin"],"image",{ButtonRect,ButtonRect,ButtonRect}) 
	DGS:dgsSetProperty(gui["btnPrevSkin"] ,"color",{tocolor(130, 130, 130, 200), tocolor(0, 98, 255, 200), tocolor(0, 0, 0, 255)})
	DGS:dgsSetProperty(gui["btnCreateChar"],"image",{ButtonRect,ButtonRect,ButtonRect}) 
	DGS:dgsSetProperty(gui["btnCreateChar"] ,"color",{tocolor(130, 130, 130, 200), tocolor(0, 98, 255, 200), tocolor(0, 0, 0, 255)})
	DGS:dgsSetProperty(gui["btnCancel"],"image",{ButtonRect,ButtonRect,ButtonRect}) 
	DGS:dgsSetProperty(gui["btnCancel"] ,"color",{tocolor(130, 130, 130, 200), tocolor(255, 0, 0, 200), tocolor(0, 0, 0, 255)})
	DGS:dgsRoundRectSetColorOverwritten(ButtonRect,false)
end

function newCharacter_viewAllLangs(button)
	if (source == gui["btnLangs"] and button == "left") then
		if isElement(gui['langWindow']) then return false end

		gui['langWindow'] = DGS:dgsCreateWindow(720, 339, 339, 446, "Languages", false)
		DGS:dgsWindowSetSizable(gui['langWindow'], false)
		showCursor(true)
	
		gui['langWindowGrid'] = DGS:dgsCreateGridList(9, 28, 320, 379, false, gui['langWindow'])
		DGS:dgsGridListAddColumn(gui['langWindowGrid'], "Languages", 0.9)
	
		for _, value in ipairs(exports['language-system']:getLanguageList()) do 
			DGS:dgsGridListAddRow(gui['langWindowGrid'], value)
		end
			
		gui['langWindowCloseBtn'] = DGS:dgsCreateButton(9, 411, 320, 25, "Close", false, gui['langWindow'])
			
		addEventHandler("onDgsMouseClickUp", gui['langWindowCloseBtn'], function(button)
			if (source == gui['langWindowCloseBtn'] and button == "left") then 
				destroyElement(gui['langWindow'])
				gui['langWindow'] = nil
			end
		end)
	
		addEventHandler("onDgsMouseDoubleClick", gui['langWindowGrid'], function(button)
		if (button == "left") then 
			local row = DGS:dgsGridListGetSelectedItem(gui['langWindowGrid'])
			local selectedLang = DGS:dgsGridListGetItemText(gui['langWindowGrid'], row, 1)
			DGS:dgsSetText(gui["lblLanguageDisplay"], exports['language-system']:getLanguageName(row + 1))
			languageselected = row + 1
			end
		end)
	end
end

function newCharacter_raceFix()
	DGS:dgsCheckBoxSetSelected ( gui["chkAsian"], false )
	DGS:dgsCheckBoxSetSelected ( gui["chkWhite"], false )
	DGS:dgsCheckBoxSetSelected ( gui["chkBlack"], false )
	if (source == gui["chkBlack"]) then
		DGS:dgsCheckBoxSetSelected ( gui["chkBlack"], true )
	elseif (source == gui["chkWhite"]) then
		DGS:dgsCheckBoxSetSelected ( gui["chkWhite"], true )
	elseif (source == gui["chkAsian"]) then
		DGS:dgsCheckBoxSetSelected ( gui["chkAsian"], true )
	end

	curskin = 1
	newCharacter_changeSkin(0)
end

function newCharacter_updateGender()
	local diff = 0
	if (source == gui["btnPrevSkin"]) then
		diff = -1
	elseif (source == gui["btnNextSkin"]) then
		diff = 1
	else
		curskin = 1
	end
	newCharacter_changeSkin(diff)
end

function newCharacter_updateLanguage()

	if source == gui["btnLanguagePrev"] then
		if languageselected == 1 then
			languageselected = call( getResourceFromName( "language-system" ), "getLanguageCount" )
		else
			languageselected = languageselected - 1
		end
	elseif source == gui["btnLanguageNext"] then
		if languageselected == call( getResourceFromName( "language-system" ), "getLanguageCount" ) then
			languageselected = 1
		else
			languageselected = languageselected + 1
		end
	end

	DGS:dgsSetText(gui["lblLanguageDisplay"], tostring(call( getResourceFromName( "language-system" ), "getLanguageName", languageselected )))
end

function newCharacter_updateScrollBars()
	local scrollHeight = DGS:dgsScrollBarGetScrollPosition(gui["scrHeight"])
	scrollHeight = math.floor((scrollHeight / 2) + 150)

	local scrWeight = DGS:dgsScrollBarGetScrollPosition(gui["scrWeight"])
	scrWeight = math.floor(scrWeight + 50)

	local scrAge = DGS:dgsScrollBarGetScrollPosition(gui["scrAge"])
	scrAge = math.floor( (scrAge * 0.8 ) + 16 )

	--local scrollHeight = tonumber(DGS:dgsGetProperty(gui["scrHeight"], "ScrollPosition")) * 100
	--scrollHeight = math.floor((scrollHeight / 2) + 150)
	DGS:dgsSetText(gui["lblHeight"], "الطول : "..scrollHeight.." سم")

	--local scrWeight = tonumber(DGS:dgsGetProperty(gui["scrWeight"], "ScrollPosition")) * 310
	--scrWeight = math.floor(scrWeight + 40)
	DGS:dgsSetText(gui["lblWeight"], "الوزن : "..scrWeight.." كلغ")

	--local scrAge = tonumber(DGS:dgsGetProperty(gui["scrAge"], "ScrollPosition")) * 100
	--scrAge = math.floor( (scrAge * 0.8 ) + 16 )
	DGS:dgsSetText(gui["lblAge"], "العمر : "..scrAge.." سنة")

	local year = getBirthday(tonumber(scrAge))
	selectedMonth = monthToNumber(selectedMonth1)
	--outputDebugString(selectedMonth)
	local dayCap = daysInMonth(selectedMonth, year) or 31

	scrDay = (tonumber(DGS:dgsScrollBarGetScrollPosition(gui["scrDay"]))+1)/100
	scrDay = math.floor( scrDay*dayCap )
	if scrDay == 0 then
		scrDay = 1
	end

	DGS:dgsSetText(gui["lblDay"], "اليوم : "..(scrDay or "1"))
end

function newCharacter_changeSkin(diff)
	local array = newCharacters_getSkinArray()
	local skin = 0
	if (diff ~= nil) then
		curskin = curskin + diff
	end

	if (curskin > #array or curskin < 1) then
		curskin = 1
		skin = array[1]
	else
		curskin = curskin
		skin = array[curskin]
	end

	if skin ~= nil then
		setElementModel(dummyPed, tonumber(skin))
	end
end

function newCharacters_getSkinArray()
	local array = { }
	if (DGS:dgsCheckBoxGetSelected( gui["chkBlack"] )) then -- BLACK
		if (DGS:dgsRadioButtonGetSelected( gui["rbMale"] )) then -- BLACK MALE
			array = blackMales
		elseif (DGS:dgsRadioButtonGetSelected( gui["rbFemale"] )) then -- BLACK FEMALE
			array = blackFemales
		else
			outputChatBox("Select a gender first!", 0, 255, 0)
		end
	elseif ( DGS:dgsCheckBoxGetSelected( gui["chkWhite"] ) ) then -- WHITE
		if ( DGS:dgsRadioButtonGetSelected( gui["rbMale"] ) ) then -- WHITE MALE
			array = whiteMales
		elseif ( DGS:dgsRadioButtonGetSelected( gui["rbFemale"] ) ) then -- WHITE FEMALE
			array = whiteFemales
		else
			outputChatBox("Select a gender first!", 0, 255, 0)
		end
	elseif ( DGS:dgsCheckBoxGetSelected( gui["chkAsian"] ) ) then -- ASIAN
		if ( DGS:dgsRadioButtonGetSelected( gui["rbMale"] ) ) then -- ASIAN MALE
			array = asianMales
		elseif ( DGS:dgsRadioButtonGetSelected( gui["rbFemale"] ) ) then -- ASIAN FEMALE
			array = asianFemales
		else
			outputChatBox("Select a gender first!", 0, 255, 0)
		end
	end
	return array
end

function newCharacter_cancel(hideSelection)
	DGS:dgsSetInputEnabled(false)
	destroyElement(dummyPed)
	destroyElement(gui["_root"])
	if gui['langWindow'] then
		destroyElement(gui['langWindow'])
	end
	gui = {}
	curskin = 1
	dummyPed = nil
	languageselected = 1
	if hideSelection ~= true then
		Characters_showSelection()
	end
	clearChat()
end

function newCharacter_attemptCreateCharacter()
	local characterName = DGS:dgsGetText(gui["txtCharName"])
	local nameCheckPassed, nameCheckError = checkValidCharacterName(characterName)
	if not nameCheckPassed then
		LoginScreen_showWarningMessage( "Error processing your character name:\n".. nameCheckError )
		return
	end
	--[[
	local characterDescription = DGS:dgsGetText(gui["memCharDesc"])
	if #characterDescription < 50 then
		LoginScreen_showWarningMessage( "Error processing your character\ndescription: Not long enough." )
		return
	elseif #characterDescription > 128 then
		LoginScreen_showWarningMessage( "Error processing your character\ndescription: Too long." )
		return
	end]]

	local race = 0
	if (DGS:dgsCheckBoxGetSelected(gui["chkBlack"])) then
		race = 0
	elseif (DGS:dgsCheckBoxGetSelected(gui["chkWhite"])) then
		race = 1
	elseif (DGS:dgsCheckBoxGetSelected(gui["chkAsian"])) then
		race = 2
	else
		LoginScreen_showWarningMessage( "Error processing your character race:\nNone selected." )
		return
	end

	local gender = 0
	if (DGS:dgsRadioButtonGetSelected( gui["rbMale"] )) then
		gender = 0
	elseif (DGS:dgsRadioButtonGetSelected( gui["rbFemale"] )) then
		gender = 1
	else
		LoginScreen_showWarningMessage( "Error processing your character gender:\nNone selected." )
		return
	end

	local skin = getElementModel( dummyPed )
	if not skin then
		LoginScreen_showWarningMessage( "Error processing your character skin:\nNone selected." )
		return
	end


	local scrollHeight = DGS:dgsScrollBarGetScrollPosition(gui["scrHeight"])
	scrollHeight = math.floor((scrollHeight / 2) + 150)

	local scrWeight = DGS:dgsScrollBarGetScrollPosition(gui["scrWeight"])
	scrWeight = math.floor(scrWeight + 50)

	local scrAge = DGS:dgsScrollBarGetScrollPosition(gui["scrAge"])
	scrAge = math.floor( (scrAge * 0.8 ) + 16 )

	if languageselected == nil then
		LoginScreen_showWarningMessage( "Error processing your character language:\nNone selected." )
		return
	end
	DGS:dgsSetEnabled(gui["btnCancel"], false)
	DGS:dgsSetEnabled(gui["btnCreateChar"], false)
	DGS:dgsSetEnabled(gui["_root"], false)
	fadeCamera(false, 1)
	setTimer(function ()
		selectStartPointGUI(characterName, characterDescription, race, gender, skin, scrollHeight, scrWeight, scrAge, languageselected, selectedMonth, scrDay) --This is the correct place. /MAXIME
	end, 1000, 1)
end

function newCharacter_response(statusID, statusSubID)
	if (statusID == 1) then
		LoginScreen_showWarningMessage( "Oops, something went wrong. Try again\nor contact an administrator.\nError ACC"..tostring(statusSubID) )
	elseif (statusID == 2) then
		if (statusSubID == 1) then
			LoginScreen_showWarningMessage( "This charactername is already in\nuse, sorry :(!" )
		else
			LoginScreen_showWarningMessage( "Oops, something went wrong. Try again\nor contact an administrator.\nError ACD"..tostring(statusSubID) )
		end
	elseif (statusID == 3) then
		newCharacter_cancel(true)
		triggerServerEvent("accounts:characters:spawn", getLocalPlayer(), statusSubID, nil, nil, nil, nil, true)
		triggerServerEvent("updateCharacters", getLocalPlayer())
		--selectStartPointGUI(statusSubID) --Turned out this not where we should have started LOL /Max
		return
	end

	DGS:dgsSetEnabled(gui["btnCancel"], true)
	DGS:dgsSetEnabled(gui["btnCreateChar"], true)
	DGS:dgsSetEnabled(gui["_root"], true)

end
addEventHandler("accounts:characters:new", getRootElement(), newCharacter_response)

local wSelectStartPoint = nil
function selectStartPointGUI(characterName, characterDescription, race, gender, skin, scrollHeight, scrWeight, scrAge, languageselected, selectedMonth, scrDay )
	closeSelectStartPoint() -- Make sure the GUI won't get duplicated and stuck on client's screen at any case.
	showCursor(true)
	DGS:dgsSetInputEnabled(true)

	--config
	local locations = {
					-- x, 			y,					 z, 			rot    		int, 	dim 	Location Name
		["default"] = {1168.6484375, -1412.576171875, 13.497941017151, 357.72854614258, 0, 0, "A bus stop near the mall"},
		["igs"] = { 1922.9072265625, -1760.6982421875, 13.546875, 0,			0, 		0, 		"A bus stop next in Idlewood"},
		["bus"] = {1749.509765625, -1860.5087890625, 13.578649520874, 359.0744, 	0, 		0, 		"Unity Bus Station"},
		["metro"] = {808.88671875, -1354.6513671875, -0.5078125, 139.5092, 			0, 		0,		"Metro Station"},
		["air"] = {1691.6455078125, -2334.001953125, 13.546875, 0.10711, 			0, 		0,		"Los Santos International Airport"},
		["boat"] = {2809.66015625, -2436.7236328125, 13.628322601318, 90.8995, 		0, 		0,		"Santa Maria Dock"},
	}

	wSelectStartPoint = DGS:dgsCreateWindow(0,0, 300, 250, "How do you arrive in Los Santos?", false)
	exports.global:dgsCenterWindow(wSelectStartPoint)

	local busButton = DGS:dgsCreateButton(40, 40, 100, 60, "Bus", false, wSelectStartPoint)
	addEventHandler("onDgsMouseClickUp", busButton, function ()
		newCharacter_cancel(true)
		triggerServerEvent("accounts:characters:new", getLocalPlayer(), characterName, characterDescription, race, gender, skin, scrollHeight, scrWeight, scrAge, languageselected, selectedMonth, scrDay, locations.bus)
		closeSelectStartPoint()
	end)

	local metroButton = DGS:dgsCreateButton(40, 120, 100, 60, "Metro", false, wSelectStartPoint)
	addEventHandler("onDgsMouseClickUp", metroButton, function()
		newCharacter_cancel(true)
		triggerServerEvent("accounts:characters:new", getLocalPlayer(), characterName, characterDescription, race, gender, skin, scrollHeight, scrWeight, scrAge, languageselected, selectedMonth, scrDay, locations.metro)
		closeSelectStartPoint()
	end)

	local airButton = DGS:dgsCreateButton(160, 40, 100, 60, "Airplane", false, wSelectStartPoint)
	addEventHandler("onDgsMouseClickUp", airButton, function()
		newCharacter_cancel(true)
		triggerServerEvent("accounts:characters:new", getLocalPlayer(), characterName, characterDescription, race, gender, skin, scrollHeight, scrWeight, scrAge, languageselected, selectedMonth, scrDay, locations.air)
		closeSelectStartPoint()
	end)

	local boatButton = DGS:dgsCreateButton(160, 120, 100, 60, "Boat", false, wSelectStartPoint)
	addEventHandler("onDgsMouseClickUp", boatButton, function()
		newCharacter_cancel(true)
		triggerServerEvent("accounts:characters:new", getLocalPlayer(), characterName, characterDescription, race, gender, skin, scrollHeight, scrWeight, scrAge, languageselected, selectedMonth, scrDay, locations.boat)
		closeSelectStartPoint()
	end)

	--Temporarily disabled new character spawnpoint selector until we set up all the spawnpoint's shops and locations properly. /Maxime
	triggerServerEvent("accounts:characters:new", getLocalPlayer(), characterName, characterDescription, race, gender, skin, scrollHeight, scrWeight, scrAge, languageselected, selectedMonth, scrDay, locations.default)
	closeSelectStartPoint()
	-- end of the disability
end

function closeSelectStartPoint()
	if wSelectStartPoint and isElement(wSelectStartPoint) then
		destroyElement(wSelectStartPoint)
		showCursor(false)
		DGS:dgsSetInputEnabled(false)
	end
end

function isThisYearLeap(year)
     if (tonumber(year)%4) == 0 then
          return true
     else
          return false
     end
end

function monthToNumber(monthName)
	if not monthName then
		return 1
	else
		if monthName == "January" then
			return 1
		elseif monthName == "February" then
			return 2
		elseif monthName == "March" then
			return 3
		elseif monthName == "April" then
			return 4
		elseif monthName == "May" then
			return 5
		elseif monthName == "June" then
			return 6
		elseif monthName == "July" then
			return 7
		elseif monthName == "August" then
			return 8
		elseif monthName == "September" then
			return 9
		elseif monthName == "October" then
			return 10
		elseif monthName == "November" then
			return 11
		elseif monthName == "December" then
			return 12
		else
			return 1
		end
	end
end

function monthNumberToName(monthNumber)
	if not monthNumber or not tonumber(monthNumber) then
		return "January"
	else
		monthNumber = tonumber(monthNumber)
		if monthNumber == 1 then
			return "January"
		elseif monthNumber == 2 then
			return "February"
		elseif monthNumber == 3 then
			return "March"
		elseif monthNumber == 4 then
			return "April"
		elseif monthNumber == 5 then
			return "May"
		elseif monthNumber == 6 then
			return "June"
		elseif monthNumber == 7 then
			return "July"
		elseif monthNumber == 8 then
			return "August"
		elseif monthNumber == 9 then
			return "September"
		elseif monthNumber == 10 then
			return "October"
		elseif monthNumber == 11 then
			return "November"
		elseif monthNumber == 12 then
			return "December"
		else
			return "January"
		end
	end
end

function daysInMonth(month, year)
	if not month or not year or not tonumber(month) or not tonumber(year) then
		return 31
	else
		month = tonumber(month)
		year = tonumber(year)
	end

	if month == 1 then
		return 31
	elseif month == 2 then
		if isThisYearLeap(year) then
			return 29
		else
			return 28
		end
	elseif month == 3 then
		return 31
	elseif month == 4 then
		 return 30
	elseif month == 5 then
		return 31
	elseif month == 6 then
		return 30
	elseif month == 7 then
		return 31
	elseif month == 8 then
		return 31
	elseif month == 9 then
		return 30
	elseif month == 10 then
		return 31
	elseif month == 11 then
		return 30
	elseif month == 12 then
		return 31
	else
		return 31
	end
end

function getBirthday(age)
	if not age or not tonumber(age) then
		return 2015
	else
		age = tonumber(age)
	end

	local time = getRealTime()
	time.year = time.year + 1900
	return (time.year - age)
end

function getBetterDay(day)
	if not day or not tonumber(day) then
		return "1st"
	else
		day = tonumber(day)
		if day == 1 or day == 21 or day == 31 then
			return day.."st"
		elseif day == 2 or day == 22 then
			return day.."nd"
		elseif day == 3 or day == 23 then
			return day.."rd"
		else
			return day.."th"
		end
	end
end

function dgsComboBoxAdjustHeight ( combobox, itemcount )
    if getElementType ( combobox ) ~= "dgs-dxcombobox" or type ( itemcount ) ~= "number" then error ( "Invalid arguments @ 'dgsComboBoxAdjustHeight'", 2 ) end
    local width = DGS:dgsGetSize ( combobox, false )
    return DGS:dgsSetSize ( combobox, width, ( itemcount * 20 ) + 20, false )
end