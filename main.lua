--  1.5 B. Jurisch 01.04.2024 complete new version for Ethos 1.5
--  1.6 B. Jurisch 11.04.2024 dShow switch label
--  1.7 B. Jurisch 16.04.2024 some problems with ETHOS 1.5.6
--  1.8 B. Jurisch 17.04.2024 err message if Staandard.lua not available and no modell.lua exist
--  requires at least Ethos 1.5.3

local version="2.5"
local translations = {en="Switch Mapping", de="Schalter Zuordnung",}
local debug_flag=false         --> for debug mode	liste daten in load_erw ggf. aktivieren
local debug_mode=0
local debug_col ={string.char(27).."[0m", string.char(27).."[36m"}
local wait = 0 
-- Get information for Transmitter
local sys = system.getVersion()   	
local RADIO=sys.board
local KAVAN="V"
local kaf=false

local SWMAP=nil
local anz_dig=0	
local anz_ana=0
local sw_tast=""
local last_tast=""

local sw_pos=nil 
local data_values=nil
local data_switch=nil
local data_analog=nil
local data_trim=nil
local data_fuswitch=nil
local load_def_ok=false
local load_def_erw=false
local disp=false
local dix=0
local screen=false
local err=nil
local err_flag=false
local err_config=false
local langu={}

--local out_txt="" ab Version 2.5 nicht mehr
local debugflag=false

local curposl=0
local curposh=0

if system.getLocale() == "de" then	
	langu={"Kopiere von Modell",
		   "Schalter Position anzeigen",	
		   "Analoggeber anzeigen",
		   "Funktionschalter anzeigen",
		   "Trimmschalter anzeigen (T1-T6)",
		   "Bezeichnung anzeigen",								
		   "Kreis um Geber",
		   "Hintergrundfarbe",
		   "Textfarbe",
		   "Linenfarbe",
		   "KAVAN",
		   "wird  nicht  unterstützt ",
		   "Schalterbezeichnung anzeigen",
		   "wurde nicht gefunden",
		   ", erzeuge Fehlermeldung",
		   ", wurde gefunden und kopiert.",
		   "Bitte wieder bereit stellen!",
		   " , kopiere Standard.lua Datei",
		   "kann die Modelldatei nicht finden: ",
		   "Fehler: dieser geber ist nicht Konfiguriert: ",
		   "Globale Verwendung",
		  }
	
else
	langu={ "Copy from model",
			"Show switch position",
			"Show analogue encoder",
			"Show function switch",
			"Show trim switch (T1-T6)",
			"Show label",
			"Circle around encoder",
			"Background color",
			"Text color",
			"Line color",
			"KAVAN",
			"is not supported ",
			"Show switch label",
			"was not found",
			", generate error message",
			", was found and copied.",
			"Please make it available again!",
			" , copy standard.lua file",
			"cannot find the model file: ",
			"Error: this encoder is not configured: ",
			"Global use",
		  }
end  


local function list_tab(array,anz)
	--print("Liste Table",array," Anzahl:",anz, " tabsaetze:", #array)
    
    for idx,key in pairs(array) do
		if array[idx]~=nil then
			for i=0,anz, 1 do 
				if i==0 then 
					out="Satz: "..idx
				end
				
				if array[idx][i]~=nil then 
					out=out..","..array[idx][i]
				end
			end
			--print(out)
		end
    end
end


-- check if file exist
function existFile(file)
	local fileOpen=io.open(file,"r")
	if fileOpen==nil then 
		return false
	else
		local fileClose= io.close(fileOpen)
		return true
	end
end

-- copy file function
function copyFile(fromfile,tofile)
	local f=io.open(fromfile,"rb")
	if f==nil then
		return nil, nil
	end
	local content=""
	while true do
		line = io.read(f,"L")
		if (line == nil) then break end
		content=content..line
	end
	io.close(f)
	if content~=nil then
		f=nil
		f = io.open(tofile, "w")
		io.write(f,content)
		io.close(f)
	end
end


function write_file(file,text)
	text = text.."\n"
	if existFile(file)==true then	
		f = io.open(file, "w")
		if f~=nil then 
			io.write(f,text)
			io.close(f)
		else
			local fileOpen=i
			f = io.open(file, "w")
			io.write(f,text)
			io.close(f)
		end
    else
		f = io.open(file, "w")
		io.write(f,text)
		io.close(f)
	end
end



function write_log(txt)
	txt=txt.."\n"
	file="/logs/SWMAP-log.txt"
	local f=nil
	if existFile(file)==true then
		f = io.open(file, "a")
	else
		f = io.open(file, "w")
	end
	io.write(f,txt)	
	io.close(f)
end

-- debug function
function deprint(txt)
	if debugflag==true then
		txt=os.date("%d.%m.%Y",os.time()).." - "..os.date("%H:%M:%S",os.time()).." "..txt
		if sys.simulation==true then print(txt) end
		if debug_flag==true then
			write_log(txt)
		end
	end
end


-- search switch position
local function switch_pos()
	local ok=false
	local idx=-1
	local me=nil 
	for i=0,#SWMAP,1 do 
		if SWMAP[i]~=nil then
			if SWMAP[i][0]=="DIG" then 
				me = system.getSource({category=CATEGORY_SWITCH_POSITION, member=i})
			end
			if SWMAP[i][0]=="FUN" then 
				me = system.getSource({category=CATEGORY_FUNCTION_SWITCH, member=i})
			end
			if SWMAP[i][0]=="ANA" then 
				me = system.getSource({category=CATEGORY_ANALOG, member=i-anz_dig})
			end
			if SWMAP[i][0]=="TRM" then 
				me = system.getSource({category=CATEGORY_TRIM_POSITION, member=i-anz_dig})
			end
			if me~=nil then
					x=0
					if SWMAP[i][0]=="DIG" or SWMAP[i][0]=="FUN" then
						if me:state()==true then 
							x=1 
						else
							x=0
						end
					else
						x=me:stringValue()	
					end	
					if SWMAP[i][2]~=x then
						SWMAP[i][2]=x
						if SWMAP[i][0]=="DIG" then 
							sw_tast=string.sub(me:name(),1,2)
						else
							sw_tast=me:name()
						end
						ok=true
						break
					end
			end
		end
	end
	return ok

end



local function add_positions(na,idx)
	--print("adD_pos",na,idx)
	local ok=false
	for x=0,#sw_pos,1 do
		if sw_pos[x]~=nil then 
			if na==sw_pos[x][1] then
				ok=true
				for y=1,16,1 do
					SWMAP[idx][10+y]=sw_pos[x][y]
				end
				break
			end
		end
	end
	if ok==false then 
		err_config=true 
		--out_txt=langu[20]..na.."\n"..out_txt 
	end	
end

local function load_erw()
	--concatenate SWMAP with modelconfig Textdata
	trm_idx=1
	fun_idx=1
	for i=0,#SWMAP,1 do
		if SWMAP[i]~=nil then
			if SWMAP[i][0]=="FUN" then 
				if data_fuswitch[fun_idx]~=nil then
					SWMAP[i][5]=data_fuswitch[fun_idx]
				end
				add_positions(SWMAP[i][1],i)
				fun_idx=fun_idx+1
			end
			if SWMAP[i][0]=="TRM" then 
				if data_trim[trm_idx]~=nil then
					SWMAP[i][5]=data_trim[trm_idx]
					--print("load_erw",SWMAP[i][0], SWMAP[i][1],SWMAP[i][2],SWMAP[i][3],SWMAP[i][4], SWMAP[i][5], "i:",i)
					--if system.getLocale() ~= "de" then	
					--	print("load_erw",SWMAP[i][0], SWMAP[i][1])
					--end
				end
				add_positions(SWMAP[i][1],i)
				trm_idx=trm_idx+1
			end
		else
			break
		end
	end
	data_fuswitch=nil
	data_trim=nil
	
	if debug_flag==true then 
		local log_txt=nil
		for i=0,#SWMAP,1 do
			if SWMAP[i]~=nil then
				if SWMAP[i][5]~=nil then 
					deprint="function Load_erw: Source-type: "..SWMAP[i][0].." Source: "..SWMAP[i][1].." --> "..SWMAP[i][5].." IDX:"..i.."\n"
				end
 			end
    	end
	end
end

local function load_def()
	if err==nil then
		--concatenate SWMAP with modelconfig Textdata
		ana_idx=1
		for i=0,#SWMAP,1 do
			if SWMAP[i]~=nil then
				if SWMAP[i][0]=="DIG" then 
					if data_switch[i+1]~=nil then
						SWMAP[i][5]=data_switch[i+1]
					end
					add_positions(string.sub(SWMAP[i][1],1,2),i)
				end
				if SWMAP[i][0]=="ANA" then 
					if data_analog[ana_idx]~=nil then
						SWMAP[i][5]=data_analog[ana_idx]
					end
					add_positions(SWMAP[i][1],i)
					ana_idx=ana_idx+1
				end
			end
		end
		data_switch=nil
		data_analog=nil
		load_def_ok=true
		
		if debug_flag==true then 
			local log_txt=nil
			for i=0,#SWMAP,1 do
				if SWMAP[i]~=nil then
					if SWMAP[i][5]~=nil then 
						deprint("function load_def: Source-type: "..SWMAP[i][0].." Source: "..SWMAP[i][1].." --> "..SWMAP[i][5].." IDX:"..i)
					end
				end
			end
		end
		
		
	end
end

-- read all configured data tables  
local function load_data(widget,na)
	widget.global= storage.read("global")
	if widget.global==nil then 
		widget.global=false
	end
	--print("widget.global:",widget.global)
	
	if na==nil then na=model.name()..".lua" end
	if widget.global==true then na="global.lua" end
	
	local file = "/scripts/swmap/modelle/"..na
	
	if existFile(file)==true then
		--print("-------------------------------------")
		--print("Modellname:",model.name())
		--print("load Date from :",file)
		--print("-------------------------------------")
		load_def_ok=false 
		load_def_erw=false
		data_Value=nil
		data_switch=nil
		data_analog=nil
		data_trim=nil
		data_fuswitch=nil
		
		data_values, data_switch, data_analog, data_trim, data_fuswitch = dofile(file)
		--for i=1,15,1 do
		--	print("data_values:",i,data_values[i])
		--end
		-- set switches and colors	
		widget.backcolor=tonumber(data_values[2])
		widget.farbe=tonumber(data_values[3])
		widget.linecolor=tonumber(data_values[4])
		widget.DisplaySwitchNames=data_values[5]
		widget.DisplayTrim=data_values[6]
		widget.DisplayFswitch=data_values[7]
		widget.DisplayAnalog=data_values[8]   
		widget.DisplayPos=data_values[9]
		widget.circle_sw=data_values[10]
		if data_values[11]==nil then 
			widget.DisplaySwitchNames=false
		else
			widget.DisplayDigiNames=data_values[11]
		end
		
		-- activate Debug mode over model lua config
		if data_values[12]~=nil then 
			if data_values[12]==true then 
				debug_flag = true
			end
		end
		
		data_value=nil
		widget.modell_load_flag=true
	end
	 
	
end

-- write configured modell data's
local function write_data(widget)
	print("write Data:","/scripts/swmap/modelle/"..model.name()..".lua")
	-- save all configuration values to file
	local data_def="local def_values={"
	local data_analog="local def_ana={"
	local data_trim="local def_trim={"
	local data_fuswitch="local def_fusw={"
	local data_switch="local def_switch={"
	local data_return="return def_values, def_switch, def_ana, def_trim, def_fusw".."\n"
	
	-- save widget switches and colors
	data_def=data_def.."\""..version.."\","
	data_def=data_def.."\""..widget.backcolor.."\","
	data_def=data_def.."\""..widget.farbe.."\","
	data_def=data_def.."\""..widget.linecolor.."\","
	data_def=data_def..tostring(widget.DisplaySwitchNames)..","
	data_def=data_def..tostring(widget.DisplayTrim)..","
	data_def=data_def..tostring(widget.DisplayFswitch)..","
	data_def=data_def..tostring(widget.DisplayAnalog)..","
	data_def=data_def..tostring(widget.DisplayPos)..","
	data_def=data_def..tostring(widget.circle_sw)..","
	data_def=data_def..tostring(widget.DisplayDigiNames)..",}".."\n"
	
	
	y=5
	for i=0,#SWMAP,1 do
		if SWMAP[i]~=nil then
			if SWMAP[i][y]==nil then SWMAP[i][y]="" end
			if SWMAP[i][0]=="ANA" then
				data_analog=data_analog.."\""..SWMAP[i][y].."\","
			end
			if SWMAP[i][0]=="DIG" then
				data_switch=data_switch.."\""..SWMAP[i][y].."\","
			end
			if SWMAP[i][0]=="TRM" then
				data_trim=data_trim.."\""..SWMAP[i][y].."\","
			end
			if SWMAP[i][0]=="FUN" then
				data_fuswitch=data_fuswitch.."\""..SWMAP[i][y].."\","
			end
		end
	end
	data_analog=data_analog.."}".."\n"
	data_switch=data_switch.."}".."\n"
	data_trim=data_trim.."}".."\n"
	data_fuswitch=data_fuswitch.."}".."\n"
	
	if widget.global==true then 
		file="/scripts/swmap/modelle/global.lua"
	else
		file="/scripts/swmap/modelle/"..model.name()..".lua"
	end
	f = io.open(file, "w")
	io.write(f,data_def..data_analog..data_trim..data_fuswitch..data_switch..data_return)
	io.close(f)
	data_def=nil
	data_switch=nil
	data_analog=nil
	data_fuswitch=nil
end

-- load an other file into table
local function loadLib(name)
  local lib=nil
  --print("Lade LIB:", name)
  if system.getLocale() == "de" then	
	
	--out_txt= "Lade /scripts/swmap/lib/"..name..".lua".."\n RADIO:"..RADIO.."\n"
	--print("Deutsche Version:","/scripts/swmap/lib/"..name..".lua")
	lib = dofile("/scripts/swmap/lib/"..name..".lua")
  else
	--out_txt= "Load /scripts/swmap/lib/"..name.."_"..system.getLocale()..".lua".."\n RADIO:"..RADIO.."\n"
	--print("Englische Version:","/scripts/swmap/lib/"..name.."_"..system.getLocale()..".lua")
	lib = dofile("/scripts/swmap/lib/"..name.."_"..system.getLocale()..".lua")
  end
  
  return lib
end

-- initial function for load files
local function initLibs(na)
	--print("initLibs laden daten:",na)
	sw_pos=nil  
	sw_pos=loadLib(na)
end


--function for display all switches and slider and lines
function display(widget,typ,idx)
	--print("SWMAP Display:",typ, idx, SWMAP[idx][0], SWMAP[idx][1],"IDX:",idx)
	local na=SWMAP[idx][1]
	local dis_na=SWMAP[idx][5]
	local prefixtext=""	
	local s_font_w, s_font_h = lcd.getTextSize(na)
	lcd.color(widget.farbe)
	if dis_na==nil then dis_na="" end   -- 20.12.2024 2.5 B. Jurisch
	if SWMAP[idx][0]~="DIG" and widget.DisplaySwitchNames == false then 
		na=""
	end
	if SWMAP[idx][0]=="DIG" then 
		na=string.sub(SWMAP[idx][1],1,2)
		if widget.DisplayDigiNames==false  then
			na=""
		else
			if widget.DisplayPos==false then
				na=string.sub(SWMAP[idx][1],1,2)
			else
				na=SWMAP[idx][1]
			end
		end
		if SWMAP[idx][12]~=nil then 				-- 2.5 B. Jurisch 20.12.2024
			if SWMAP[idx][12]<0 then
				prefixtext = dis_na.." "..na 
			else
				prefixtext = na.." "..dis_na
			end
		end											-- 2.5 B. Jurisch 20.12.2024
			
	else
		if SWMAP[idx][12]~=nil then 				-- 2.5 B. Jurisch 20.12.2024
			if SWMAP[idx][12]<0 then
				prefixtext = dis_na.." "..na 
			else
				prefixtext = na.." "..dis_na
			end
		end											-- 2.5 B. Jurisch 20.12.2024
		
		if SWMAP[idx][0]=="ANA" and widget.DisplayAnalog==false then
			prefixtext =""	
		end
		if SWMAP[idx][0]=="FUN" and widget.DisplayFswitch==false then
			prefixtext =""	
		end
		if SWMAP[idx][0]=="TRM" and widget.DisplayTrim==false then
			prefixtext =""	
		end
	end
	if widget.DisplaySwitchNames==false and string.len(prefixtext)==1 then
		prefixtext=nil
	end
	if prefixtext~=nil and string.len(prefixtext)==1 then 
		prefixtext=""
	end
	
	if prefixtext~="" and prefixtext~=nil then
		
		-- text color
		if SWMAP[idx][21]~=nil then 
			lcd.color(SWMAP[idx][21])
		else
			lcd.color(widget.farbe)
		end
		-- text Font
		if SWMAP[idx][22]~=nil then
			lcd.font(SWMAP[idx][22])
		else
			lcd.font(FONT_S)
		end		
		pos=SWMAP[idx][12] 
		l_pos=SWMAP[idx][12] 
		
		if SWMAP[idx][12]<0 then
			pos=widget.w-10
			l_pos=widget.w-10
			w, h = lcd.getTextSize(prefixtext)
			sys_font_h=h
		    pos=pos-w+2
			lcd.drawText(pos, SWMAP[idx][13], prefixtext)	
		else
			pos=SWMAP[idx][12]
			lcd.drawText(pos, SWMAP[idx][13],prefixtext)
		end	
			
		-- horizontal line color
		if SWMAP[idx][19]~=nil then
			lcd.color(SWMAP[idx][19])
		else
			lcd.color(widget.linecolor)
		end
		s_font_w, s_font_h = lcd.getTextSize(prefixtext)

		
		if sys.simulation==true and debug_mode==8 and curposh-s_font_h>=0 and curposl>=0 then 
			lcd.font(FONT_S)
			lcd.color(COLOR_WHITE)
			lcd.drawText(1, widget.h-s_font_h,"Pos left:"..curposl.."    Pos high: "..curposh-s_font_h)
		end
		
		lcd.drawLine(l_pos ,SWMAP[idx][13]+s_font_h,SWMAP[idx][14],SWMAP[idx][13]+s_font_h)
		
		-- vertikal line color
		if SWMAP[idx][15]~=nil and SWMAP[idx][16]~=nil then
			if SWMAP[idx][20]~=nil then
				lcd.color(SWMAP[idx][20])
			else
				lcd.color(widget.linecolor)
			end
			lcd.drawLine(SWMAP[idx][15],SWMAP[idx][16]+s_font_h, SWMAP[idx][17],SWMAP[idx][18]+s_font_h)
			
		end
		
		
		-------------------------- display cirle for switch
		if sys.simulation==true and widget.circle_sw==true  then 
			if SWMAP[idx][0]=="DIG" and debug_mode==1 then 
				if sw_tast=="SA" then sw_tast="T4 links" end
				if sw_tast=="SB" then sw_tast="T4 rechts" end
				if sw_tast=="SC" then sw_tast="T3 tief" end
				if sw_tast=="SD" then sw_tast="T3 hoch" end
			end
			
			if SWMAP[idx][0]=="DIG" and debug_mode==2 then 
				if sw_tast=="SC" then sw_tast="T1 links" end
				if sw_tast=="SD" then sw_tast="T1 rechts" end
				if string.sub(RADIO,1,2)=="XE" then 
					if sw_tast=="SA" then sw_tast="T2 hoch" end
					if sw_tast=="SB" then sw_tast="T2 tief" end
				else
					if sw_tast=="SA" then sw_tast="T2 tief" end
					if sw_tast=="SB" then sw_tast="T2 hoch" end
				end
			end
			if SWMAP[idx][0]=="DIG" and debug_mode==3 then 
				if string.sub(RADIO,1,2)=="XE" then 
					if sw_tast=="SA" then sw_tast="T5 hoch" end
					if sw_tast=="SB" then sw_tast="T5 tief" end
					if sw_tast=="SC" then sw_tast="T6 hoch" end
					if sw_tast=="SD" then sw_tast="T6 tief" end
				else
					if sw_tast=="SA" then sw_tast="T5 links" end
					if sw_tast=="SB" then sw_tast="T5 rechts" end
					if sw_tast=="SC" then sw_tast="T6 links" end
					if sw_tast=="SD" then sw_tast="T6 rechts" end
				end
				
			end
			if SWMAP[idx][0]=="DIG" and debug_mode==4 then 
				if sw_tast=="SA" then sw_tast="FS1" end	
				if sw_tast=="SB" then sw_tast="FS2" end	
				if sw_tast=="SC" then sw_tast="FS3" end	
				if sw_tast=="SD" then sw_tast="FS4" end	
				if sw_tast=="SE" then sw_tast="FS5" end	
				if sw_tast=="SF" then sw_tast="FS6"  end	
			end
			if SWMAP[idx][0]=="DIG" and debug_mode==5 then 
				if sw_tast=="SA" then sw_tast="Drehg. li." end	
				if sw_tast=="SB" then sw_tast="Drehg. re." end	
			end
			if SWMAP[idx][0]=="DIG" and debug_mode==6 then 
				if sw_tast=="SA" then sw_tast="Pot1" end	
				if sw_tast=="SB" then sw_tast="Pot2" end	
				if sw_tast=="SC" then sw_tast="Pot3" end	
				if sw_tast=="SD" then sw_tast="Pot4" end	
			end
			if SWMAP[idx][0]=="DIG" and debug_mode==7 then 
				if sw_tast=="SA" then sw_tast="L1" end	
				if sw_tast=="SB" then sw_tast="L2" end	
				if sw_tast=="SC" then sw_tast="Ext1" end	
				if sw_tast=="SD" then sw_tast="Ext2" end	
			end
			for i=0,#SWMAP,1 do
				if SWMAP[i]~=nil then
					if SWMAP[i][1]==sw_tast then idx=i break end
				else
					break
				end
			end
		end
		---- circle around encoder/switch/functionswitch or trim
		if a==true then 
			if SWMAP[idx][23]~=nil and SWMAP[idx][24]~=nil and SWMAP[idx][25]~=nil then
				if (SWMAP[idx][0]=="DIG" and string.sub(SWMAP[idx][1],1,2)==sw_tast) or (SWMAP[idx][0]~="DIG" and SWMAP[idx][1]==sw_tast) then
					lcd.color(SWMAP[idx][25])
					if string.sub(RADIO,1,3)=="X18" or string.sub(RADIO,1,3)=="X10" or string.sub(RADIO,1,3)=="TWX"  then
						for y=5,7,1 do
							lcd.drawCircle(SWMAP[idx][23],SWMAP[idx][24],y)
						end
					else
						for y=8,10,1 do
							lcd.drawCircle(SWMAP[idx][23],SWMAP[idx][24],y)
						end
					end
				end	
			end
		end
	end	
end

--------------------------------------------------------------------- from here default ETHOS function's ------------------------------------------------------------------
local function name()
    local locale = system.getLocale()
    return translations[locale] or translations["en"]
end

local function create_tables()
	SWMAP={}
	anz_dig=0
	anz_ana=0
	local err_flag=false
	local fun_sw = 5
	local sw_end = "SZ"
	if string.sub(RADIO,1,3)=="TWX" then 
		sw_end = "SF"
		fun_sw = 3
	end
	if string.sub(RADIO,1,3)=="X14" then 
		sw_end = "SF"
	end
	if string.sub(RADIO,1,3)=="X10"  then 
		sw_end = "SH"
	end
	local log_txt=""
	-- copy modelldata from standard file
	file="/scripts/swmap/modelle/"..model.name()..".lua"
	if existFile(file)==false then 
		fromfile="/scripts/swmap/modelle/Standard.lua"
		if existFile(fromfile)==false then 
			debug_flag=true
			err=fromfile.."\n"..langu[14].."\n"..langu[17]
			deprint("function create_tables: "..file.." "..langu[14])
			deprint("function create_tables: "..fromfile.." "..langu[14]..langu[15])
			return true	
		else
			copyFile(fromfile,file)
			err_flag=true
		end
	end
	
	--read all switches from transmitter 
	--out_txt=out_txt.."\n".."TYP;Name \n"
	--out_txt=out_txt.."-------------------------- \n"
	if debug_flag==true then deprint("function create_tables: read all switches from transmitter") end	
	for i=0,100,1 do 
		local me = system.getSource({category=CATEGORY_SWITCH_POSITION, member=i})
		if me~=nil then
			if string.sub(me:name(),1,1)=="S" then 
				if SWMAP[anz_dig]==nil then SWMAP[anz_dig]={} end
				SWMAP[anz_dig][0]="DIG"
				SWMAP[anz_dig][1]=me:name()
				--if string.sub(me:name(),1,1)=="S" then 
				--	out_txt=out_txt.."DIG"..";"..string.sub(me:name(),1,2).."\n"
				--else
				--	out_txt=out_txt.."DIG"..";"..me:name().."\n"
				--end
				if me:state()==true then
					SWMAP[anz_dig][2]=1
					SWMAP[anz_dig][3]=1
				else
					SWMAP[anz_dig][2]=0
					SWMAP[anz_dig][3]=0
				end
				--deprint("TYP:"..SWMAP[anz_dig][0].." Bez:"..SWMAP[anz_dig][1].." VALUE: "..SWMAP[anz_dig][2].." IDX:"..anz_dig) 
				anz_dig=anz_dig+1
			end
			
			if string.sub(me:name(),1,2)==sw_end then break end
		end
	end
	-- add function switsches to SWMAP  
	if debug_flag==true then deprint("function create_tables: add function switches") end	
	for i=0,fun_sw,1 do
		local me = system.getSource({category=CATEGORY_FUNCTION_SWITCH, member=i})
		if me~=nil then
			if string.sub(me:name(),1,2)=="FS" then 
				if SWMAP[anz_dig]==nil then SWMAP[anz_dig]={} end
				SWMAP[anz_dig][0]="FUN"
				SWMAP[anz_dig][1]=me:name()
				--out_txt=out_txt.."FUN"..";"..me:name().."\n"
				if me:state()==true then
					SWMAP[anz_dig][2]=1
					SWMAP[anz_dig][3]=1
				else
					SWMAP[anz_dig][2]=0
					SWMAP[anz_dig][3]=0
				end
				--deprint("TYP:"..SWMAP[anz_dig][0].." Bez:"..SWMAP[anz_dig][1].." VALUE: "..SWMAP[anz_dig][2].." IDX:"..anz_dig) 
				anz_dig=anz_dig+1
			end
		end
	end
	anz_ana=anz_dig	
	anz_dig=anz_dig-1
	--read all analog encoder not the sticks!
	if debug_flag==true then deprint("function create_tables: read analog encoder from transmitter") end	
	for i=4,100,1 do 
		local me = system.getSource({category=CATEGORY_ANALOG, member=i})
		if me:name()~="---" then
			na=me:name()
			if sys.simulation==true and string.sub(RADIO,1,3)=="X10" and string.len(na)==1 then na="Pot2" end
			if na~="---" then
				if SWMAP[anz_ana]==nil then SWMAP[anz_ana]={} end
				SWMAP[anz_ana][0]="ANA"
				SWMAP[anz_ana][1]=na
				SWMAP[anz_ana][2]=me:rawValue()
				SWMAP[anz_ana][3]=me:rawValue()
				--out_txt=out_txt.."ANA"..";"..na.."\n"
				--deprint("TYP:"..SWMAP[anz_ana][0].." Bez:"..SWMAP[anz_ana][1].." VALUE: "..SWMAP[anz_ana][2].." IDX:"..anz_ana,i) 
				anz_ana=anz_ana+1
				
			end
		else
			if me:name()==nil or me:name()=="---" then break end
		end
	end
	-- add trim switsches to SWMAP
	if debug_flag==true then deprint("function create_tables: add trim switches") end	
	TR=20
	if string.sub(RADIO,1,3)=="X10" then 
		TR=7
	end
	--deprint("Add Trim switsches")
	for i=0,TR,1 do
		local me = system.getSource({category=CATEGORY_TRIM_POSITION, member=i})
		if me~=nil then
			--print("me:",me:name())
			if string.sub(me:name(),1,1)=="T" then 
				--deprint("Hinzufuegen ",me:name())
				if SWMAP[anz_ana]==nil then SWMAP[anz_ana]={} end
					SWMAP[anz_ana][0]="TRM"
					SWMAP[anz_ana][1]=me:name()
					SWMAP[anz_ana][2]=me:rawValue()
					SWMAP[anz_ana][3]=me:rawValue()
					--out_txt=out_txt.."TRM"..";"..me:name().."\n"
					--deprint("TYP:"..SWMAP[anz_ana][0].." Bez:"..SWMAP[anz_ana][1].." VALUE: "..SWMAP[anz_ana][2].." IDX:"..anz_ana) 
					anz_ana=anz_ana+1
			end
		end
	end
	
	
	if err_flag==true then 
		debug_flag=true
		deprint("function create_tables: "..langu[19]..file..langu[18])
		deprint("function create_tables: "..fromfile.." "..langu[16])
	end
end

local function create()
	--print("Create swmap")
	if debug_flag==true then deprint("function create:") end	
	initLibs(RADIO)
	if SWMAP==nil then
		if debug_flag==true then deprint("call function create_tables") end	
		create_tables()
	end
	local backcolor=THEME_DEFAULT_BGCOLOR
	local farbe=SYSTEM_COLOR_ORANGE
	local linecolor=SYSTEM_COLOR_WHITE
	if debug_flag==true then deprint("end of function create") end	
	return {DisplaySwitchNames=true, DisplayDigiNames=false,DisplayTrim=false,DisplayAnalog=false,DisplayFswitch=false,DisplayPos=false,modell_load_flag=false,circle_sw=false, backcolor=backcolor,farbe=farbe,linecolor=linecolor, filename=nil}
end




local function paint_sw(widget)
	--print("paint_SW")
	widget.w, widget.h = lcd.getWindowSize()
	lcd.color(widget.backcolor)
	lcd.drawFilledRectangle(0, 0, widget.w, widget.h)
		
	if sys.simulation==true then
		if debug_mode~=0  then 
			lcd.color(COLOR_WHITE)
			lcd.font(FONT_STD)
			txt="Debug Mode: "
			if debug_mode==1 then txt=txt.." Trim links" end
			if debug_mode==2 then txt=txt.." Trim rechts" end
			if debug_mode==3 then txt=txt.." Trim 5 & 6" end
			if debug_mode==4 then txt=txt.." FS 1-6" end
			if debug_mode==5 then txt=txt.." Drehg. li. &  re. " end
			if debug_mode==6 then txt=txt.." Pot 1-4" end
			if debug_mode==7 then txt=txt.." L1,L2, Ext1, Ext2" end
			if debug_mode==8 then txt=txt.." Positions" end
			w, h = lcd.getTextSize(txt)
			w=(widget.w-10)-w
			h=(widget.h)-h-2
			lcd.drawText(w,h,txt )
			deprint("paint_sw Debug Mode: "..debug_mode)
		end
	end
	
	
	--check_display(widget)
    lcd.drawBitmap(1,10,bitmap,widget.w-10,widget.h-40)   	
	----Display DATAS------
	local err_txt=""
	for i=0,#SWMAP,1 do
		if SWMAP[i]~=nil then
			
			if SWMAP[i][0]=="DIG" and SWMAP[i][2]==1 then 
				if SWMAP[i][11]~=0 and SWMAP[i][12]~=0 then 
					SWMAP[i][3]=SWMAP[i][2]
					display(widget,"DIG",i)
				end
			end	
			if SWMAP[i][0]=="FUN" and widget.DisplayFswitch==true then 
				if SWMAP[i][11]~=0 and SWMAP[i][12]~=0 then 
					SWMAP[i][3]=SWMAP[i][2]
					display(widget,"FUN",i)
				end
			end	
			if SWMAP[i][0]=="ANA" and widget.DisplayAnalog==true then 
				if SWMAP[i][11]~=0 and SWMAP[i][12]~=0 then 
					SWMAP[i][3]=SWMAP[i][2]
					display(widget,"ANA",i)
				end
			end	
			if SWMAP[i][0]=="TRM" and widget.DisplayTrim==true then 
				if SWMAP[i][11]~=0 and SWMAP[i][12]~=0 then 
					SWMAP[i][3]=SWMAP[i][2]
					display(widget,"TRM",i)
				end
			end	
		end
	end
end


local function paint(widget)
	-- B. Jurisch 20.12.2024-------------------------------Start--------------------
	if string.sub(sys.version,1,3)>"1.5" and widget.circle_sw==true then 
		widget.circle_sw=false
	end
	
	-- B. Jurisch 20.12.2024-------------------------------Ende---------------------
	
	if err~=nil or kaf==true then 
		widget.w, widget.h = lcd.getWindowSize()
		lcd.color(widget.backcolor)
		lcd.drawFilledRectangle(0, 0, widget.w, widget.h)
		lcd.font(FONT_XL)
		lcd.color(COLOR_ORANGE)
		if err~=nil then 
			na=err
			lcd.drawText(1,1,na)
		end
		if kaf==true then
			na=langu[11]
			w, h = lcd.getTextSize(na)
			lcd.drawText((widget.w/2)-w/2,(widget.h/2)-h/2,na)
			na=langu[12]
			w, h = lcd.getTextSize(na)
			lcd.drawText((widget.w/2)-w/2,(widget.h/2)+h/2,na)
		end
	else
		if disp==true then 
			paint_sw(widget)
		end
	end
end

local function configure(widget)
	-- Version
	line = form.addLine("swmap Version: "..version.."   (c) B. Jurisch") 
	form.addStaticText(line, nil, "")
	
	
	widget.filename="" 
	line=form.addLine(langu[1])
	form.addFileField(line, nil, "/scripts/swmap/modelle/", "any", function() return widget.filename end, function(newValue) widget.filename = newValue end)
	
	-- Globalew Verwendung
	line = form.addLine(langu[21])
	form.addBooleanField(line, nil, function() return widget.global end, function(value) widget.global = value end)
	
	-- Display Switch Pos
	line = form.addLine(langu[2])
	form.addBooleanField(line, nil, function() return widget.DisplayPos end, function(value) widget.DisplayPos = value end)
	
	-- display switch names if configured
	line = form.addLine(langu[3])
	form.addBooleanField(line, nil, function() return widget.DisplayAnalog end, function(value) widget.DisplayAnalog = value end)
	
	-- Add Funktion/logical switch
	line = form.addLine(langu[4])
	form.addBooleanField(line, nil, function() return widget.DisplayFswitch end, function(value) widget.DisplayFswitch = value end)
	
	-- Add Trimm 
	line = form.addLine(langu[5])
	form.addBooleanField(line, nil, function() return widget.DisplayTrim end, function(value) widget.DisplayTrim = value end)
	
	-- display switch names
	line = form.addLine(langu[13])
	form.addBooleanField(line, nil, function() return widget.DisplayDigiNames end, function(value) widget.DisplayDigiNames = value end)
	
	-- display switch names
	line = form.addLine(langu[6])
	form.addBooleanField(line, nil, function() return widget.DisplaySwitchNames end, function(value) widget.DisplaySwitchNames = value end)
	
	
	
	-- Funktion/logical circle switch
	-- Ab 1.6 geht dies enicht mehr
	--line = form.addLine(langu[7])
	--form.addBooleanField(line, nil, function() return widget.circle_sw end, function(value) widget.circle_sw = value end)	
	widget.circle_sw=false
		
		
	-- backcolor
	line = form.addLine(langu[8])
	widget.field_color = form.addColorField(line, nil, function() return widget.backcolor end, function(color) widget.backcolor = color end)
	-- textcolor
	line = form.addLine(langu[9])
	widget.field_color = form.addColorField(line, nil, function() return widget.farbe end, function(color) widget.farbe = color end)
	
	--linecolor
	line = form.addLine(langu[10])
	widget.field_color = form.addColorField(line, nil, function() return widget.linecolor end, function(color) widget.linecolor = color end)
	
	

	for i=0,anz_ana,1 do
		if SWMAP[i]~=nil then
			if SWMAP[i][5]~=nil then 				-- 2.5 B. Jurisch 20.12.2024
				if SWMAP[i][0]=="DIG" then
					line = form.addLine(SWMAP[i][1])
					form.addTextField(line, nil, function() return SWMAP[i][5] end, function(value) SWMAP[i][5] = value end)
				end
				
				if SWMAP[i][0]=="ANA" then
					line = form.addLine(SWMAP[i][1])
					form.addTextField(line, nil, function() return SWMAP[i][5] end, function(value) SWMAP[i][5] = value end)
				end
				
				if SWMAP[i][0]=="TRM" then
					--print("trim:",widget.source:name())
					line = form.addLine(SWMAP[i][1])
					form.addTextField(line, nil, function() return SWMAP[i][5] end, function(value) SWMAP[i][5] = value end)
				end
				
				if SWMAP[i][0]=="FUN" then
					line = form.addLine(SWMAP[i][1])
					form.addTextField(line, nil, function() return SWMAP[i][5] end, function(value) SWMAP[i][5] = value end)
				end
			end										-- 2.5 B. Jurisch 20.12.2024
		else
			break
		end
	end
	
	
end



local function write(widget)
	storage.write("global",widget.global)
	--print("function write") 
	--print("widget.DisplayDigiNames:",widget.DisplayDigiNames)
	if widget.filename~=nil and string.len(widget.filename)>=1 then 
		fromfile="/scripts/swmap/modelle/"..widget.filename..".lua"
		file="/scripts/swmap/modelle/"..model.name()..".lua"
		copyFile(fromfile,file)
		--print("Datei kopiert")
		
		widget.filename=model.name()
		create_tables()
		load_data(widget,widget.filename..".lua") 
		load_def_ok=false 
		load_def_erw=false

		return true 
	end
	if widget.modell_load_flag==false  then 
		if existFile("/scripts/swmap/modelle/"..model.name()..".lua" )==true then 
			widget.modell_load_flag=true
			load_data(widget,model.name()..".lua" ) 
		end
	else
		load_flag=false
		write_data(widget)
	end
end

local function check_swmap()
	if string.sub(RADIO,1,1)==KAVAN then 
		kaf=true
	end
	if load_def_ok==true then 
		if data_trim~=nil and data_fuswitch~=nil then
			load_erw() 
		end
	end
	if load_def_ok==false then 
		load_def() 
	end
	
	--if err_config==true then write_file("/scripts/swmap/error.txt",out_txt) end
end
	


local function wakeup(widget)
	if sys.simulation==true then 
		if os.time()>=wait then 
			wait=os.time() + 60
			--collectgarbage("collect")
			mem = system.getMemoryUsage()
			mem1=string.format("%.2f",(mem["luaRamAvailable"]/1024))
			mem2=string.format("%.2f",(mem["luaBitmapsRamAvailable"]/1024))
			print(debug_col[2].."Widget: "..name().." "..version, "Uhrzeit:", os.date("%H:%M:%S",os.time()),"lua Ram Available: "..mem1.."kB","lua Bitmaps Ram Available: "..mem2.."kB"..debug_col[1]) 	
		end
	end
	--if lcd.isVisible()==false then
	--	return true
	--end
	if err~=nil and lcd.isVisible() then
		if err_flag==false then 
			lcd.invalidate()
			err_flag=true
		end
		return true
	end
	
	if data_trim~=nil and data_fuswitch~=nil then load_def_erw=false else load_def_erw= true end
	if load_def_ok==false or load_def_erw==false then
		check_swmap()
	else
		disp=true
	end
	
	if widget.DisplayPos==true then 
		if dix>=12 and switch_pos()==true then
			if sys.simulation==true and sw_tast=="SG" then
				if sw_tast~=last_sw_tast then 
					debug_mode=debug_mode+1
					if debug_mode>8 then debug_mode=0 end
				end
			end
			--print("widget.DisplayPos:",widget.DisplayPos, "dix:",dix, "last:",last_sw,"sw_tast:",sw_tast)
			last_sw_tast=sw_tast
			
			lcd.invalidate()
		else
			if dix<12 then 
				switch_pos()
				dix=dix+1
			end
		
		end
	else
		if lcd.isVisible() and screen==false then
			screen=true
			lcd.invalidate()
		end
		if lcd.invalidate() and screen==true then	
			screen=false
		end

	end
	
	if kaf==true and wait==0 then
		wait = os.time() + 5
	else
		if kaf==true and os.time()>=wait then
			system.exit ()
		end
	end
	
	
end

local function event(widget, category, value, x, y)
	
	if sys.simulation==true and debug_mode==8 then 
		curposl=x
		curposh=y
		lcd.invalidate()
		return true	
	end
  --print("Event received:", category, value, "x:"..x, "Y:"..y)	
	if sys.simulation==true and debug_flag==true then 
	  deprint("Event received:", category, value, x, y)
	  if category == EVT_KEY and value == KEY_EXIT_BREAK then
		return true
	  end
	  if value == KEY_PAGE_UP then						--  page up button
		deprint("event: Pg UP")
		PageNext = PageActual+1
			if PageNext > PageMax then
				PageNext = 1
			end
		updateForm = true
		deprint("EVENT page up",PageNext)
		paint()
	  elseif value == KEY_PAGE_DOWN then			--  page down button
		deprint("event: Pg DN")
		PageNext = PageActual-1
			if PageNext == 0 then
				PageNext = PageMax
			end
		updateForm = true
		deprint("EVENT page up",PageNext)
		paint()	
	  end
	  return false
	end
	
end



local function init()
	if sys.simulation==true then 
    	print("SWMAP RADIO:"..RADIO)
	end

	if bitmap==nil then
		file="/scripts/swmap/lib/"..RADIO..".lua"
		if existFile(file)==false then 
			fromfile="/scripts/swmap/lib/x"..string.sub(RADIO,2,3)..".lua"
			copyFile(fromfile,file)
		end
		file="/scripts/swmap/bitmaps/"..RADIO..".png"
		if existFile(file)==true then 
			bitmap = lcd.loadBitmap(file)	
		else
			fromfile="/scripts/swmap/bitmaps/x"..string.sub(RADIO,2,3)..".png"
			copyFile(fromfile,file)
			bitmap = lcd.loadBitmap(file)	
		end
	end
	system.registerWidget({key="swmap", name=name,  read=load_data, write=write, create=create, paint=paint,  wakeup=wakeup,   configure=configure, event=event, title=false })
end
return {init=init}
