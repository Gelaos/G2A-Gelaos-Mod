
///////////////////////////////////////////////////////////////////////
//	Info EXIT 
///////////////////////////////////////////////////////////////////////
INSTANCE DIA_Brutus_EXIT   (C_INFO)
{
	npc         = VLK_4100_Brutus;
	nr          = 999;
	condition   = DIA_Brutus_EXIT_Condition;
	information = DIA_Brutus_EXIT_Info;
	permanent	= TRUE;
	description = DIALOG_ENDE ;
};

FUNC INT DIA_Brutus_EXIT_Condition()
{	
	if (Kapitel < 3)
	{
			return TRUE;
	};
};
FUNC VOID DIA_Brutus_EXIT_Info()
{
	B_NpcClearObsessionByDMT (self);
};
///////////////////////////////////////////////////////////////////////
//	Brutus ist ToughGuy 
///////////////////////////////////////////////////////////////////////
//	Info AFTER_FIGHT 
///////////////////////////////////////////////////////////////////////
instance DIA_Brutus_AFTER_FIGHT		(C_INFO)
{
	npc			 = 	VLK_4100_Brutus;
	nr			 = 	1;
	condition	 = 	DIA_Brutus_AFTER_FIGHT_Condition;
	information	 = 	DIA_Brutus_AFTER_FIGHT_Info;
	permanent	 = 	TRUE;
	important	 =  TRUE;
};

func int DIA_Brutus_AFTER_FIGHT_Condition ()
{	
	if (self.aivar[AIV_LastFightAgainstPlayer] != FIGHT_NONE)
	&& (self.aivar[AIV_LastFightComment] == FALSE)
	&& Npc_IsInState (self, ZS_Talk)
	&& (NpcObsessedByDMT_Brutus == FALSE)
	{
		return TRUE;
	};
};
func void DIA_Brutus_AFTER_FIGHT_Info ()
{

	
	if (self.aivar[AIV_LastFightAgainstPlayer] == FIGHT_LOST)
	{
		AI_Output (other, self, "DIA_Brutus_AFTER_FIGHT_15_00"); //Tak co, máš ještę poâád všechny zuby?
		AI_Output (self, other, "DIA_Brutus_AFTER_FIGHT_06_01"); //Chlape, ty jsi pękný poâízek! Nechtęl bych se s tebou utkat, to teda ne.
	}
	else if  (self.aivar[AIV_LastFightAgainstPlayer] == FIGHT_WON)
	{
		AI_Output (other, self, "DIA_Brutus_AFTER_FIGHT_15_02"); //Myslím, že bys mi zlomil všechny žebra, ne-li nęco horšího.
		AI_Output (self, other, "DIA_Brutus_AFTER_FIGHT_06_03"); //A já tę taky nemlátil plnou silou. No nevadí, mám rád chlapy, které nęjaká ta rána hned tak nesklátí.
		
		if (Brutus_einmalig == FALSE)
		{
			AI_Output (self, other, "DIA_Brutus_AFTER_FIGHT_06_04"); //Tenhle lektvar tę zase postaví na nohy a s útrobami dęlá hotové zázraky!
		
			CreateInvItems (self, ItPo_Health_01,1);
			B_GiveInvItems (self, hero, ItPo_Health_01,1); 
			Brutus_einmalig = TRUE;
		};
	}
	else //Cancel
	{
		AI_Output (self, other, "DIA_Brutus_AFTER_FIGHT_06_05"); //Nemám nic proti dobrému boji, ale když se začnu bít, tak taky vím, kdy skončit.
	};
	// ------ AIVAR resetten ------
	self.aivar[AIV_LastFightComment] = TRUE;
};
///////////////////////////////////////////////////////////////////////
//	Info PRISONER
///////////////////////////////////////////////////////////////////////
instance DIA_Brutus_PRISONER		(C_INFO)
{
	npc		     = 	VLK_4100_Brutus;
	nr		     = 	2;
	condition	 = 	DIA_Brutus_PRISONER_Condition;
	information	 = 	DIA_Brutus_PRISONER_Info;
	description	 = 	"Co tu máš na práci?";
};

func int DIA_Brutus_PRISONER_Condition ()
{	
	if (Kapitel < 3)
	&& (NpcObsessedByDMT_Brutus == FALSE)
	{
		return TRUE;
	};
};
func void DIA_Brutus_PRISONER_Info ()
{
	AI_Output (other, self, "DIA_Brutus_PRISONER_15_00"); //Co tu máš na práci?
	AI_Output (self, other, "DIA_Brutus_PRISONER_06_01"); //Co mám na práci? Cvičím tyhle hošany. Učím je, jak získat ocelové svaly.
	AI_Output (self, other, "DIA_Brutus_PRISONER_06_02"); //Taky se starám o vęznę, jsem pro ty bastardy nęco jako zatracenę pâísný otec!
	AI_Output (self, other, "DIA_Brutus_PRISONER_06_03"); //Ale opravdové umęní je pâimęt je k hovoru. A vęâ mi - já rozvážu jazyk úplnę každému.
	AI_Output (other, self, "DIA_Brutus_PRISONER_15_04"); //To zní dęsivę hezky.
	AI_Output (self, other, "DIA_Brutus_PRISONER_06_05"); //Ale ti zablešení zabednęnci, které jsme teë zabásli, nám toho moc neâeknou - ani nemají co.
	
	if (MIS_RescueGorn != LOG_SUCCESS)
	{
		AI_Output (self, other, "DIA_Brutus_PRISONER_06_06"); //A tak se nebudu moci vypoâádat s tím Gornem.
		
		KnowsAboutGorn = TRUE; 
	};
	
	
};
///////////////////////////////////////////////////////////////////////
//	Info PERM
///////////////////////////////////////////////////////////////////////
instance DIA_Brutus_PERM		(C_INFO)
{
	npc			 = 	VLK_4100_Brutus;
	nr			 =  90;
	condition	 = 	DIA_Brutus_PERM_Condition;
	information	 = 	DIA_Brutus_PERM_Info;
	permanent	 = 	TRUE;
	description	 = 	"Nęco nového?";
};

func int DIA_Brutus_PERM_Condition ()
{	
	if  Npc_KnowsInfo (hero,DIA_Brutus_PRISONER) 
	&& (Kapitel < 3)
	&& (NpcObsessedByDMT_Brutus == FALSE)
	{
		return TRUE;
	};
};
func void DIA_Brutus_PERM_Info ()
{
	AI_Output (other, self, "DIA_Brutus_PERM_15_00"); //Nęco nového?
	AI_Output (self, other, "DIA_Brutus_PERM_06_01"); //Všecko vypadá klidnę. Žádní noví vęzni - nikomu nemůžu pomáhat hledat správná slova - je to prostę zlé.
	B_NpcClearObsessionByDMT (self);
};
///////////////////////////////////////////////////////////////////////
//	Info Kasse
///////////////////////////////////////////////////////////////////////
instance DIA_Brutus_Kasse		(C_INFO)
{
	npc			 = 	VLK_4100_Brutus;
	nr			 = 	2;
	condition	 = 	DIA_Brutus_Kasse_Condition;
	information	 = 	DIA_Brutus_Kasse_Info;
	permanent	 = 	FALSE;
	description	 = 	"Mohl bys mę cvičit?";
};

func int DIA_Brutus_Kasse_Condition ()
{	
	if  Npc_KnowsInfo (hero,DIA_Brutus_PRISONER) 
	&& (Kapitel < 3)
	&& (NpcObsessedByDMT_Brutus == FALSE)
	{
		return TRUE;
	};
};
func void DIA_Brutus_Kasse_Info ()
{
	AI_Output (other, self, "DIA_Brutus_Kasse_15_00"); //Mohl bys mę cvičit?
	AI_Output (self, other, "DIA_Brutus_Kasse_06_01"); //Jasnę - můžu ti pomoci zvýšit sílu, ale zadarmo ani kuâe nehrabe.
	AI_Output (other, self, "DIA_Brutus_Kasse_15_02"); //Kolik chceš?
	AI_Output (self, other, "DIA_Brutus_Kasse_06_03"); //Hmm, tys pobíhal kolem toho hradu, že jo? Tak ti navrhnu tohle.
	AI_Output (self, other, "DIA_Brutus_Kasse_06_04"); //Můj asistent Den se pâi posledním útoku úplnę vypaâil - prostę nevydržel.
	AI_Output (self, other, "DIA_Brutus_Kasse_06_05"); //Ale neodešel s prázdnou. Odnesl si i obsah naší pokladnice.
	AI_Output (other, self, "DIA_Brutus_Kasse_15_06"); //Jaké pokladnice?
	AI_Output (self, other, "DIA_Brutus_Kasse_06_07"); //V téhle truhlici jsme schovávali zboží, které jsme časem, ehm, vybrali.
	AI_Output (self, other, "DIA_Brutus_Kasse_06_08"); //Byla to pęknę zaokrouhlená sumička - 200 zlaăáků, a to nepočítám ještę vzácné klenoty.
	AI_Output (self, other, "DIA_Brutus_Kasse_06_09"); //Jestli mi vrátíš to zlato, budeš si moci nechat ty klenoty a ještę k tomu tę budu cvičit.
	
	Log_CreateTopic (TopicBrutusKasse,LOG_MISSION);
	Log_SetTopicStatus (TopicBrutusKasse,LOG_RUNNING);
	B_LogEntry (TopicBrutusKasse,"Brutův partner Den se ztratil i s 200 zlaăáků a nęjakými klenoty. Když Brutovi pâinesu aspoŕ ty dvę stovky, pomůže mi zvýšit sílu.");
};
///////////////////////////////////////////////////////////////////////
//	Info Wo ist Den?
///////////////////////////////////////////////////////////////////////
instance DIA_Brutus_Den		(C_INFO)
{
	npc			 = 	VLK_4100_Brutus;
	nr			 = 	2;
	condition	 = 	DIA_Brutus_Den_Condition;
	information	 = 	DIA_Brutus_Den_Info;
	permanent	 = 	FALSE;
	description	 = 	"Nevíš, kam Den míâil?";
};

func int DIA_Brutus_Den_Condition ()
{	
	if  Npc_KnowsInfo (hero,DIA_Brutus_Kasse) 
	&& (Kapitel < 3)
	&& (NpcObsessedByDMT_Brutus == FALSE)
	{
		return TRUE;
	};
};
func void DIA_Brutus_Den_Info ()
{
	AI_Output (other, self, "DIA_Brutus_Den_15_00"); //Nevíš, kam Den míâil?
	AI_Output (self, other, "DIA_Brutus_Den_06_01"); //Nejspíš co nejdál odsud. Možná se pokusil projít průsmykem.
	AI_Output (other, self, "DIA_Brutus_Den_15_02"); //Díky, fakt jsi mi moc pomohl.
	AI_Output (self, other, "DIA_Brutus_Den_06_03"); //No co můžu âíct? Nemám ani potuchy, kam mohl jít.
	
	B_LogEntry (TopicBrutusKasse,"Den se snažil projít průsmykem.");
};
///////////////////////////////////////////////////////////////////////
//	Info Gold
///////////////////////////////////////////////////////////////////////
instance DIA_Brutus_Gold		(C_INFO)
{
	npc			 = 	VLK_4100_Brutus;
	nr			 = 	2;
	condition	 = 	DIA_Brutus_Gold_Condition;
	information	 = 	DIA_Brutus_Gold_Info;
	permanent	 = 	TRUE;
	description	 = 	"Nęco tu pro tebe mám (pâedat 200 zlaăáků).";
};

func int DIA_Brutus_Gold_Condition ()
{	
	if  Npc_KnowsInfo (hero,DIA_Brutus_Kasse) 
	&& (NpcObsessedByDMT_Brutus == FALSE)
	&& (Brutus_TeachSTR == FALSE)
	{
		return TRUE;
	};
};
func void DIA_Brutus_Gold_Info ()
{
	AI_Output (other, self, "DIA_Brutus_Gold_15_00"); //Nęco tu pro tebe mám.
	
	if B_GiveInvItems (other,self,Itmi_Gold,200)
	{
		AI_Output (self, other, "DIA_Brutus_Gold_06_01"); //Výbornę. Nyní tę můžu vycvičit, jestli tedy chceš.
		Brutus_TeachSTR = TRUE;
		Log_CreateTopic	(TOPIC_Teacher_OC, LOG_NOTE);
		B_LogEntry		(TOPIC_Teacher_OC, "S pomocí Bruta se mohu stát silnęjším.");
		B_GivePlayerXP  (XP_Ambient);
	}
	else 
	{
		AI_Output (self, other, "DIA_Brutus_Gold_06_02"); //Poslyš, prostę mi pâines 200 zlaăáků. Nezajímá mę, kde si je opatâíš - zlaăák jako zlaăák.
	};
};
//*******************************************
//	TechPlayer
//*******************************************
INSTANCE DIA_Brutus_Teach(C_INFO)
{
	npc			= VLK_4100_Brutus;
	nr			= 7;
	condition	= DIA_Brutus_Teach_Condition;
	information	= DIA_Brutus_Teach_Info;
	permanent	= TRUE;
	description = "Chtęl bych se stát silnęjším.";
};                       

FUNC INT DIA_Brutus_Teach_Condition()
{
	if (Brutus_TeachSTR == TRUE)
	&& (NpcObsessedByDMT_Brutus == FALSE)
	{
		return TRUE;
	};
};
 
FUNC VOID DIA_Brutus_Teach_Info()
{	
	AI_Output (other,self ,"DIA_Brutus_Teach_15_00"); //Chtęl bych se stát silnęjším.

	Info_ClearChoices (DIA_Brutus_Teach);
	Info_AddChoice		(DIA_Brutus_Teach, DIALOG_BACK, DIA_Brutus_Teach_Back);
	Info_AddChoice		(DIA_Brutus_Teach, B_BuildLearnString(PRINT_LearnSTR1			, B_GetLearnCostAttribute(other, ATR_STRENGTH))			,DIA_Brutus_Teach_STR_1);
	Info_AddChoice		(DIA_Brutus_Teach, B_BuildLearnString(PRINT_LearnSTR5			, B_GetLearnCostAttribute(other, ATR_STRENGTH)*5)		,DIA_Brutus_Teach_STR_5);
};

FUNC VOID DIA_Brutus_Teach_Back ()
{
	Info_ClearChoices (DIA_Brutus_Teach);
};

FUNC VOID DIA_Brutus_Teach_STR_1 ()
{
	B_TeachAttributePoints (self, other, ATR_STRENGTH, 1, T_MED);
	
	Info_ClearChoices 	(DIA_Brutus_Teach);
	Info_AddChoice		(DIA_Brutus_Teach, DIALOG_BACK, DIA_Brutus_Teach_Back);
	Info_AddChoice		(DIA_Brutus_Teach, B_BuildLearnString(PRINT_LearnSTR1		, B_GetLearnCostAttribute(other, ATR_STRENGTH))			,DIA_Brutus_Teach_STR_1);
	Info_AddChoice		(DIA_Brutus_Teach, B_BuildLearnString(PRINT_LearnSTR5			, B_GetLearnCostAttribute(other, ATR_STRENGTH)*5)		,DIA_Brutus_Teach_STR_5);
};

FUNC VOID DIA_Brutus_Teach_STR_5 ()
{
	B_TeachAttributePoints (self, other, ATR_STRENGTH, 5, T_MED);
	
	Info_ClearChoices 	(DIA_Brutus_Teach);
	Info_AddChoice		(DIA_Brutus_Teach, DIALOG_BACK, DIA_Brutus_Teach_Back);
	Info_AddChoice		(DIA_Brutus_Teach, B_BuildLearnString(PRINT_LearnSTR1		, B_GetLearnCostAttribute(other, ATR_STRENGTH))			,DIA_Brutus_Teach_STR_1);
	Info_AddChoice		(DIA_Brutus_Teach, B_BuildLearnString(PRINT_LearnSTR5		, B_GetLearnCostAttribute(other, ATR_STRENGTH)*5)		,DIA_Brutus_Teach_STR_5);
	
};
//#####################################################################
//##
//##
//##							KAPITEL 3
//##
//##
//#####################################################################

// ************************************************************
// 	  				   EXIT KAP3
// ************************************************************

INSTANCE DIA_Brutus_KAP3_EXIT(C_INFO)
{
	npc			= VLK_4100_Brutus;
	nr			= 999;
	condition	= DIA_Brutus_KAP3_EXIT_Condition;
	information	= DIA_Brutus_KAP3_EXIT_Info;
	permanent	= TRUE;
	description = DIALOG_ENDE;
};                       
FUNC INT DIA_Brutus_KAP3_EXIT_Condition()
{
	if (Kapitel == 3)	
	{
		return TRUE;
	};
};
FUNC VOID DIA_Brutus_KAP3_EXIT_Info()
{	
	B_NpcClearObsessionByDMT (self);
};

///////////////////////////////////////////////////////////////////////
//	Info DuSchonWieder
///////////////////////////////////////////////////////////////////////
instance DIA_Brutus_DUSCHONWIEDER		(C_INFO)
{
	npc			 = 	VLK_4100_Brutus;
	nr			 = 	30;
	condition	 = 	DIA_Brutus_DUSCHONWIEDER_Condition;
	information	 = 	DIA_Brutus_DUSCHONWIEDER_Info;
	permanent	 = 	TRUE;
	description	 = 	"Mučil jsi dneska nękoho?";
};

func int DIA_Brutus_DUSCHONWIEDER_Condition ()
{
	if (Kapitel == 3)	
		&& (NpcObsessedByDMT_Brutus == FALSE)
	{
		return TRUE;
	};
};

func void DIA_Brutus_DUSCHONWIEDER_Info ()
{
	AI_Output (other, self, "DIA_Brutus_DUSCHONWIEDER_15_00"); //Mučil jsi dneska nękoho?
	AI_Output (self, other, "DIA_Brutus_DUSCHONWIEDER_06_01"); //Copak nevidíš, že mám práci? Vraă se pozdęji.

	B_NpcClearObsessionByDMT (self);
};


//#####################################################################
//##
//##
//##							KAPITEL 4
//##
//##
//#####################################################################


// ************************************************************
// 	  				   EXIT KAP4
// ************************************************************

INSTANCE DIA_Brutus_KAP4_EXIT(C_INFO)
{
	npc			= VLK_4100_Brutus;
	nr			= 999;
	condition	= DIA_Brutus_KAP4_EXIT_Condition;
	information	= DIA_Brutus_KAP4_EXIT_Info;
	permanent	= TRUE;
	description = DIALOG_ENDE;
};                       
FUNC INT DIA_Brutus_KAP4_EXIT_Condition()
{
	if (Kapitel == 4)	
	{
		return TRUE;
	};
};
FUNC VOID DIA_Brutus_KAP4_EXIT_Info()
{	
	B_NpcClearObsessionByDMT (self);
};


///////////////////////////////////////////////////////////////////////
//	Info Warumnichtarbbeit
///////////////////////////////////////////////////////////////////////
instance DIA_Brutus_WARUMNICHTARBBEIT		(C_INFO)
{
	npc		 = 	VLK_4100_Brutus;
	nr		 = 	40;
	condition	 = 	DIA_Brutus_WARUMNICHTARBBEIT_Condition;
	information	 = 	DIA_Brutus_WARUMNICHTARBBEIT_Info;

	description	 = 	"Jak to, že nejsi v práci?";
};

func int DIA_Brutus_WARUMNICHTARBBEIT_Condition ()
{
	if (Kapitel >= 4)
		&& (NpcObsessedByDMT_Brutus == FALSE)
		&& (MIS_OCGateOpen == FALSE)
		{
				return TRUE;
		};
};

func void DIA_Brutus_WARUMNICHTARBBEIT_Info ()
{
	AI_Output			(other, self, "DIA_Brutus_WARUMNICHTARBBEIT_15_00"); //Jak to, že nejsi v práci?
	AI_Output			(self, other, "DIA_Brutus_WARUMNICHTARBBEIT_06_01"); //(úzkostnę) To je ale nechutné!
	AI_Output			(self, other, "DIA_Brutus_WARUMNICHTARBBEIT_06_02"); //Vidęls, jak to u mę vypadá? Ty hnusný žravý štęnice jsou úplnę všude!
	AI_Output			(self, other, "DIA_Brutus_WARUMNICHTARBBEIT_06_03"); //Nemám ani šajna, kdo tam co dęlal, ale já se tam určitę nevrátím, dokud tam bude ten hnusný hmyz.
	AI_Output			(self, other, "DIA_Brutus_WARUMNICHTARBBEIT_06_04"); //Já ty potvory prostę nesnáším. A pâestaŕ se tak blbę kâenit.

	Log_CreateTopic (TOPIC_BrutusMeatbugs, LOG_MISSION);
	Log_SetTopicStatus(TOPIC_BrutusMeatbugs, LOG_RUNNING);
	B_LogEntry (TOPIC_BrutusMeatbugs,"Hradní mučitel Brutus se mi svęâil, že mu neškodné žravé štęnice v mučírnę nahánęjí husí kůži. Je to prostę drsŕák každým coulem."); 

};


///////////////////////////////////////////////////////////////////////
//	Info Meatbugsweg
///////////////////////////////////////////////////////////////////////
instance DIA_Brutus_MEATBUGSWEG		(C_INFO)
{
	npc		 = 	VLK_4100_Brutus;
	nr		 = 	31;
	condition	 = 	DIA_Brutus_MEATBUGSWEG_Condition;
	information	 = 	DIA_Brutus_MEATBUGSWEG_Info;
	
	description	 = 	"Už je po štęnicích. Můžeš se vrátit a leštit všechny ty palečnice a ostatní mučící nástroje.";
};

func int DIA_Brutus_MEATBUGSWEG_Condition ()
{
	if (Npc_KnowsInfo(other, DIA_Brutus_WARUMNICHTARBBEIT))
		&& (Npc_IsDead(Meatbug_Brutus1))
		&& (Npc_IsDead(Meatbug_Brutus2))
		&& (Npc_IsDead(Meatbug_Brutus3))
		&& (Npc_IsDead(Meatbug_Brutus4))
		&& (Kapitel >= 4)
		&& (NpcObsessedByDMT_Brutus == FALSE)
		&& (MIS_OCGateOpen == FALSE)
		{
				return TRUE;
		};
};

func void DIA_Brutus_MEATBUGSWEG_Info ()
{
	AI_Output			(other, self, "DIA_Brutus_MEATBUGSWEG_15_00"); //Už je po štęnicích. Můžeš se vrátit a leštit všechny ty palečnice a ostatní mučící nástroje.
	AI_Output			(self, other, "DIA_Brutus_MEATBUGSWEG_06_01"); //Víš opravdu jistę, že tam ani jedna z tęch potvor nezbyla?
	AI_Output			(other, self, "DIA_Brutus_MEATBUGSWEG_15_02"); //Naprosto jistę.
	AI_Output			(self, other, "DIA_Brutus_MEATBUGSWEG_06_03"); //No tak tedy dobâe. Tumáš, za odmęnu si vezmi tohle zlato.
	AI_Output			(other, self, "DIA_Brutus_MEATBUGSWEG_15_04"); //Uá, jenom mę tu nerozbreč.

	TOPIC_END_BrutusMeatbugs = TRUE;
	
	B_GivePlayerXP (XP_BrutusMeatbugs);
	B_NpcClearObsessionByDMT (self);

	CreateInvItems (self, ItMi_Gold, 150);									
	B_GiveInvItems (self, other, ItMi_Gold, 150);					

	Npc_ExchangeRoutine	(self,"Start");  
};

///////////////////////////////////////////////////////////////////////
//	Info perm4
///////////////////////////////////////////////////////////////////////
instance DIA_Brutus_PERM4		(C_INFO)
{
	npc		 = 	VLK_4100_Brutus;
	nr		 = 	32;
	condition	 = 	DIA_Brutus_PERM4_Condition;
	information	 = 	DIA_Brutus_PERM4_Info;
	permanent	 = 	TRUE;

	description	 = 	"Jsi v poâádku?";
};

func int DIA_Brutus_PERM4_Condition ()
{
	if 	((Npc_KnowsInfo(other, DIA_Brutus_MEATBUGSWEG))
	 	||(MIS_OCGateOpen == TRUE))
	 	&& (NpcObsessedByDMT_Brutus == FALSE)
	 {
				return TRUE;
	 };
};

func void DIA_Brutus_PERM4_Info ()
{

	if 	(
			(MIS_OCGateOpen == TRUE) 
			|| ((hero.guild == GIL_KDF)&& (Kapitel >= 5))
		)
		{						
			B_NpcObsessedByDMT (self);
		}
		else 
 		{
			AI_Output			(other, self, "DIA_Brutus_PERM4_15_00"); //Jsi v poâádku?
			AI_Output			(self, other, "DIA_Brutus_PERM4_06_01"); //(znepokojenę) A víš určitę, že už tam žádné žravé štęnice nejsou?
			AI_Output			(other, self, "DIA_Brutus_PERM4_15_02"); //Ehm, podívej, jednu máš pâímo za sebou!
			AI_Output			(self, other, "DIA_Brutus_PERM4_06_03"); //(ječí) Cože?
		
			B_NpcClearObsessionByDMT (self);
			
			
			Npc_SetTarget 		(self, other);
			
			self.aivar[AIV_INVINCIBLE] = FALSE; //HACK, weil durch AI_StartState (böse) Flag nicht zurückgesetzt wird 
			other.aivar[AIV_INVINCIBLE] = FALSE;
			
			AI_StartState 		(self, ZS_Flee, 0, "");
		 };		
};	

///////////////////////////////////////////////////////////////////////
//	Info bessen
///////////////////////////////////////////////////////////////////////
instance DIA_Brutus_BESSEN		(C_INFO)
{
	npc		 = 	VLK_4100_Brutus;
	nr		 = 	55;
	condition	 = 	DIA_Brutus_BESSEN_Condition;
	information	 = 	DIA_Brutus_BESSEN_Info;
	permanent	 = 	TRUE;

	description	 = 	"Ty jsi posedlý!";
};

func int DIA_Brutus_BESSEN_Condition ()
{
 	if (NpcObsessedByDMT_Brutus == TRUE)
 		&& (NpcObsessedByDMT == FALSE)
	 {
				return TRUE;
	 };
};

func void DIA_Brutus_BESSEN_Info ()
{
	AI_Output			(other, self, "DIA_Brutus_BESSEN_15_00"); //Ty jsi posedlý!

	if (hero.guild == GIL_KDF)
		||(hero.guild == GIL_PAL)
	{
	AI_Output			(other, self, "DIA_Brutus_BESSEN_15_01"); //Bęž do kláštera, aă tę tam vyléčí.
	AI_Output			(self, other, "DIA_Brutus_BESSEN_06_02"); //Mnę už není pomoci, bęž pryč!
	B_NpcClearObsessionByDMT (self);
	}
	else
	{
	AI_Output			(other, self, "DIA_Brutus_BESSEN_15_03"); //Nękdo ti musí z hlavy vypudit ty démony.
	AI_Output			(self, other, "DIA_Brutus_BESSEN_06_04"); //(kâičí) NE!
	B_NpcClearObsessionByDMT (self);
		
	Npc_SetTarget 		(self, other);
	
	self.aivar[AIV_INVINCIBLE] = FALSE; //HACK, weil durch AI_StartState (böse) Flag nicht zurückgesetzt wird 
	other.aivar[AIV_INVINCIBLE] = FALSE;
			
	AI_StartState 		(self, ZS_Flee, 0, "");	
	};
};

//#####################################################################
//##
//##
//##							KAPITEL 5 und 6
//##
//##
//#####################################################################

// ************************************************************
// 	  				   EXIT KAP5
// ************************************************************

INSTANCE DIA_Brutus_KAP5_EXIT(C_INFO)
{
	npc			= VLK_4100_Brutus;
	nr			= 999;
	condition	= DIA_Brutus_KAP5_EXIT_Condition;
	information	= DIA_Brutus_KAP5_EXIT_Info;
	permanent	= TRUE;
	description = DIALOG_ENDE;
};                       
FUNC INT DIA_Brutus_KAP5_EXIT_Condition()
{
	if (Kapitel >= 5)	
	{
		return TRUE;
	};
};
FUNC VOID DIA_Brutus_KAP5_EXIT_Info()
{	
	B_NpcClearObsessionByDMT (self);
};


// ************************************************************
// 			  				PICK POCKET
// ************************************************************

INSTANCE DIA_Brutus_PICKPOCKET (C_INFO)
{
	npc			= VLK_4100_Brutus;
	nr			= 900;
	condition	= DIA_Brutus_PICKPOCKET_Condition;
	information	= DIA_Brutus_PICKPOCKET_Info;
	permanent	= TRUE;
	description = Pickpocket_20;
};                       

FUNC INT DIA_Brutus_PICKPOCKET_Condition()
{
	C_Beklauen (14, 35);
};
 
FUNC VOID DIA_Brutus_PICKPOCKET_Info()
{	
	Info_ClearChoices	(DIA_Brutus_PICKPOCKET);
	Info_AddChoice		(DIA_Brutus_PICKPOCKET, DIALOG_BACK 		,DIA_Brutus_PICKPOCKET_BACK);
	Info_AddChoice		(DIA_Brutus_PICKPOCKET, DIALOG_PICKPOCKET	,DIA_Brutus_PICKPOCKET_DoIt);
};

func void DIA_Brutus_PICKPOCKET_DoIt()
{
	B_Beklauen ();
	Info_ClearChoices (DIA_Brutus_PICKPOCKET);
};
	
func void DIA_Brutus_PICKPOCKET_BACK()
{
	Info_ClearChoices (DIA_Brutus_PICKPOCKET);
};





































