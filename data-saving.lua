DATASAVE = {}

DATASAVE.dir = "mtsaves/"

function DATASAVE:DoesPathExist( path )
    if ( type( path ) ~= "string" ) then return false end 

    local response = os.execute( "cd " .. path )
    
    if ( response == true ) then
        return true
    end

    return false
end 

function DATASAVE:RunLaunchChecks()
    Citizen.Wait( 1000 ) -- just to reduce clutter in the console on startup 

    local exists = self:DoesPathExist( "mtsaves" )

    if ( not exists ) then 
        self:print( "mtsaves folder not found, attempting to create." )

        os.execute( "mkdir mtsaves" )
    else
        self:print( "mtsaves folder found!" )
    end 
end 

function DATASAVE:GetSteamId( source )
    local ids = GetPlayerIdentifiers( source )

    for k, v in pairs( ids ) do 
        local start = string.sub( v, 1, 5 )

        if ( start == "steam" ) then 
            return stringsplit( v, ":" )[2]
        end 
    end 

    return nil
end 

function DATASAVE:DoesFileExist( name )
    local dir = self.dir .. name
    local file = io.open( dir, "r" )

    if ( file ~= nil ) then 
        io.close( file )
        return true 
    else 
        return false 
    end 
end 

function DATASAVE:CreateFile( name )
    local dir = self.dir .. name

    local file, err = io.open( dir, 'w' )

    if ( not file ) then self:print( err ) end

    file:write( "{}" ) 
    file:close()
end 

function DATASAVE:LoadFile( name )
    local dir = self.dir .. name 

    local file, err = io.open( dir, 'rb' )

    if ( not file ) then self:print( err ) return nil end 

    local contents = file:read( "*all" )

    contents = json.decode( contents )

    file:close()

    return contents 
end 

function DATASAVE:WriteToFile( name, data, index )
    local dir = self.dir .. name

    local fileTable = self:LoadFile( name ) 

    if ( not fileTable ) then return end 

    if ( data == nil ) then 
        table.remove( fileTable, index ) -- table.remove reindexes all values after removing 
    else 
        fileTable[index] = data
    end 

    local fileString = json.encode( fileTable )

    local file, err = io.open( dir, 'w+' )

    if ( not file ) then self:print( err ) return end 

    file:write( fileString )
    file:close()
end 

function DATASAVE:SendSaveData( source )
    local id = self:GetSteamId( source )

    if ( id ~= nil ) then 
        local vehicleData = {}
        local skinData = {}

        local vehFileName = id .. "_vehicles.txt"
        local skinFileName = id .. "_skins.txt"

        vehicleData = self:LoadFile( vehFileName )
        skinData = self:LoadFile( skinFileName )

        if ( next( vehicleData ) ~= nil ) then 
            TriggerClientEvent( 'wk:RecieveSavedVehicles', source, vehicleData )
        end 

        if ( next( skinData ) ~= nil ) then 
            TriggerClientEvent( 'wk:RecieveSavedSkins', source, skinData )
        end 
    else 
        self:print( "Attempted to load save data for " .. GetPlayerName( source ) .. ", but does not have a steam id." ) 
    end 
end 

function DATASAVE:print( text )
    RconPrint( "MELLOTRAINER: " .. text .. "\n" )
end 

Citizen.CreateThread( function()
    DATASAVE:RunLaunchChecks()
end )

RegisterServerEvent( 'wk:AddPlayerToDataSave' )
AddEventHandler( 'wk:AddPlayerToDataSave', function()
    local id = DATASAVE:GetSteamId( source )
    
    if ( id ~= nil ) then 
        local vehFileName = id .. "_vehicles.txt"
        local skinFileName = id .. "_skins.txt"

        local exists = DATASAVE:DoesFileExist( vehFileName ) and DATASAVE:DoesFileExist( skinFileName )

        if ( exists ) then 
            DATASAVE:print( GetPlayerName( source ) .. " has a save file." )
            DATASAVE:SendSaveData( source )
        else 
            DATASAVE:print( GetPlayerName( source ) .. " does not have a save file, creating one." )

            DATASAVE:CreateFile( vehFileName )
            DATASAVE:CreateFile( skinFileName )
        end 
    else 
        DATASAVE:print( GetPlayerName( source ) .. " is not connecting with a steam id.\nPlayer will not have the ability to save/load." )
    end 
end )

RegisterServerEvent( 'wk:DataSave' )
AddEventHandler( 'wk:DataSave', function( type, data, index )
    local id = DATASAVE:GetSteamId( source )

    if ( id ~= nil ) then 
        local file = id .. "_" .. type .. ".txt"
        DATASAVE:WriteToFile( file, data, index )
    else 
        DATASAVE:print( GetPlayerName( source ) .. " attempted to save, but does not have a steam id." ) 
    end 
end )

function startsWith( string, start )
    return string.sub( string, 1, string.len( start ) ) == start
end

function stringsplit( inputstr, sep )
    if sep == nil then
        sep = "%s"
    end

    local t = {} ; i = 1
    
    for str in string.gmatch( inputstr, "([^" .. sep .. "]+)" ) do
        t[i] = str
        i = i + 1
    end

    return t
end