
function addNotification(texto, tipo)
    exports.Notificaciones:addNotification(texto, tipo, true)
end
addEvent("addNotification", true)
addEventHandler("addNotification", root, addNotification)



local marker = createMarker(1758.50537, -1894.01099, 13.55594-1, "cylinder", 3.0, 0, 0, 255, 255, false)

local isPlayerInMarker = false
local trabajo = false

function MarkerHit(hitPlayer)
    if isElement(hitPlayer) and getElementType(hitPlayer) == "player" and hitPlayer == localPlayer then
        if not trabajo then
        isPlayerInMarker = true
        addNotification("Para Empezar a Trabajar pon /trabajar", "info", true) 
        outputChatBox("/trabajar", 255, 0, 0)
        end
    end
end
addEventHandler("onClientMarkerHit", marker, MarkerHit)
 

function LeaveHit()
    isPlayerInMarker = false
end
addEventHandler ( "onClientMarkerLeave", marker, LeaveHit )



function Command(player)
    if isPlayerInMarker then
        if not trabajo then
        addNotification("Bienvenido al Trabajo. Coje un Taxi para Empezar", "success", true) 
        addNotification("Recuerda el /dejar para dejar Trabajo", "info", true) 
        outputChatBox("/dejar para dejar Trabajo", 0,255,0)
        trabajo = true
        hola = createMarker(1787.86255, -1886.16650, 13.39508-1, "cylinder", 3.0, 0, 0, 255, 255, false)
        addEventHandler("onClientMarkerHit", hola, Vehiclehit)
        if isElement(marker) then
            destroyElement(marker)
            marker = nil 
        end
        else
            addNotification("Ya Tienes este Trabajo", "warn", true) 
        end
    else
        addNotification("No Estas en el Marcador", "warn", true) 
    end
end
addCommandHandler("trabajar", Command)


function Vehiclehit()
    if trabajo then
        triggerServerEvent("onVehicle", root)
        addNotification("Sigue la Ruta para Empezar a Trabajar", "success", true)
        destroyElement(hola)
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

local habi = createMarker(1787.86255, -1886.16650, 13.39508-1, "cylinder", 3.0, 0, 0, 0, 0, false)
local index = 1
local cor = nil
local bli = 1

function createRecursiveMarker(index)

    if index > #marcadores then
        return -- Si el índice supera el número de marcadores, se detiene la recursión
    end

    
    local coor = marcadores[index]
    cor = createMarker(coor[1], coor[2], coor[3], "checkpoint", 4.0, 0, 0, 255, 255)
    blip = createBlip (coor[1], coor[2], coor[3],  0,  2,  255,  0,  0,  255,  0,  6383.0  )
    addEventHandler("onClientMarkerHit", cor, function(player)
        if player == getLocalPlayer() then
            destroyElement(cor)
            destroyElement(blip)
            triggerServerEvent("onmoney", root)
            addNotification("Sigue Así", "success", true)
            createRecursiveMarker(index + 1) -- Llamada recursiva para crear el siguiente marcador
            if index >= 8 then
                addNotification("Vuelve al Marcador", "info", true) 
                if not isElement(hola) then
                    hola = createMarker(1787.86255, -1886.16650, 13.39508-1, "cylinder", 3.0, 0, 0, 255, 150, false)
                    addEventHandler("onClientMarkerHit", hola, Vehiclehit)
                end
            end
        end
    end)
end

-- Evento inicial para comenzar el proceso

function Activar()
    if trabajo then
        createRecursiveMarker(index)
    else
        return
    end
end
addEventHandler("onClientMarkerHit", habi, Activar)


function Leave(player)
    if trabajo then
        trabajo = false
            destroyElement(hola)
            destroyElement(cor)
            destroyElement(blip)
            addNotification("Haz Dejado el Trabajo", "success", true) 
                marker = createMarker(1758.50537, -1894.01099, 13.55594-1, "cylinder", 3.0, 0, 0, 255, 255, false)
                addEventHandler("onClientMarkerHit", marker, MarkerHit)
                triggerServerEvent("onDestroyVehicle", root)
        else
            addNotification("No Tienes este Trabajo", "error", true) 
        end
end
addCommandHandler("dejar", Leave)