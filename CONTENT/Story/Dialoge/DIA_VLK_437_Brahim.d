///////////////////////////////////////////////////////////////////////
//	Info EXIT 
///////////////////////////////////////////////////////////////////////
var int Brahim_ShowedMaps;
FUNC VOID B_BrahimNewMaps ()
{
	if (Brahim_ShowedMaps == TRUE)
	{
		AI_Output			(self, other, "B_BrahimNewMaps_07_00"); //Vraă se pozdęji, určitę pro tebe pak budu nęco mít.
	};
};
INSTANCE DIA_Brahim_EXIT   (C_INFO)
{
	npc         = VLK_437_Brahim;
	nr          = 999;
	condition   = DIA_Brahim_EXIT_Condition;
	information = DIA_Brahim_EXIT_Info;
	permanent   = TRUE;
	description = DIALOG_ENDE;
};

FUNC INT DIA_Brahim_EXIT_Condition()
{
	if (Kapitel <= 2)
	{
		return TRUE;
	};	
};

FUNC VOID DIA_Brahim_EXIT_Info()
{
	B_BrahimNewMaps ();
	AI_StopProcessInfos (self);
};
// ************************************************************
// 			  				PICK POCKET
// ************************************************************

INSTANCE DIA_Brahim_PICKPOCKET (C_INFO)
{
	npc			= VLK_437_Brahim;
	nr			= 900;
	condition	= DIA_Brahim_PICKPOCKET_Condition;
	information	= DIA_Brahim_PICKPOCKET_Info;
	permanent	= TRUE;
	description = Pickpocket_20;
};                       

FUNC INT DIA_Brahim_PICKPOCKET_Condition()
{
	C_Beklauen (15, 15);
};
 
FUNC VOID DIA_Brahim_PICKPOCKET_Info()
{	
	Info_ClearChoices	(DIA_Brahim_PICKPOCKET);
	Info_AddChoice		(DIA_Brahim_PICKPOCKET, DIALOG_BACK 		,DIA_Brahim_PICKPOCKET_BACK);
	Info_AddChoice		(DIA_Brahim_PICKPOCKET, DIALOG_PICKPOCKET	,DIA_Brahim_PICKPOCKET_DoIt);
};

func void DIA_Brahim_PICKPOCKET_DoIt()
{
	B_Beklauen ();
	Info_ClearChoices (DIA_Brahim_PICKPOCKET);
};
	
func void DIA_Brahim_PICKPOCKET_BACK()
{
	Info_ClearChoices (DIA_Brahim_PICKPOCKET);
};
///////////////////////////////////////////////////////////////////////
//	Info GREET
///////////////////////////////////////////////////////////////////////
instance DIA_Brahim_GREET		(C_INFO)
{
	npc			 = 	VLK_437_Brahim;
	nr			 = 	2;
	condition	 = 	DIA_Brahim_GREET_Condition;
	information	 = 	DIA_Brahim_GREET_Info;
	permanent	 =  FALSE;
	description	 = 	"Co tady dęláš?";
};
func int DIA_Brahim_GREET_Condition ()
{
	return TRUE;
};
func void DIA_Brahim_GREET_Info ()
{
	AI_Output (other, self, "DIA_Brahim_GREET_15_00"); //Co tady dęláš?
	AI_Output (self, other, "DIA_Brahim_GREET_07_01"); //Jmenuji se Brahim. Kreslím mapy a pak je prodávám.
	AI_Output (self, other, "DIA_Brahim_GREET_07_02"); //Tys tu nový, a tak by se ti nęjaká mapa męsta jistę hodila.
	AI_Output (self, other, "DIA_Brahim_GREET_07_03"); //Je pomęrnę levná a bude se ti dost hodit, dokud se tu úplnę nezorientuješ.
	
	Log_CreateTopic (Topic_CityTrader,LOG_NOTE);
	B_LogEntry (Topic_CityTrader,"Brahim kreslí a prodává mapy. Sídlí poblíž pâístavu.");
};

///////////////////////////////////////////////////////////////////////
//	Info MissingPeople
///////////////////////////////////////////////////////////////////////
instance DIA_Addon_Brahim_MissingPeople		(C_INFO)
{
	npc		 = 	VLK_437_Brahim;
	nr		 = 	5;
	condition	 = 	DIA_Addon_Brahim_MissingPeople_Condition;
	information	 = 	DIA_Addon_Brahim_MissingPeople_Info;

	description	 = 	"Je to pravda, že obyvatelé tohohle męsta mizejí bez jakékoli stopy?";
};

func int DIA_Addon_Brahim_MissingPeople_Condition ()
{
	if (SC_HearedAboutMissingPeople == TRUE)
	&& (ENTERED_ADDONWORLD == FALSE)
		{
			return TRUE;
		};
};

func void DIA_Addon_Brahim_MissingPeople_Info ()
{
	AI_Output	(other, self, "DIA_Addon_Brahim_MissingPeople_15_00"); //Je to pravda, že obyvatelé tohohle męsta mizejí bez jakékoli stopy?
	AI_Output	(self, other, "DIA_Addon_Brahim_MissingPeople_07_01"); //Hej, taky sem o tom slyšel. Bohužel, nemůžu âíct, jestli jsou ty pâíbehy pravdivé.
	AI_Output	(self, other, "DIA_Addon_Brahim_MissingPeople_07_02"); //Jen se koukni okolo. Tohle skutečnę není místo kde bys chtel žít navždy, co?
	AI_Output	(self, other, "DIA_Addon_Brahim_MissingPeople_07_03"); //Žáden div, že lidé odcházejí.
};

///////////////////////////////////////////////////////////////////////
//	Info Perm
///////////////////////////////////////////////////////////////////////
/*
instance DIA_Brahim_Perm		(C_INFO)
{
	npc			 = 	VLK_437_Brahim;
	nr			 = 	99;
	condition	 = 	DIA_Brahim_Perm_Condition;
	information	 = 	DIA_Brahim_Perm_Info;
	permanent	 =  TRUE;
	description	 = 	"Teë už to nechávám na mladších.";
};
func int DIA_Brahim_Perm_Condition ()
{	
	
	{
		return TRUE;
	};
};
func void DIA_Brahim_Perm_Info ()
{
	AI_Output (other, self, "DIA_Brahim_Perm_15_00"); //
	AI_Output (self, other, "DIA_Brahim_Perm_07_01"); //
};
*/
///////////////////////////////////////////////////////////////////////
//	Info BUY
///////////////////////////////////////////////////////////////////////
instance DIA_Brahim_BUY		(C_INFO)
{
	npc			 = 	VLK_437_Brahim;
	nr			 = 	9;
	condition	 = 	DIA_Brahim_BUY_Condition;
	information	 = 	DIA_Brahim_BUY_Info;
	permanent 	 =  TRUE;
	trade 		 =  TRUE;
	description	 = 	"Ukaž mi své mapy.";
};

func int DIA_Brahim_BUY_Condition ()
{	
	if Npc_KnowsInfo (hero,DIA_Brahim_GREET)
	{
		return TRUE;
	};
};
func void DIA_Brahim_BUY_Info ()
{
	B_GiveTradeInv (self);
	AI_Output (other, self, "DIA_Brahim_BUY_15_00"); //Ukaž mi své mapy.
	
	if (hero.guild == GIL_KDF)
	{
		AI_Output (self ,other, "DIA_Brahim_BUY_07_01"); //Lepší nenajdeš ani v tom svém klášteâe.
	};
	if (hero.guild == GIL_PAL)
	{
		AI_Output (self ,other, "DIA_Brahim_BUY_07_02"); //Dobré mapy jsou důležité, zvláštę pro ty, kdo pâicházejí z pevniny, mistâe paladine.
	};
	Brahim_ShowedMaps = TRUE;
};

//######################################
//##
//##	Kapitel 3
//##
//######################################

///////////////////////////////////////////////////////////////////////
//	Info Kap3_EXIT 
///////////////////////////////////////////////////////////////////////
INSTANCE DIA_Brahim_Kap3_EXIT   (C_INFO)
{
	npc         = VLK_437_Brahim;
	nr          = 999;
	condition   = DIA_Brahim_Kap3_EXIT_Condition;
	information = DIA_Brahim_Kap3_EXIT_Info;
	permanent   = TRUE;
	description = DIALOG_ENDE;
};

FUNC INT DIA_Brahim_Kap3_EXIT_Condition()	//siehe auch First Exit
{
	if (Kapitel >= 3)
	&& ((Npc_KnowsInfo (other,DIA_Brahim_Kap3_First_EXIT))
	|| (Npc_HasItems (other,ItWr_ShatteredGolem_MIS) == 0))
	{
		return TRUE;
	};	
};

FUNC VOID DIA_Brahim_Kap3_EXIT_Info()
{
	if (Kapitel <= 4)
	{
		B_BrahimNewMaps ();
	};
	AI_StopProcessInfos (self);
};

///////////////////////////////////////////////////////////////////////
//	Info Kap3_First_EXIT 
///////////////////////////////////////////////////////////////////////
INSTANCE DIA_Brahim_Kap3_First_EXIT   (C_INFO)
{
	npc         = VLK_437_Brahim;
	nr          = 999;
	condition   = DIA_Brahim_Kap3_First_EXIT_Condition;
	information = DIA_Brahim_Kap3_First_EXIT_Info;
	permanent   = FALSE;
	description = DIALOG_ENDE;
};

FUNC INT DIA_Brahim_Kap3_First_EXIT_Condition()
{
	if (Kapitel >= 3)
	&& (Npc_HasItems (other,ItWr_ShatteredGolem_MIS) >=1)
	{
		return TRUE;
	};	
};

FUNC VOID DIA_Brahim_Kap3_First_EXIT_Info()
{
	AI_Output (self ,other,"DIA_Brahim_Kap3_First_EXIT_07_00"); //Já vędęl, že tę tenhle kousek bude zajímat.
	AI_Output (other,self ,"DIA_Brahim_Kap3_First_EXIT_15_01"); //Jaký kousek?
	AI_Output (self ,other,"DIA_Brahim_Kap3_First_EXIT_07_02"); //No, ta stará mapa, kterou sis právę koupil.
	AI_Output (self, other,"DIA_Brahim_Kap3_First_EXIT_07_03"); //Znám takové, jako jsi ty. Nepropásnete jedinou šanci, jak pâijít k bohatství.
	Info_ClearChoices (DIA_Brahim_Kap3_First_EXIT);
	Info_AddChoice (DIA_Brahim_Kap3_First_EXIT,DIALOG_BACK,DIA_Brahim_Kap3_First_EXIT_BACK);
	Info_AddChoice (DIA_Brahim_Kap3_First_EXIT,"Jak jsi získal tenhle dokument?",DIA_Brahim_Kap3_First_EXIT_WhereGetIt);
	Info_AddChoice (DIA_Brahim_Kap3_First_EXIT,"Co je to za dokument?",DIA_Brahim_Kap3_First_EXIT_Content);
	Info_AddChoice (DIA_Brahim_Kap3_First_EXIT,"Proč si ji nenecháš sám?",DIA_Brahim_Kap3_First_EXIT_KeepIt);
};

FUNC VOID DIA_Brahim_Kap3_First_EXIT_BACK ()
{
	Info_ClearChoices (DIA_Brahim_Kap3_First_EXIT);
};

FUNC VOID DIA_Brahim_Kap3_First_EXIT_WhereGetIt ()
{
	AI_Output (other,self ,"DIA_Brahim_Kap3_First_EXIT_WhereGetIt_15_00"); //Kde jsi získal tuhle mapu?
	AI_Output (self ,other,"DIA_Brahim_Kap3_First_EXIT_WhereGetIt_07_01"); //No, našel jsem ji ve štosu starých map, který jsem nedávno koupil.
	AI_Output (self ,other,"DIA_Brahim_Kap3_First_EXIT_WhereGetIt_07_02"); //Ten, kdo ji prodával, ji musel pâehlédnout.
};

FUNC VOID DIA_Brahim_Kap3_First_EXIT_Content ()
{
	AI_Output (other,self ,"DIA_Brahim_Kap3_First_EXIT_Content_15_00"); //Co je to za mapu?
	AI_Output (self ,other,"DIA_Brahim_Kap3_First_EXIT_Content_07_01"); //Vypadá to jako nęjaká mapa k pokladu.
	AI_Output (self ,other,"DIA_Brahim_Kap3_First_EXIT_Content_07_02"); //Ty mi ale pâipadáš jako nękdo, kdo by nęčemu takovému mohl pâijít na kloub.
};

FUNC VOID DIA_Brahim_Kap3_First_EXIT_KeepIt()
{
	AI_Output (other,self ,"DIA_Brahim_Kap3_First_EXIT_KeepIt_15_00"); //Proč si ji nenecháš sám?
	AI_Output (self ,other,"DIA_Brahim_Kap3_First_EXIT_KeepIt_07_01"); //Jsem už starý a časy, kdy jsem vyrážel na výpravy, už jsou dávno pryč.
	AI_Output (self ,other,"DIA_Brahim_Kap3_First_EXIT_KeepIt_07_02"); //Teë už to nechávám na mladších.
};


