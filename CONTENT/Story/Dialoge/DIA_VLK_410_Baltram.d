///////////////////////////////////////////////////////////////////////
//	Info EXIT 
///////////////////////////////////////////////////////////////////////
INSTANCE DIA_Baltram_EXIT   (C_INFO)
{
	npc         = VLK_410_Baltram;
	nr          = 999;
	condition   = DIA_Baltram_EXIT_Condition;
	information = DIA_Baltram_EXIT_Info;
	permanent   = TRUE;
	description = DIALOG_ENDE;
};
FUNC INT DIA_Baltram_EXIT_Condition()
{
	return TRUE;
};
FUNC VOID DIA_Baltram_EXIT_Info()
{
	AI_StopProcessInfos (self);
};
///////////////////////////////////////////////////////////////////////AUSKOMMENTIERT WEGEN ADDON M.F. (Missionen passen nicht mehr, Spielfluß hemmend)
//	Info Sperre
///////////////////////////////////////////////////////////////////////
/*
instance DIA_Baltram_Sperre		(C_INFO)
{
	npc			 = 	VLK_410_Baltram;
	nr			 = 	1;
	condition	 = 	DIA_Baltram_Sperre_Condition;
	information	 = 	DIA_Baltram_Sperre_Info;
	permanent	 =  TRUE;
	important	 = 	TRUE;
};
func int DIA_Baltram_Sperre_Condition ()
{
	if (Canthar_Sperre == TRUE)
	&& (Npc_IsInState (self, ZS_Talk ))
	&& ((!Npc_KnowsInfo (other, DIA_Addon_Baltram_LaresAbloese))
	|| (SCIsWearingRangerRing == FALSE))
	{
		return TRUE;
	};
};
func void DIA_Baltram_Sperre_Info ()
{
	AI_Output (self, other, "DIA_Baltram_Sperre_01_00"); //Was willst du? Du bist ein Sträfling aus der Minenkolonie. Mit dir mache ich keine Geschäfte!
	AI_StopProcessInfos (self);	 
};
*/
///////////////////////////////////////////////////////////////////////
//	Info Hallo
///////////////////////////////////////////////////////////////////////
instance DIA_Baltram_Hallo		(C_INFO)
{
	npc			 = 	VLK_410_Baltram;
	nr			 = 	2;
	condition	 = 	DIA_Baltram_Hallo_Condition;
	information	 = 	DIA_Baltram_Hallo_Info;
	permanent	 =  FALSE;
	important	 = 	TRUE;
};
func int DIA_Baltram_Hallo_Condition ()
{
	if (Npc_IsInState (self, ZS_Talk))
	&& (self.aivar[AIV_TalkedToPlayer] == FALSE)
	//&& (Canthar_Sperre == FALSE)
	&& (MIS_Nagur_Bote == FALSE) 
	{
		return TRUE;
	};
};
func void DIA_Baltram_Hallo_Info ()
{
	if (hero.guild != GIL_SLD)
	&& (hero.guild != GIL_DJG)
	{
		AI_Output (self, other, "DIA_Baltram_Hallo_01_00"); //Vítej, cizinče, jmenuji se Baltram. Pâišel ses zásobit jídlem?
		AI_Output (self, other, "DIA_Baltram_Hallo_01_01"); //Obávám se, že tę zklamu. Moc toho právę teë na skladę nemám.
		AI_Output (self, other, "DIA_Baltram_Hallo_01_02"); //Ale každým dnem bych męl dostat nové zboží.
	}
	else
	{
		AI_Output (self, other, "DIA_Baltram_Hallo_01_03"); //Pokud jsi pâišel ke mnę nakoupit jídlo, můžeš jít klidnę zase pryč.
		AI_Output (self, other, "DIA_Baltram_Hallo_01_04"); //Nemyslím si o vás žoldácích nic dobrého! Způsobujete mi jen samé problémy.
	};
};

///////////////////////////////////////////////////////////////////////
//	Info LaresAbloese
///////////////////////////////////////////////////////////////////////
instance DIA_Addon_Baltram_LaresAbloese		(C_INFO)
{
	npc		 	= VLK_410_Baltram;
	nr		 	= 1;
	condition	= DIA_Addon_Baltram_LaresAbloese_Condition;
	information	= DIA_Addon_Baltram_LaresAbloese_Info;

	important 	= TRUE;
};

func int DIA_Addon_Baltram_LaresAbloese_Condition ()
{
	if (Npc_IsInState (self, ZS_Talk))
	&& (SCIsWearingRangerRing == TRUE)
	&& (MIS_Lares_BringRangerToMe == LOG_RUNNING)
	{
		return TRUE;
	};
};

func void DIA_Addon_Baltram_LaresAbloese_Info ()
{
	AI_Output	(other, self, "DIA_Addon_Baltram_LaresAbloese_15_00"); //Proč vypadáš tak skepticky?
	AI_Output	(self, other, "DIA_Addon_Baltram_LaresAbloese_01_01"); //Vidím, že máš znamení 'Kruhu Vody'.
	AI_Output	(other, self, "DIA_Addon_Baltram_LaresAbloese_15_02"); //Jsi jedním z nich?
	AI_Output	(self, other, "DIA_Addon_Baltram_LaresAbloese_01_03"); //A pokud by to byl ten pâípad?
	AI_Output	(other, self, "DIA_Addon_Baltram_LaresAbloese_15_04"); //To bych ti pak âekl, že Lares chce nękoho jiného, kdo se posará o jeho úkol v pâístavu.
	AI_Output	(self, other, "DIA_Addon_Baltram_LaresAbloese_01_05"); //Ok. Pokusím se najít nękoho, kdo bude ochoten to udęlat.
	AI_Output	(other, self, "DIA_Addon_Baltram_LaresAbloese_15_06"); //Výbornę.
	B_GivePlayerXP (XP_Ambient);

	B_LogEntry (TOPIC_Addon_BringRangerToLares,"Baltram, obchodník na tržišti, se postará o Laresův ornament. Možná bude moci Lares KONEČNĘ opustit pâístav."); 

	SC_KnowsBaltramAsRanger = TRUE;
	Baltram_Exchange4Lares = TRUE;
};

///////////////////////////////////////////////////////////////////////
//	Info Job
///////////////////////////////////////////////////////////////////////
instance DIA_Baltram_Job		(C_INFO)
{
	npc			 = 	VLK_410_Baltram;
	nr			 = 	3;
	condition	 = 	DIA_Baltram_Job_Condition;
	information	 = 	DIA_Baltram_Job_Info;
	permanent	 =  FALSE;
	description  =  "Máš pro mę práci?";
};
func int DIA_Baltram_Job_Condition ()
{
	if (MIS_Nagur_Bote != LOG_RUNNING)
	&& (MIS_Nagur_Bote != LOG_SUCCESS)
	&& (hero.guild == GIL_NONE)
	{
		return TRUE;
	};	
};
func void DIA_Baltram_Job_Info ()
{
	AI_Output (other, self, "DIA_Baltram_Job_15_00"); //Máš pro mę práci?
	AI_Output (self, other, "DIA_Baltram_Job_01_01"); //Ne, poslíčka už mám. Zkus to u jiného obchodníka.
};
///////////////////////////////////////////////////////////////////////
//	Info Trick
///////////////////////////////////////////////////////////////////////
instance DIA_Baltram_Trick		(C_INFO)
{
	npc			 = 	VLK_410_Baltram;
	nr			 = 	4;
	condition	 = 	DIA_Baltram_Trick_Condition;
	information	 = 	DIA_Baltram_Trick_Info;
	permanent	 =  FALSE;
	important 	 =  TRUE;
};
func int DIA_Baltram_Trick_Condition ()
{
	if Npc_IsInState (self, ZS_Talk)
	&& (MIS_Nagur_Bote == LOG_RUNNING)
	{
		return TRUE;
	};
};
func void DIA_Baltram_Trick_Info ()
{
	AI_Output (self, other, "DIA_Baltram_Trick_01_00"); //Hledáš práci?
	AI_Output (other, self, "DIA_Baltram_Trick_15_01"); //Jasnę, o co jde?
	AI_Output (self, other, "DIA_Baltram_Trick_01_02"); //Můj poslíček se ještę nevrátil zpátky a já čekám dodávku od farmáâe Akila.
	AI_Output (other, self, "DIA_Baltram_Trick_15_03"); //A kolik mi za to dáš?
	AI_Output (self, other, "DIA_Baltram_Trick_01_04"); //Dám ti 50 zlaăáků.
	AI_Output (other, self, "DIA_Baltram_Trick_15_05"); //Dobrá, to beru.
	AI_Output (self, other, "DIA_Baltram_Trick_01_06"); //Dobrá, jenom âekni Akilovi, že tę posílám. Dá ti balík. Pâines mi ho.
	
	MIS_Baltram_ScoutAkil = LOG_RUNNING;
	B_LogEntry (TOPIC_Nagur,"Baltram mę zamęstnal jako poslíčka. Mám mu pâinést nęjakou zásilku z Akilova statku.");
	
	Log_CreateTopic (TOPIC_Baltram,LOG_MISSION);
	Log_SetTopicStatus (TOPIC_Baltram,LOG_RUNNING);
	B_LogEntry (TOPIC_Baltram, "Když Beltramovi doručím jeho zásilku, zaplatí mi 50 zlaăáků.");
};
///////////////////////////////////////////////////////////////////////
//	Info WAREZ
///////////////////////////////////////////////////////////////////////
var int Baltram_TradeLOG;
// --------------------------------------------------------------
instance DIA_Baltram_WAREZ		(C_INFO)
{
	npc			 = 	VLK_410_Baltram;
	nr			 = 	2;
	condition	 = 	DIA_Baltram_WAREZ_Condition;
	information	 = 	DIA_Baltram_WAREZ_Info;
	permanent	 = 	TRUE;
	trade		 = 	TRUE;
	description	 = 	"Ukaž mi své zboží.";
};

func int DIA_Baltram_WAREZ_Condition ()
{
	return TRUE;
};
func void DIA_Baltram_WAREZ_Info ()
{
	B_GiveTradeInv (self);
	AI_Output (other, self,"DIA_Baltram_WAREZ_15_00"); //Ukaž mi své zboží.
	
	if (Baltram_TradeLOG == FALSE)
	{
		Log_CreateTopic (Topic_CityTrader,LOG_NOTE);
		B_LogEntry (Topic_CityTrader,"Baltram prodává na tržišti potraviny.");
		Baltram_TradeLOG = TRUE;
	};
	
	if (Kapitel == 3)
	&& (MIS_RescueBennet != LOG_SUCCESS)
	{
		AI_Output (self ,other,"DIA_Baltram_WAREZ_01_01"); //Nemęli to nechat dojít tak daleko. Teë jeden ze žoldáků zavraždil paladina.
		AI_Output (self ,other,"DIA_Baltram_WAREZ_01_02"); //Nęco by se męlo stát!
	};
	if ((MIS_BaltramTrade != LOG_SUCCESS)
	&& ((hero.guild == GIL_SLD)
	||  (hero.guild == GIL_DJG)))
	{
		AI_Output (self ,other,"DIA_Baltram_WAREZ_01_03"); //Lidé jako ty ode mne nic nedostanou.
		AI_Output (other, self,"DIA_Baltram_WAREZ_15_04"); //Proč?
		AI_Output (self ,other,"DIA_Baltram_WAREZ_01_05"); //Nejdâív znesváâíte farmáâe a potom dęláte, jako by se nic nestalo.
		AI_Output (self ,other,"DIA_Baltram_WAREZ_01_06"); //Teë vypadni, odháníš mi zákazníky.
		
		MIS_BaltramTrade = LOG_FAILED;
		
		AI_StopProcessInfos (self);
	};
};

///////////////////////////////////////////////////////////////////////
//	Info Skip
///////////////////////////////////////////////////////////////////////
instance DIA_Addon_Baltram_Skip		(C_INFO)
{
	npc		 = 	VLK_410_Baltram;
	nr		 = 	5;
	condition	 = 	DIA_Addon_Baltram_Skip_Condition;
	information	 = 	DIA_Addon_Baltram_Skip_Info;

	description	 = 	"Mimochodem, ty jsi v kontaktu s piráty?";
};

func int DIA_Addon_Baltram_Skip_Condition ()
{
	if (SCKnowsBaltramAsPirateTrader == TRUE)
		{
			return TRUE;
		};
};

func void DIA_Addon_Baltram_Skip_Info ()
{
	AI_Output	(other, self, "DIA_Addon_Baltram_Skip_15_00"); //(náhodile) Mimochoem, ty jsi v kontaktu s piráty?
	AI_Output	(self, other, "DIA_Addon_Baltram_Skip_01_01"); //(cítí se odhalen) Co? Kdo to âíkal?
	AI_Output	(other, self, "DIA_Addon_Baltram_Skip_15_02"); //Mluvil jsem s jedním. Vypadá to, že na tebe čeká ve svém zálivu.
	AI_Output	(self, other, "DIA_Addon_Baltram_Skip_01_03"); //Dobâe, a co bych męl teda dęlat? Tęžké časy, vždyă víš. Musím se nęjak živit.
	
	Info_ClearChoices	(DIA_Addon_Baltram_Skip);
	Info_AddChoice	(DIA_Addon_Baltram_Skip, "Nebojíš se, že tę pâitom chytí?", DIA_Addon_Baltram_Skip_erwischen );
	Info_AddChoice	(DIA_Addon_Baltram_Skip, "Budeš muset čelit důsledkům svých činů!", DIA_Addon_Baltram_Skip_MIL );
};
func void DIA_Addon_Baltram_Skip_Back ()
{
	AI_Output (other, self, "DIA_Addon_Baltram_Skip_Back_15_00"); //Ok, to je vše, co jsem chtęl vędęt.
	Info_ClearChoices	(DIA_Addon_Baltram_Skip);
};

func void DIA_Addon_Baltram_Skip_MIL ()
{
	AI_Output (other, self, "DIA_Addon_Baltram_Skip_MIL_15_00"); //Budeš muset čelit důsledkům svých činů!
	AI_Output (self, other, "DIA_Addon_Baltram_Skip_MIL_01_01"); //Hej, poslouchej. Âeknu ti všechno co vím a ty to na mę na oplátku neâekneš, ok?
	
	Info_ClearChoices (DIA_Addon_Baltram_Skip);
	Info_AddChoice	(DIA_Addon_Baltram_Skip, "Jaké zboží vymęŕuješ?", DIA_Addon_Baltram_Skip_was );
	Info_AddChoice	(DIA_Addon_Baltram_Skip, "Co víš o pirátech?", DIA_Addon_Baltram_Skip_pirat );
};

func void DIA_Addon_Baltram_Skip_erwischen ()
{
	AI_Output (other, self, "DIA_Addon_Baltram_Skip_erwischen_15_00"); //Nebojíš se, že tę pâitom chytí?
	AI_Output (self, other, "DIA_Addon_Baltram_Skip_erwischen_01_01"); //No, může se to stát. Nakonec, však ty jsi to zjistil.
	AI_Output (self, other, "DIA_Addon_Baltram_Skip_erwischen_01_02"); //Ale ty to nikomu neâekneš, že ne?
	
	Info_ClearChoices	(DIA_Addon_Baltram_Skip);
	Info_AddChoice	(DIA_Addon_Baltram_Skip, "Jaké zboží vymęŕuješ?", DIA_Addon_Baltram_Skip_was );
	Info_AddChoice	(DIA_Addon_Baltram_Skip, "Co víš o pirátech?", DIA_Addon_Baltram_Skip_pirat );
};

func void DIA_Addon_Baltram_Skip_was ()
{
	AI_Output			(other, self, "DIA_Addon_Baltram_Skip_was_15_00"); //(tvrdę) Jaké zboží vymęŕuješ?
	AI_Output			(self, other, "DIA_Addon_Baltram_Skip_was_01_01"); //Obvykle jídlo.
	AI_Output			(self, other, "DIA_Addon_Baltram_Skip_was_01_02"); //A výmęnou za to dostávám ten nejlepší rum, jaký můžes v Khorinisu dostat.
	
	Info_AddChoice	(DIA_Addon_Baltram_Skip, "Ok, to je vše, co jsem chtęl vędęt.", DIA_Addon_Baltram_Skip_Back );
	Info_AddChoice	(DIA_Addon_Baltram_Skip, "Mohl bych ti pomoci.", DIA_Addon_Baltram_Skip_Ich );
};

func void DIA_Addon_Baltram_Skip_Ich ()
{
	AI_Output			(other, self, "DIA_Addon_Baltram_Skip_Ich_15_00"); //(s úsmęvem) Mohl bych ti pomoci.
	AI_Output			(self, other, "DIA_Addon_Baltram_Skip_Ich_01_01"); //To není špatný nápad. Teë zrovna nemůžu opustit Khorinis.
	CreateInvItems (self, ItMi_Packet_Baltram4Skip_Addon, 1);									
	B_GiveInvItems (self, other, ItMi_Packet_Baltram4Skip_Addon, 1);		
	AI_Output			(self, other, "DIA_Addon_Baltram_Skip_Ich_01_02"); //Tady, vezmi si tento balíček a âekni Skipovi, aă tentokrát s tím rumem nešetâí.
	AI_Output			(self, other, "DIA_Addon_Baltram_Skip_Ich_01_03"); //Nemęlo by to být míŕ než 3 flašky.
	
	B_LogEntry (TOPIC_Addon_BaltramSkipTrade,"Baltram mi dal balíček. Męl bych ho doručit Skipovi."); 
	
	MIS_Addon_Baltram_Paket4Skip = LOG_RUNNING;
};

func void DIA_Addon_Baltram_Skip_pirat ()
{
	AI_Output			(other, self, "DIA_Addon_Baltram_Skip_pirat_15_00"); //(tvrdę) Co víš o pirátech?
	AI_Output			(self, other, "DIA_Addon_Baltram_Skip_pirat_01_01"); //(spęšnę) Žijí nękde schovaní na ostrovę.
	AI_Output			(self, other, "DIA_Addon_Baltram_Skip_pirat_01_02"); //Pokud vím, tak se tam dá dostat jedinę lodí.
	AI_Output			(self, other, "DIA_Addon_Baltram_Skip_pirat_01_03"); //Občané Khorinisu se jich bojí. Oprávnęnę. V podstatę je to banda smradlavých hrdloâezů.
	AI_Output			(self, other, "DIA_Addon_Baltram_Skip_pirat_01_04"); //Na druhou stranu si myslím, že poâád nejsou tak strašní jako banditi.
};

///////////////////////////////////////////////////////////////////////
//	Info SkipsRum
///////////////////////////////////////////////////////////////////////
instance DIA_Addon_Baltram_SkipsRum		(C_INFO)
{
	npc		 = 	VLK_410_Baltram;
	nr		 = 	5;
	condition	 = 	DIA_Addon_Baltram_SkipsRum_Condition;
	information	 = 	DIA_Addon_Baltram_SkipsRum_Info;

	description	 = 	"Mám ten rum. Bohužel mi Skip dal jen 2 flašky.";
};

func int DIA_Addon_Baltram_SkipsRum_Condition ()
{
	
	if (Skip_Rum4Baltram == TRUE)
	&& (MIS_Addon_Baltram_Paket4Skip == LOG_RUNNING)
	&& (Npc_HasItems (other,ItFo_Addon_Rum) >= 2)
		{
			return TRUE;
		};
};

func void DIA_Addon_Baltram_SkipsRum_Info ()
{
	AI_Output	(other, self, "DIA_Addon_Baltram_SkipsRum_15_00"); //Mám ten rum. Bohužel mi Skip dal jen 2 flašky.
	AI_Output	(self, other, "DIA_Addon_Baltram_SkipsRum_01_01"); //(naštvanę) Zatracenę drahé. Co si o sobę ten Skip vůbec myslí? Ale dobâe, dej to sem.
	B_GiveInvItems (other, self, ItFo_Addon_Rum,2); 
	AI_Output	(self, other, "DIA_Addon_Baltram_SkipsRum_01_02"); //Nemůžu ti za to dát mnoho. To je vše.
	CreateInvItems (self, ItMi_Gold, 10);									
	B_GiveInvItems (self, other, ItMi_Gold, 10);		

	TOPIC_END_BaltramSkipTrade = TRUE;
	B_GivePlayerXP (XP_Ambient);
};

///////////////////////////////////////////////////////////////////////
//	Info AkilsHof
///////////////////////////////////////////////////////////////////////
instance DIA_Baltram_AkilsHof		(C_INFO)
{
	npc			 = 	VLK_410_Baltram;
	nr			 =  4;
	condition	 = 	DIA_Baltram_AkilsHof_Condition;
	information	 = 	DIA_Baltram_AkilsHof_Info;
	permanent	 =  FALSE;
	description	 = 	"Kde najdu Akilovu farmu?";
};
func int DIA_Baltram_AkilsHof_Condition ()
{
	if (MIS_Baltram_ScoutAkil == LOG_RUNNING)
	{
		return TRUE;
	};
};

func void DIA_Baltram_AkilsHof_Info ()
{
	AI_Output (other, self, "DIA_Baltram_AkilsHof_15_00"); //Kde najdu Akilovu farmu?
	AI_Output (self, other, "DIA_Baltram_AkilsHof_01_01"); //Projdi východní branou a drž se cesty vedoucí na jihovýchod.
	AI_Output (self, other, "DIA_Baltram_AkilsHof_01_02"); //Po chvíli pâijdeš ke kamennému schodišti. Vyjdi nahoru a odtud už uvidíš Akilovu farmu.
};
///////////////////////////////////////////////////////////////////////
//	Info Lieferung geholt
///////////////////////////////////////////////////////////////////////
instance DIA_Baltram_Lieferung	(C_INFO)
{
	npc			 = 	VLK_410_Baltram;
	nr			 =  5;
	condition	 = 	DIA_Baltram_Lieferung_Condition;
	information	 = 	DIA_Baltram_Lieferung_Info;
	permanent 	 =  FALSE;
	description	 = 	"Mám Akilovu dodávku.";
};

func int DIA_Baltram_Lieferung_Condition ()
{
	if (Npc_HasItems (other, ItMi_BaltramPaket) >=1)
	{
		return TRUE;
	};
};
func void DIA_Baltram_Lieferung_Info ()
{
	AI_Output (other, self, "DIA_Baltram_Lieferung_15_00"); //Mám Akilovu dodávku.
	AI_Output (self, other, "DIA_Baltram_Lieferung_01_01"); //Výbornę. Konečnę zase můžu nabízet čerstvé zboží. Tady máš 50 zlatých.
	
	B_GiveInvItems (other, self, ItMi_BaltramPaket,1);
	B_GiveInvItems (self, other, ItMi_Gold,50);
	
	MIS_Baltram_ScoutAkil = LOG_SUCCESS;
	MIS_Nagur_Bote = LOG_FAILED;
	B_GivePlayerXP (XP_Baltram_ScoutAkil);
	
	Npc_RemoveInvItems (self, ItMi_BaltramPaket,1);
	
	CreateInvItems (self,ItFo_Cheese	,  5); 	
	CreateInvItems (self,ItFo_Apple 	, 10); 
	CreateInvItems (self,ItFo_Beer  	,  5);
	CreateInvItems (self,ItFo_Bacon 	,  5);
	CreateInvItems (self,ItFo_Sausage	,  5);
	
};

///////////////////////////////////////////////////////////////////////
//	Info LetUsTrade
///////////////////////////////////////////////////////////////////////
instance DIA_Baltram_LetUsTrade		(C_INFO)
{
	npc			 = 	VLK_410_Baltram;
	nr			 =  6;
	condition	 = 	DIA_Baltram_LetUsTrade_Condition;
	information	 = 	DIA_Baltram_LetUsTrade_Info;
	permanent	 =  FALSE;
	description	 = 	"Mohli bychom po tom všem spolu uzavâít obchod?";
};
func int DIA_Baltram_LetUsTrade_Condition ()
{
	if (MIS_BaltramTrade == LOG_FAILED)
	{
		return TRUE;
	};
};

func void DIA_Baltram_LetUsTrade_Info ()
{
	AI_Output (other, self, "DIA_Baltram_LetUsTrade_15_00"); //Mohli bychom po tom všem spolu uzavâít obchod?
	AI_Output (self, other, "DIA_Baltram_LetUsTrade_01_01"); //Poslouchej, když mi pâineseš 10 šunek a 10 lahví vína, potom s tebou budu zase obchodovat.
	AI_Output (other, self, "DIA_Baltram_LetUsTrade_15_02"); //Uvidím, co se dá dęlat.
	
	MIS_BaltramTrade = LOG_RUNNING;
};

var int BaltramEnoughBacon;
var int BaltramEnoughWine;

///////////////////////////////////////////////////////////////////////
//	Info HaveYourWarez
///////////////////////////////////////////////////////////////////////
instance DIA_Baltram_HaveYourWarez		(C_INFO)
{
	npc			 = 	VLK_410_Baltram;
	nr			 =  6;
	condition	 = 	DIA_Baltram_HaveYourWarez_Condition;
	information	 = 	DIA_Baltram_HaveYourWarez_Info;
	permanent	 =  TRUE;
	description	 = 	"Mám tvé zboží.";
};
func int DIA_Baltram_HaveYourWarez_Condition ()
{
	if (MIS_BaltramTrade == LOG_RUNNING)
	&& (MIS_BaltramTrade != LOG_SUCCESS)
	{
		return TRUE;
	};
};

func void DIA_Baltram_HaveYourWarez_Info ()
{
	AI_Output (other, self, "DIA_Baltram_HaveYourWarez_15_00"); //Mám tvé zboží.
	AI_Output (self, other, "DIA_Baltram_HaveYourWarez_01_01"); //Ukaž mi to.
	
	if (Npc_HasItems (other,ItFo_Bacon) < 10)
	{
		AI_Output (self, other, "DIA_Baltram_HaveYourWarez_01_02"); //Dohodli jsme se snad na 10 šunkách. Pâijë, až jich budeš mít dost.
		
		BaltramEnoughBacon = FALSE;
	}
	else
	{
		BaltramEnoughBacon = TRUE;
	};  
	if (Npc_HasItems (other,ItFo_Wine) < 10)
	{
		AI_Output (self, other, "DIA_Baltram_HaveYourWarez_01_03"); //A co 10 lahví vína? Na ty jsi zapomnęl?
	
		BaltramEnoughWine = FALSE;
	}
	else
	{
		BaltramEnoughWine = TRUE;
	};
	
	if (BaltramEnoughBacon == TRUE
	&&  BaltramEnoughWine  == TRUE)
	{
		AI_Output (self, other, "DIA_Baltram_HaveYourWarez_01_04"); //Hmm, není to sice nejlepší kvalita, ale v tęchto dobách nemůžeš být moc vybíravý.
		
		B_GiveInvItems (other,self,ItFo_Bacon,10);
		B_GiveInvItems (other,self,ItFo_Wine,10);
		
		MIS_BaltramTrade = LOG_SUCCESS;
	
		B_GivePlayerXP (XP_BaltramTrade);
		
		AI_Output (self, other, "DIA_Baltram_HaveYourWarez_01_05"); //Teë nám nic nebrání v uzavâení obchodu.
	};	
};



// ************************************************************
// 			  				PICK POCKET
// ************************************************************

INSTANCE DIA_Baltram_PICKPOCKET (C_INFO)
{
	npc			= VLK_410_Baltram;
	nr			= 900;
	condition	= DIA_Baltram_PICKPOCKET_Condition;
	information	= DIA_Baltram_PICKPOCKET_Info;
	permanent	= TRUE;
	description = Pickpocket_80;
};                       

FUNC INT DIA_Baltram_PICKPOCKET_Condition()
{
	C_Beklauen (76, 175);
};
 
FUNC VOID DIA_Baltram_PICKPOCKET_Info()
{	
	Info_ClearChoices	(DIA_Baltram_PICKPOCKET);
	Info_AddChoice		(DIA_Baltram_PICKPOCKET, DIALOG_BACK 		,DIA_Baltram_PICKPOCKET_BACK);
	Info_AddChoice		(DIA_Baltram_PICKPOCKET, DIALOG_PICKPOCKET	,DIA_Baltram_PICKPOCKET_DoIt);
};

func void DIA_Baltram_PICKPOCKET_DoIt()
{
	B_Beklauen ();
	Info_ClearChoices (DIA_Baltram_PICKPOCKET);
};
	
func void DIA_Baltram_PICKPOCKET_BACK()
{
	Info_ClearChoices (DIA_Baltram_PICKPOCKET);
};



















