# [Server Logging](https://forum.fivem.net/t/server-log-discord-webhook/482062)
A FiveM Server Logging Plugin

# Installation
1. Download `Serverlogging`!
2. Install it into `/resources/`.
3. Enter your webhook url in `server.lua`
4. Make a Steam API Key in https://steamcommunity.com/dev/apikey and paste the key in `server.lua`
5. Start the plugin
6. Good job, now you can screen your users 👀

# Endpoint
You want to log EVERYTHING on the server? Do you want to check every move the user makes? Creepy but you can by adding this line to your favorite script
```lua
TriggerServerEvent("logging:send", "<TITLE HERE>", "<DESCRIPTION HERE>", <DECIMAL COLOR HERE>)
TriggerEvent("logging:send", "<TITLE HERE>", "<DESCRIPTION HERE>", <DECIMAL COLOR HERE>)
```
Use `TriggerServerEvent` for client sided code (not recommended)

# Supported scripts
These are the scripts that have logging build in, no need for extra fidgeting and coding.
* COMING SOON
