
function addNotification(texto, tipo)
    exports.Notificaciones:addNotification(texto, tipo, true)
end
addEvent("addNotificationbike", true)
addEventHandler("addNotificationbike", root, addNotification)



--aca puedes agregar mas lugares

local mundo = {
    {1143.95398, -1426.31018, 15.79688-1},
    {-777.07721, 2746.52954, 45.69983-1}
}

    for _, tasa in pairs(mundo) do 
        local puntoss = createMarker(tasa[1], tasa[2], tasa[3], "cylinder", 1.5, 255, 255, 0, 170)
        addEventHandler("onClientMarkerHit", puntoss, function(hitElement)
            if hitElement == localPlayer then
                Panel() 
            end
        end)
    end



loadstring(exports.dxlibrary:dxGetLibrary())()

local sx, sy = guiGetScreenSize()
local sw, sh = sx/1920, sy/1080

function Panel()

    ventanas = dxWindow(670*sw, 389*sh, 587*sw, 259*sh, 'Panel de Renta de Bicicletas', false, 7, nil, -15856105, -1, -15856105)
    Comprar = dxButton(687*sw, 541*sh, 223*sw, 83*sh, 'Comprar', ventanas, 9, -12177770, -1, -12506991)
    Cancelar = dxButton(1013*sw, 536*sh, 223*sw, 83*sh, 'Cancelar', ventanas, 9, -12177770, -1, -12506991)
    memoo = dxMemo(745*sw, 420*sh, 432*sw, 99*sh, 'Puedes Rentar Bicicletas por 10 Minutos. Precio $2500', ventanas, false)
    showCursor(true)
    
    addEventHandler("onClick", Comprar, function()
        triggerServerEvent("onServerBikes", resourceRoot)   
        showCursor(false)
        destroyElement(ventanas)
    end, false)

    addEventHandler("onClick", Cancelar, function()
        destroyElement(ventanas) 
        showCursor(false)     
end, false)

end


