--
-- If there is an XML file for IRIS in directory, then we start the IRIS Server to do the screen repeating
-- Iris-Server.exe either needs to be pathed or be in the DCS program directory.
-- We also register an export stop routine to terminate the screen repeating.
-- 
local lAircraft = "FA-18C_hornet"
local PrevExport = {}
if Helios.aircraft == lAircraft and not Helios.vr then
	lfs = require('lfs')
	PrevExport.LuaExportStop = LuaExportStop
	local thisScript = debug.getinfo(1,'S').short_src:gsub("\\","/"):gsub("//","/"):match('^.*/(.*).([Ll][Uu][Aa])"]$')
	local thisPath = debug.getinfo(1,'S').short_src:gsub("\\","/"):gsub("//","/"):match('^.*"(.*/).*.([Ll][Uu][Aa]).*$')

	  Helios.log.write(thisScript,'Current path = ' .. thisPath)

		if Helios.debug then
			Helios.log.write(thisScript,string.format("Local Mod - Running " .. thisScript))
		end

	  -- Find an IRIS XML file
		for file in lfs.dir(thisPath) do
			--if file:match('(.*).[Ii][Rr][Ii][Ss].*$') ~= nil then 
			if file:match('(.*).([Ii][Rr][Ii][Ss])$') ~= nil then 
					Helios.log.write(thisScript,"Found XML file for Iris " .. thisPath .. file)
					local programPath = os.getenv("ProgramFiles(x86)"):gsub("\\","/") .. "/Iris Screen Exporter/"
					local OculusCheck = 'tasklist /FI "IMAGENAME eq OculusClient.exe" 2>nul | FIND /I /N "OculusClient.exe" >nul || '
					OculusCheck = ''
					-- os.execute can silently fail due to the number of parameters for the whole command.  Three parameters seems to be the limit (the command length seems less important)
					local lcmd = OculusCheck .. 'tasklist  2>nul | FIND /I /N "Iris-Server.exe" >nul || start "DCS Screen Repeater" /b /min "' .. programPath .. 'Iris-Server.exe" "' .. thisPath .. file ..'"'
					os.execute(lcmd)
					Helios.log.write(thisScript,lcmd)
					-- start the Iris Server if it is not already running
			end
		end	
end

function LuaExportStop()
os.execute('taskkill /FI "IMAGENAME eq Iris-server.exe"') -- Send Termination signal to the Iris-Server process
    if PrevExport.LuaExportStop  then
        PrevExport.LuaExportStop()
    end
end
