-- Made by Tazio

local DISCORD_WEBHOOK = ""
local DISCORD_NAME = "System"
-- local DISCORD_IMAGE = "" !coming soon!

--PerformHttpRequest(DISCORD_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME, content = "**Serverlogging is ONLINE**"}), { ['Content-Type'] = 'application/json' })


AddEventHandler('chatMessage', function(source, name, message) 
    PerformHttpRequest(DISCORD_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = name, content = message}), { ['Content-Type'] = 'application/json' })
end)

AddEventHandler('playerConnecting', function() 
    PerformHttpRequest(DISCORD_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME, content = "```".. GetPlayerName(source) .. " connecting ```"}), { ['Content-Type'] = 'application/json' })
end)

AddEventHandler('playerDropped', function(reason) 
    PerformHttpRequest(DISCORD_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME, content = "```".. GetPlayerName(source) .. " left ( ".. reason .. " )```"}), { ['Content-Type'] = 'application/json' })
end)

RegisterServerEvent('playerDied')
AddEventHandler('playerDied',function(killer,reason)
	if killer == "**Invalid**" then --Can't figure out what's generating invalid, it's late. If you figure it out, let me know. I just handle it as a string for now.
		reason = 2
	end
	if reason == 0 then
		--TriggerClientEvent('showNotification', -1,"~o~".. GetPlayerName(source).."~w~ committed suicide. ")
    	PerformHttpRequest(DISCORD_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME, content = GetPlayerName(source) .. " committed suicide"}), { ['Content-Type'] = 'application/json' })
	elseif reason == 1 then
		--TriggerClientEvent('showNotification', -1,"~o~".. killer .. "~w~ killed ~o~"..GetPlayerName(source).."~w~.")
    	PerformHttpRequest(DISCORD_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME, content = GetPlayerName(source) .. " was killed by: " .. killer}), { ['Content-Type'] = 'application/json' })
	else
		--TriggerClientEvent('showNotification', -1,"~o~".. GetPlayerName(source).."~w~ died.")
    	PerformHttpRequest(DISCORD_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME, content = GetPlayerName(source) .. " died"}), { ['Content-Type'] = 'application/json' })

	end
end)