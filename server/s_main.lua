local QBCore = export["qb-core"]:GetCoreObjects()

RegisterNetEvent('ktrp-leoshop:server:buyLeoVehicle', function(vehData,paymentMethod)
    local src = source
    vehicle = vehData.spawnName
    local pData = QBCore.Functions.GetPlayer(src)
    local cid = pData.PlayerData.citizenid                                
    local cash = pData.PlayerData.money['cash']
    local bank = pData.PlayerData.money['bank']
    local vehiclePrice = vehData.price
    local plate = GeneratePlate()
    if paymentMethod == "cash" and cash > tonumber(vehiclePrice) then
        MySQL.insert('INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, garage, state) VALUES (?, ?, ?, ?, ?, ?, ?, ?)', {
            pData.PlayerData.license,
            cid,
            vehicle,
            GetHashKey(vehicle),
            '{}',
            plate,
            'police',
            0
        })
        TriggerClientEvent('QBCore:Notify', src, vehData.name.."Purchase Successful", 'success')
        TriggerClientEvent('qb-vehicleshop:client:buyShowroomVehicle', src, vehicle, plate)
        pData.Functions.RemoveMoney('cash', vehiclePrice, 'vehicle-bought-in-LeoShop')
    else
        TriggerClientEvent('QBCore:Notify', src, "You Don't have enough Money in Hand", 'error')
    end
    if paymentMethod == "bank" and bank > tonumber(vehiclePrice) then
        MySQL.insert('INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, garage, state) VALUES (?, ?, ?, ?, ?, ?, ?, ?)', {
            pData.PlayerData.license,
            cid,
            vehicle,
            GetHashKey(vehicle),
            '{}',
            plate,
            'police',
            0
        })
        TriggerClientEvent('QBCore:Notify', src, vehData.name.."Purchase Successful", 'success')
        TriggerClientEvent('qb-vehicleshop:client:buyShowroomVehicle', src, vehicle, plate)
        pData.Functions.RemoveMoney('bank', vehiclePrice, 'vehicle-bought-in-LeoShop')
    else
        TriggerClientEvent('QBCore:Notify', src, "You Don't have enough Money in Bank", 'error')
    end
end)