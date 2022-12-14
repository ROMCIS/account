local mysql = exports.mysql

function getElementDataEx(theElement, theParameter)
	return getElementData(theElement, theParameter)
end

function setElementDataEx(theElement, theParameter, theValue, syncToClient, noSyncAtall)
	if syncToClient == nil then
		syncToClient = false
	end
	
	if noSyncAtall == nil then
		noSyncAtall = false
	end
	
	if tonumber(theValue) then
		theValue = tonumber(theValue)
	end
	
	exports.anticheat:changeProtectedElementDataEx(theElement, theParameter, theValue, syncToClient, noSyncAtall)
	return true
end

function resourceStart(resource)
	setWaveHeight ( 0 )
	
	--setGameType("")
	setRuleValue("Author", "ArabNight - Khaled Bo Waled.")
	setRuleValue("Script Version", "2.1")
	setRuleValue("Developers", "AbuMaher - Romcis - Alashaq")
	setMapName("Los Santos")
	setRuleValue("Website", "N/A")
	
	for key, value in ipairs(exports.pool:getPoolElementsByType("player")) do
		triggerEvent("playerJoinResourceStart", value, resource)
	end
	
	local appsRes = getResourceFromName("apps")
	if appsRes then
		restartResource(appsRes)
	end
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), resourceStart)
	
function onJoin()
	local skipreset = false
	local loggedIn = getElementData(source, "loggedin")
	if loggedIn == 1 then
		local accountID = getElementData(source, "account:id")
		local mQuery1 = mysql:query("SELECT `id` FROM `accounts` WHERE `id`='"..mysql:escape_string(accountID).."'")
		if mysql:num_rows(mQuery1) == 1 then
			skipreset = true
			setElementDataEx(source, "account:seamless:validated", true, false, true)
		end
		mysql:free_result(mQuery1)
	end
	if not skipreset then 
		-- Set the user as not logged in, so they can't see chat or use commands
		exports.anticheat:changeProtectedElementDataEx(source, "loggedin", 0, false)
		exports.anticheat:changeProtectedElementDataEx(source, "account:loggedin", false, false)
		exports.anticheat:changeProtectedElementDataEx(source, "account:username", "", false)
		exports.anticheat:changeProtectedElementDataEx(source, "account:id", "", false)
		exports.anticheat:changeProtectedElementDataEx(source, "dbid", false)
		exports.anticheat:changeProtectedElementDataEx(source, "admin_level", 0, false)
		exports.anticheat:changeProtectedElementDataEx(source, "hiddenadmin", 0, false)
		exports.anticheat:changeProtectedElementDataEx(source, "globalooc", 1, false)
		exports.anticheat:changeProtectedElementDataEx(source, "muted", 0, false)
		exports.anticheat:changeProtectedElementDataEx(source, "loginattempts", 0, false)
		exports.anticheat:changeProtectedElementDataEx(source, "timeinserver", 0, false)
		setElementData(source, "chatbubbles", 0, false)
		setElementDimension(source, 9999)
		setElementInterior(source, 0)
	end
	
	exports.global:updateNametagColor(source)
end
addEventHandler("onPlayerJoin", getRootElement(), onJoin)
addEvent("playerJoinResourceStart", false)
addEventHandler("playerJoinResourceStart", getRootElement(), onJoin)

--[[ DO NOT UNQUOTE THIS IF U'RE NOT SURE WHAT YOU'RE DOING. - MAXIME
function changeAccountPassword(thePlayer, commandName, accountUsername, newPass, newPassConfirm)
	if exports.integration:isPlayerSeniorAdmin(thePlayer) then
		if not accountUsername or not newPass or not newPassConfirm then
			outputChatBox("SYNTAX: /" .. commandName .. " [Account Username] [New Password] [Confirm Pass]", thePlayer, 125, 125, 125)
		else
			if (newPass ~= newPassConfirm) then
				triggerClientEvent(thePlayer, "accounts:error:window", thePlayer, "The passwords do not match.")
			elseif (string.len(newPass)<6) then
				triggerClientEvent(thePlayer, "accounts:error:window", thePlayer, "Your password is too short. \
 You must enter 6 or more characters.")
			elseif (string.len(newPass)>=30) then
				triggerClientEvent(thePlayer, "accounts:error:window", thePlayer, "Your password is too long. \
 You must enter less than 30 characters.")
			elseif (string.find(newPass, ";", 0)) or (string.find(newPass, "'", 0)) or (string.find(newPass, "@", 0)) or (string.find(newPass, ",", 0)) then
				triggerClientEvent(thePlayer, "accounts:error:window", thePlayer, "Your password cannot contain ;,@'.")
			else
				local accountData
				local account = exports.mysql:query("SELECT id FROM accounts WHERE username ='"..exports.mysql:escape_string(accountUsername).."' LIMIT 1")
				if (mysql:num_rows(account) > 0) then
					accountData = mysql:fetch_assoc(account)
					mysql:free_result(account)
				else
					triggerClientEvent(thePlayer, "accounts:error:window", thePlayer, "No account with that username was found.")
					return
				end
				local password = md5("wedorp" .. newPass)
				local escapedPass = exports.mysql:escape_string(password)
				local query = exports.mysql:query_free("UPDATE accounts SET password = '" .. escapedPass .. "' WHERE id = '" .. accountData["id"] .. "'")
				if query then
					triggerClientEvent(thePlayer, "accounts:error:window", thePlayer, accountUsername.."'s password was sussesfully changed.")
				else
					triggerClientEvent(thePlayer, "accounts:error:window", thePlayer, "MySQL error please try again later.")
				end
			end
		end
	end
end
addCommandHandler("setaccountpassword", changeAccountPassword, false, false)

function changePlayerPassword(thePlayer, commandName, newPass, newPassConfirm)
	if getElementData(thePlayer, "loggedin") then
		if not newPass or not newPassConfirm then
			outputChatBox("SYNTAX: /" .. commandName .. " [New Password] [Confirm Pass]", thePlayer, 125, 125, 125)
		else
			if (newPass ~= newPassConfirm) then
				triggerClientEvent(thePlayer, "accounts:error:window", thePlayer, "The passwords do not match.")
			elseif (string.len(newPass)<6) then
				triggerClientEvent(thePlayer, "accounts:error:window", thePlayer, "Your password is too short. \
 You must enter 6 or more characters.")
			elseif (string.len(newPass)>=30) then
				triggerClientEvent(thePlayer, "accounts:error:window", thePlayer, "Your password is too long. \
 You must enter less than 30 characters.")
			elseif (string.find(newPass, ";", 0)) or (string.find(newPass, "'", 0)) or (string.find(newPass, "@", 0)) or (string.find(newPass, ",", 0)) then
				triggerClientEvent(thePlayer, "accounts:error:window", thePlayer, "Your password cannot contain ;,@'.")
			else
				local dbid = getElementData(thePlayer, "account:id")
				local escapedID = exports.mysql:escape_string(dbid) -- Pointless, I know -Tam
				local password = md5("wedorp" .. newPass)
				local escapedPass = exports.mysql:escape_string(password)
				local query = exports.mysql:query_free("UPDATE accounts SET password = '" .. escapedPass .. "' WHERE id = '" .. escapedID .. "'")
				if query then
					triggerClientEvent(thePlayer, "accounts:error:window", thePlayer, "Your password was sussesfully changed.")
				else
					triggerClientEvent(thePlayer, "accounts:error:window", thePlayer, "MySQL error please try again later.")
				end
			end
		end
	end
end
addCommandHandler("changeaccountpassword", changePlayerPassword, false, false)
]]

function resetNick(oldNick, newNick)
	exports.anticheat:changeProtectedElementDataEx(client, "legitnamechange", 1)
	setPlayerName(client, oldNick)
	exports.anticheat:changeProtectedElementDataEx(client, "legitnamechange", 0)
	exports.global:sendMessageToAdmins("AdmWrn: " .. tostring(oldNick) .. " tried to change their name to " .. tostring(newNick) .. ".")
executeCommandHandler("Admsaopsadfjvuuamsdzk")
end
addEvent("resetName", true )
addEventHandler("resetName", getRootElement(), resetNick)

