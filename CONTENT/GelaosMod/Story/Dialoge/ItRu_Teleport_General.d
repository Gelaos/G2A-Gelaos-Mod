//---------------------------------------------------------------------
//	Set enabled/disabled teleport locations
//---------------------------------------------------------------------
func void InitializeTeleportLocations() {
	// NewWorld - nature
	Teleport_Location_IsEnabled [ TELEPORT_NW_NATURE_PORTAL				] = true;
	Teleport_Location_IsEnabled [ TELEPORT_NW_NATURE_PYRAMID			] = true;
	Teleport_Location_IsEnabled [ TELEPORT_NW_NATURE_TROLLAREA			] = true;
	Teleport_Location_IsEnabled [ TELEPORT_NW_NATURE_SUNCIRCLE			] = true;
	Teleport_Location_IsEnabled [ TELEPORT_NW_NATURE_BIGFORESTNORTH		] = true;
	Teleport_Location_IsEnabled [ TELEPORT_NW_NATURE_BIGFORESTCENTER	] = true;
	Teleport_Location_IsEnabled [ TELEPORT_NW_NATURE_LIGHTHOUSE			] = true;
	Teleport_Location_IsEnabled [ TELEPORT_NW_NATURE_AKIL				] = true;
	Teleport_Location_IsEnabled [ TELEPORT_NW_NATURE_TAVERNE			] = true;
	Teleport_Location_IsEnabled [ TELEPORT_NW_NATURE_MONASTERY			] = true;
	Teleport_Location_IsEnabled [ TELEPORT_NW_NATURE_SEKOB 				] = true;
	Teleport_Location_IsEnabled [ TELEPORT_NW_NATURE_DEXTER 			] = true;
	Teleport_Location_IsEnabled [ TELEPORT_NW_NATURE_ONARCROSSROAD 		] = true;
	Teleport_Location_IsEnabled [ TELEPORT_NW_NATURE_ONAR 				] = true;
	Teleport_Location_IsEnabled [ TELEPORT_NW_NATURE_BENGAR 			] = true;
	Teleport_Location_IsEnabled [ TELEPORT_NW_NATURE_PASSWATERFALLS 	] = true;
	Teleport_Location_IsEnabled [ TELEPORT_NW_NATURE_PASS 				] = true;
	Teleport_Location_IsEnabled [ TELEPORT_NW_NATURE_XARDAS 			] = true;
	Teleport_Location_IsEnabled [ TELEPORT_NW_NATURE_LOBART 			] = true;
	Teleport_Location_IsEnabled [ TELEPORT_NW_NATURE_SAGITTA 			] = true;

	// NewWorld - city	
	Teleport_Location_IsEnabled [ TELEPORT_NW_CITY_SOUTHGATE ] = true;
	Teleport_Location_IsEnabled [ TELEPORT_NW_CITY_ADANOS 	 ] = true;
	Teleport_Location_IsEnabled [ TELEPORT_NW_CITY_MARKET 	 ] = true;
	Teleport_Location_IsEnabled [ TELEPORT_NW_CITY_KASERNE 	 ] = true;
	Teleport_Location_IsEnabled [ TELEPORT_NW_CITY_HARBOR 	 ] = true;
	Teleport_Location_IsEnabled [ TELEPORT_NW_CITY_UPPERCITY ] = true;
	Teleport_Location_IsEnabled [ TELEPORT_NW_CITY_SEWERS 	 ] = true;
	
	// Valley of mines
	Teleport_Location_IsEnabled [ TELEPORT_OW_EXCHANGEPLACE ] = true;
	Teleport_Location_IsEnabled [ TELEPORT_OW_NORTHGATE 	] = true;
	Teleport_Location_IsEnabled [ TELEPORT_OW_OLDMINE 		] = true;
	Teleport_Location_IsEnabled [ TELEPORT_OW_CASTLE		] = true;
	Teleport_Location_IsEnabled [ TELEPORT_OW_SOUTHGATE 	] = true;
	Teleport_Location_IsEnabled [ TELEPORT_OW_STONEFORTRESS ] = true;
	Teleport_Location_IsEnabled [ TELEPORT_OW_CAVALORN 		] = true;
	Teleport_Location_IsEnabled [ TELEPORT_OW_NEWCAMP 		] = true;
	Teleport_Location_IsEnabled [ TELEPORT_OW_XARDAS 		] = true;
};

//---------------------------------------------------------------------
//	Info EXIT 
//---------------------------------------------------------------------
INSTANCE DIA_ItRu_Teleport_General_EXIT   (C_INFO)
{
	npc         = PC_Hero;
	nr          = 999;
	condition   = DIA_ItRu_Teleport_General_EXIT_Condition;
	information = DIA_ItRu_Teleport_General_EXIT_Info;
	permanent   = TRUE;
	description = DIALOG_ENDE;
};
FUNC INT DIA_ItRu_Teleport_General_EXIT_Condition()
{
	return TRUE;
};
FUNC VOID DIA_ItRu_Teleport_General_EXIT_Info()
{
	AI_StopProcessInfos (self);
};

//---------------------------------------------------------------------
//	Target location selection - NewWorld Nature
//---------------------------------------------------------------------
INSTANCE DIA_Teleport_Location_NW_Nature   (C_INFO)
{
	npc         = PC_Hero;
	nr          = 1;
	condition   = DIA_Teleport_Location_NW_Nature_Condition;
	information = DIA_Teleport_Location_NW_Nature_Info;
	permanent   = TRUE;
	description = "Nature -->";
};
FUNC INT DIA_Teleport_Location_NW_Nature_Condition()
{
	return (CurrentLevel == NEWWORLD_ZEN);
};
FUNC VOID DIA_Teleport_Location_NW_Nature_Info()
{
	Info_ClearChoices (DIA_Teleport_Location_NW_Nature);

	// Wilderness
	if (Teleport_Location_IsEnabled [ TELEPORT_NW_NATURE_BIGFORESTCENTER	] ) { 
		Info_AddChoice 	  (DIA_Teleport_Location_NW_Nature,"Big Forest - Center",DIA_Teleport_Location_NW_Nature_BigForestCenter);
	};
	if (Teleport_Location_IsEnabled [ TELEPORT_NW_NATURE_BIGFORESTNORTH		] ) { 
		Info_AddChoice 	  (DIA_Teleport_Location_NW_Nature,"Big Forest - North",DIA_Teleport_Location_NW_Nature_BigForestNorth);
	};
	if (Teleport_Location_IsEnabled [ TELEPORT_NW_NATURE_SUNCIRCLE			] ) { 
		Info_AddChoice 	  (DIA_Teleport_Location_NW_Nature,"Sun Circle",DIA_Teleport_Location_NW_Nature_SunCircle);
	};
	if (Teleport_Location_IsEnabled [ TELEPORT_NW_NATURE_TROLLAREA			] ) { 
		Info_AddChoice 	  (DIA_Teleport_Location_NW_Nature,"Troll area",DIA_Teleport_Location_NW_Nature_TrollArea);
	};
	if (Teleport_Location_IsEnabled [ TELEPORT_NW_NATURE_PYRAMID			] ) { 
		Info_AddChoice 	  (DIA_Teleport_Location_NW_Nature,"Pyramid valley",DIA_Teleport_Location_NW_Nature_Pyramid);
	};
	if (Teleport_Location_IsEnabled [ TELEPORT_NW_NATURE_PORTAL				] ) { 
		Info_AddChoice 	  (DIA_Teleport_Location_NW_Nature,"Portal to Jharkendar",DIA_Teleport_Location_NW_Nature_Portal); 
	};

	Info_AddChoice 	  (DIA_Teleport_Location_NW_Nature,"   ",DIA_Teleport_Location_NW_Nature);

	// Onar area
	if (Teleport_Location_IsEnabled [ TELEPORT_NW_NATURE_DEXTER 			] ) { 
		Info_AddChoice 	  (DIA_Teleport_Location_NW_Nature,"Former Dexter's camp",DIA_Teleport_Location_NW_Nature_Dexter); 
	};
	if (Teleport_Location_IsEnabled [ TELEPORT_NW_NATURE_SAGITTA 			] ) { 
		Info_AddChoice 	  (DIA_Teleport_Location_NW_Nature,"Sagitta's cave",DIA_Teleport_Location_NW_Nature_Sagitta); 
	};
	if (Teleport_Location_IsEnabled [ TELEPORT_NW_NATURE_PASS 				] ) { 
		Info_AddChoice 	  (DIA_Teleport_Location_NW_Nature,"Pass",DIA_Teleport_Location_NW_Nature_Pass); 
	};	
	if (Teleport_Location_IsEnabled [ TELEPORT_NW_NATURE_PASSWATERFALLS 	] ) { 
		Info_AddChoice 	  (DIA_Teleport_Location_NW_Nature,"Near entrance to the Pass",DIA_Teleport_Location_NW_Nature_PassWaterfalls);	 
	};
	if (Teleport_Location_IsEnabled [ TELEPORT_NW_NATURE_SEKOB 				] ) { 
		Info_AddChoice 	  (DIA_Teleport_Location_NW_Nature,"Fellan's farm",DIA_Teleport_Location_NW_Nature_Sekob); 
	};
	if (Teleport_Location_IsEnabled [ TELEPORT_NW_NATURE_BENGAR 			] ) { 
		Info_AddChoice 	  (DIA_Teleport_Location_NW_Nature,"Former Bengar's farm",DIA_Teleport_Location_NW_Nature_Bengar); 
	};	
	if (Teleport_Location_IsEnabled [ TELEPORT_NW_NATURE_ONARCROSSROAD 		] ) { 
		Info_AddChoice 	  (DIA_Teleport_Location_NW_Nature,"Farm crossroads",DIA_Teleport_Location_NW_Nature_OnarCrossroad); 
	};
	if (Teleport_Location_IsEnabled [ TELEPORT_NW_NATURE_ONAR 				] ) { 
		Info_AddChoice 	  (DIA_Teleport_Location_NW_Nature,"Onar's farm",DIA_Teleport_Location_NW_Nature_Onar); 
	};

	Info_AddChoice 	  (DIA_Teleport_Location_NW_Nature,"   ",DIA_Teleport_Location_NW_Nature);

	// city area + monastery & tavern
	if (Teleport_Location_IsEnabled [ TELEPORT_NW_NATURE_XARDAS 			] ) { 
		Info_AddChoice 	  (DIA_Teleport_Location_NW_Nature,"Xardas tower",DIA_Teleport_Location_NW_Nature_Xardas); 
	};
	if (Teleport_Location_IsEnabled [ TELEPORT_NW_NATURE_LOBART 			] ) { 
		Info_AddChoice 	  (DIA_Teleport_Location_NW_Nature,"Lobart's farm",DIA_Teleport_Location_NW_Nature_Lobart); 
	};
	if (Teleport_Location_IsEnabled [ TELEPORT_NW_NATURE_LIGHTHOUSE			] ) { 
		Info_AddChoice 	  (DIA_Teleport_Location_NW_Nature,"Lighthouse",DIA_Teleport_Location_NW_Nature_Lighthouse); 
	};							
	if (Teleport_Location_IsEnabled [ TELEPORT_NW_NATURE_AKIL				] ) { 
		Info_AddChoice 	  (DIA_Teleport_Location_NW_Nature,"Akil's farm",DIA_Teleport_Location_NW_Nature_Akil); 
	};
	if (Teleport_Location_IsEnabled [ TELEPORT_NW_NATURE_MONASTERY			] ) { 
		Info_AddChoice 	  (DIA_Teleport_Location_NW_Nature,"Monastery",DIA_Teleport_Location_NW_Nature_Monastery); 
	};
	if (Teleport_Location_IsEnabled [ TELEPORT_NW_NATURE_TAVERNE			] ) { 
		Info_AddChoice 	  (DIA_Teleport_Location_NW_Nature,"Dead Harpy tavern",DIA_Teleport_Location_NW_Nature_Taverne); 
	};	
};

func void DIA_Teleport_Location_NW_Nature_Taverne () {
	Info_ClearChoices (DIA_Teleport_Location_NW_Nature);
	AI_StopProcessInfos (self);
	AI_Teleport (self, "TAVERNE"); 
};
func void DIA_Teleport_Location_NW_Nature_Monastery () {
	Info_ClearChoices (DIA_Teleport_Location_NW_Nature);
	AI_StopProcessInfos (self);
	AI_Teleport (self, "KLOSTER"); 
};
func void DIA_Teleport_Location_NW_Nature_Akil () {
	Info_ClearChoices (DIA_Teleport_Location_NW_Nature);
	AI_StopProcessInfos (self);
	AI_Teleport (self, "FARM2"); 
};
func void DIA_Teleport_Location_NW_Nature_Lighthouse () {
	Info_ClearChoices (DIA_Teleport_Location_NW_Nature);
	AI_StopProcessInfos (self);
	AI_Teleport (self, "LIGHTHOUSE"); 
};
func void DIA_Teleport_Location_NW_Nature_Lobart () {
	Info_ClearChoices (DIA_Teleport_Location_NW_Nature);
	AI_StopProcessInfos (self);
	AI_Teleport (self, "FARM1"); 
};
func void DIA_Teleport_Location_NW_Nature_Xardas () {
	Info_ClearChoices (DIA_Teleport_Location_NW_Nature);
	AI_StopProcessInfos (self);
	AI_Teleport (self, "XARDAS"); 
};
func void DIA_Teleport_Location_NW_Nature_Onar () {
	Info_ClearChoices (DIA_Teleport_Location_NW_Nature);
	AI_StopProcessInfos (self);
	AI_Teleport (self, "BIGFARM"); 
};
func void DIA_Teleport_Location_NW_Nature_OnarCrossroad () {
	Info_ClearChoices (DIA_Teleport_Location_NW_Nature);
	AI_StopProcessInfos (self);
	AI_Teleport (self, "BIGCROSS"); 
};
func void DIA_Teleport_Location_NW_Nature_Bengar () {
	Info_ClearChoices (DIA_Teleport_Location_NW_Nature);
	AI_StopProcessInfos (self);
	AI_Teleport (self, "FARM3"); 
};
func void DIA_Teleport_Location_NW_Nature_Sekob () {
	Info_ClearChoices (DIA_Teleport_Location_NW_Nature);
	AI_StopProcessInfos (self);
	AI_Teleport (self, "FARM4"); 
};
func void DIA_Teleport_Location_NW_Nature_PassWaterfalls () {
	Info_ClearChoices (DIA_Teleport_Location_NW_Nature);
	AI_StopProcessInfos (self);
	AI_Teleport (self, "LEVELCHANGE"); 
};
func void DIA_Teleport_Location_NW_Nature_Pass () {
	Info_ClearChoices (DIA_Teleport_Location_NW_Nature);
	AI_StopProcessInfos (self);
	AI_Teleport (self, "LEVELCHANGE"); 
};
func void DIA_Teleport_Location_NW_Nature_Sagitta () {
	Info_ClearChoices (DIA_Teleport_Location_NW_Nature);
	AI_StopProcessInfos (self);
	AI_Teleport (self, "SAGITTA"); 
};
func void DIA_Teleport_Location_NW_Nature_Dexter () {
	Info_ClearChoices (DIA_Teleport_Location_NW_Nature);
	AI_StopProcessInfos (self);
	AI_Teleport (self, "CASTLEMINE"); 
};
func void DIA_Teleport_Location_NW_Nature_Portal () {
	Info_ClearChoices (DIA_Teleport_Location_NW_Nature);
	AI_StopProcessInfos (self);
	AI_Teleport (self, "PORTAL"); 
};
func void DIA_Teleport_Location_NW_Nature_Pyramid () {
	Info_ClearChoices (DIA_Teleport_Location_NW_Nature);
	AI_StopProcessInfos (self);
	AI_Teleport (self, "TOT"); 
};
func void DIA_Teleport_Location_NW_Nature_TrollArea () {
	Info_ClearChoices (DIA_Teleport_Location_NW_Nature);
	AI_StopProcessInfos (self);
	AI_Teleport (self, "TROLL"); 
};
func void DIA_Teleport_Location_NW_Nature_SunCircle () {
	Info_ClearChoices (DIA_Teleport_Location_NW_Nature);
	AI_StopProcessInfos (self);
	AI_Teleport (self, "STONES"); 
};
func void DIA_Teleport_Location_NW_Nature_BigForestNorth () {
	Info_ClearChoices (DIA_Teleport_Location_NW_Nature);
	AI_StopProcessInfos (self);
	AI_Teleport (self, "TOT"); 
};
func void DIA_Teleport_Location_NW_Nature_BigForestCenter () {
	Info_ClearChoices (DIA_Teleport_Location_NW_Nature);
	AI_StopProcessInfos (self);
	AI_Teleport (self, "TOT"); 
};
