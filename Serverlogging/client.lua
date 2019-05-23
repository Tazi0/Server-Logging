-- Made by Tazio
-- Help by qalle-fivem (esx_checkdeathcause)

local Melee = { -1569615261, 1737195953, 1317494643, -1786099057, 1141786504, -2067956739, -868994466 }
local Bullet = { 453432689, 1593441988, 584646201, -1716589765, 324215364, 736523883, -270015777, -1074790547, -2084633992, -1357824103, -1660422300, 2144741730, 487013001, 2017895192, -494615257, -1654528753, 100416529, 205991906, 1119849093 }
local Knife = { -1716189206, 1223143800, -1955384325, -1833087301, 910830060, }
local Car = { 133987706, -1553120962 }
local Animal = { -100946242, 148160082 }
local FallDamage = { -842959696 }
local Explosion = { -1568386805, 1305664598, -1312131151, 375527679, 324506233, 1752584910, -1813897027, 741814745, -37975472, 539292904, 341774354, -1090665087 }
local Gas = { -1600701090 }
local Burn = { 615608432, 883325847, -544306709 }
local Drown = { -10959621, 1936677264 }

Citizen.CreateThread(function()
    local alreadyDead = false

    while true do
        Citizen.Wait(50)
        local playerPed = GetPlayerPed(-1)
        if IsEntityDead(playerPed) and not alreadyDead then
            local playerName = GetPlayerName(PlayerId())
            killer = GetPedKiller(playerPed)
            killername = false

            for id = 0, 64 do
                if killer == GetPlayerPed(id) then
                    killername = GetPlayerName(id)
                end
            end

            local death = GetPedCauseOfDeath(playerPed)

            if checkArray (Melee, death) then
                TriggerServerEvent('playerDied', killername .. " meleed " .. playerName)
            elseif checkArray (Bullet, death) then
                TriggerServerEvent('playerDied', killername .. " shot " .. playerName)
            elseif checkArray (Knife, death) then
                TriggerServerEvent('playerDied', killername .. " stabbed " .. playerName)
            elseif checkArray (Car, death) then
                TriggerServerEvent('playerDied', killername .. " hit " .. playerName)
            elseif checkArray (Animal, death) then
                TriggerServerEvent('playerDied', playerName .. " died by an animal")
            elseif checkArray (FallDamage, death) then
                TriggerServerEvent('playerDied', playerName .. " died of fall damage")
            elseif checkArray (Explosion, death) then
                TriggerServerEvent('playerDied', playerName .. " died of an explosion")
            elseif checkArray (Gas, death) then
                TriggerServerEvent('playerDied', playerName .. " died of gas")
            elseif checkArray (Burn, death) then
                TriggerServerEvent('playerDied', playerName .. " burned to death")
            elseif checkArray (Drown, death) then
                TriggerServerEvent('playerDied', playerName .. " drowned")
            else
                TriggerServerEvent('playerDied', playerName .. " was killed by an unknown force")
                --print(death)
            end

            alreadyDead = true
        end

        if not IsEntityDead(playerPed) then
            alreadyDead = false
        end
    end
end)

function checkArray (array, val)
    for name, value in ipairs(array) do
        if value == val then
            return true
        end
    end
    return false
end