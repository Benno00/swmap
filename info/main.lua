-- *********************************************************************************
-- *********************************************************************************
-- ** B. Jurisch® Widget Screen (Info)                                      **
-- *********************************************************************************
-- ** Autor: B. Jurisch 2023, E-Mail: benno.jurisch@gmail.de                **
-- ** 1. Das Widget kann kostenlos für den persönlichen Gebrauch verwendet werden.**
-- **    sie dürfen es nicht verteilen oder an andere weiterleiten.               **
-- **                                                                             **
-- ** 2. Widgets werden GRATIS als Geschenk von mir im https://frsky-forum.de     **
-- **    Der Firma Andreas Engel Modellbau & Technik  bereitgestell               **
-- **                                                                             **
-- ** Wenn Sie eine Spende senden möchten, um einen Teil der Entwicklungsarbeit   **
-- ** zu honorieren wäre ich Ihnen dankbar                                        **
-- ** Gerne per Paypal an benno.jurisch@dg-email.de vielen Dank                   **
-- *********************************************************************************

--**********************************************************************************
-- ** B. Jurisch® Widget Screen (Info)                                       **
--**********************************************************************************
-- ** Author: B. Jurisch 2023, email: benno.jurisch@gmail.de                **
-- ** 1. The widget is free to use for personal use.                              **
-- ** You may not distribute it or forward it to others.                          **
-- **                                                                             **
-- ** 2. Widgets will be FREE as a gift from me at https://frsky-forum.de         **
-- ** Provided by Andreas Engel Modellbau & Technik                               **
-- **                                                                             **
-- **If you would like to send a donation to be part of the development work      **
-- ** I would be grateful if you paid                                             **
-- ** Gladly via Paypal to benno.jurisch@dg-email.de thank you                    **
--**********************************************************************************
local version = "1.2"
local translations = {en="Info", de="Info"}
local fonts={{"FONT_STD",0},{"FONT_BOLD",256}, {"FONT_ITALIC",512},{"FONT_XS",1280}, {"FONT_XS_BOLD",1536},{"FONT_S",1792},{"FONT_L",2304},{"FONT_L_BOLD",2560},{"FONT_XL",2816},{"FONT_XXL",3072},{"FONT_S_BOLD",2048} }
local path = "/scripts/info/modelle/"

local langu={}
if system.getLocale() == "de" then	
	langu={"Schrift",
		   "Hintergrundfarbe",
		   "Schriftfarbe",
		   "Lade Datei",
		   "Datei nicht gefunden oder nicht konfiguriert",
		  }
	
else
	langu={"Font",
		   "Backcolor",
		   "Fontcolor",
		   "Load file",
		   "File not found or not config",
		  }
end  

local function name()
    local locale = system.getLocale()
    return translations[locale] or translations["en"]
end


local function read_file_1(widget)
	file="modelle/"..widget.filename..".txt"
	local fileOpen=io.open(file,"r")
	if fileOpen==nil then
		widget.text=nil
		return 
	end
	local zz=1;
	widget.text={}
	while true do
		widget.text[zz]= io.read(fileOpen,"l")
		if (widget.text[zz] == nil) then break end
		widget.text[zz]=string.sub(widget.text[zz],1,string.len(widget.text[zz])-1)
		zz=zz+1
	end
	io.close(fileOpen)
end 

local function create(widget)
	return {text={},font=Font_STD, backcolor=THEME_DEFAULT_BGCOLOR,farbe=ORANGE,filename=""}
end


local function configure(widget)
	line = form.addLine(langu[1])
	local field_alignment = form.addChoiceField(line, form.getFieldSlots(line)[0], fonts, function() return widget.font end, function(value) widget.font = value end)
	line = form.addLine(langu[2])
	widget.field_color = form.addColorField(line, nil, function() return widget.backcolor end, function(color) widget.backcolor = color end)
	line = form.addLine(langu[3])
	widget.field_color = form.addColorField(line, nil, function() return widget.farbe end, function(color) widget.farbe = color end)
	line=form.addLine(langu[4])
	form.addFileField(line, nil, path, "any+ext", function() return widget.filename end, function(newValue) widget.filename = newValue end)
end

local function paint(widget)
	read_file_1(widget)
	if widget.text==nil then
		widget.text={langu[5], widget.filename}
	end
	widget.w, widget.h = lcd.getWindowSize()
	lcd.color(widget.backcolor)
	lcd.drawFilledRectangle(0, 0, widget.w, widget.h)
	local pos_x, pos_y=0,0
	lcd.font(widget.font)
	lcd.color(widget.farbe)
	local s_font_w, s_font_h = lcd.getTextSize("W")
	for idx,key in pairs(widget.text) do
		if pos_y >=widget.h - s_font_h then break end
		if widget.text[idx]~=nil then
			lcd.drawText(pos_x,pos_y,widget.text[idx])
		end
		pos_y=pos_y+s_font_h+1
    end
end

local function read(widget)
	widget.font= storage.read("string")
	widget.backcolor=storage.read("string")
	widget.farbe=storage.read("string")
	widget.filename=storage.read("string")
end

local function write(widget)
	storage.write("string",widget.font)
	storage.write("string", widget.backcolor)
	storage.write("string", widget.farbe)
	if widget.filename~=nil then 
		storage.write("string", widget.filename)
		read_file_1(widget)
	end
end
local function init()
   	system.registerWidget({key="BJInfo", name=name, create=create, paint=paint,configure=configure, write=write, read=read, })
end
return {init=init}
