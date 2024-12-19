-- Positions for X20 transmitters
local sw= { 
	{"SA", 5, 53, 200, nil, nil, nil, nil,nil,nil,nil,nil,203, 75, COLOR_ORANGE},
	{"SB", 5, 75, 225, 225,  75, 240,  51,nil,nil,nil,nil,240, 75, COLOR_ORANGE },
	{"SC",-1, 75, 535, 535,  75, 523,  51,nil,nil,nil,nil,526, 75, COLOR_ORANGE },
	{"SD",-1, 53, 560, nil, nil, nil, nil,nil,nil,nil,nil,562, 75, COLOR_ORANGE},
	{"SE", 5, 22, 225, nil, nil, nil, nil, nil,nil,nil,nil,222, 45, COLOR_ORANGE },
	{"SF", 5,  3, 252, 252,   3, 259,  21, nil,nil,nil,nil,259, 45, COLOR_ORANGE },
	{"SG",-1, 22, 544, nil, nil, nil, nil, nil,nil,nil,nil,546, 45, COLOR_ORANGE }, 
	{"SH",-1,  3, 525, 525,   3, 512,  21, nil,nil,nil,nil,510, 45, COLOR_ORANGE },
	{"SI", 5, 112, 165, nil, nil, nil, nil,nil,nil,nil,nil,167,130,COLOR_ORANGE },
	{"SJ",-1, 112, 610, nil, nil, nil, nil,nil,nil,nil,nil,607, 130, COLOR_ORANGE },
	{"FS1", 5, 200, 320, 320, 200, 333, 186,COLOR_YELLOW, COLOR_YELLOW, COLOR_YELLOW, nil, 332,205, COLOR_GREEN },			--SA
	{"FS2", 5, 240, 343, 343, 240, 343, 201,COLOR_YELLOW, COLOR_YELLOW, COLOR_YELLOW, nil, 343,221, COLOR_GREEN },			--SB
	{"FS3", 5, 220, 333, nil, nil, nil, nil,COLOR_YELLOW, COLOR_YELLOW, COLOR_YELLOW, nil, 331,238, COLOR_ORANGE},			--SC
	{"FS4", -1, 200, 442, 442, 200, 442, 186,COLOR_YELLOW, COLOR_YELLOW, COLOR_YELLOW,nil, 441,205, COLOR_GREEN },			--SD
	{"FS5", -1, 240, 432, 432, 240, 432, 201,COLOR_YELLOW, COLOR_YELLOW, COLOR_YELLOW,nil, 430,221, COLOR_GREEN },			--SE
	{"FS6", -1, 220, 442,nil, nil, nil, nil,COLOR_YELLOW, COLOR_YELLOW, COLOR_YELLOW, nil, 442,238, COLOR_ORANGE},			--SF
	{"Pot1", 280, 10, 430, 345,  10, 345,  56,nil,nil,nil,nil,347, 84, COLOR_MAGENTA },
	{"Pot2", 360,  35, 480, 413,  35, 413,  56,nil,nil,nil,nil,412, 84, COLOR_GREEN },
	{"Pot3", 270, 275, 500, 386, 275, 386, 181, nil,nil,nil,nil,386, 184, COLOR_GREEN },
	{"Drehg. li.",  5, 135, 185, 185, 135, 195, 111, nil,nil,nil,nil,nil,nil,211,121, COLOR_YELLOW },
	{"Drehg. re.", -1, 135, 582, 582, 135, 578, 111,nil,nil,nil,nil,563,121,COLOR_YELLOW },
	-- Trimmung links 																										
	{"T4 links",  5, 156, 330, nil, nil, nil, nil,COLOR_MAGENTA, COLOR_MAGENTA, COLOR_MAGENTA, nil,328,174,COLOR_YELLOW },  --SA
	{"T4 rechts", 5, 175, 335, 335, 175, 345, 156,COLOR_MAGENTA, COLOR_MAGENTA, COLOR_MAGENTA, nil,350,174,COLOR_YELLOW },	--SB
	{"T3 tief", 225, 100, 346, 346, 110, 346 ,99,COLOR_MAGENTA, COLOR_MAGENTA, COLOR_MAGENTA, nil,346,144,COLOR_YELLOW },	--SC
	{"T3 hoch", 225, 130, 346, 346, 130, 346 ,121,COLOR_MAGENTA, COLOR_MAGENTA, COLOR_MAGENTA, nil,346,126,COLOR_YELLOW },	--SD
	-- Trimmung rechts	
	{"T2 tief", 426, 100, 544 ,426, 110, 426, 99,COLOR_MAGENTA, COLOR_MAGENTA, COLOR_MAGENTA,nil,425,126,COLOR_YELLOW },	--SA
	{"T2 hoch", 426, 130, 544 ,426, 130, 426, 121,COLOR_MAGENTA, COLOR_MAGENTA, COLOR_MAGENTA,nil,425,144,COLOR_YELLOW },	--SB
	{"T1 rechts", -1, 156, 440, nil, nil, nil, nil,COLOR_MAGENTA, COLOR_MAGENTA, COLOR_MAGENTA,nil,423,174,COLOR_YELLOW },	--SC
	{"T1 links",-1, 175, 440, 440, 175, 426, 156,COLOR_MAGENTA, COLOR_MAGENTA, COLOR_MAGENTA,nil,443,174,COLOR_YELLOW },	--SD
-- nicht verbaut
	{"T5 rechts", 0, 0}, 
	{"T6 rechts", 0, 0}, 
	{"T5 links", 0, 0}, 
	{"T6 links", 0, 0}, 
	{"Ext1", 0, 0}, 
	{"Ext2", 0, 0}, 
	{"SN", 0, 0}, 
	{"SM", 0, 0}, 
	{"SL", 0, 0}, 
	{"SK", 0, 0}, 
}
return sw