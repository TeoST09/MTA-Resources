-- Definir posiciones donde se ubicarán los objetos de carne
local meatPositions = {
    {955.969, 2142.139, 1011.023},
    {955.969, 2133.230, 1011.023},
    {956.969, 2125.894, 1011.023},
}



local meatMarkers = {}
local meatObjects = {}

-- Crear marcadores para entrada, salida y entrega de carne
local exitMarker = createMarker(965.377, 2108.729, 1010.030, "cylinder", 2, 255, 0, 0, 255)
local entranceMarker = createMarker(-90.270, -9.841, 2.109, "cylinder", 2, 255, 0, 0, 255)
local deliveryMarker = createMarker(942.944, 2117.574, 1010.030, "cylinder", 2, 255, 0, 0, 255)
local inicio = createMarker ( 961.05261, 2099.84497, 1011.02515-1,  "cylinder", 2,  0,  0, 255,  255 )

-- Establecer el interior para los marcadores correspondientes
setElementInterior(exitMarker, 1)
setElementInterior(inicio, 1)
setElementInterior(deliveryMarker, 1)

local blia = createBlip ( -90.270, -9.841, 2.109 , 0,  2, 255,  0,0, 255, 0,16383.0  )
-- Función para manejar la salida del interior
function onExitMarkerHit(hitElement)
    if getElementType(hitElement) == "player" then
        setElementPosition(hitElement, -87.752, -10.551, 3.109)
        setElementInterior(hitElement, 0)
    end
end
addEventHandler("onMarkerHit", exitMarker, onExitMarkerHit)
player = client


local jobde

function trabajot(hitElement)

    if getElementType(hitElement) == "player" then
        outputChatBox("Bienvenido al Trabajo de Carnicero", hitElement, 0,0,255)
        triggerClientEvent(hitElement, "PanelCar", resourceRoot)
    end
end
addEventHandler("onMarkerHit", (inicio), trabajot)

local job = false
function onJob()
    if not job then
        job = true
        outputChatBox("Genial, Haz Empezado a Trabajar Aqui")
        if isElement(inicio) then
        destroyElement(inicio)
        end
        if isElement(inicioo) then
            destroyElement(inicioo)
        end
        jobde = createMarker(962.73950, 2101.94678, 1011.02722 - 1, "cylinder", 2, 0, 240, 255, 51 )
        if jobde then
        addEventHandler("onMarkerHit", (jobde), ondejob)
        setElementInterior(jobde, 1)
        end
    else
    end
end
addEvent("onJob", true) -- 2nd argument should be set to true, in order to be triggered from counter side (in this case client-side)
addEventHandler("onJob", resourceRoot, onJob)

function dejarjob()
    if job then
        if isElement(jobde) then
             destroyElement(jobde) 
             jobde = nil 
             outputChatBox("El marcador del trabajo ha sido destruido.", root, 255, 255, 0) 
            else 
            outputChatBox("No hay marcador de trabajo activo para destruir.", root, 255, 0, 0)
        end
        job = false
        inicioo = createMarker(961.05261, 2099.84497, 1011.02515 - 1, "cylinder", 2, 0, 0, 255, 255)
        addEventHandler("onMarkerHit", (inicioo), trabajot)
        setElementInterior(inicioo, 1)
        outputChatBox("Hasta pronto", root, 255, 255, 0)
    else
        outputChatBox("No tienes un trabajo activo.", root, 255, 0, 0)
    end
end
addEvent("ondej", true)
addEventHandler("ondej", resourceRoot, dejarjob)



function onEntranceMarkerHit(hitElement)
    if getElementType(hitElement) == "player" then
        setElementData(hitElement, "isEntering", true)
        setElementInterior(hitElement, 1)
        setElementPosition(hitElement, 962.065, 2108.585, 1011.030)
        setTimer(function()
            if isElement(hitElement) then
                setElementData(hitElement, "isEntering", false)
            end
        end, 5000, 1)
    end
end
addEventHandler("onMarkerHit", entranceMarker, onEntranceMarkerHit)

-- Función para manejar la entrega de la carne
function onDeliveryMarkerHit(hitElement)
    if not job then
        outputChatBox("no Tienes este Trabajo", hitElement,255,0,0)
        return
    end

    if getElementType(hitElement) == "player" then
        local hasMeat = getElementData(hitElement, "hasMeat") or false
        if hasMeat then
            outputChatBox("✅ Has entregado la carne correctamente. ¡Buen trabajo!", hitElement, 0, 255, 0)
            givePlayerMoney(hitElement, 5000)
            local playerExp = getElementData(hitElement, "exp") or 0
            setElementData(hitElement, "exp", playerExp + 2)
            local moneyIncrease = 10
            givePlayerMoney(hitElement, moneyIncrease) 
            setElementData(hitElement, "hasMeat", false)

            -- Eliminar el objeto de carne adjunto al jugador
            local meatObject = getElementData(hitElement, "meatObject")
            if isElement(meatObject) then
                destroyElement(meatObject)
                setElementData(hitElement, "meatObject", nil)
            end

            -- Opcional: reproducir una animación de celebración
            setPedAnimation(hitElement, "SHOP", "SHP_Thank", -1, false, false, false, false)

        else
            outputChatBox("❌ No tienes carne para entregar.", hitElement, 255, 0, 0)
        end
    end
end
addEventHandler("onMarkerHit", deliveryMarker, onDeliveryMarkerHit)

-- Función para crear los objetos y marcadores de carne
function createMeatObjects()
    for i, pos in ipairs(meatPositions) do
        local x, y, z = unpack(pos)
        local meatObject = createObject(2806, x, y, z)
        setElementInterior(meatObject, 1)
        setElementCollisionsEnabled(meatObject, true) -- Las colisiones del objeto en el suelo están activadas

        local meatMarker = createMarker(x, y, z - 1, "cylinder", 2, 255, 0, 0, 50)
        setElementInterior(meatMarker, 1)
        setElementData(meatMarker, "isMeat", true)
        setElementData(meatMarker, "isAvailable", true)
        meatMarkers[i] = meatMarker
        meatObjects[meatMarker] = meatObject
        addEventHandler("onMarkerHit", meatMarker, function(hitElement)
            if getElementType(hitElement) == "player" then
                pickUpMeat(hitElement)
            end
        end)
    end
end
createMeatObjects()

-- Función para recoger la carne
function pickUpMeat(player)
    local isNearMeat = false
    if not job then
        outputChatBox("No Tienes el Trabajo de Carnicero",player, 255,0,0)
        return
    end

    for _, meatMarker in ipairs(meatMarkers) do
        if isElementWithinMarker(player, meatMarker) then
            isNearMeat = true
            local hasMeat = getElementData(player, "hasMeat") or false
            local isAvailable = getElementData(meatMarker, "isAvailable") or false
            if isAvailable then
                if not hasMeat then
                    setElementData(player, "hasMeat", true)
                    outputChatBox("🧺 Has recogido la carne. Llévala al punto de entrega.", player, 0, 255, 0)
                    setElementData(meatMarker, "isAvailable", false)
                    
                    -- Crear un nuevo objeto de carne y adjuntarlo al jugador
                    local meatObject = createObject(2806, 0, 0, 0)
                    setElementInterior(meatObject, getElementInterior(player))
                    setElementDimension(meatObject, getElementDimension(player))
                    attachElements(meatObject, player, 0, 0.5, 0, 0, 0, 0)
                    setElementData(player, "meatObject", meatObject)
                    setElementCollisionsEnabled(meatObject, false) -- Desactivar colisiones del objeto

                    -- Reproducir animación de recogida
                    setPedAnimation(player, "CARRY", "liftup", 1000, false, false, false, false)

                    -- Restaurar la disponibilidad del marcador después de un tiempo
                else
                    outputChatBox("⚠️ Ya tienes carne. Entrégala antes de recoger más.", player, 255, 255, 0)
                end
            else
                outputChatBox("⏳ No hay carne disponible aquí en este momento.", player, 255, 165, 0)
            end
            break
        end
    end
    if not isNearMeat then
        outputChatBox("ℹ️ No estás cerca de ningún punto de recogida de carne.", player, 200, 200, 200)
    end
end
addEventHandler("onMarkerHit", (meatMarker), pickUpMeat)



function ondejob(hitElement)
    if getElementType(hitElement) == "player" then
        triggerClientEvent(hitElement, "ondejob", resourceRoot)
    end
end


