//---------------------------------------------------------------------
//	Set enabled/disabled teleport locations
//---------------------------------------------------------------------
func void InitializeTeleportLocations() {
	TeleportLocationMainMenu = true;

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
func void DIA_Teleport_Location_Reset_Selection () {
	Info_ClearChoices (DIA_Teleport_Location_NW_Nature);
	Info_ClearChoices (DIA_Teleport_Location_NW_City);
	Info_ClearChoices (DIA_Teleport_Location_OW_Nature);
	TeleportLocationMainMenu = true;
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
	return (CurrentLevel != OLDWORLD_ZEN && CurrentLevel != NEWWORLD_ZEN);
};
FUNC VOID DIA_ItRu_Teleport_General_EXIT_Info()
{
	MEM_Timer.factorMotion = mkf(1);
	DIA_Teleport_Location_Reset_Selection();
	AI_StopProcessInfos (self);
};

//---------------------------------------------------------------------
//	Teleport function
//---------------------------------------------------------------------
func void TeleportHandler (var C_NPC npc, var string wp) {
	MEM_Timer.factorMotion = mkf(1);
	DIA_Teleport_Location_Reset_Selection();
	AI_StopProcessInfos (npc);
	AI_Teleport (npc, wp); // should be last statement, because this function erases AI queue
};

//---------------------------------------------------------------------
//	Target location selection - City
//---------------------------------------------------------------------
INSTANCE DIA_Teleport_Location_NW_City   (C_INFO)
{
	npc         = PC_Hero;
	nr          = 1;
	condition   = DIA_Teleport_Location_NW_City_Condition;
	information = DIA_Teleport_Location_NW_City_Info;
	permanent   = TRUE;
	description = "City locations -->";
};
FUNC INT DIA_Teleport_Location_NW_City_Condition()
{
	return (CurrentLevel == NEWWORLD_ZEN && TeleportLocationMainMenu);
};
FUNC VOID DIA_Teleport_Location_NW_City_Info()
{
	TeleportLocationMainMenu = false;

	if ( Teleport_Location_IsEnabled [ TELEPORT_NW_CITY_SEWERS ] ) {
		Info_AddChoice (DIA_Teleport_Location_NW_City, "Sewers", DIA_Teleport_Location_NW_City_Sewers );
	};	
	if ( Teleport_Location_IsEnabled [ TELEPORT_NW_CITY_ADANOS ] ) {
		Info_AddChoice (DIA_Teleport_Location_NW_City, "Adanos temple", DIA_Teleport_Location_NW_City_Adanos );
	};
	if ( Teleport_Location_IsEnabled [ TELEPORT_NW_CITY_KASERNE ] ) {
		Info_AddChoice (DIA_Teleport_Location_NW_City, "Militia barracks", DIA_Teleport_Location_NW_City_Kaserne );
	};
	if ( Teleport_Location_IsEnabled [ TELEPORT_NW_CITY_HARBOR ] ) {
		Info_AddChoice (DIA_Teleport_Location_NW_City, "Harbour", DIA_Teleport_Location_NW_City_Harbor );
	};
	if ( Teleport_Location_IsEnabled [ TELEPORT_NW_CITY_MARKET ] ) {
		Info_AddChoice (DIA_Teleport_Location_NW_City, "Marketplace", DIA_Teleport_Location_NW_City_Market );
	};
	if ( Teleport_Location_IsEnabled [ TELEPORT_NW_CITY_SOUTHGATE ] ) {
		Info_AddChoice (DIA_Teleport_Location_NW_City, "Worker's Quarter", DIA_Teleport_Location_NW_City_SouthGate );
	};
	if ( Teleport_Location_IsEnabled [ TELEPORT_NW_CITY_UPPERCITY ] ) {
		Info_AddChoice (DIA_Teleport_Location_NW_City, "Upper Quarter", DIA_Teleport_Location_NW_City_UpperCity );
	};

	Info_AddChoice 	  (DIA_Teleport_Location_NW_City,"<-- BACK",DIA_Teleport_Location_Reset_Selection);
};

func void DIA_Teleport_Location_NW_City_Sewers () {
	TeleportHandler( self, "NW_CITY_KANAL_23");
};
func void DIA_Teleport_Location_NW_City_Adanos () {
	TeleportHandler( self, "NW_CITY_MERCHANT_TEMPLE_IN");
};
func void DIA_Teleport_Location_NW_City_Kaserne () {
	TeleportHandler( self, "NW_CITY_HABOUR_KASERN_12");
};
func void DIA_Teleport_Location_NW_City_Harbor () {
	TeleportHandler( self, "HAFEN");
};
func void DIA_Teleport_Location_NW_City_Market () {
	TeleportHandler( self, "NW_CITY_MERCHANT_PATH_28_F");
};
func void DIA_Teleport_Location_NW_City_SouthGate () {
	TeleportHandler( self, "DOWNTOWN");
};
func void DIA_Teleport_Location_NW_City_UpperCity () {
	TeleportHandler( self, "REICH");
};

//---------------------------------------------------------------------
//	Target location selection - NewWorld Nature
//---------------------------------------------------------------------
INSTANCE DIA_Teleport_Location_NW_Nature   (C_INFO)
{
	npc         = PC_Hero;
	nr          = 2;
	condition   = DIA_Teleport_Location_NW_Nature_Condition;
	information = DIA_Teleport_Location_NW_Nature_Info;
	permanent   = TRUE;
	description = "Other locations -->";
};
FUNC INT DIA_Teleport_Location_NW_Nature_Condition()
{
	return (CurrentLevel == NEWWORLD_ZEN && TeleportLocationMainMenu);
};
FUNC VOID DIA_Teleport_Location_NW_Nature_Info()
{
	TeleportLocationMainMenu = false;

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

	// city area
	if (Teleport_Location_IsEnabled [ TELEPORT_NW_NATURE_AKIL				] ) { 
		Info_AddChoice 	  (DIA_Teleport_Location_NW_Nature,"Akil's farm",DIA_Teleport_Location_NW_Nature_Akil); 
	};	
	if (Teleport_Location_IsEnabled [ TELEPORT_NW_NATURE_XARDAS 			] ) { 
		Info_AddChoice 	  (DIA_Teleport_Location_NW_Nature,"Xardas tower",DIA_Teleport_Location_NW_Nature_Xardas); 
	};
	if (Teleport_Location_IsEnabled [ TELEPORT_NW_NATURE_LOBART 			] ) { 
		Info_AddChoice 	  (DIA_Teleport_Location_NW_Nature,"Lobart's farm",DIA_Teleport_Location_NW_Nature_Lobart); 
	};
	if (Teleport_Location_IsEnabled [ TELEPORT_NW_NATURE_LIGHTHOUSE			] ) { 
		Info_AddChoice 	  (DIA_Teleport_Location_NW_Nature,"Lighthouse",DIA_Teleport_Location_NW_Nature_Lighthouse); 
	};

	Info_AddChoice 	  (DIA_Teleport_Location_NW_Nature,"<-- BACK",DIA_Teleport_Location_Reset_Selection);
};

func void DIA_Teleport_Location_NW_Nature_Taverne () {
	TeleportHandler( self, "NW_TAVERNE");	
};
func void DIA_Teleport_Location_NW_Nature_Monastery () {
	TeleportHandler( self, "NW_MONASTERY_ENTRY_01");
};
func void DIA_Teleport_Location_NW_Nature_Akil () {
	TeleportHandler( self, "NW_FARM2_PATH_05");
};
func void DIA_Teleport_Location_NW_Nature_Lighthouse () {
	TeleportHandler( self, "LIGHTHOUSE");
};
func void DIA_Teleport_Location_NW_Nature_Lobart () {
	TeleportHandler( self, "FARM1");
};
func void DIA_Teleport_Location_NW_Nature_Xardas () {
	TeleportHandler( self, "NW_XARDAS_TOWER_PATH_01_B");
};
func void DIA_Teleport_Location_NW_Nature_Onar () {
	TeleportHandler( self, "NW_BIGFARM_STABLE_OUT_04");
};
func void DIA_Teleport_Location_NW_Nature_OnarCrossroad () {
	TeleportHandler( self, "NW_BIGFARM_CROSS");
};
func void DIA_Teleport_Location_NW_Nature_Bengar () {
	TeleportHandler( self, "FARM3");
};
func void DIA_Teleport_Location_NW_Nature_Sekob () {
	TeleportHandler( self, "NW_FARM4_05");
};
func void DIA_Teleport_Location_NW_Nature_PassWaterfalls () {
	TeleportHandler( self, "LEVELCHANGE");
};
func void DIA_Teleport_Location_NW_Nature_Pass () {
	TeleportHandler( self, "NW_PASS_ORKS_12");
};
func void DIA_Teleport_Location_NW_Nature_Sagitta () {
	TeleportHandler( self, "NW_SAGITTA_CAVE_03");
};
func void DIA_Teleport_Location_NW_Nature_Dexter () {
	TeleportHandler( self, "CASTLEMINE");
};
func void DIA_Teleport_Location_NW_Nature_Portal () {
	TeleportHandler( self, "NW_TROLLAREA_PORTAL_09");
};
func void DIA_Teleport_Location_NW_Nature_Pyramid () {
	TeleportHandler( self, "NW_TROLLAREA_RUINS_11");
};
func void DIA_Teleport_Location_NW_Nature_TrollArea () {
	TeleportHandler( self, "NW_TROLLAREA_PATH_80"); 
};
func void DIA_Teleport_Location_NW_Nature_SunCircle () {
	TeleportHandler( self, "NW_TROLLAREA_RITUALPATH_01");
};
func void DIA_Teleport_Location_NW_Nature_BigForestNorth () {
	TeleportHandler( self, "NW_FOREST_PATH_65");
};
func void DIA_Teleport_Location_NW_Nature_BigForestCenter () {
	TeleportHandler( self, "NW_FOREST_PATH_26");
};

//---------------------------------------------------------------------
//	Target location selection - NewWorld - dummy
//---------------------------------------------------------------------
INSTANCE DIA_Teleport_Location_NW_Separator   (C_INFO)
{
	npc         = PC_Hero;
	nr          = 3;
	condition   = DIA_Teleport_Location_NW_Separator_Condition;
	information = DIA_Teleport_Location_NW_Separator_Info;
	permanent   = TRUE;
	description = "   ------------   ";
};
FUNC INT DIA_Teleport_Location_NW_Separator_Condition()
{
	return (CurrentLevel == NEWWORLD_ZEN && TeleportLocationMainMenu);
};
FUNC VOID DIA_Teleport_Location_NW_Separator_Info()
{
};

//---------------------------------------------------------------------
//	Target location selection - NewWorld - Quick - City
//---------------------------------------------------------------------
INSTANCE DIA_Teleport_Location_NW_Quick_City   (C_INFO)
{
	npc         = PC_Hero;
	nr          = 4;
	condition   = DIA_Teleport_Location_NW_Quick_City_Condition;
	information = DIA_Teleport_Location_NW_Quick_City_Info;
	permanent   = TRUE;
	description = "City";
};
FUNC INT DIA_Teleport_Location_NW_Quick_City_Condition()
{
	return (
		CurrentLevel == NEWWORLD_ZEN 
		&& TeleportLocationMainMenu
		&& Teleport_Location_IsEnabled [TELEPORT_NW_CITY_SOUTHGATE]
	);
};
FUNC VOID DIA_Teleport_Location_NW_Quick_City_Info()
{
	DIA_Teleport_Location_NW_City_SouthGate ();
};

//---------------------------------------------------------------------
//	Target location selection - NewWorld - Quick - Onar
//---------------------------------------------------------------------
INSTANCE DIA_Teleport_Location_NW_Quick_Onar   (C_INFO)
{
	npc         = PC_Hero;
	nr          = 5;
	condition   = DIA_Teleport_Location_NW_Quick_Onar_Condition;
	information = DIA_Teleport_Location_NW_Quick_Onar_Info;
	permanent   = TRUE;
	description = "Onar's farm";
};
FUNC INT DIA_Teleport_Location_NW_Quick_Onar_Condition()
{
	return (
		CurrentLevel == NEWWORLD_ZEN 
		&& TeleportLocationMainMenu
		&& Teleport_Location_IsEnabled [TELEPORT_NW_NATURE_ONAR]
	);
};
FUNC VOID DIA_Teleport_Location_NW_Quick_Onar_Info()
{
	DIA_Teleport_Location_NW_Nature_Onar ();
};

//---------------------------------------------------------------------
//	Target location selection - NewWorld - Quick - Tavern
//---------------------------------------------------------------------
INSTANCE DIA_Teleport_Location_NW_Quick_Tavern   (C_INFO)
{
	npc         = PC_Hero;
	nr          = 6;
	condition   = DIA_Teleport_Location_NW_Quick_Tavern_Condition;
	information = DIA_Teleport_Location_NW_Quick_Tavern_Info;
	permanent   = TRUE;
	description = "Dead Harpy tavern";
};
FUNC INT DIA_Teleport_Location_NW_Quick_Tavern_Condition()
{
	return (
		CurrentLevel == NEWWORLD_ZEN 
		&& TeleportLocationMainMenu
		&& Teleport_Location_IsEnabled [TELEPORT_NW_NATURE_TAVERNE]
	);
};
FUNC VOID DIA_Teleport_Location_NW_Quick_Tavern_Info()
{
	DIA_Teleport_Location_NW_Nature_Taverne ();
};

//---------------------------------------------------------------------
//	Target location selection - NewWorld - Quick - Monastery
//---------------------------------------------------------------------
INSTANCE DIA_Teleport_Location_NW_Quick_Monastery   (C_INFO)
{
	npc         = PC_Hero;
	nr          = 7;
	condition   = DIA_Teleport_Location_NW_Quick_Monastery_Condition;
	information = DIA_Teleport_Location_NW_Quick_Monastery_Info;
	permanent   = TRUE;
	description = "Monastery";
};
FUNC INT DIA_Teleport_Location_NW_Quick_Monastery_Condition()
{
	return (
		CurrentLevel == NEWWORLD_ZEN 
		&& TeleportLocationMainMenu
		&& Teleport_Location_IsEnabled [TELEPORT_NW_NATURE_MONASTERY] 
	);
};
FUNC VOID DIA_Teleport_Location_NW_Quick_Monastery_Info()
{
	DIA_Teleport_Location_NW_Nature_Monastery ();
};

//---------------------------------------------------------------------
//	Target location selection - Valley of Mines
//---------------------------------------------------------------------
INSTANCE DIA_Teleport_Location_OW_Nature   (C_INFO)
{
	npc         = PC_Hero;
	nr          = 1;
	condition   = DIA_Teleport_Location_OW_Nature_Condition;
	information = DIA_Teleport_Location_OW_Nature_Info;
	permanent   = TRUE;
	description = "Other locations -->";
};
FUNC INT DIA_Teleport_Location_OW_Nature_Condition()
{
	return (CurrentLevel == OLDWORLD_ZEN && TeleportLocationMainMenu);
};
FUNC VOID DIA_Teleport_Location_OW_Nature_Info()
{
	TeleportLocationMainMenu = false;

	if (Teleport_Location_IsEnabled [ TELEPORT_OW_EXCHANGEPLACE ] ) {
		Info_AddChoice (DIA_Teleport_Location_OW_Nature, "Former exchange place", DIA_Teleport_Location_OW_Nature_ExchangePlace );
	};
	if (Teleport_Location_IsEnabled [ TELEPORT_OW_STONEFORTRESS ] ) {
		Info_AddChoice (DIA_Teleport_Location_OW_Nature, "Stone fortress", DIA_Teleport_Location_OW_Nature_StoneFortress );
	};
	if (Teleport_Location_IsEnabled [ TELEPORT_OW_XARDAS ] ) {
		Info_AddChoice (DIA_Teleport_Location_OW_Nature, "Xardas tower", DIA_Teleport_Location_OW_Nature_Xardas );
	};
	if (Teleport_Location_IsEnabled [ TELEPORT_OW_NEWCAMP ] ) {
		Info_AddChoice (DIA_Teleport_Location_OW_Nature, "Former New Camp", DIA_Teleport_Location_OW_Nature_NewCamp );
	};
	if (Teleport_Location_IsEnabled [ TELEPORT_OW_OLDMINE ] ) {
		Info_AddChoice (DIA_Teleport_Location_OW_Nature, "Former Old mine", DIA_Teleport_Location_OW_Nature_OldMine );
	};
	if (Teleport_Location_IsEnabled [ TELEPORT_OW_CAVALORN ] ) {
		Info_AddChoice (DIA_Teleport_Location_OW_Nature, "Former Cavalorn's hut", DIA_Teleport_Location_OW_Nature_Cavalorn );
	};
	if (Teleport_Location_IsEnabled [ TELEPORT_OW_SOUTHGATE ] ) {
		Info_AddChoice (DIA_Teleport_Location_OW_Nature, "Castle - South", DIA_Teleport_Location_OW_Nature_SouthGate );
	};
	if (Teleport_Location_IsEnabled [ TELEPORT_OW_NORTHGATE ] ) {
		Info_AddChoice (DIA_Teleport_Location_OW_Nature, "Castle - North", DIA_Teleport_Location_OW_Nature_NorthGate );
	};
	if (Teleport_Location_IsEnabled [ TELEPORT_OW_CASTLE ] ) {
		Info_AddChoice (DIA_Teleport_Location_OW_Nature, "Castle - Inside", DIA_Teleport_Location_OW_Nature_Castle );
	};

	Info_AddChoice 	  (DIA_Teleport_Location_OW_Nature,"<-- BACK",DIA_Teleport_Location_Reset_Selection);
};

func void DIA_Teleport_Location_OW_Nature_ExchangePlace () {
	TeleportHandler( self, "WP_INTRO03");
};
func void DIA_Teleport_Location_OW_Nature_StoneFortress () {
	TeleportHandler( self, "LOCATION_19_03_PATH_RUIN7");
};
func void DIA_Teleport_Location_OW_Nature_Xardas () {
	TeleportHandler( self, "DT_PLATFORM_02");
};
func void DIA_Teleport_Location_OW_Nature_NewCamp () {
	TeleportHandler( self, "OW_ICEREGION_01");
};
func void DIA_Teleport_Location_OW_Nature_OldMine () {
	TeleportHandler( self, "OW_PATH_266");
};
func void DIA_Teleport_Location_OW_Nature_Cavalorn () {
	TeleportHandler( self, "CAVALORN");
};
func void DIA_Teleport_Location_OW_Nature_SouthGate () {
	TeleportHandler( self, "OC2");
};
func void DIA_Teleport_Location_OW_Nature_NorthGate () {
	TeleportHandler( self, "OC1");
};
func void DIA_Teleport_Location_OW_Nature_Castle () {
	TeleportHandler( self, "OC_GATE_GUARD_01");
};

//---------------------------------------------------------------------
//	Target location selection - OldWorld - dummy
//---------------------------------------------------------------------
INSTANCE DIA_Teleport_Location_OW_Separator   (C_INFO)
{
	npc         = PC_Hero;
	nr          = 3;
	condition   = DIA_Teleport_Location_OW_Separator_Condition;
	information = DIA_Teleport_Location_OW_Separator_Info;
	permanent   = TRUE;
	description = "   ------------   ";
};
FUNC INT DIA_Teleport_Location_OW_Separator_Condition()
{
	return (CurrentLevel == OLDWORLD_ZEN && TeleportLocationMainMenu);
};
FUNC VOID DIA_Teleport_Location_OW_Separator_Info()
{
};

//---------------------------------------------------------------------
//	Target location selection - OldWorld - Quick - Castle
//---------------------------------------------------------------------
INSTANCE DIA_Teleport_Location_OW_Quick_Castle   (C_INFO)
{
	npc         = PC_Hero;
	nr          = 3;
	condition   = DIA_Teleport_Location_OW_Quick_Castle_Condition;
	information = DIA_Teleport_Location_OW_Quick_Castle_Info;
	permanent   = TRUE;
	description = "Castle";
};
FUNC INT DIA_Teleport_Location_OW_Quick_Castle_Condition()
{
	return (
		CurrentLevel == OLDWORLD_ZEN 
		&& TeleportLocationMainMenu
		&& Teleport_Location_IsEnabled [TELEPORT_OW_CASTLE] 
	);
};
FUNC VOID DIA_Teleport_Location_OW_Quick_Castle_Info()
{
	DIA_Teleport_Location_OW_Nature_Castle();
};
