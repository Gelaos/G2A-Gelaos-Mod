// ************************************************************
// 			  				   EXIT 
// ************************************************************
INSTANCE DIA_Sylvio_EXIT   (C_INFO)
{
	npc         = SLD_806_Sylvio;
	nr          = 999;
	condition   = DIA_Sylvio_EXIT_Condition;
	information = DIA_Sylvio_EXIT_Info;
	permanent   = TRUE;
	description = DIALOG_ENDE;
};

FUNC INT DIA_Sylvio_EXIT_Condition()
{
	return TRUE;
};

FUNC VOID DIA_Sylvio_EXIT_Info()
{
	AI_StopProcessInfos (self);
};

// ************************************************************
// 			  				   Hallo 
// ************************************************************
instance DIA_Sylvio_Hallo		(C_INFO)
{
	npc			= SLD_806_Sylvio;
	nr		 	= 1;
	condition	= DIA_Sylvio_Hallo_Condition;
	information	= DIA_Sylvio_Hallo_Info;
	permanent	= TRUE;
	description	= "Jak se vede?";
};

func int DIA_Sylvio_Hallo_Condition ()
{
	return TRUE;
};

func void DIA_Sylvio_Hallo_Info ()
{
	AI_Output (other, self, "DIA_Sylvio_Hallo_15_00"); //Jak se vede?
	AI_Output (self, other, "DIA_Sylvio_Hallo_09_01"); //Dal jsem ti svolení k tomu, abys mne oslovil?
	
	Sylvio_angequatscht = Sylvio_angequatscht + 1;
	AI_StopProcessInfos (self);
};

// ************************************************************
// 			  				  Thekla 
// ************************************************************
instance DIA_Sylvio_Thekla		(C_INFO)
{
	npc		 	= SLD_806_Sylvio;
	nr		 	= 2;
	condition	= DIA_Sylvio_Thekla_Condition;
	information	= DIA_Sylvio_Thekla_Info;
	permanent 	= FALSE;
	description	= "Thekla má s tebou problém.";
};

func int DIA_Sylvio_Thekla_Condition ()
{
	if (Npc_KnowsInfo (other, DIA_Thekla_Problem))
	{
		return TRUE;
	};
};

func void DIA_Sylvio_Thekla_Info ()
{
	AI_Output (other, self, "DIA_Sylvio_Thekla_15_00"); //Thekla má s tebou problém.
	AI_Output (self, other, "DIA_Sylvio_Thekla_09_01"); //Skutečnę? A jakej má ta drahá paní problém? A proč nepâišla sama?
	AI_Output (other, self, "DIA_Sylvio_Thekla_15_02"); //To pâece rozhodnę víš...
	AI_Output (self, other, "DIA_Sylvio_Thekla_09_03"); //(cynicky pâátelsky) Proč si nejdeš hned promluvit s mým pâítelem Bullcem?

	Sylvio_angequatscht = Sylvio_angequatscht + 1;
	AI_StopProcessInfos (self);
};

// ************************************************************
// 			  				   Gossip 
// ************************************************************
instance DIA_Sylvio_Gossip		(C_INFO)
{
	npc			= SLD_806_Sylvio;
	nr		 	= 3;
	condition	= DIA_Sylvio_Gossip_Condition;
	information	= DIA_Sylvio_Gossip_Info;
	permanent	= FALSE;
	description	= "Hodnę lidí o tobę mluví.";
};

func int DIA_Sylvio_Gossip_Condition ()
{
	return TRUE;
};

func void DIA_Sylvio_Gossip_Info ()
{
	AI_Output (other, self, "DIA_Sylvio_Gossip_15_00"); //Hodnę lidí o tobę mluví.
	AI_Output (self, other, "DIA_Sylvio_Gossip_09_01"); //Hodnę lidí mluví víc, než je zdrávo.
	
	Sylvio_angequatscht = Sylvio_angequatscht + 1;
	AI_StopProcessInfos (self);
};
	
// ************************************************************
// 			  				   Gossip 
// ************************************************************
instance DIA_Sylvio_AboutLee (C_INFO)
{
	npc			= SLD_806_Sylvio;
	nr		 	= 4;
	condition	= DIA_Sylvio_AboutLee_Condition;
	information	= DIA_Sylvio_AboutLee_Info;
	permanent	= FALSE;
	description	= "Co si myslíš o Leeovi?";
};

func int DIA_Sylvio_AboutLee_Condition ()
{
	return TRUE;
};

func void DIA_Sylvio_AboutLee_Info ()
{
	AI_Output (other, self, "DIA_Sylvio_AboutLee_15_00"); //Co si myslíš o Leeovi?
	AI_Output (self, other, "DIA_Sylvio_AboutLee_09_01"); //(trochu ironicky) Jo, je to dobrý bojovník. Nikdy bych s ním nechtęl bojovat.
	AI_Output (self, other, "DIA_Sylvio_AboutLee_09_02"); //(chladnę) Samozâejmę pokud by nebylo vyhnutí.
	
	Sylvio_angequatscht = Sylvio_angequatscht + 1;
	AI_StopProcessInfos (self);
};
	

// ************************************************************
// 			  				  MenDefeated
// ************************************************************
instance DIA_Sylvio_MenDefeated (C_INFO)
{
	npc			= SLD_806_Sylvio;
	nr		 	= 5;
	condition	= DIA_Sylvio_MenDefeated_Condition;
	information	= DIA_Sylvio_MenDefeated_Info;
	permanent	= FALSE;
	important	= TRUE;
};

func int DIA_Sylvio_MenDefeated_Condition ()
{
	var int victories;
	victories = 0;
	if (Rod.aivar[AIV_DefeatedByPlayer] == TRUE)		{	victories = victories + 1;	};
	if (Sentenza.aivar[AIV_DefeatedByPlayer] == TRUE)	{	victories = victories + 1;	};
	if (Fester.aivar[AIV_DefeatedByPlayer] == TRUE)		{	victories = victories + 1;	};
	if (Raoul.aivar[AIV_DefeatedByPlayer] == TRUE)		{	victories = victories + 1;	};
	if (Bullco.aivar[AIV_DefeatedByPlayer] == TRUE)		{	victories = victories + 1;	};
	if (MIS_Jarvis_SldKO != FALSE)
	&& (victories >= 2) 
	{
		return TRUE;
	};
};

func void DIA_Sylvio_MenDefeated_Info ()
{
	AI_Output (self, other, "DIA_Sylvio_MenDefeated_09_00"); //Všiml jsem si, že máš spadeno na mé hochy!
	AI_Output (self, other, "DIA_Sylvio_MenDefeated_09_01"); //A pokud vím, jsi jedním z Leeových chránęnců.
	AI_Output (self, other, "DIA_Sylvio_MenDefeated_09_02"); //Varuju tę! Pár vęcí se tady v brzké dobę zmęní a pak si o tom promluvíme!
	
	Sylvio_MenDefeated = TRUE;
	
	AI_StopProcessInfos (self);
};

// ************************************************************
// 			  				 Asshole
// ************************************************************
instance DIA_Sylvio_Asshole (C_INFO)
{
	npc			= SLD_806_Sylvio;
	nr		 	= 2;
	condition	= DIA_Sylvio_Asshole_Condition;
	information	= DIA_Sylvio_Asshole_Info;
	permanent	= FALSE;
	description	= "Hej, sráči...";
};

func int DIA_Sylvio_Asshole_Condition ()
{
	if (Sylvio_angequatscht >= 1)
	{
		return TRUE;
	};
};

func void DIA_Sylvio_Asshole_Info ()
{
	AI_Output (other, self, "DIA_Sylvio_Asshole_15_00"); //Hej, sráči...
	AI_Output (self, other, "DIA_Sylvio_Asshole_09_01"); //Nemyslíš si snad, že bych se nechal pâemluvit do souboje s tebou?
	AI_Output (self, other, "DIA_Sylvio_Asshole_09_02"); //Bęž se radši odplazit pod svůj kamínek.
	
	Sylvio_angequatscht = Sylvio_angequatscht + 1;
	
	AI_StopProcessInfos (self);
};



// ************************************************************
// 			  				PICK POCKET
// ************************************************************

INSTANCE DIA_SylvioSLD_PICKPOCKET (C_INFO)
{
	npc			= SLD_806_Sylvio;
	nr			= 900;
	condition	= DIA_SylvioSLD_PICKPOCKET_Condition;
	information	= DIA_SylvioSLD_PICKPOCKET_Info;
	permanent	= TRUE;
	description = Pickpocket_80;
};                       

FUNC INT DIA_SylvioSLD_PICKPOCKET_Condition()
{
	C_Beklauen (80, 210);
};
 
FUNC VOID DIA_SylvioSLD_PICKPOCKET_Info()
{	
	Info_ClearChoices	(DIA_SylvioSLD_PICKPOCKET);
	Info_AddChoice		(DIA_SylvioSLD_PICKPOCKET, DIALOG_BACK 		,DIA_SylvioSLD_PICKPOCKET_BACK);
	Info_AddChoice		(DIA_SylvioSLD_PICKPOCKET, DIALOG_PICKPOCKET	,DIA_SylvioSLD_PICKPOCKET_DoIt);
};

func void DIA_SylvioSLD_PICKPOCKET_DoIt()
{
	B_Beklauen ();
	Info_ClearChoices (DIA_SylvioSLD_PICKPOCKET);
};
	
func void DIA_SylvioSLD_PICKPOCKET_BACK()
{
	Info_ClearChoices (DIA_SylvioSLD_PICKPOCKET);
};

















