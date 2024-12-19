
-- Positions for X20pro transmitters
local sw= { 
	{"SA", 5, 135, 218, nil, nil, nil, nil,nil,nil,nil,nil,203, 75, COLOR_ORANGE},
	{"SB", 5, 155, 230, 230, 155, 249,135,nil,nil,nil,nil,240, 75, COLOR_ORANGE },
	{"SC",-1, 155, 561, 560, 155, 541,135,nil,nil,nil,nil,526, 75, COLOR_ORANGE },
	{"SD",-1, 135, 572, nil, nil, nil, nil,nil,nil,nil,nil,562, 75, COLOR_ORANGE},
	{"SE", 5, 84, 227, 227, 84, 237, 93, nil,nil,nil,nil,222, 45, COLOR_ORANGE },
	{"SF", 5, 64, 238, 238, 64, 268, 93, nil,nil,nil,nil,259, 45, COLOR_ORANGE },
	{"SG",-1, 84, 567, 567, 84, 555, 95, nil,nil,nil,nil,546, 45, COLOR_ORANGE }, 
	{"SH",-1, 64, 556, 556,  64, 524, 95, nil,nil,nil,nil,510, 45, COLOR_ORANGE },
	{"SI", 5, 195, 182, nil, nil, nil, nil,nil,nil,nil,nil,167,130,COLOR_ORANGE },
	{"SJ",-1, 195, 606, nil, nil, nil, nil,nil,nil,nil,nil,607, 130, COLOR_ORANGE },
	{"SK", 5, 104, 187, nil, nil, nil, nil, nil,nil,nil,nil,222, 45, COLOR_ORANGE },
	{"SL",-1, 104, 606, nil, nil, nil, nil,nil,nil,nil,nil,562, 75, COLOR_ORANGE},
	{"FS1", 5, 310, 298, 299, 310, 343, 265,COLOR_YELLOW, COLOR_YELLOW, COLOR_YELLOW, nil, 332,205, COLOR_GREEN },			--SA
	{"FS2", 5, 330, 312, 313, 329, 343, 298,COLOR_YELLOW, COLOR_YELLOW, COLOR_YELLOW, nil, 331,238, COLOR_ORANGE},			--SC
	{"FS3", 5, 350, 354, 354, 350, 354, 283,COLOR_YELLOW, COLOR_YELLOW, COLOR_YELLOW, nil, 343,221, COLOR_GREEN },			--SB
	{"FS4", -1, 310, 493, 492, 310, 448, 265,COLOR_YELLOW, COLOR_YELLOW, COLOR_YELLOW,nil, 441,205, COLOR_GREEN },			--SD
	{"FS5", -1, 330, 482, 481, 330, 450, 298,COLOR_YELLOW, COLOR_YELLOW, COLOR_YELLOW, nil, 442,238, COLOR_ORANGE},			--SF
	{"FS6", -1, 350, 437, 437, 350, 437, 283,COLOR_YELLOW, COLOR_YELLOW, COLOR_YELLOW,nil, 430,221, COLOR_GREEN },			--SE
	{"Pot1", 291, 44, 449, 366, 44, 366, 145,nil,nil,nil,nil,347, 84, COLOR_MAGENTA },
	{"Pot2", 379,  64, 520, 425,  64, 425, 145,nil,nil,nil,nil,412, 84, COLOR_GREEN },
	{"Pot3", 280, 375, 510, 395, 375, 395, 280, nil,nil,nil,nil,386, 184, COLOR_GREEN },
	{"Drehg. li.",  5, 175, 190, 190, 175, 209, 193, nil,nil,nil,nil,nil,nil,211,121, COLOR_YELLOW },
	{"Drehg. re.", -1, 175, 602, 602, 175, 583, 193,nil,nil,nil,nil,563,121,COLOR_YELLOW },
	-- Trimmung links 																										
	{"T4 links",  5, 237, 342, nil, nil, nil, nil,COLOR_MAGENTA, COLOR_MAGENTA, COLOR_MAGENTA, nil,328,174,COLOR_YELLOW },  --SA
	{"T4 rechts", 5, 217, 337, 337, 217, 358, 237,COLOR_MAGENTA, COLOR_MAGENTA, COLOR_MAGENTA, nil,350,174,COLOR_YELLOW },	--SB
	{"T3 tief", 225, 186, 350, 350, 186, 356 ,191,COLOR_MAGENTA, COLOR_MAGENTA, COLOR_MAGENTA, nil,346,126,COLOR_YELLOW },	--SD
	{"T3 hoch", 225, 206, 353, nil, nil, nil ,99,COLOR_MAGENTA, COLOR_MAGENTA, COLOR_MAGENTA, nil,346,144,COLOR_YELLOW },	--SC
	-- Trimmung rechts	
	{"T2 tief", 441, 186, 544 ,441, 186, 432, 192,COLOR_MAGENTA, COLOR_MAGENTA, COLOR_MAGENTA,nil,425,126,COLOR_YELLOW },	--SA
	{"T2 hoch", 443, 206, 544 ,443, 206, 432, 205,COLOR_MAGENTA, COLOR_MAGENTA, COLOR_MAGENTA,nil,425,144,COLOR_YELLOW },	--SB
	{"T1 links", -1, 217, 450, 450, 217, 430, 205,COLOR_MAGENTA, COLOR_MAGENTA, COLOR_MAGENTA,nil,423,174,COLOR_YELLOW },	--SC
	{"T1 rechts",-1, 237, 448, nil, nil, nil, nil,COLOR_MAGENTA, COLOR_MAGENTA, COLOR_MAGENTA,nil,443,174,COLOR_YELLOW },	--SD
-- nicht Konfiguriert 
	{"T5 links", 5, 257, 252, 252, 257, 261, 247,COLOR_MAGENTA, COLOR_MAGENTA, COLOR_MAGENTA, nil,328,174,COLOR_YELLOW },  --SA 
	{"T5 rechts", 5, 277, 260, 260, 277, 260, 263,COLOR_MAGENTA, COLOR_MAGENTA, COLOR_MAGENTA, nil,328,174,COLOR_YELLOW },  --SA 
	{"T6 links", -1, 257, 539, 539, 257, 530, 247,COLOR_MAGENTA, COLOR_MAGENTA, COLOR_MAGENTA,nil,423,174,COLOR_YELLOW },	--SC
	{"T6 rechts", -1, 277, 530, 530, 277, 530, 263,COLOR_MAGENTA, COLOR_MAGENTA, COLOR_MAGENTA,nil,443,174,COLOR_YELLOW },	--SD
	{"Ext1", 0, 0}, 
	{"Ext2", 0, 0}, 
	{"SN", 0, 0}, 
	{"SM", 0, 0}, 
}
return sw