-- DO NOT TOUCHY, CONTACT Michael G/TheStonedTurtle if anything is broken.
-- DO NOT TOUCHY, CONTACT Michael G/TheStonedTurtle if anything is broken.
-- DO NOT TOUCHY, CONTACT Michael G/TheStonedTurtle if anything is broken.
-- DO NOT TOUCHY, CONTACT Michael G/TheStonedTurtle if anything is broken.
-- DO NOT TOUCHY, CONTACT Michael G/TheStonedTurtle if anything is broken.


--    _______ _                    ____        _   _                 
--   |__   __(_)                  / __ \      | | (_)                
--      | |   _ _ __ ___   ___   | |  | |_ __ | |_ _  ___  _ __  ___ 
--      | |  | | '_ ` _ \ / _ \  | |  | | '_ \| __| |/ _ \| '_ \/ __|
--      | |  | | | | | | |  __/  | |__| | |_) | |_| | (_) | | | \__ \
--      |_|  |_|_| |_| |_|\___|   \____/| .__/ \__|_|\___/|_| |_|___/
--                                      | |                          
--                                      |_|                          

RegisterServerEvent('mellotrainer:adminTime')
AddEventHandler('mellotrainer:adminTime', function(from, hour, minutes, seconds)
	TriggerClientEvent('mellotrainer:updateTime', -1, hour, minutes, seconds)
end)



-- __          __        _   _                  ____        _   _                 
-- \ \        / /       | | | |                / __ \      | | (_)                
--  \ \  /\  / /__  __ _| |_| |__   ___ _ __  | |  | |_ __ | |_ _  ___  _ __  ___ 
--   \ \/  \/ / _ \/ _` | __| '_ \ / _ \ '__| | |  | | '_ \| __| |/ _ \| '_ \/ __|
--    \  /\  /  __/ (_| | |_| | | |  __/ |    | |__| | |_) | |_| | (_) | | | \__ \
--     \/  \/ \___|\__,_|\__|_| |_|\___|_|     \____/| .__/ \__|_|\___/|_| |_|___/
--                                                   | |                          
--                                                   |_|                          

RegisterServerEvent('mellotrainer:adminWeather')
AddEventHandler('mellotrainer:adminWeather', function(from, weatherState, persistToggle)
	TriggerClientEvent('mellotrainer:updateWeather', -1, weatherState, persistToggle)
end)


RegisterServerEvent('mellotrainer:adminBlackout')
AddEventHandler('mellotrainer:adminBlackout', function(from, toggle)
	TriggerClientEvent('mellotrainer:updateBlackout', -1, toggle)
end)




RegisterServerEvent('mellotrainer:adminWind')
AddEventHandler('mellotrainer:adminWind', function(from, state, heading)
	TriggerClientEvent('mellotrainer:updateWind', -1, state, heading)
end)