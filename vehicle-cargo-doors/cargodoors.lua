-- Config
RegisterKeyMapping("cargodoor", "Toggle Cargo Doors", "keyboard", "Y")
RegisterKeyMapping("bombbay", "Toggle Bomb Bays", "keyboard", "B")
local doorCommandName = "cargodoor" -- Command for cargo doors
local bombBayCommandName = "bombbay" -- Command for bomb bays
local vehicleWhitelist = {"cv22b", "mh47g", "mh60k", "uh60v", "f14a", "f14d2", "ch47d"} -- Cargo Door Whitelist
local bombBayWhitelist = {"bombushka", "f22a"} -- Bomb bay whitelist

-- Function to check if a vehicle is whitelisted
local function isVehicleWhitelisted(vehicleName, whitelist)
    for _, whitelistedVehicle in ipairs(whitelist) do
        if string.lower(vehicleName) == string.lower(whitelistedVehicle) then
            return true
        end
    end
    return false
end

-- Command to toggle cargo doors
RegisterCommand(doorCommandName, function(source, args, rawCommand)
    ToggleDoor()
end, false)

-- Command to toggle bomb bays
RegisterCommand(bombBayCommandName, function(source, args, rawCommand)
    BombBayControl()
end, false)

-- Function to display notifications
function DisplayNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end

-- Function to toggle cargo doors
function ToggleDoor()
    local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)

    if DoesEntityExist(vehicle) and isVehicleWhitelisted(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)), vehicleWhitelist) then
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

-- Function to control bomb bays
function BombBayControl()
    local playerPed = GetPlayerPed(-1)
    if (IsPedSittingInAnyVehicle(playerPed)) then
        local vehicle = GetVehiclePedIsIn(playerPed, false)

            if isVehicleWhitelisted(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)), bombBayWhitelist) then
                if AreBombBayDoorsOpen(vehicle, bombBayIndex) then
                    CloseBombBayDoors(vehicle, bombBayIndex)
                    DisplayNotification("Bomb bays closed!")
                else
                    OpenBombBayDoors(vehicle, bombBayIndex)
                    DisplayNotification("Bomb bays opened!")
                end
            else
                DisplayNotification("You are not in a whitelisted vehicle, or this vehicle does not have bomb bays.") -- Whitelist Messages
            end
    else
        DisplayNotification("You are not in a vehicle.")
    end
end
