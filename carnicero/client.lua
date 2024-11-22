function addNotification(texto, tipo)
    exports.Notificaciones:addNotification(texto, tipo, true)
end
addEvent("addNotificationcar", true)
addEventHandler("addNotificationcar", root, addNotification)


-- Obtener las dimensiones de la pantalla
local screenWidth, screenHeight = guiGetScreenSize()

-- Función para mostrar mensajes en pantalla
function displayHUD()
    local isEntering = getElementData(localPlayer, "isEntering") or false
    local interior = getElementInterior(localPlayer)

    if interior == 1 then
        -- Mostrar experiencia del jugador
        local playerExp = getElementData(localPlayer, "exp") or 0
        dxDrawText("Experiencia: " .. playerExp, 10, screenHeight - 60, screenWidth, screenHeight, tocolor(255, 255, 255, 255), 1.2, "default-bold")
    end

    if isEntering then
        dxDrawText("¡Bienvenido!", 0, 0, screenWidth, screenHeight - 20, tocolor(255, 255, 255, 255), 1.5, "pricedown", "center", "bottom")
    end
end
addEventHandler("onClientRender", root, displayHUD)

-- Restablecer animación después de recoger carne
function resetPlayerAnimation()
    setPedAnimation(localPlayer)
end
addEvent("resetPlayerAnimation", true)
addEventHandler("resetPlayerAnimation", root, resetPlayerAnimation)

loadstring(exports.dxlibrary:dxGetLibrary())()

local sx, sy = guiGetScreenSize()
local sw, sh = sx/1920, sy/1080

function PanelCar()
    ventanas = dxWindow(6*sw, 295*sh, 367*sw, 545*sh, 'Trabajo de Carnicero', false, 7, 3, -15856105, -1, -15856105)
    trabajar = dxButton(102*sw, 536*sh, 181*sw, 89*sh, 'Trabajar', ventanas, 7, -16318976, -1, -12506991)
    cancelar = dxButton(101*sw, 681*sh, 181*sw, 89*sh, 'Cancelar', ventanas, 7, -196608, -1, -12506991)
    mensaje = dxMemo(52*sw, 345*sh, 270*sw, 142*sh, 'Bienvenido al Trabajo de Carnicero para Empezar a Trabajar unde el Boton Trabajar y Empieza a Cortar', ventanas, false)
    showCursor(true)
        addEventHandler ( "onClick", trabajar, function()
            destroyElement(ventanas)
            showCursor(false)
            triggerServerEvent("onJob", resourceRoot)
            addNotification("Felicidades: Ahora Trabajas como Carnicero", "success", true) 
        end)
    
        addEventHandler ( "onClick", cancelar, function()
            showCursor(false)
            destroyElement(ventanas)
            outputChatBox("Hasta Pronto", 255,0,0)
            addNotification("Hasta Pronto", "warn", true) 
    end)
end
addEvent("PanelCar", true)
addEventHandler("PanelCar", root, PanelCar)

function ondejJob()
    ventanas = dxWindow(6*sw, 295*sh, 367*sw, 545*sh, 'Trabajo de Carnicero', false, 7, 3, -15856105, -1, -15856105)
    cance = dxButton(101*sw, 681*sh, 181*sw, 89*sh, 'Cancelar', ventanas, 7, -196608, -1, -12506991)
    dejar = dxButton(102*sw, 536*sh, 181*sw, 89*sh, 'Dejar de Trabajar', ventanas, 7, -16318976, -1, -12506991)
    mensaje = dxMemo(52*sw, 345*sh, 270*sw, 142*sh, 'Hola como Va tu Dia? Quieres Dejar de Trabajar?', ventanas, false)
    showCursor(true)
        addEventHandler ( "onClick", dejar, function()
            destroyElement(ventanas)
            showCursor(false)
            triggerServerEvent("ondej", resourceRoot)
            addNotification("Lamentamos que te Vayas", "error", true) 
        end)
    
        addEventHandler ( "onClick", cance, function()
            showCursor(false)
            destroyElement(ventanas)
    end)
end
addEvent("ondejob", true)
addEventHandler("ondejob", resourceRoot, ondejJob)
