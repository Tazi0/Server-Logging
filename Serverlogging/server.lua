-- Made by Tazio

local DISCORD_WEBHOOK = ""
local DISCORD_NAME = "System"
local STEAM_KEY = ""
local DISCORD_IMAGE = "https://pbs.twimg.com/profile_images/847824193899167744/J1Teh4Di_400x400.jpg" -- default is FiveM logo

--DON'T EDIT BELOW THIS

PerformHttpRequest(DISCORD_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME, content = "**Discord Webhook is ONLINE**"}), { ['Content-Type'] = 'application/json' })

AddEventHandler('chatMessage', function(source, name, message) 
	--print(tonumber(GetIDFromSource('steam', source), 16)) -- DEBUGGING
	--print('https://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=' .. STEAM_KEY .. '&steamids=' .. tonumber(GetIDFromSource('steam', source), 16))
	if STEAM_KEY == '' or STEAM_KEY == nil then
		PerformHttpRequest(DISCORD_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = name .. " [" .. source .. "]", content = message}), { ['Content-Type'] = 'application/json' })
	else
		PerformHttpRequest('https://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=' .. STEAM_KEY .. '&steamids=' .. tonumber(GetIDFromSource('steam', source), 16), function(err, text, headers)
			local image = string.match(text, '"avatarfull":"(.-)","')
			--print(image) -- DEBUGGING
			return PerformHttpRequest(DISCORD_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = name .. " [" .. source .. "]", content = message, avatar_url = image, tts = false}), { ['Content-Type'] = 'application/json' })
		end)
	end
end)

AddEventHandler('playerConnecting', function() 
    --PerformHttpRequest(DISCORD_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME, content = "```CSS\n".. GetPlayerName(source) .. " connecting\n```", avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })
    sendToDiscord("Server Login", GetPlayerName(source) " is connecting to the server.")
end)

AddEventHandler('playerDropped', function(reason) 
    --PerformHttpRequest(DISCORD_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME, content = "```fix\n".. GetPlayerName(source) .. " left ( ".. reason .. " )\n```", avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })
    sendToDiscord("Server Logout", GetPlayerName(source) " has disconnected from the server.")
end)

RegisterServerEvent('playerDied')
AddEventHandler('playerDied',function(killer,reason)
	if killer == "**Invalid**" then
		reason = 2
	end
	if reason == 0 then
    	PerformHttpRequest(DISCORD_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME, content = GetPlayerName(source) .. " committed suicide", avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })
	elseif reason == 1 then
    	PerformHttpRequest(DISCORD_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME, content = GetPlayerName(source) .. " was killed by: " .. killer, avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })
	else
    	PerformHttpRequest(DISCORD_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME, content = GetPlayerName(source) .. " died", avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })

	end
end)

function GetIDFromSource(Type, ID) --(Thanks To WolfKnight [forum.FiveM.net])
    local IDs = GetPlayerIdentifiers(ID)
    for k, CurrentID in pairs(IDs) do
        local ID = stringsplit(CurrentID, ':')
        if (ID[1]:lower() == string.lower(Type)) then
            return ID[2]:lower()
        end
    end
    return nil
end

function stringsplit(input, seperator)
	if seperator == nil then
		seperator = '%s'
	end
	
	local t={} ; i=1
	
	for str in string.gmatch(input, '([^'..seperator..']+)') do
		t[i] = str
		i = i + 1
	end
	
	return t
end

function sendToDiscord(name, message)
  local connect = {
        {
            ["color"] = "8663711",
            ["title"] = "**".. name .."**",
            ["description"] = message,
            ["footer"] = {
                ["text"] = "Made by Tazio",
            },
        }
    }
  PerformHttpRequest(DISCORD_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME, embeds = connect, avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })
end