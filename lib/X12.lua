-- Positions for X10 transmitters
local sw= { 
-- Left Side                           co1,col,col,font,kreis p1,p2, col  
--	{"CC", 5, 36, 115, nil,nil,nil,nil,nil,nil,nil,FONT_XS,115, 45, ORANGE },  
	{"SE", 5, 15, 130, 130, 15,130, 20,nil,nil,nil,FONT_XS,130, 25, COLOR_ORANGE }, 
	{"SF", 5,  0, 148, 148, 0, 148, 20,nil,nil,nil,nil,148, 25, COLOR_ORANGE }, 
	{"SA", 5, 30, 118,nil,nil,nil,nil,nil,nil,nil,nil,118, 43, COLOR_ORANGE }, 
	{"SB",         5, 45, 135, 135,45 ,135, 42,nil,nil,nil,nil,135, 43, COLOR_ORANGE }, 
	{"Drehg. li.", 5, 83, 120, nil,nil,nil,nil,nil,nil,nil,nil,120, 98, COLOR_ORANGE }, 
	{"Drehg. re.", -1, 83, 350,nil,nil,nil,nil,nil,nil,nil,nil,347, 98, COLOR_ORANGE }, 

-- Right side
	{"SC", -1, 45, 332, 332,45,332,45,nil,nil,nil,nil,334, 45, COLOR_ORANGE }, 
	{"SD", -1, 30, 350,nil,nil,nil,nil,nil,nil,nil,nil,347, 45, COLOR_ORANGE },  
	{"SG",-1, 15, 340, 340, 15, 335, 20,nil,nil,nil,nil,337, 25, COLOR_ORANGE },  
	{"SH", -1, 0, 330,330,0,320,20,nil,nil,nil,nil,320, 25, COLOR_ORANGE }, 
-- TOP
	{"Pot1", 180, 0, 250, 203,  0,203, 48,nil,nil,nil,nil,203, 55, COLOR_ORANGE }, 
	{"Pot2", 220, 15, 280, 263,15,263,48,nil,nil,nil,nil,263, 55, COLOR_ORANGE }, 
	{"Pot3", 170, 65, 250, 233,65,233,48,nil,nil,nil,nil,233, 55, COLOR_ORANGE }, 	
-- Trimmung links 	
	{"T4 links", 5, 120, 190, nil, nil, nil, nil,COLOR_MAGENTA, COLOR_MAGENTA, COLOR_MAGENTA, nil,193,132,COLOR_YELLOW },
	{"T4 rechts", 5, 135, 210, 210, 135, 210, 135,COLOR_MAGENTA, COLOR_MAGENTA, COLOR_MAGENTA, nil,212,132, COLOR_GREEN },
	{"T3 hoch", 5, 97, 195, 195, 97, 205 ,97,COLOR_MAGENTA, COLOR_MAGENTA, COLOR_MAGENTA, nil,205, 97,COLOR_YELLOW }, 
	{"T3 tief", 5, 110, 200, 200, 110, 210 , 100,COLOR_MAGENTA, COLOR_MAGENTA, COLOR_MAGENTA, nil,205,110,COLOR_YELLOW },
-- Trimmung rechts	
	{"T2 hoch", -1,  97, 265 ,265, 97, 255, 97,COLOR_MAGENTA, COLOR_MAGENTA, COLOR_MAGENTA,nil,255,110,COLOR_GREEN},
	{"T2 tief", -1, 110, 265 ,265, 110, 255, 110,COLOR_MAGENTA, COLOR_MAGENTA, COLOR_MAGENTA,nil,255,97,COLOR_GREEN},
	{"T1 rechts", -1, 120, 275, nil, nil, nil, nil,COLOR_MAGENTA, COLOR_MAGENTA, COLOR_MAGENTA,nil,255,132,COLOR_RED },
	{"T1 links",  -1, 135, 260, 260, 135, 255, 130,COLOR_MAGENTA, COLOR_MAGENTA, COLOR_MAGENTA,nil,275,132,COLOR_RED },
-- nicht verbaut
	{"T5", 0, 0}, 
	{"T6", 0, 0}, 
	{"Ext1", 0,0}, 
	{"Ext2", 0,0}, 
}
return sw