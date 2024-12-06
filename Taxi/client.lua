local markerTrabajo = createMarker(1758.50537, -1894.01099, 12.55594, "cylinder", 3.0, 0, 0, 255, 255, false)
createBlipAttachedTo(markerTrabajo, 42, 2, 255, 255, 255, 255)
local trabajando = false
local index = 1
local markerInicio = nil
local cor = nil

function addNotification(texto, tipo)
    exports.Notificaciones:addNotification(texto, tipo, true)
end
addEvent("addNotification", true)
addEventHandler("addNotification", root, addNotification)

function MarkerHit(hitPlayer)
    if isElement(hitPlayer) and getElementType(hitPlayer) == "player" and hitPlayer == localPlayer then
        if not trabajando and isElementWithinMarker(hitPlayer, markerTrabajo) then
            addNotification("Para Empezar a Trabajar pon /trabajar", "info", true) 
            outputChatBox("/trabajar", 255, 0, 0)
        end
    end
end
addEventHandler("onClientMarkerHit", markerTrabajo, MarkerHit)
 
function starJob(player)
    if isElementWithinMarker(localPlayer, markerTrabajo) then
        if not trabajando then
            trabajando = true
            markerInicio = createMarker(1787.86255, -1886.16650, 13.39508-1, "cylinder", 3.0, 0, 0, 255, 255, false)
            addNotification("Bienvenido al Trabajo. Coje un Taxi para Empezar", "success", true) 
            addNotification("Recuerda el /dejar para dejar Trabajo", "info", true) 
            addEventHandler("onClientMarkerHit", markerInicio, Vehiclehit)
            isElementToDestroy(markerTrabajo)
        else
            addNotification("Ya Tienes este Trabajo", "warn", true) 
        end
    else
        addNotification("No Estas en el Marcador", "warn", true) 
    end
end
addCommandHandler("trabajar", starJob)

function Vehiclehit()
    if trabajando then
        triggerServerEvent("onVehicle", resourceRoot)
        addNotification("Sigue la Ruta para Empezar a Trabajar", "success", true)
        isElementToDestroy(markerInicio)
        createRecursiveMarker(index)
    end
end

local marcadores = {
    {1714.1564941406, -1809.943359375, 12.358455657959},
    {1633.8422851562, -1870.1185302734, 12.3828125},
    {1571.8957519531, -1816.0960693359, 12.3828125},
    {1621.2606201172, -1734.892578125, 12.3828125},
    {1751.4653320312, -1664.1198730469, 12.383814811707},
    {1818.8746337891, -1638.6666259766, 12.3828125},
    {1818.9927978516, -1763.1535644531, 12.3828125},
    {1817.3918457031, -1870.0146484375, 12.4140625}
}

function createRecursiveMarker(index)
    if index > #marcadores then
        return
    end
    
    local coor = marcadores[index]
    cor = createMarker(coor[1], coor[2], coor[3], "checkpoint", 4.0, 0, 0, 255, 255)
    blip = createBlip (coor[1], coor[2], coor[3],  0,  2,  255,  0,  0,  255,  0,  6383.0  )
    addEventHandler("onClientMarkerHit", cor, function(player)
        if player == getLocalPlayer() then
            isElementToDestroy(cor)
            isElementToDestroy(blip)
            triggerServerEvent("onmoney", resourceRoot)
            addNotification("Sigue Así", "success", true)
            createRecursiveMarker(index + 1)
            if index >= 8 then
                addNotification("Vuelve al Marcador", "info", true) 
                if not isElement(markerInicio) then
                    markerInicio = createMarker(1787.86255, -1886.16650, 13.39508-1, "cylinder", 3.0, 0, 0, 255, 150, false)
                    addEventHandler("onClientMarkerHit", markerInicio, Vehiclehit)
                    triggerServerEvent("onDestroyVehicle", resourceRoot)
                end
            end
        end
    end)
end

function Leave(player)
    if trabajando then
        trabajando = false
        isElementToDestroy(markerInicio)
        isElementToDestroy(cor)
        isElementToDestroy(blip)
        addNotification("Haz Dejado el Trabajo", "success", true) 
        markerTrabajo = createMarker(1758.50537, -1894.01099, 13.55594-1, "cylinder", 3.0, 0, 0, 255, 255, false)
        addEventHandler("onClientMarkerHit", markerTrabajo, MarkerHit)
        triggerServerEvent("onDestroyVehicle", resourceRoot)
    else
        addNotification("No Tienes este Trabajo", "error", true) 
    end
end
addCommandHandler("dejar", Leave)

function isElementToDestroy(element)
    if isElement(element) then
        destroyElement(element)
    end
end