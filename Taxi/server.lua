local playerVehicles = {}

addEvent("onVehicle", true)
addEventHandler("onVehicle", resourceRoot, function()
    local player = client
    
    if playerVehicles[player] then
        if isElement(playerVehicles[player]) then
            destroyElement(playerVehicles[player])
        end
    end

    playerVehicles[player] = createVehicle(420, 1835.21216, -1872.24207, 14.38975)
    warpPedIntoVehicle(player, playerVehicles[player])
    
    setTimer(function()
        if isElement(playerVehicles[player]) then
            destroyElement(playerVehicles[player])
            triggerClientEvent(player, "addNotification", player, "Paso el Tiempo de Prestado de Taxi", "warn", true)
            playerVehicles[player] = nil
        end
    end, 10000000, 1)
end)

function money ()
    givePlayerMoney ( client, 2500 )
end
addEvent("onmoney", true)
addEventHandler("onmoney", resourceRoot, money)

function onDestroyVehicle()
    local player = client
    if playerVehicles[player] then
        if isElement(playerVehicles[player]) then
            destroyElement(playerVehicles[player])
        end
    end
end
addEvent("onDestroyVehicle", true)
addEventHandler("onDestroyVehicle", resourceRoot, onDestroyVehicle)
