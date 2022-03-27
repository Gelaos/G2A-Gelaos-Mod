///////////////////////////////////////////////////////////////////////
//	Info EXIT 
///////////////////////////////////////////////////////////////////////
INSTANCE DIA_PAL_270_EXIT   (C_INFO)
{
	npc         = PAL_270_Ritter;
	nr          = 999;
	condition   = DIA_PAL_270_EXIT_Condition;
	information = DIA_PAL_270_EXIT_Info;
	permanent   = TRUE;
	description = DIALOG_ENDE;
};

FUNC INT DIA_PAL_270_EXIT_Condition()
{
	return TRUE;
};

FUNC VOID DIA_PAL_270_EXIT_Info()
{
	AI_StopProcessInfos (self);
};
///////////////////////////////////////////////////////////////////////
//	Info OUT
///////////////////////////////////////////////////////////////////////
instance DIA_Ritter_OUT		(C_INFO)
{
	npc			 = 	PAL_270_Ritter;
	condition	 = 	DIA_Ritter_OUT_Condition;
	information	 = 	DIA_Ritter_OUT_Info;
	important	 = 	TRUE;
	permanent	 = 	TRUE;
};
var int DIA_Ritter_OUT_NoPerm;
func int DIA_Ritter_OUT_Condition ()
{	
	if Npc_IsInState (self, ZS_Talk)
	{
		return TRUE;
	};
};
func void DIA_Ritter_OUT_Info ()
{
	if (DIA_Ritter_OUT_NoPerm == FALSE)
	{
		AI_Output			(self, other, "DIA_Ritter_OUT_06_00"); //Pâišel jsi z Khorinisu, že? Až bude po všem, vrátím se tam.
		DIA_Ritter_OUT_NoPerm = TRUE;
	};
	
	if (hero.guild == GIL_KDF)
		{
			AI_Output			(self, other, "DIA_Ritter_OUT_06_01"); //Je to obrovská úleva, sire, že tę máme po boku.
		}
		else
		{
			AI_Output			(self, other, "DIA_Ritter_OUT_06_02"); //Zvládneme to. Dopravíme rudu do Khorinisu a budou nás oslavovat!
		};
};


 



