![Untitled-1](https://github.com/BuddyNotFound/bbv-rentacar/assets/74051918/1c729616-c2fd-41e7-b1ea-77b7306ede31)

---

**|  Preview : https://streamable.com/ua4gdx**
**|   Tebex : https://bbv.world**

---

**An Advanced Rent a Car script with UI** that allows you to easily add new cars using the config file. The script also enables players to test drive rental cars before they rent them. Server developers can set the test location and limit how far they can go and for how long they can test from the config. There is an option for 'Full Tuning Rental,' where all cars will be modified (inside and outside). You can also enable Car Limit (you will need to return your rental before renting another one) and CarBlip (it will show the rental car on your minimap).

**Script supports QBCore/ESX & Standalone Frameworks**
**Script supports QB/OX/BT & No Target**

Config Preview:

```
Config = {}

--QBCore = exports['qb-core']:GetCoreObject()  -- uncomment if you use QBCore
-- ESX = exports["es_extended"]:getSharedObject() -- uncomment if you use ESX

Config.Settings = {
    Framework = "ST", -- QB/ESX/ST - (ST = Standalone)
    Target = "OX", -- QB/OX/BT/ST - (ST = No Target)
    RentLocation = vector3(-895.22, -2585.96, 13.98),
    TestDriveLocation = vector4(-930.05, -3278.49, 13.94, 61.23),
    CarSpawn = vector4(-896.36, -2592.7, 13.16, 150.29),
    ReturnLocation = vector3(-879.71, -2601.51, 13.83),
    TestDriveTime = 60, -- For how long players can test drive a car.
    TestDriveLocationSize = 250, -- How far can a player go with a test drive car.
    MaxTune = true, -- If the rented cars are full tunning or no.
    LimitCars = true, -- If true players will be able to rent only 1 car and will have to return it to rent another one.
    CarBlip = true -- If true the rental car will be marked on the map.
}

Config.Cars = {
	{
		name = 'Elegy',
        price = 980, -- Price to rent
        url = 'https://cdn.discordapp.com/attachments/870375951257731152/1191809583350554746/elegy-retro-custom.png?ex=65a6ca2b&is=6594552b&hm=4df96bd3332e0ea3bf0edc3c53d11ff5facdb38c6afce33762df0114710dfd97&',
	},
}
```
