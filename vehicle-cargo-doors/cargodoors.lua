RegisterKeyMapping("cargodoor", "Toggle Cargo Doors", "keyboard", "Y")

-- Config
local commandName = "cargodoor" -- Command
local vehicleWhitelist = {"cv22b", "mh47g", "mh60k", "uh60v", "f14a", "f14d2", "ch47d"} -- Vehicle Whitelist

local function isVehicleWhitelisted(vehicleName)
    for _, whitelistedVehicle in ipairs(vehicleWhitelist) do
        if string.lower(vehicleName) == string.lower(whitelistedVehicle) then
            return true
        end
    end
    return false
end

RegisterCommand(commandName, function(source, args, rawCommand)
    ToggleDoor()
end, false)

function DisplayNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end

function ToggleDoor()
    local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)

    if DoesEntityExist(vehicle) and isVehicleWhitelisted(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))) then
        SetVehicleDoorShut(vehicle, 2, false) -- Door 3
        SetVehicleDoorShut(vehicle, 3, false) -- Door 4

        local isDoor3Open = GetVehicleDoorAngleRatio(vehicle, 2) > 0.0
        local isDoor4Open = GetVehicleDoorAngleRatio(vehicle, 3) > 0.0

        if not isDoor3Open and not isDoor4Open then
            SetVehicleDoorOpen(vehicle, 2, false, false) -- Open Door 3
            SetVehicleDoorOpen(vehicle, 3, false, false) -- Open Door 4
        else
            SetVehicleDoorShut(vehicle, 2, false) -- Close Door 3
            SetVehicleDoorShut(vehicle, 3, false) -- Close Door 4
        end

        DisplayNotification("Cargo doors toggled!") -- Opening/Closing Doors
    else
        DisplayNotification("You are not in a whitelisted vehicle.") -- Whitelist Messages
    end
end
