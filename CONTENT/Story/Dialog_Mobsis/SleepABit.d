const int PC_Sleep_SpinnerHourMinute_Min = 0;
const int PC_Sleep_SpinnerHourMinute_Max = 1440; // 24 hours
const string PC_SLEEP_SPINNERHourMinute_ID 	= "PC_Sleep_SpinnerHourMinute";
const string PC_SLEEP_MORNING_DESCRIPTION 	= "Sleep till morning";
const string PC_SLEEP_NOON_DESCRIPTION 		= "Sleep till noon";
const string PC_SLEEP_EVENING_DESCRIPTION 	= "Sleep till evening";
const string PC_SLEEP_MIDNIGHT_DESCRIPTION 	= "Sleep till midnight";

var int PC_Sleep_SpinnerHourMinute_IsActive;
var int PC_Sleep_SpinnerHourMinute_Value;
var int PC_Sleep_SpinnerHourMinute_Hour;
var int PC_Sleep_SpinnerHourMinute_Minute;
var int PC_Sleep_SpinnerHourMinute_Initialized;

var string PC_Sleep_SpinnerHourMinute_LastID;
var string PC_Sleep_SpinnerHourMinute_DiaDescription;
var string PC_Sleep_SpinnerHourMinute_HourStr;
var string PC_Sleep_SpinnerHourMinute_MinuteStr;

//****************************
// 		PC_Sleep
//****************************

func void PC_Sleep_HoursMinutes (var int hour, var int min)
{
	CinemaScopeFadeOut();
	AI_StopProcessInfos(self);		// [SK] ->muss hier stehen um das update zu gewährleisten

	PLAYER_MOBSI_PRODUCTION	= MOBSI_NONE;
	self.aivar[AIV_INVINCIBLE] = FALSE;
	
	if	( Wld_IsTime(00,00, hour, min) ) { Wld_SetTime	(hour, min);  		}
	else 								 { Wld_SetTime	(hour + 24, min); 	};

	SleepRegeneration(hero);

	//-------- AssessEnterRoom-Wahrnehmung versenden --------
	PrintGlobals		(PD_ITEM_MOBSI);
	Npc_SendPassivePerc	(hero,	PERC_ASSESSENTERROOM, NULL, hero);		//...damit der Spieler dieses Feature nicht zum Hütteplündern ausnutzt!

	PC_Sleep_SpinnerHourMinute_Initialized = false;
};

// -------------------------------------------------------------

func void SetSleepDialogueDescription(var C_INFO info, var int hour, var int minute, var string defaultDesc) {
	var string description; description = defaultDesc;
	var string hourStr;   hourStr   = PaddString(IntToString(hour),   2, "0", PADD_START);
	var string minuteStr; minuteStr = PaddString(IntToString(minute), 2, "0", PADD_START);
	var string timeStr;   timeStr   = ConcatStrings5("(",hourStr, ":", minuteStr,")");

	StringOverlay_Reset();
	StringOverlay_Set_PaddingStart(25, " ");
	StringOverlay_Set_TextAlign(StringOverlay_TextAlign_Left);
	timeStr = StringOverlay_Generate(timeStr);

	description = ConcatStrings(defaultDesc, timeStr);

	// target time on the next day
	if (! Wld_IsTime(00,00, hour, minute)) {		
		StringOverlay_Set_PaddingStart(33, " ");
		StringOverlay_Set_ColorPreset(StringOverlay_ColorPreset_Red);
		description = ConcatStrings(description, StringOverlay_Generate("next day"));
	};

	info.description = description;
};

// -------------------------------------------------------------

func void SLEEPABIT_S1 ()
{
	var C_NPC her; 	her = Hlp_GetNpc(PC_Hero);
	var C_NPC rock; rock = Hlp_GetNpc(PC_Rockefeller);

	//***ALT** if	(Hlp_GetInstanceID (self)== Hlp_GetInstanceID (Hero)) // MH: geändert, damit kontrollierte NSCs nicht schlafen können!
	if ( (Hlp_GetInstanceID(self)==Hlp_GetInstanceID(her))||(Hlp_GetInstanceID(self)==Hlp_GetInstanceID(rock)) )
	{
		self.aivar[AIV_INVINCIBLE]=TRUE;
		PLAYER_MOBSI_PRODUCTION	=	MOBSI_SLEEPABIT;

		CinemaScopeFadeIn();
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
	CinemaScopeFadeOut();
	AI_StopProcessInfos (self);
 	
	Wld_StopEffect("DEMENTOR_FX");
	
	self.aivar[AIV_INVINCIBLE] = FALSE;
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
	description		= "";
};

FUNC INT PC_SleepTime_Morning_Condition()
{
	if (PLAYER_MOBSI_PRODUCTION	==	MOBSI_SLEEPABIT)
	{
		SetSleepDialogueDescription(PC_SleepTime_Morning, 8,0,PC_SLEEP_MORNING_DESCRIPTION);
		return 1;
	};
};

func void PC_SleepTime_Morning_Info ()
{
	PC_Sleep_HoursMinutes(8,0);
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
		SetSleepDialogueDescription(PC_SleepTime_Noon, 12,0,PC_SLEEP_NOON_DESCRIPTION);
		return 1;
	};
};

func void PC_SleepTime_Noon_Info ()
{
	PC_Sleep_HoursMinutes(12,0);
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
		SetSleepDialogueDescription(PC_SleepTime_Evening, 20,0,PC_SLEEP_EVENING_DESCRIPTION);
		return 1;
	};
};

func void PC_SleepTime_Evening_Info ()
{
	PC_Sleep_HoursMinutes(20,0);
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
		SetSleepDialogueDescription(PC_SleepTime_Midnight, 0,0,PC_SLEEP_MIDNIGHT_DESCRIPTION);
		return 1;
	};
};

func VOID PC_SleepTime_Midnight_Info()
{
	PC_Sleep_HoursMinutes(0,0);
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
						
		// setup spinner
		PC_Sleep_SpinnerHourMinute_IsActive = Hlp_StrCmp (InfoManagerSpinnerID, PC_SLEEP_SPINNERHourMinute_ID);		
		if (PC_Sleep_SpinnerHourMinute_IsActive) {
			InfoManagerSpinnerPageSize = -30; // page-up/down quantity
			InfoManagerSpinnerValueMin = PC_Sleep_SpinnerHourMinute_Min; // min/max values (Home/End keys)
			InfoManagerSpinnerValueMax = PC_Sleep_SpinnerHourMinute_Max - 30;

			PC_Sleep_SpinnerHourMinute_Value = InfoManagerSpinnerValue;
		};

		PC_Sleep_SpinnerHourMinute_LastID = InfoManagerSpinnerID;

		// get target hour & minute		
		PC_Sleep_SpinnerHourMinute_Hour = truncf(divf(mkf(PC_Sleep_SpinnerHourMinute_Value), mkf(60)));   
		PC_Sleep_SpinnerHourMinute_Minute = PC_Sleep_SpinnerHourMinute_Value - PC_Sleep_SpinnerHourMinute_Hour*60;

		PC_Sleep_SpinnerHourMinute_HourStr   = PaddString(IntToString(PC_Sleep_SpinnerHourMinute_Hour),   2, "0", PADD_START);		
		PC_Sleep_SpinnerHourMinute_MinuteStr = PaddString(IntToString(PC_Sleep_SpinnerHourMinute_Minute), 2, "0", PADD_START);

		// update description
		PC_Sleep_SpinnerHourMinute_DiaDescription = ConcatStrings6(
			DIA_SPINNER, PC_SLEEP_SPINNERHourMinute_ID, " <-- --> Sleep till ",
			PC_Sleep_SpinnerHourMinute_HourStr, ":", PC_Sleep_SpinnerHourMinute_MinuteStr
		);

		// if the target time is on next day, add info to description 
		if ( !Wld_IsTime(00,00, PC_Sleep_SpinnerHourMinute_Hour, PC_Sleep_SpinnerHourMinute_Minute)) {
			StringOverlay_Reset();
			StringOverlay_Set_PaddingStart(33, " ");
			StringOverlay_Set_TextAlign(StringOverlay_TextAlign_Left);
			StringOverlay_Set_ColorPreset(StringOverlay_ColorPreset_Red);

			PC_Sleep_SpinnerHourMinute_DiaDescription = ConcatStrings(
				PC_Sleep_SpinnerHourMinute_DiaDescription,
				StringOverlay_Generate("next day")
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



