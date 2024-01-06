Config = {}

QBCore = exports['qb-core']:GetCoreObject()  -- uncomment if you use QBCore
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
    {
        name = 'T20',
        price = 1250, -- Price to rent
        url = 'https://oyster.ignimgs.com/mediawiki/apis.ign.com/grand-theft-auto-5/7/7d/T20.png'
    },
    {
        name = 'Asea',
        price = 250, -- Price to rent
        url = 'https://cdn.discordapp.com/attachments/870375951257731152/1191809812028215306/latest.png?ex=65a6ca61&is=65945561&hm=5fd640c7f72a08a53e91da17fa89a031f4a92787f2db27121699688d0939586f&',
    },
    {
        name = 'sentinel2',
        price = 450, -- Price to rent
        url = 'https://cdn.discordapp.com/attachments/1133534812704079964/1193246659459686410/latest.png?ex=65ac048d&is=65998f8d&hm=a732de7afd47637e435df5ed599abc5c70d93c634f9721ada7ffa7c1810f7822&',
    },
    {
        name = 'jackal',
        price = 525, -- Price to rent
        url = 'https://cdn.discordapp.com/attachments/1133534812704079964/1193246577561718794/latest.png?ex=65ac0479&is=65998f79&hm=775d039826097fd96e35978e9558b9dd69df03acaee91542941af1bb554ece11&',
    },
    {
        name = 'stalion2',
        price = 425, -- Price to rent
        url = 'https://cdn.discordapp.com/attachments/1133534812704079964/1193246509291020359/latest.png?ex=65ac0469&is=65998f69&hm=2eaec94ea3350cdf350a661cff78cdc5bfbb243bce05110589a0e41ea8743aa9&',
    },
    {
        name = 'everon',
        price = 750, -- Price to rent
        url = 'https://cdn.discordapp.com/attachments/1133534812704079964/1193246893342470297/latest.png?ex=65ac04c4&is=65998fc4&hm=976d3f21ef035c3641a898cc5896cb8d2afb66bc0a98559cfed1116960b4cf1e&',
    },
}