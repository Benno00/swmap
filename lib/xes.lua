--- Positions for X20 transmitters
local sw= { 
	{"SA", 5, 50, 248, 248, 50, 248, 54,nil,nil,nil,FONT_XS,248, 60, COLOR_ORANGE},
	{"SB", 5, 15, 287, 287, 15, 287, 50,nil,nil,nil,FONT_XS,288, 60, COLOR_ORANGE },
	{"SC", 5, 0, 327, 327, 0, 327, 50,nil,nil,nil,FONT_XS,327, 60, COLOR_ORANGE },
	{"SD", 5, 65, 250, 250, 65, 250, 85,nil,nil,nil,FONT_XS,247, 87, COLOR_ORANGE},
	{"SE", 5,  80, 287, 287,  80, 287, 85, nil,nil,nil,FONT_XS,288, 87, COLOR_ORANGE },
	{"SF", 5, 95, 327, 327, 95, 327, 85, nil,nil,nil,FONT_XS,325, 87, COLOR_ORANGE },
	{"SG",-1, 0, 453, 453, 0, 453, 54, nil,nil,nil,FONT_XS,453, 60, COLOR_ORANGE }, 
	{"SH",-1,  15, 491, 491,15,491,54, nil,nil,nil,FONT_XS,491, 60, COLOR_ORANGE },
	{"SI",-1, 50, 530, 530, 50, 530, 54,nil,nil,nil,FONT_XS,530, 60, COLOR_ORANGE },
	{"SJ", -1, 95, 453, 453, 95, 453, 85,nil,nil,nil,FONT_XS,453,87,COLOR_ORANGE },
	{"SK",-1, 80, 491, 491, 80, 491, 85,nil,nil,nil,FONT_XS,491, 87, COLOR_ORANGE },
	{"SL",  -1, 65, 530, 530, 65, 530, 85,nil,nil,nil,FONT_XS,530, 87, COLOR_ORANGE },
	
	{"Pot1", 5, 33, 181, nil,nil,nil,nil,nil,nil,nil,FONT_XS,182, 47, COLOR_MAGENT },
	{"Pot2", 5, 115, 179,nil,nil,nil,nil,nil,nil,nil,FONT_XS,180, 125, COLOR_GREEN },
	{"Pot3",-1,  33, 593,nil,nil,nil,nil,nil,nil,nil,FONT_XS,593, 47, COLOR_GREEN },
	{"Pot4",-1, 115, 593,nil,nil,nil,nil,nil,nil,nil,FONT_XS,593, 125, COLOR_GREEN },	
	{"Drehg. li.",  5, 179, 166, nil,nil,nil,nil,nil,nil,nil,FONT_XS,170,195, COLOR_YELLOW },
	{"Drehg. re.", -1, 180, 606, nil,nil,nil,nil,nil,nil,nil,FONT_XS,608,195,COLOR_YELLOW },
	{"L1", 230, 120, 373, 373,120,373,165,nil,nil,nil,FONT_XS,373, 165, COLOR_GREEN },
	{"L2", 400, 120, 530, 400,120,400,165,nil,nil,nil,FONT_XS,402, 165, COLOR_GREEN },

	{"FS1", 5, 225, 235, nil,nil,nil,nil,COLOR_YELLOW, COLOR_YELLOW, COLOR_YELLOW,FONT_XS, 233,240, COLOR_GREEN },
	{"FS2", 5, 242, 245, nil,nil,nil,nil,COLOR_YELLOW, COLOR_YELLOW, COLOR_YELLOW,FONT_XS, 247,257, COLOR_GREEN },
	{"FS3", 5, 257, 235, nil, nil, nil, nil,COLOR_YELLOW, COLOR_YELLOW, COLOR_YELLOW,FONT_XS,235, 273, COLOR_ORANGE},	
	{"FS4", -1, 223, 539, nil, nil, nil, nil,COLOR_YELLOW, COLOR_YELLOW, COLOR_YELLOW,FONT_XS, 539,240, COLOR_GREEN },
	{"FS5", -1, 240, 528, nil, nil, nil, nil,COLOR_YELLOW, COLOR_YELLOW, COLOR_YELLOW,FONT_XS, 528,257, COLOR_GREEN },
	{"FS6", -1, 255, 539,nil, nil, nil, nil,COLOR_YELLOW, COLOR_YELLOW, COLOR_YELLOW,FONT_XS,539, 273, COLOR_ORANGE},
-- nicht verbaut	
	{"SM",0, 0, 610, nil, nil, nil, nil,nil,nil,nil,nil,607, 130, COLOR_ORANGE },
	{"SN",0, 0, 610, nil, nil, nil, nil,nil,nil,nil,nil,607, 130, COLOR_ORANGE },
	{"Ext1", 0, 0, 500,386,275,386,200, nil,nil,nil,nil,nil,386, 184, COLOR_GREEN },
	{"Ext2", 0, 0, 500,386,275,386,200, nil,nil,nil,nil,nil,386, 184, COLOR_GREEN },


	-- Trimmung links 	
	{"T2 hoch", 430, 138, 530, nil, nil, nil, nil,COLOR_MAGENTA, COLOR_MAGENTA, COLOR_MAGENTA, FONT_XS,428,152,COLOR_YELLOW },
	{"T2 tief", 430, 154, 530, nil, nil, nil, nil,COLOR_MAGENTA, COLOR_MAGENTA, COLOR_MAGENTA, FONT_XS,428,172, COLOR_GREEN },
	{"T3 hoch", 230,138, 348, nil, nil, nil, nil,COLOR_MAGENTA, COLOR_MAGENTA, COLOR_MAGENTA, FONT_XS,346,152,COLOR_YELLOW },
	{"T3 tief", 230,154, 348, nil, nil, nil, nil,COLOR_MAGENTA, COLOR_MAGENTA, COLOR_MAGENTA, FONT_XS,346,172,COLOR_YELLOW },
	-- Trimmung rechts	
	{"T4 links", 5, 210, 264,nil, nil, nil, nil,COLOR_MAGENTA, COLOR_MAGENTA, COLOR_MAGENTA, FONT_XS,264,228,COLOR_GREEN},
	{"T4 rechts",280, 210, 400,nil, nil, nil, nil,COLOR_MAGENTA, COLOR_MAGENTA, COLOR_MAGENTA, FONT_XS,280,228,COLOR_GREEN},
	{"T1 links", 320, 230, 496, 496, 230, 496, 225,COLOR_MAGENTA, COLOR_MAGENTA, COLOR_MAGENTA, FONT_XS,495,228,COLOR_RED },
	{"T1 rechts",510, 210, 760, nil, nil, nil, nil,COLOR_MAGENTA, COLOR_MAGENTA, COLOR_MAGENTA, FONT_XS,510,228,COLOR_RED },
	-- Trimmung T5 & T6
	{"T5 hoch", 5, 134, 200, 200, 134, 214, 138,COLOR_MAGENTA, COLOR_MAGENTA, COLOR_MAGENTA,FONT_XS,214,140,COLOR_GREEN},
	{"T5 tief", 5, 150, 212, 212, 150, 212, 154,COLOR_MAGENTA, COLOR_MAGENTA, COLOR_MAGENTA,FONT_XS,214,155,COLOR_GREEN},
	{"T6 hoch", -1, 134, 570 ,570, 134, 561, 138,COLOR_MAGENTA, COLOR_MAGENTA, COLOR_MAGENTA,FONT_XS,561,140,COLOR_GREEN},
	{"T6 tief", -1, 150, 560 ,560, 150, 560, 154,COLOR_MAGENTA, COLOR_MAGENTA, COLOR_MAGENTA,FONT_XS,561,155,COLOR_GREEN},
	
}
return sw
--[[
	

	

--]]