
local playerVehicles = {}
addEvent("onVehicle", true)
addEventHandler("onVehicle", resourceRoot, function(player)
    local player = client
    
    if playerVehicles[player] then
        if isElement(playerVehicles[player]) then
            destroyElement(playerVehicles[player])
        end
    end
       
        local taxi = createVehicle(420, 1835.21216, -1872.24207, 13.38975 + 1)
        if taxi then
            warpPedIntoVehicle(player, taxi)
            playerVehicles[player] = taxi
            
            setTimer(function()
                if isElement(taxi) then
                    destroyElement(taxi)
                    triggerClientEvent(player, "addNotification", player, "Paso el Tiempo de Prestado de Taxi", "warn", true)
                    playerVehicles[player] = nil
                end
            end, 10000000, 1)

    else
        triggerClientEvent(player, "addNotification", player, "No se Pudo Crear el Taxi", "warn", true)
    end

end)


function money ( player )
    local player = client
    givePlayerMoney ( player, 2500 )
end
addEvent("onmoney", true)
addEventHandler("onmoney", resourceRoot, money)

function onDestroyVehicle ( player )
    local player = client
    if playerVehicles[player] then
        if isElement(playerVehicles[player]) then
            destroyElement(playerVehicles[player])
        end
    end
end
addEvent("onDestroyVehicle", true)
addEventHandler("onDestroyVehicle", resourceRoot, onDestroyVehicle)



