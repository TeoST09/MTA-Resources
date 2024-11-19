



local playerVehicles = {}


function onServerVehicle()
    local player = client
    local money = getPlayerMoney(player)


    if playerVehicles[player] then
        if isElement(playerVehicles[player]) then
            destroyElement(playerVehicles[player])
        end
    end


    if money >= 2500 then
        triggerClientEvent(player, "addNotificationbike", player, "Haz Rentado una Bicicleta", "success", true)
        takePlayerMoney ( player, 2500 )
        local x, y, z = getElementPosition(player)
        local vehicle = createVehicle(510, x, y, z + 1)
        if vehicle then
            warpPedIntoVehicle(player, vehicle)
            playerVehicles[player] = vehicle
            
            setTimer(function()
                if isElement(vehicle) then
                    destroyElement(vehicle)
                    triggerClientEvent(player, "addNotificationbike", player, "Paso el Tiempo de Renta se Elimino el Vehiculo", "warn", true)
                    playerVehicles[player] = nil
                end
            end, 600000, 1)
        end
    else
        triggerClientEvent(player, "addNotification", player, "No Tienes Suficiente Dinero", "warn", true)
    end

end

addEvent("onServerBikes", true)
addEventHandler("onServerBikes", resourceRoot, onServerVehicle)

addEventHandler("onPlayerQuit", root, function() 
    local player = source if playerVehicles[player] then 
        if isElement(playerVehicles[player]) then 
            destroyElement(playerVehicles[player]) playerVehicles[player] = nil 
        end 
    end 
end)