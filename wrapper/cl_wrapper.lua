
Wrapper = {
    resname = GetCurrentResourceName(),
    blip = {},
    cam = {},
    zone = {},
    cars = {},
    object = {},
    ServerCallbacks = {}
}

-- RESETS

AddEventHandler("onResourceStop", function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
      return
    end
    for k,v in pairs(Wrapper.cars) do 
        DeleteVehicle(v)
    end
end)

-- ^ RESETS

-- Target

function Wrapper:Target(id,label,pos,event,type) -- QBTarget target create
    if Config.Settings.Target == "QB" then 
        local sizex = 1
        local sizey = 1
        exports["qb-target"]:AddBoxZone(id, pos, sizex, sizey, {
            name = id,
            heading = "90.0",
            minZ = pos - 5,
            maxZ = pos + 5
        }, {
            options = {
                {
                    type = "client",
                    event = event,
                    icon = "fas fa-button",
                    label = label,
                }
            },
            distance = 1.5
        })
    end
    if Config.Settings.Target == "OX" then
        Wrapper.zone[id] = exports["ox_target"]:addBoxZone({ -- -1183.28, -884.06, 13.75
        coords = vec3(pos.x,pos.y,pos.z - 1),
        size = vec3(1, 1, 1),
        rotation = 45,
        debug = false,
        options = {
            {
                name = id,
                event = event,
                icon = "fa-solid fa-cube",
                label = label,
            },
        }
    })
    end
    if Config.Settings.Target == "BT" then 
        local _id = id
        exports["bt-target"]:AddBoxZone(_id, vector3(pos.x,pos.y,pos.z), 0.4, 0.6, {
            name=_id,
            heading=91,
            minZ = pos.z - 1,
            maxZ = pos.z + 1
            }, {
                options = {
                    {
                        type = "client",
                        event = event,
                        icon = "fa-solid fa-cube",
                        label = label,
                    },
                },
                distance = 1.5
            })
    end
    if Config.Settings.Target == "ST" then 
        TriggerEvent('bbv-objects:sttarget',id,label,pos,event,remove,type)
    end
end

function Wrapper:TargetRemove(sendid) -- Remove QBTarget target
    if Config.Settings.Target == "QB" then 
        exports["qb-target"]:RemoveZone(sendid)
    end 
    if Config.Settings.Target == "OX" then 
        exports["ox_target"]:removeZone(Wrapper.zone[sendid])
    end
    if Config.Settings.Target == "BT" then 
        exports["bt-taget"]:RemoveZone(sendid)
    end
    return
end

RegisterNetEvent('bbv-objects:sttarget',function(id,label,pos,event,remove,type)
    local WaitTime = 3000
    while true do 
        Wait(WaitTime)
        local mypos = GetEntityCoords(PlayerPedId())
        local dist = #(pos - mypos)
        if dist < 1.5 then 
            WaitTime = 0
            Wrapper:Draw3DText(pos,'[E] Interact',4,0.05,0.05)
            if IsControlJustReleased(0,46) then
                TriggerEvent(event)
            end
        else
            WaitTime = 3000
        end
    end
end)

function Wrapper:Draw3DText(pos,textInput,fontId,scaleX,scaleY)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, pos.x,pos.y,pos.z, 1)    
    local scale = (1/dist)*20
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov   
    SetTextScale(scaleX*scale, scaleY*scale)
    SetTextFont(fontId)
    SetTextProportional(1)
    SetTextColour(250, 250, 250, 255)		-- You can change the text color here
    SetTextDropshadow(1, 1, 1, 1, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(textInput)
    SetDrawOrigin(pos.x,pos.y,pos.z, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end

-- ^ Target



function Wrapper:LoadModel(model) -- Load Model
    local modelHash = model
    RequestModel(modelHash)
    while not HasModelLoaded(modelHash) do
      Wait(0)
    end
end

-- ^ OBJECT


-- Blip

function Wrapper:Blip(id,label,pos,sprite,color,scale) -- Create Normal Blip on Map
    Wrapper.blip[id] = AddBlipForCoord(pos.x, pos.y, pos.z)
    SetBlipSprite(Wrapper.blip[id], sprite)
    SetBlipDisplay(Wrapper.blip[id], 4)
    SetBlipScale(Wrapper.blip[id], 0.8)
    SetBlipAsShortRange(Wrapper.blip[id], false)
    SetBlipColour(Wrapper.blip[id], color)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName(label)
    EndTextCommandSetBlipName(Wrapper.blip[id])
    return
end
function Wrapper:RemoveBlip(id)
    RemoveBlip(Wrapper.blip[id])
end

-- ^ Blip


-- REMOVE

function Wrapper:RemoveMoney(type,amount)
    TriggerServerEvent(Wrapper.resname.."Wrapper:RemoveMoney",type,amount)
end


-- ^ REMOVE


-- Notify

function Wrapper:Prompt(msg) --Msg is part of the Text String at B
	SetTextComponentFormat("STRING")
	AddTextComponentString(msg) -- B
	DisplayHelpTextFromStringLabel(0,0,1,-1) -- Look on that website for what these mean, I forget. I think one is about flashing or not
end

function Wrapper:Notify(txt,tp,time) -- QBCore notify
    if Config.Settings.Framework == "QB" then 
        QBCore.Functions.Notify(txt, tp, time)
    end
    if Config.Settings.Framework == "ESX" then 
        ESX.ShowNotification(txt)
    end
    if Config.Settings.Framework == "ST" then 
        self:Alert(txt)
    end
end

function Wrapper:Alert(msg) --Msg is part of the Text String at B
	SetNotificationTextEntry("STRING")
	AddTextComponentString(msg) -- B
	DrawNotification(true, false) -- Look on that website for what these mean, I forget. I think one is about flashing or not
end

-- ^ Notify
