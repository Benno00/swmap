-- Positions for X18 transmitters
local sw= { 
-- Left Side
	{"SC",   5,  3,  115, nil, nil, nil, nil,nil,nil,nil,nil,114, 21, COLOR_ORANGE },  
	{"SF", 130,  3,  235, 130, 3, 125, 34,nil,nil,nil,nil,125, 35, COLOR_ORANGE },  
	{"SA",   5, 28, 100, nil, nil, nil, nil,nil,nil,nil,nil,105, 45, COLOR_ORANGE },  
	{"Drehg. li.", 5, 50, 115, 115,  50, 158,  40,nil,nil,nil,nil,155, 40, COLOR_YELLOW},  
-- Right side
	{"SE", 245,  3, 330, 330, 3, 335, 35,nil,nil,nil,nil,335, 35, COLOR_ORANGE},  
	{"SD", -1, 3, 342, nil, nil, nil, nil,nil,nil,nil,nil,342, 21, COLOR_ORANGE},  
	{"SB", -1, 28, 353, nil, nil, nil, nil,nil,nil,nil,nil,354, 45, COLOR_ORANGE},  
	{"Drehg. re.", -1, 50, 353,353,50,307,40,nil,nil,nil,nil,300, 40, COLOR_YELLOW},  
-- Functionswitch3
	{"FS1", 5, 170, 195,195,170,195,160,nil,nil,nil,nil,195, 160, COLOR_ORANGE},  
	{"FS2", 5, 190, 218,218,190,218,160,nil,nil,nil,nil,220, 160, COLOR_ORANGE},  
	{"FS3", -1, 190, 240,240,190,240,160,nil,nil,nil,nil,240,160, COLOR_ORANGE},  
	{"FS4", -1, 170, 265,265,170,265,160,nil,nil,nil,nil,265,160, COLOR_ORANGE},  

	-- Trimmung links 	
	{"T4 links",  5, 93, 180, nil, nil, nil, nil,COLOR_MAGENTA, COLOR_MAGENTA, COLOR_MAGENTA, nil,180,110,COLOR_YELLOW },		--SA
	{"T4 rechts", 160, 40, 300, 197, 40, 197, 108,COLOR_MAGENTA, COLOR_MAGENTA, COLOR_MAGENTA, nil,200,110, COLOR_GREEN },		--SB
	{"T3 tief",   5, 113, 183, 183, 113, 188 ,118,COLOR_MAGENTA, COLOR_MAGENTA, COLOR_MAGENTA, nil,190,120,COLOR_YELLOW },		--SC
	{"T3 hoch",   5, 73, 183, 183, 73, 190 ,100,COLOR_MAGENTA, COLOR_MAGENTA, COLOR_MAGENTA, nil,190,100,COLOR_YELLOW },		--SD
	-- Trimmung rechts	
	{"T2 tief",  -1, 113, 280 ,280, 113, 267, 118,COLOR_MAGENTA, COLOR_MAGENTA, COLOR_MAGENTA,nil,265,120,COLOR_GREEN},			--SA
	{"T2 hoch",  -1, 73, 275 ,275, 73, 265, 100,COLOR_MAGENTA, COLOR_MAGENTA, COLOR_MAGENTA,nil,265,100,COLOR_GREEN},			--SB
	{"T1 links",205, 60, 320, 258, 60, 258, 108,COLOR_MAGENTA, COLOR_MAGENTA, COLOR_MAGENTA,nil,258,110,COLOR_RED },			--SC
	{"T1 rechts", -1, 93, 275, nil, nil, nil, nil,COLOR_MAGENTA, COLOR_MAGENTA, COLOR_MAGENTA,nil,275,110,COLOR_RED },			--SD
	
	-- T5 u.- T6
	{"T5 links",  5, 130, 185, 185, 130, 198, 138,COLOR_MAGENTA, COLOR_MAGENTA, COLOR_MAGENTA, nil,195,138,COLOR_YELLOW },		--SA
	{"T5 rechts", 5, 145, 175, 175, 145, 208, 138,COLOR_MAGENTA, COLOR_MAGENTA, COLOR_MAGENTA, nil,205,138, COLOR_GREEN },		--SB
	{"T6 links", -1, 145, 280, 280, 145, 250, 137,COLOR_MAGENTA, COLOR_MAGENTA, COLOR_MAGENTA, nil,250,138, COLOR_GREEN },		--SC	
	{"T6 rechts",  -1, 130, 270, 270, 130, 259, 137, COLOR_MAGENTA, COLOR_MAGENTA, COLOR_MAGENTA, nil,260,138,COLOR_YELLOW },	--SD

-- nicht verbaut
	{"FS5", 0, 0 },
	{"FS6", 0, 0 },
}
return sw

