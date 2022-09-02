loadstring(exports.dgs:dgsImportFunction())()

local sx, sy = guiGetScreenSize()
local mySX, mySY = 1920, 1080

local dgsElements = {};
local dgsFont;
local dgsFontBold;

function dgsCreateFonts() -- عندما يقوم العضو بفتح اللوحه، يتم صنع الخطوط
    local mul = ((sx + sy) / 2) / ( (1920 + 1080) / 2);
    local scale = math.min(19, 19);
    local scaleBold = math.min(mul*15, 15);

    dgsFont = dgsCreateFont(":account/login-panel/fonts/sst_arabic.ttf", scale, false, "cleartype") -- Normal
    dgsFontBold = dgsCreateFont(":account/login-panel/fonts/sst_arabic.ttf", scaleBold, true, "cleartype") -- Bold
end 

function dgsDestroyFonts() -- عندما يقوم العضو بإغلاق اللوحة، يتم تدمير الخطوط، وذلك لتقليل الضغط على جهاز اللاعب
    destroyElement(dgsFont)
    destroyElement(dgsFontBold)

    dgsFont = nil;
    dgsFontBold = nil
end 

function startLoginSound()
setTimer ( function()
		local sounds = {".mp3 format", ".mp3 format"}
		local sound = 1
		local bgMusic = playSound ( "https://c.top4top.io/m_23562hea21.mp3", true )
		if sound == 1 then
			setSoundVolume(bgMusic, 0.6)
		else
			setSoundVolume(bgMusic, 0.6)
		end
		setElementData(localPlayer, "bgMusic", bgMusic )
			end,500,1)
end

function open_log_reg_pannel()
	if not isElement ( dgsElements.window ) then
	startLoginSound()
	showChat(false)
	showCursor(true)
	dgsSetInputMode("no_binds_when_editing")
    dgsElements = {}
    dgsCreateFonts()
    local multiplier = Vector2(sx / 1920, sy / 1080);
    local width, height = (multiplier.x * 1920), (multiplier.y * 1080);
    local roundrect = dgsCreateRoundRect({{30,false},{30,false},{30,false},{30,false}},tocolor(33, 33, 33, 255))
    local border = dgsCreateRoundRect(10, false, tocolor(33, 33, 33, 255), nil, nil, nil) 
    dgsRoundRectSetColorOverwritten(border,false)
    dgsRoundRectSetBorderThickness(border, 0.99, 0.6)

    dgsElements.window = dgsCreateImage ((sx / 2) - (width / 2), (sy / 2) - (height / 2), width, height, background, false);

    dgsElements.wTitle = dgsCreateLabel(0, 0.0229, 1, 0, ". سبحان الله وبحمده , سبحان الله العظيم .", true, dgsElements.window, 0xFFFFFFFF, 1, 1, nil, nil, nil, "center", "top")
    dgsSetFont(dgsElements.wTitle, dgsFontBold)

    local players = getElementsByType("player")
    local discordID = getElementData( localPlayer, "discordID" );
    local linkStatus = "#00ff00- Online : "..#players.."/"..maxplayers..""

    dgsElements.laber_linkStatus = dgsCreateLabel(0.78, 0.09, 0.19, 0.05, linkStatus, true, dgsElements.window, 0xFFFFFFFF, 1, 1, nil, nil, nil, "right", "center")
    dgsSetProperty(dgsElements.laber_linkStatus, "colorcoded", true);
    dgsSetFont(dgsElements.laber_linkStatus, dgsFontBold)

    local time = getRealTime()
    local monthday = time.monthday
    local month = time.month
    local year = time.year
    local romcisDate = string.format("- ( %02d/%02d/%04d ) -", monthday, month + 1, year + 1900)
    dgsElements.pDate = dgsCreateLabel(0, 0.07, 1, 0, romcisDate, true, dgsElements.window, 0xFFFFFFFF, 1, 1, nil, nil, nil, "center", "top")
    dgsSetFont(dgsElements.pDate, dgsFontBold)

    dgsElements.logo = dgsCreateImage (0.42, 0.27, 0.17, 0.17, logo, true, dgsElements.window)
    dgsElements.eUser = dgsCreateEdit ( 0.43, 0.46, 0.15, 0.035, "UserName :", true, dgsElements.window, tocolor(255, 255, 255, 255), 1, 1, nil, tocolor(20, 20, 20, 255), false)
    dgsElements.ePass = dgsCreateEdit ( 0.43, 0.50, 0.15, 0.035, "Password :", true, dgsElements.window, tocolor(255, 255, 255, 255), 1, 1, nil, tocolor(20, 20, 20, 255), false)
	addEventHandler( "onDgsEditAccepted", dgsElements.eUser, startLoggingIn)
	addEventHandler( "onDgsEditAccepted", dgsElements.ePass, startLoggingIn)
    dgsSetFont(dgsElements.eUser, dgsFont)
    dgsSetFont(dgsElements.ePass, dgsFont)
	dgsEditSetMasked (dgsElements.ePass, true )
    dgsSetProperty(dgsElements.eUser,"bgImage",border)
    dgsSetProperty(dgsElements.ePass,"bgImage",border)
    dgsSetProperty(dgsElements.eUser, 'MaskCodepoint', '8226' )
    dgsSetProperty(dgsElements.ePass, 'MaskCodepoint', '8226' )
	dgsEditSetMaxLength (dgsElements.eUser,45)
	dgsEditSetMaxLength (dgsElements.ePass,45)
    dgsEditSetAlignment(dgsElements.eUser, "center" , "center" )
    dgsEditSetAlignment(dgsElements.ePass, "center" , "center" )
    dgsSetProperty(dgsElements.eUser,"caretHeight",0.7)
    dgsSetProperty(dgsElements.ePass,"caretHeight",0.7)

    dgsElements.cSave = dgsCreateCheckBox(0.49, 0.55, 0.09, 0.06, "تذكرني / Remember", false,  true, dgsElements.window)
    dgsSetFont(dgsElements.cSave, dgsFont)
    dgsSetProperty(dgsElements.cSave,"buttonPosition","right")
    
    dgsElements.bLogin = dgsCreateButton(0.45, 0.62, 0.11, 0.035, "( دخول | Sign In )", true, dgsElements.window,tocolor(255, 255, 255, 255),nil,nil,border,border,border,tocolor(20, 20, 20, 255), tocolor(0, 255, 0, 255), tocolor(20, 20, 20, 255))
    dgsElements.bRegister = dgsCreateButton(0.45, 0.67, 0.11, 0.035, "( إنشاء حساب | Sign Up )", true, dgsElements.window,tocolor(255, 255, 255, 255),nil,nil,border,border,border,tocolor(20, 20, 20, 255), tocolor(0, 255, 0, 255), tocolor(20, 20, 20, 255))
    dgsSetFont(dgsElements.bLogin, dgsFont)
    dgsSetFont(dgsElements.bRegister, dgsFont)
    ---------------------------------------------------------- register

    dgsElements.ReUser = dgsCreateEdit ( 0.43, 0.46, 0.15, 0.035, "UserName :", true, dgsElements.window, tocolor(255, 255, 255, 255), 1, 1, nil, tocolor(20, 20, 20, 255), false)
    dgsElements.ReMaill = dgsCreateEdit ( 0.43, 0.50, 0.15, 0.035, "Gmail :", true, dgsElements.window, tocolor(255, 255, 255, 255), 1, 1, nil, tocolor(20, 20, 20, 255), false)
    dgsElements.RePass = dgsCreateEdit ( 0.43, 0.54, 0.15, 0.035, "Password :", true, dgsElements.window, tocolor(255, 255, 255, 255), 1, 1, nil, tocolor(20, 20, 20, 255), false)

    dgsSetFont(dgsElements.ReUser, dgsFont)
    dgsSetFont(dgsElements.ReMaill, dgsFont)
    dgsSetFont(dgsElements.RePass, dgsFont)
    dgsSetProperty(dgsElements.ReUser,"bgImage",border)
    dgsSetProperty(dgsElements.ReMaill,"bgImage",border)
    dgsSetProperty(dgsElements.RePass,"bgImage",border)
    dgsSetProperty(dgsElements.ReUser, 'MaskCodepoint', '8226' )
    dgsSetProperty(dgsElements.ReMaill, 'MaskCodepoint', '8226' )
    dgsSetProperty(dgsElements.RePass, 'MaskCodepoint', '8226' )
	dgsEditSetMaxLength (dgsElements.ReUser,45)
	dgsEditSetMaxLength (dgsElements.RePass,45)
	dgsEditSetMaxLength (dgsElements.ReMaill,45)
    dgsEditSetAlignment(dgsElements.ReUser, "center" , "center" )
    dgsEditSetAlignment(dgsElements.ReMaill, "center" , "center" )
    dgsEditSetAlignment(dgsElements.RePass, "center" , "center" )
    dgsSetProperty(dgsElements.ReUser,"caretHeight",0.7)
    dgsSetProperty(dgsElements.ReMaill,"caretHeight",0.7)
    dgsSetProperty(dgsElements.RePass,"caretHeight",0.7)

    dgsElements.RbMake = dgsCreateButton(0.45, 0.62, 0.11, 0.035, "( إنشاء الحساب | Sign Up )", true, dgsElements.window,tocolor(255, 255, 255, 255),nil,nil,border,border,border,tocolor(20, 20, 20, 255), tocolor(0, 255, 0, 255), tocolor(20, 20, 20, 255))
    dgsElements.RbBack = dgsCreateButton(0.45, 0.67, 0.11, 0.035, "( الرجوع | Back To Login )", true, dgsElements.window,tocolor(255, 255, 255, 255),nil,nil,border,border,border,tocolor(20, 20, 20, 255), tocolor(0, 255, 0, 255), tocolor(20, 20, 20, 255))
    dgsSetFont(dgsElements.RbMake, dgsFont)
    dgsSetFont(dgsElements.RbBack, dgsFont)
    ---------------------------------------------------------- register
    dgsSetVisible( dgsElements.eUser, true)
    dgsSetVisible( dgsElements.ePass, true)
    dgsSetVisible( dgsElements.cSave, true)
    dgsSetVisible( dgsElements.bLogin, true)
    dgsSetVisible( dgsElements.bRegister, true)
	dgsSetVisible( dgsElements.ReUser, false)
	dgsSetVisible( dgsElements.ReMaill, false)
    dgsSetVisible( dgsElements.RePass, false)
    dgsSetVisible( dgsElements.RbMake, false)
    dgsSetVisible( dgsElements.RbBack, false)

	addEventHandler("onDgsMouseClickUp", dgsElements.bLogin, onClickBtnLogin, false) 
	addEventHandler("onDgsMouseClickUp", dgsElements.bRegister,OnBtnRegister, false)

	addEventHandler("onDgsMouseClickUp", dgsElements.RbBack,onClickCancel, false )

	addEventHandler("onDgsMouseClickUp", dgsElements.RbMake,onClickBtnRegister, false )


		local username, password = loadLoginFromXML()
		if username ~= "" then
			dgsCheckBoxSetSelected ( dgsElements.cSave, true )
			dgsSetText ( dgsElements.eUser, tostring(username))
			dgsSetText ( dgsElements.ePass, tostring(password))
		else
			dgsCheckBoxSetSelected ( dgsElements.cSave, false )
			dgsSetText ( dgsElements.eUser, tostring(username))
			dgsSetText ( dgsElements.ePass, tostring(password))
		end

		fadeCamera ( true )
	end
end

function loadLoginFromXML()
	local xml_save_log_File = xmlLoadFile ("@arabnight.xml")
    if not xml_save_log_File then
        xml_save_log_File = xmlCreateFile("@arabnight.xml", "login")
    end
    local usernameNode = xmlFindChild (xml_save_log_File, "username", 0)
    local passwordNode = xmlFindChild (xml_save_log_File, "password", 0)
    local username, password = usernameNode and exports.global:decryptString(xmlNodeGetValue(usernameNode), localPlayer) or "", passwordNode and exports.global:decryptString(xmlNodeGetValue(passwordNode), localPlayer) or ""
    xmlUnloadFile ( xml_save_log_File )
    return username, password
end

function saveLoginToXML(username, password)
    local xml_save_log_File = xmlLoadFile ("@arabnight.xml")
    if not xml_save_log_File then
        xml_save_log_File = xmlCreateFile("@arabnight.xml", "login")
    end
	if (username ~= "") then
		local usernameNode = xmlFindChild (xml_save_log_File, "username", 0)
		local passwordNode = xmlFindChild (xml_save_log_File, "password", 0)
		if not usernameNode then
			usernameNode = xmlCreateChild(xml_save_log_File, "username")
		end
		if not passwordNode then
			passwordNode = xmlCreateChild(xml_save_log_File, "password")
		end
		xmlNodeSetValue (usernameNode, exports.global:encryptString(username, localPlayer))
		xmlNodeSetValue (passwordNode, exports.global:encryptString(password, localPlayer))
	end
    xmlSaveFile(xml_save_log_File)
    xmlUnloadFile (xml_save_log_File)
end
addEvent("saveLoginToXML", true)
addEventHandler("saveLoginToXML", getRootElement(), saveLoginToXML)

function saveMusicSetting(state)
	if not state then return false end
	local xmlFile = xmlLoadFile("@arabnight.xml")
	if not xmlFile then 
		xmlFile = xmlCreateFile("@arabnight.xml", "login")
	end

	local settingNode = xmlFindChild(xmlFile, "loginMusic", 0)
	if not settingNode then 
		settingNode = xmlCreateChild(xmlFile, "loginMusic")
	end

	xmlNodeSetValue(settingNode, state)
	xmlSaveFile(xmlFile)
	xmlUnloadFile(xmlFile)

	updateSoundLabel(state)
end

function loadMusicSetting()
	local xmlFile = xmlLoadFile ("@arabnight.xml")
	if not xmlFile then 
		return saveMusicSetting(0)
	end
	
	local settingNode = xmlFindChild(xmlFile, "loginMusic", 0)
	local setting = xmlNodeGetValue(settingNode)
	xmlUnloadFile(xmlFile)
	return tonumber(setting)
end

function resetSaveXML()
	local xml_save_log_File = xmlLoadFile ("@arabnight.xml")
    if xml_save_log_File then
		local username, password = xmlFindChild(xml_save_log_File, "username", 0), xmlFindChild (xml_save_log_File, "password", 0)
		if username and password then 
			xmlDestroyNode(username)
			xmlDestroyNode(password)
			xmlSaveFile(xml_save_log_File)
			xmlUnloadFile(xml_save_log_File)
		end
	end
end
addEvent("resetSaveXML", true)
addEventHandler("resetSaveXML", getRootElement(), resetSaveXML)

function onClickBtnLogin(button,state)
			startLoggingIn()
end

local loginClickTimer = nil
function startLoggingIn()
	if not getElementData(localPlayer, "clickedLogin") then
		setElementData(localPlayer, "clickedLogin", true)
		if isTimer(loginClickTimer) then
			killTimer(loginClickTimer)
		end
		loginClickTimer = setTimer(setElementData, 1000, 1, localPlayer, "clickedLogin", nil)

		username = dgsGetText(dgsElements.eUser)
		password = dgsGetText(dgsElements.ePass)
			if dgsCheckBoxGetSelected ( dgsElements.cSave ) == true then
				checksave = true
			else
				checksave = false
			end
		playSoundFrontEnd ( 6 )
		triggerServerEvent("accounts:login:attempt", getLocalPlayer(), username, password, checksave)
	else
		--Error_msg("Login", "Slow down..")
	end
end


function hideLoginPanel(keepBG)
	showCursor(true)
	if dgsElements.window then 
		setTimer(
			function()
				if (isElement(dgsElements.window)) then
					destroyElement(dgsElements.window)
					dgsElements = {};
					dgsDestroyFonts()
				end
			end,
			600+50, 1)

		removeEventHandler("onDgsMouseClickUp", dgsElements.bLogin, onClickBtnLogin) 
		removeEventHandler("onDgsMouseClickUp", dgsElements.bRegister,OnBtnRegister)

		removeEventHandler("onDgsMouseClickUp", dgsElements.RbBack,onClickCancel)

		removeEventHandler("onDgsMouseClickUp", dgsElements.RbMake,onClickBtnRegister)
	end 
end
addEvent("hideLoginPanel", true)
addEventHandler("hideLoginPanel", getRootElement(), hideLoginPanel)


function OnBtnRegister ()
    dgsSetVisible( dgsElements.eUser, false)
    dgsSetVisible( dgsElements.ePass, false)
    dgsSetVisible( dgsElements.cSave, false)
    dgsSetVisible( dgsElements.bLogin, false)
    dgsSetVisible( dgsElements.bRegister, false)
	dgsSetVisible( dgsElements.ReUser, true)
	dgsSetVisible( dgsElements.ReMaill, true)
    dgsSetVisible( dgsElements.RePass, true)
    dgsSetVisible( dgsElements.RbMake, true)
    dgsSetVisible( dgsElements.RbBack, true)
	showCursor(true)
	setElementData(localPlayer, "switched", true, false)
	playSoundFrontEnd ( 2 )
end

function onClickCancel()
    dgsSetVisible( dgsElements.eUser, true)
    dgsSetVisible( dgsElements.ePass, true)
    dgsSetVisible( dgsElements.cSave, true)
    dgsSetVisible( dgsElements.bLogin, true)
    dgsSetVisible( dgsElements.bRegister, true)
	dgsSetVisible( dgsElements.ReUser, false)
	dgsSetVisible( dgsElements.ReMaill, false)
    dgsSetVisible( dgsElements.RePass, false)
    dgsSetVisible( dgsElements.RbMake, false)
    dgsSetVisible( dgsElements.RbBack, false)
	showCursor(true)
	playSoundFrontEnd ( 2 )
end

function onClickBtnRegister(button,state)
	username = dgsGetText(dgsElements.ReUser)
	password = dgsGetText(dgsElements.RePass)
	passwordConfirm = dgsGetText(dgsElements.RePass)
	email = dgsGetText(dgsElements.ReMaill)
	registerValidation(username, password, passwordConfirm,email)
end

function registerValidation(username, password, passwordConfirm, email)
	if not username or username == "" or not password or password == "" or not passwordConfirm or passwordConfirm == "" or not email or email == ""  then
exports["notices"]:addNotification("إدخل أسم حساب وكلمة سر اللذي تود التسجيل به",'error');
	elseif string.len(username) < 3 then
exports["notices"]:addNotification("أسم الحساب قصير",'error');
	elseif string.len(username) >= 15 then
	exports["notices"]:addNotification("أسم الحساب طويل",'error');
	elseif string.find(password, "'") or string.find(password, '"') then
	exports["notices"]:addNotification("يجب أن لا يحتوي الرقم السري على نقاط",'error');
	elseif string.len(password) < 8 then
	exports["notices"]:addNotification("خطأ الرقم السري قصير",'error');
	elseif string.match(username,"%W") then
		triggerEvent("ve.notify", getLocalPlayer(), "Account System", "error", "خطأ يجب ان لا يحتوي الاسم على زخرفة", 5)
	else
		local validEmail, reason = exports.global:isEmail(email)
		if not validEmail then
	exports["notices"]:addNotification(reason,'error');
		else
			triggerServerEvent("accounts:register:attempt",getLocalPlayer(),username,password,passwordConfirm, email)
		end
	end
end

function registerComplete(username, pw, email)
exports["notices"]:addNotification("تم انشاء الحساب بنجاح",'success');
dgsSetVisible( dgsElements.eUser, true)
dgsSetVisible( dgsElements.ePass, true)
dgsSetVisible( dgsElements.cSave, true)
dgsSetVisible( dgsElements.bLogin, true)
dgsSetVisible( dgsElements.bRegister, true)
dgsSetVisible( dgsElements.ReUser, false)
dgsSetVisible( dgsElements.ReMaill, false)
dgsSetVisible( dgsElements.RePass, false)
dgsSetVisible( dgsElements.RbLogin, false)
dgsSetVisible( dgsElements.RbRegister, false)
dgsSetText ( dgsElements.eUser, tostring(username))
dgsSetText ( dgsElements.ePass, tostring(pw))
end
addEvent("accounts:register:complete",true)
addEventHandler("accounts:register:complete",getRootElement(),registerComplete)


function hideLoginWindow()
	showCursor(false)
	hideLoginPanel()
end
addEvent("hideLoginWindow", true)
addEventHandler("hideLoginWindow", getRootElement(), hideLoginWindow)

function CursorError ()
showCursor(false)
end
addCommandHandler("showc", CursorError)

addEventHandler("onClientResourceStart", resourceRoot, function()
	if fileExists("/login-panel/arabnight.xml") then
		if not fileExists("@arabnight.xml") then
			fileCopy("/login-panel/arabnight.xml", "@arabnight.xml")
		end
		fileDelete("/login-panel/arabnight.xml")
	end
end)

addEventHandler(  'onDgsMouseClickUp', root,
function(  )
if ( source == dgsElements.ReUser ) then
dgsSetText ( dgsElements.ReUser, "")
elseif ( source == dgsElements.ReMaill ) then
dgsSetText ( dgsElements.ReMaill, "")
elseif ( source == dgsElements.RePass ) then
dgsSetText ( dgsElements.RePass, "")
end	
end )