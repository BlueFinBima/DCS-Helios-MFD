_  = function(p) return p; end;
local aircraft = "FA-18C_hornet"
local hDisplay = {{id=1,width=3440},{id=3,width=2560},{id=2,width=900}}

name = _( aircraft .. ' Config');
Description = aircraft .. ' Config Incl Aircraft Specific viewports'
local x0=0
local y0=0
local reconfigure_for_unit = nil
local function configure_displays() 
	if  displays and #displays == 3 then
		-- the order of the monitors in the displays table can differ so locals are used
		--
		--    +-------------------------+  +-------------+  +-----+
		--    |                         |  |             |  |     |	
		--    |             ?           |  |      ?      |  |  ?  |
		--    |                         |  |             |  |     |
		--    +-------------------------+  +-------------+  +-----+
		--
		--  The virtual display is used to export instruments so that they do not take up
		--  monitor real estate, but can be captured by IRIS to be sent over the network.
		--  For better use of video memory, the virtual screen 1440 x 900 is in portrait
		--

		-- for i = 1,#displays,1
		-- do
			-- table.insert(hDisplay,{id=i,width=displays[i].width});
		-- end
		-- table.sort(hDisplay,function(a,b) return a.width>b.width end);  -- sort in descending width order to get correct display number
		
		primary = 
		{
			x 		= 0;
			y 		= 0;
			width   = displays[hDisplay[1].id].width;
			height  = displays[hDisplay[1].id].height;
			aspect  = displays[hDisplay[1].id].width/displays[hDisplay[1].id].height;
			viewDx  = 0;
			viewDy  = 0;
		}
		GUI=
		{
			x 		= displays[hDisplay[1].id].width;
			y 		= 0;
			width   = displays[hDisplay[2].id].width-1000;
			height  = displays[hDisplay[2].id].height;
			aspect  = (displays[hDisplay[2].id].width-1000)/displays[hDisplay[2].id].height;
			viewDx  = 1;
			viewDy  = 0;
		}
		GHOST=
		{
			x 		= displays[hDisplay[1].id].width + displays[hDisplay[2].id].width;
			y 		= 0;
			width   = displays[hDisplay[3].id].width;
			height  = displays[hDisplay[3].id].height;
			aspect  = displays[hDisplay[3].id].width/displays[hDisplay[3].id].height;
			viewDx  = 2;
			viewDy  = 0;     
		}

		x0 = GHOST.x ;
		y0 = GHOST.y;
		-- placement is for a 900x1440 (portrait) screen
		
		if aircraft ~= nil then reconfigure_for_unit(aircraft) end
		UIMainView = GUI
		GU_MAIN_VIEWPORT = primary
		Viewports = {primary}

		else
		primary =
		{
			x = 0;
			y = 0;
			width = screen.width;
			height = screen.height;
			viewDx = 0;
			viewDy = 0;
			aspect = screen.aspect;
		}
		UIMainView = primary
		GU_MAIN_VIEWPORT = primary
		Viewports = {primary}

	end
end
reconfigure_for_unit = function (unit_type)   --unit type is string with unit name
local lBorder = 20
	if unit_type == "A-10C" then
		LEFT_MFCD = 
		{
			x = x0 + 0;
			y = y0 + 0;
			width = 456;
			height = 456;
		}
		RIGHT_MFCD = 
		{
			x = LEFT_MFCD.x + 0;
			y = LEFT_MFCD.y + LEFT_MFCD.height;
			width = 456;
			height = 456;
		}
		RWR_SCREEN =
		{
			x = LEFT_MFCD.x + 0;
			y = LEFT_MFCD.x + LEFT_MFCD.height + RIGHT_MFCD.height;
			width = 200;
			height = 200;
		}
		DIGIT_CLOCK =
		{
			x = RWR_SCREEN.x + RWR_SCREEN.width;
			y = RWR_SCREEN.y;
			width = 200;
			height = 200;
		}
		CDU_EXPORT = 
		{
			x = RWR_SCREEN.x + 0;
			y = RWR_SCREEN.y + RWR_SCREEN.height;
			width = 356;
			height = 270;
		}
		UHF_PRESET_CHANNEL =
		{
			x = RWR_SCREEN.x + 0;
			y = CDU_EXPORT.y + CDU_EXPORT.height;
			width = 40;
			height = 40;
		}

		UHF_FREQUENCY_STATUS =
		{
			x = UHF_PRESET_CHANNEL.x + UHF_PRESET_CHANNEL.width;
			y = UHF_PRESET_CHANNEL.y + 0;
			width = 170;
			height = 40;
		} 
	elseif unit_type == "AV8BNA" then
		
		LEFT_MFCD =
		{
			 x = x0 + lBorder ;
			 y = y0 + lBorder ;
			 width = 320;
			 height = 300;
		}

		RIGHT_MFCD =
		{
			 x = LEFT_MFCD.x ;
			 y = LEFT_MFCD.y + LEFT_MFCD.height + lBorder;
			 width = 320;
			 height = 300;
		}
	elseif unit_type == "FA-18C_hornet" then
		LEFT_MFCD =
		{
			 x = x0 ;
			 y = y0 ;
			 width = 400;  -- was 360
			 height = 400; -- was 360
		}

		RIGHT_MFCD =
		{
			 x = LEFT_MFCD.x;
			 y = LEFT_MFCD.y + LEFT_MFCD.height;
			 width = 400;
			 height = 400;
		}
		--AMPCD
		CENTER_MFCD =
		{
			 x = LEFT_MFCD.x;  --20
			 y = RIGHT_MFCD.y + RIGHT_MFCD.height; 
			 --width = 518;
			 --height = 518;
			 width = 640;
			 height = 640;
		}
		-- RWR
		F18_RWR =
		{
			 x = LEFT_MFCD.x + LEFT_MFCD.width + 60;
			 y = LEFT_MFCD.y + LEFT_MFCD.height + 60 ;
			 width = 180;
			 height = 180;
		}
	elseif unit_type == "F-14B" then

	elseif unit_type == "F-16C" then

	elseif unit_type == "SpitfireLFMkIX" then

	end
end
configure_displays()
