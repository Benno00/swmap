-- Positions for X18 transmitters
local sw= { 
-- Left Side
--	{"CC", 5, 36, 115, nil,nil,nil,nil,nil,nil,nil,FONT_XS,115, 45, COLOR_ORANGE },  
	{"SE", 5, 15, 130, 130,15,130,20,nil,nil,nil,FONT_XS,130, 20, COLOR_ORANGE }, 
	{"SF", 5, -2, 145, 145, -2, 145, 20,nil,nil,nil,FONT_XS,145, 20, COLOR_ORANGE }, 
	{"SA", 5, 35, 117,117,35,117,35,nil,nil,nil,FONT_XS,117, 35, COLOR_ORANGE }, 
	{"SB", 5, 50, 125, 125,50 ,133,35,nil,nil,nil,FONT_XS,133, 35, COLOR_ORANGE }, 
	{"SI", 5, 65, 98,nil,nil,nil,nil,nil,nil,nil,FONT_XS,96, 80, COLOR_ORANGE }, 
	{"Drehg. li.", 5, 85, 100, 100, 85, 116, 80,nil,nil,nil,FONT_XS,116, 80, COLOR_ORANGE }, 
-- TOP
	{"Pot1", 160, 0, 225, 209,0,209,43,nil,nil,nil,FONT_XS,208, 46, COLOR_ORANGE }, 
	{"Pot2", 240, 0, 310, 254,0,254,43,nil,nil,nil,FONT_XS,254, 46, COLOR_ORANGE }, 
-- Right side
	{"SC", -1, 50, 338, 338,50,330,35,nil,nil,nil,FONT_XS,330, 40, COLOR_ORANGE }, 
	{"SD", -1, 35, 348,348,35,348,35,nil,nil,nil,FONT_XS,348, 40, COLOR_ORANGE }, 
	{"SG", -1, 15, 336,336,15,336,20,nil,nil,nil,FONT_XS,336, 20, COLOR_ORANGE },  
	{"SH", -1, -2, 328,328,-2,316,20,nil,nil,nil,FONT_XS,316, 20, COLOR_ORANGE },  
	{"Drehg. re.", -1, 83, 353,353,83,346,80,nil,nil,nil,FONT_XS,346, 80, COLOR_ORANGE }, 
	{"SJ", -1, 65, 368,nil,nil,nil,nil,nil,nil,nil,FONT_XS,365, 80, COLOR_ORANGE }, 
-- Functionswitch3
	{"FS1", 5, 120, 194,nil,nil,nil,nil,nil,nil,nil,FONT_XS,194, 135, COLOR_ORANGE }, 
	{"FS2", 5, 132, 200,nil,nil,nil,nil,nil,nil,nil,FONT_XS,200, 145, COLOR_ORANGE }, 
	{"FS3", 5, 145, 194,nil,nil,nil,nil,nil,nil,nil,FONT_XS,194, 158, COLOR_ORANGE }, 
	{"FS4", -1, 120, 272,nil,nil,nil,nil,nil,nil,nil,FONT_XS,272, 135, COLOR_ORANGE }, 
	{"FS5", -1, 132, 264,nil,nil,nil,nil,nil,nil,nil,FONT_XS,264, 145, COLOR_ORANGE }, 
	{"FS6", -1, 145, 272,nil,nil,nil,nil,nil,nil,nil,FONT_XS,272, 158, COLOR_ORANGE }, 
	-- Trimmung links 	
	{"T4 links",  5, 85, 180, 180, 85, 188, 108,COLOR_MAGENTA, COLOR_MAGENTA, COLOR_MAGENTA, FONT_XS,180,110,COLOR_MAGENTA },		--SA
	{"T4 rechts", 5, 105, 190, 190, 105, 196, 108,COLOR_MAGENTA, COLOR_MAGENTA, COLOR_MAGENTA, FONT_XS,200,110, COLOR_MAGENTA },		--SB
	{"T3 tief",   130, 80, 220, nil, nil, nil ,nil,COLOR_MAGENTA, COLOR_MAGENTA, COLOR_MAGENTA, FONT_XS,205,95,COLOR_MAGENTA },		--SC
	{"T3 hoch",   130, 65, 200, nil, nil, nil ,nil,COLOR_MAGENTA, COLOR_MAGENTA, COLOR_MAGENTA, FONT_XS,205,75,COLOR_MAGENTA },		--SD
	-- Trimmung rechts	
	{"T2 tief",  255, 80, 325 ,nil, nil, nil ,nil,COLOR_MAGENTA, COLOR_MAGENTA, COLOR_MAGENTA,FONT_XS,255,95,COLOR_MAGENTA},			--SA
	{"T2 hoch",  255, 65, 325 ,nil, nil, nil ,nil,COLOR_MAGENTA, COLOR_MAGENTA, COLOR_MAGENTA,FONT_XS,255,75,COLOR_MAGENTA},			--SB
	{"T1 links", -1, 85, 278, 278, 85, 278, 108,COLOR_MAGENTA, COLOR_MAGENTA, COLOR_MAGENTA,FONT_XS,280,110,COLOR_MAGENTA },			--SC
	{"T1 rechts", -1, 105, 270, 270, 105, 270, 108,COLOR_MAGENTA, COLOR_MAGENTA, COLOR_MAGENTA,FONT_XS,270,110,COLOR_MAGENTA },			--SD
	
	-- T5 u.- T6
	{"T5 links",  5, 160, 210, 210, 160, 205, 110,COLOR_MAGENTA, COLOR_MAGENTA, COLOR_MAGENTA, FONT_XS,185,110,COLOR_MAGENTA },		--SA
	{"T5 rechts", 5, 175, 220, 220, 175, 218, 110,COLOR_MAGENTA, COLOR_MAGENTA, COLOR_MAGENTA, FONT_XS,195,110, COLOR_MAGENTA },		--SB
	{"T6 links", -1, 160, 245, 245, 160, 255, 110,COLOR_MAGENTA, COLOR_MAGENTA, COLOR_MAGENTA, FONT_XS,250,110, COLOR_MAGENTA },		--SC	
	{"T6 rechts",  -1, 175, 230, 230, 175, 245, 110, COLOR_MAGENTA, COLOR_MAGENTA, COLOR_MAGENTA, FONT_XS,260,110,COLOR_MAGENTA },	--SD

}
return sw
