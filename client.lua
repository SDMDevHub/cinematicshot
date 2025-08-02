ESX = exports['es_extended']:getSharedObject()

local activeCam = nil

RegisterCommand("cinematiccamera", function(source, args)
    ESX.ShowNotification("Modalità Cinematica Attivata")
    local playerPed = PlayerPedId()
    local PlayerCoords = GetEntityCoords(playerPed)
    
    local offsetX = tonumber(args[1]) or 2.0
    local offsetY = tonumber(args[2]) or 2.0
    local offsetZ = tonumber(args[2]) or 1.0
    if activeCam ~= nil then
        RenderScriptCams(false, false, 0, true, true)
        DestroyCam(activeCam, false) -- Destroy the previous camera
        activeCam = nil
        end
    local cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
    SetCamCoord(cam, PlayerCoords.x + offsetX, PlayerCoords.y + offsetY,  PlayerCoords.z + offsetZ)
    PointCamAtEntity(cam, playerPed, 0.0, 0.0, 0.0, true)
    SetCamActive(cam, true)
    RenderScriptCams(true, false, 0, true, true)
end, false)


RegisterCommand("stopcam", function()
        ESX.ShowNotification("Modalità Cinematica Disattivata!")
        RenderScriptCams(false, false, 0, true, true)
        DestroyCam(cam, false)
        
end, false)


RegisterCommand("cinematicfollow", function()
   local playerPed = PlayerPedId()
   if not DoesCamExist(cam) then
    ESX.ShowNotification("Modalità Cinematica inseguimento Attivata")
    local cam = CreateCamera("DEFAULT_SCRIPTED_CAMERA", true)
    AttachCamToEntity(cam, playerPed, 1.0, 2.0, 1.0, true)
    SetCamRot(cam, 0.0, 0.0, 0.0, 2)
    SetCamActive(cam, true)
    RenderScriptCams(true, true, 1000, true, true)
   end
end, false)