var int PC_Sleep_SpinnerHourMinute_Initialized;

//****************************
// 		PC_Sleep
//****************************

func void PC_Sleep (var int t)
{
	AI_StopProcessInfos(self);		// [SK] ->muss hier stehen um das update zu gewährleisten

	PLAYER_MOBSI_PRODUCTION	=	MOBSI_NONE;
	self.aivar[AIV_INVINCIBLE]=FALSE;
	if	(Wld_IsTime(00,00,t,00))
	{
		Wld_SetTime	(t,00);
	}
	else
	{
		t = t + 24;
		Wld_SetTime	(t,00);
	};

	Wld_StopEffect("DEMENTOR_FX");

	// FIXME_Nico: dauert zu lange um es vernuenftig zu machen.
	// Wld_PlayEffect ("SLEEP_BLEND", hero, hero, 0, 0, 0, FALSE);

	if (SC_IsObsessed == TRUE)
	{
 		//PrintScreen	(PRINT_SleepOverObsessed, -1,-1,FONT_Screen,2);
	}
	else
	{
		//PrintScreen	(PRINT_SleepOver, -1,-1,FONT_Screen,2);
		hero.attribute[ATR_HITPOINTS] = hero.attribute[ATR_HITPOINTS_MAX];
		hero.attribute[ATR_MANA] = hero.attribute[ATR_MANA_MAX];
	};

	//-------- AssessEnterRoom-Wahrnehmung versenden --------
	PrintGlobals		(PD_ITEM_MOBSI);
	Npc_SendPassivePerc	(hero,	PERC_ASSESSENTERROOM, NULL, hero);		//...damit der Spieler dieses Feature nicht zum Hütteplündern ausnutzt!

	PC_Sleep_SpinnerHourMinute_Initialized = false;
};



func void SLEEPABIT_S1 ()
{
	var C_NPC her; 	her = Hlp_GetNpc(PC_Hero);
	var C_NPC rock; rock = Hlp_GetNpc(PC_Rockefeller);

	//***ALT** if	(Hlp_GetInstanceID (self)== Hlp_GetInstanceID (Hero)) // MH: geändert, damit kontrollierte NSCs nicht schlafen können!
	if ( (Hlp_GetInstanceID(self)==Hlp_GetInstanceID(her))||(Hlp_GetInstanceID(self)==Hlp_GetInstanceID(rock)) )
	{
		self.aivar[AIV_INVINCIBLE]=TRUE;
		PLAYER_MOBSI_PRODUCTION	=	MOBSI_SLEEPABIT;
		Ai_ProcessInfos (her);

		if (SC_IsObsessed == TRUE)
			{
				Wld_PlayEffect("DEMENTOR_FX",  hero, hero, 0, 0, 0, FALSE );
			};
	};
};

//-------------------- Gar nicht schlafen -------------------------

INSTANCE PC_NoSleep (c_Info)

{
	npc				= PC_Hero;
	nr				= 999;
	condition		= PC_NoSleep_Condition;
	information		= PC_NoSleep_Info;
	important		= 0;
	permanent		= 1;
	description		= DIALOG_ENDE;
};

FUNC INT PC_NoSleep_Condition()
{
	if (PLAYER_MOBSI_PRODUCTION	==	MOBSI_SLEEPABIT)
	{
		return 1;
	};
};

func VOID PC_NoSleep_Info()
{
	AI_StopProcessInfos (self);
 	Wld_StopEffect("DEMENTOR_FX");
	self.aivar[AIV_INVINCIBLE]=FALSE;
	PLAYER_MOBSI_PRODUCTION	=	MOBSI_NONE;

	PC_Sleep_SpinnerHourMinute_Initialized = false;
};

//---------------------- morgens --------------------------------------

INSTANCE PC_SleepTime_Morning (C_INFO)
{
	npc				= PC_Hero;
	condition		= PC_SleepTime_Morning_Condition;
	information		= PC_SleepTime_Morning_Info;
	important		= 0;
	permanent		= 1;
	description		= "Spát až do rána";
};

FUNC INT PC_SleepTime_Morning_Condition()
{
	if (PLAYER_MOBSI_PRODUCTION	==	MOBSI_SLEEPABIT)
	{
		return 1;
	};
};

func void PC_SleepTime_Morning_Info ()
{
	PC_Sleep (8);
};

//--------------------- mittags -----------------------------------------

INSTANCE PC_SleepTime_Noon (C_INFO)
{
	npc				= PC_Hero;
	condition		= PC_SleepTime_Noon_Condition;
	information		= PC_SleepTime_Noon_Info;
	important		= 0;
	permanent		= 1;
	description		= "Spát až do poledne";
};

FUNC INT PC_SleepTime_Noon_Condition()
{
	if (PLAYER_MOBSI_PRODUCTION	==	MOBSI_SLEEPABIT)
	{
		return 1;
	};
};

func void PC_SleepTime_Noon_Info ()
{
	PC_Sleep (12);
};

//---------------------- abend --------------------------------------

INSTANCE PC_SleepTime_Evening (C_INFO)
{
	npc				= PC_Hero;
	condition		= PC_SleepTime_Evening_Condition;
	information		= PC_SleepTime_Evening_Info;
	important		= 0;
	permanent		= 1;
	description		= "Spát až do dalšího veèera";
};

FUNC INT PC_SleepTime_Evening_Condition()
{
	if (PLAYER_MOBSI_PRODUCTION	==	MOBSI_SLEEPABIT)
	{
		return 1;
	};
};

func void PC_SleepTime_Evening_Info ()
{
	PC_Sleep (20);
};

//------------------------ nacht -----------------------------------------

instance PC_SleepTime_Midnight (C_INFO)
{
	npc				= PC_Hero;
	condition		= PC_SleepTime_Midnight_Condition;
	information		= PC_SleepTime_Midnight_Info;
	important		= 0;
	permanent		= 1;
	description		= "Spát až do pùlnoci";
};

FUNC INT PC_SleepTime_Midnight_Condition()
{
	if (PLAYER_MOBSI_PRODUCTION	==	MOBSI_SLEEPABIT)
	{
		return 1;
	};
};

func VOID PC_SleepTime_Midnight_Info()
{
	PC_Sleep (0);
};

// /////////////////////////////////////////////////
// /////////////////////////////////////////////////
// Custom sleep
// /////////////////////////////////////////////////
// /////////////////////////////////////////////////

const int PC_Sleep_SpinnerHourMinute_Min = 0;
const int PC_Sleep_SpinnerHourMinute_Max = 1440; // 24 hours
const string PC_SLEEP_SPINNERHourMinute_ID = "PC_Sleep_SpinnerHourMinute";
var int PC_Sleep_SpinnerHourMinute_IsActive;
var int PC_Sleep_SpinnerHourMinute_Value;
var int PC_Sleep_SpinnerHourMinute_Hour;
var int PC_Sleep_SpinnerHourMinute_Minute;
//var int PC_Sleep_SpinnerHourMinute_Initialized;
var string PC_Sleep_SpinnerHourMinute_LastID;
var string PC_Sleep_SpinnerHourMinute_DiaDescription;
var string PC_Sleep_SpinnerHourMinute_HourStr;
var string PC_Sleep_SpinnerHourMinute_MinuteStr;

func void PC_Sleep_HoursMinutes (var int hour, var int min)
{
	AI_StopProcessInfos(self);		// [SK] ->muss hier stehen um das update zu gewährleisten

	PLAYER_MOBSI_PRODUCTION	= MOBSI_NONE;
	self.aivar[AIV_INVINCIBLE] = FALSE;
	
	if	( Wld_IsTime(00,00, hour, min) ) { 
		Wld_SetTime	(hour, min); 
	}
	else {
		Wld_SetTime	(hour + 24, min);
	};

	Wld_StopEffect("DEMENTOR_FX");

	// FIXME_Nico: dauert zu lange um es vernuenftig zu machen.
	// Wld_PlayEffect ("SLEEP_BLEND", hero, hero, 0, 0, 0, FALSE);

	if (SC_IsObsessed == TRUE) {
 		//PrintScreen	(PRINT_SleepOverObsessed, -1,-1,FONT_Screen,2);
	}
	else {
		//PrintScreen	(PRINT_SleepOver, -1,-1,FONT_Screen,2);
		
		hero.attribute[ATR_HITPOINTS] = hero.attribute[ATR_HITPOINTS_MAX];
		hero.attribute[ATR_MANA] = hero.attribute[ATR_MANA_MAX];
	};

	//-------- AssessEnterRoom-Wahrnehmung versenden --------
	PrintGlobals		(PD_ITEM_MOBSI);
	Npc_SendPassivePerc	(hero,	PERC_ASSESSENTERROOM, NULL, hero);		//...damit der Spieler dieses Feature nicht zum Hütteplündern ausnutzt!

	PC_Sleep_SpinnerHourMinute_Initialized = false;
};

// ----------------------------------------------------------------------
// converts time in minutes to basic range (0,1440)
// i.e. 1450 is the same as 10 (1450 - 1440), that is 10 minutes = 00:10 o'clock
//      -2000 is the same as 880 (-2000 + 2*1440), that is 880 minutes = 14:40 o'clock
func int ConvertTimeToBasicRange(var int minutes) {
	var int m; m = minutes;

	if (m < 0) {
		while(m < 0);
			m = m + 1440;		  
		end;
	};

	if (m >= 1440) {
		while(m >= 1440);
			m = m - 1440;		  
		end;
	};

	return m;
};
// ----------------------------------------------------------------------

instance PC_SleepTime_Custom (C_INFO)
{
	nr 				= 1;
	npc				= PC_Hero;
	condition		= PC_SleepTime_Custom_Condition;
	information		= PC_SleepTime_Custom_Info;
	important		= 0;
	permanent		= 1;
	description		= "Sleep till current time (next day)";
};

FUNC INT PC_SleepTime_Custom_Condition() {
	if (PLAYER_MOBSI_PRODUCTION	==	MOBSI_SLEEPABIT) {	
		// ----------------------------------------
		// Spinner handler
		// ----------------------------------------
		
		if (!PC_Sleep_SpinnerHourMinute_Initialized ) {
			InfoManagerSpinnerValue = 60*Wld_GetHour() + Wld_GetMinute();
			PC_Sleep_SpinnerHourMinute_Value = InfoManagerSpinnerValue;
			PC_Sleep_SpinnerHourMinute_Initialized = true;
		};		
		
		// check range
		PC_Sleep_SpinnerHourMinute_Value = ConvertTimeToBasicRange(PC_Sleep_SpinnerHourMinute_Value);
		//if (PC_Sleep_SpinnerHourMinute_Value == 1440) {
		//	PC_Sleep_SpinnerHourMinute_Value = 0;
		//}		
		//else if (  PC_Sleep_SpinnerHourMinute_Value < PC_Sleep_SpinnerHourMinute_Min
		//		|| PC_Sleep_SpinnerHourMinute_Value >= PC_Sleep_SpinnerHourMinute_Max ) { 
		//	PC_Sleep_SpinnerHourMinute_Value = ConvertTimeToBasicRange(PC_Sleep_SpinnerHourMinute_Value);
		//};
		
		PC_Sleep_SpinnerHourMinute_IsActive = Hlp_StrCmp (InfoManagerSpinnerID, PC_SLEEP_SPINNERHourMinute_ID);

		// setup spinner
		if (PC_Sleep_SpinnerHourMinute_IsActive) {
			InfoManagerSpinnerPageSize = 30; // page-up/down quantity
			InfoManagerSpinnerValueMin = PC_Sleep_SpinnerHourMinute_Min; // min/max values (Home/End keys)
			InfoManagerSpinnerValueMax = PC_Sleep_SpinnerHourMinute_Max - 30;

			PC_Sleep_SpinnerHourMinute_Value = InfoManagerSpinnerValue;
		};

		PC_Sleep_SpinnerHourMinute_LastID = InfoManagerSpinnerID;

		// get target hour & minute		
		PC_Sleep_SpinnerHourMinute_Hour = truncf(divf(mkf(PC_Sleep_SpinnerHourMinute_Value), mkf(60)));   
		PC_Sleep_SpinnerHourMinute_Minute = PC_Sleep_SpinnerHourMinute_Value - PC_Sleep_SpinnerHourMinute_Hour*60;

		PC_Sleep_SpinnerHourMinute_HourStr = iifStr( 
			PC_Sleep_SpinnerHourMinute_Hour < 10, 
			ConcatStrings("0",IntToString(PC_Sleep_SpinnerHourMinute_Hour)),
			IntToString(PC_Sleep_SpinnerHourMinute_Hour)
		);

		PC_Sleep_SpinnerHourMinute_MinuteStr = iifStr(
			PC_Sleep_SpinnerHourMinute_Minute < 10, 
			ConcatStrings("0",IntToString(PC_Sleep_SpinnerHourMinute_Minute)),
			IntToString(PC_Sleep_SpinnerHourMinute_Minute)
		);

		// update description
		PC_Sleep_SpinnerHourMinute_DiaDescription = ConcatStrings6(
			DIA_SPINNER, PC_SLEEP_SPINNERHourMinute_ID, " <-- --> Sleep till ",
			PC_Sleep_SpinnerHourMinute_HourStr, ":", PC_Sleep_SpinnerHourMinute_MinuteStr
		);

		// if the target time is on next day, add info to description 
		if ( !Wld_IsTime(00,00, PC_Sleep_SpinnerHourMinute_Hour, PC_Sleep_SpinnerHourMinute_Minute)) {
			PC_Sleep_SpinnerHourMinute_DiaDescription = ConcatStrings5(
				PC_Sleep_SpinnerHourMinute_DiaDescription, 
				DIA_FORMAT_START,
					DIA_COLOR_RED, "(next day)",
				DIA_FORMAT_END
			);
		};

		PC_SleepTime_Custom.description = PC_Sleep_SpinnerHourMinute_DiaDescription;

		// ----------------------------------------
		// ----------------------------------------

		return true;
	};
};

func VOID PC_SleepTime_Custom_Info() {	
	PC_Sleep_HoursMinutes (PC_Sleep_SpinnerHourMinute_Hour,PC_Sleep_SpinnerHourMinute_Minute);
};

// ----------------------------------------------------------------------



