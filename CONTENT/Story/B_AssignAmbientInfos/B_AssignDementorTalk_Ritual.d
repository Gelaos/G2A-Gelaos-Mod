// ***************************************************
//  	B_AssignDementorTalk_Ritual	
// ***************************************************

func void B_AssignDementorTalk_Ritual ()
{	
	Wld_PlayEffect("DEMENTOR_FX",  hero, hero, 0, 0, 0, FALSE );
	Wld_PlayEffect("spellFX_Fear",  self, self, 0, 0, 0, FALSE );
	AI_PlayAni (self,"T_PRACTICEMAGIC5");	

	if (MIS_SCKnowsInnosEyeIsBroken == FALSE)
	
	{
		AI_Output			(self ,other, "DIA_RitualDementor_19_00"); //Pâišel jsi pâíliš pozdę.
		AI_Output			(self ,other, "DIA_RitualDementor_19_01"); //Zničili jsme Innosovo oko, takže už nemůže nikdy znovu nabýt svou moc.
		AI_Output			(self ,other, "DIA_RitualDementor_19_02"); //Teë ti ukážeme pošetilost tvých snah postavit se Pánu.

		MIS_SCKnowsInnosEyeIsBroken  = TRUE;
		B_LogEntry (TOPIC_INNOSEYE, "Ti hrozní chlapi mi pęknę hrají na nervy - zničili Innosovo oko a já teë netuším, jak je spravit.");
 		B_LogEntry (TOPIC_TraitorPedro, "Našel jsem Innosovo oko, ale po Pedrovi nebylo nikde ani vidu, ani slechu. Dal se do spolku s tęmi černými mágy.");
		B_GivePlayerXP (XP_SCKnowsInnosEyeIsBroken);
	}
	else
	{
		var int randy;
		randy = Hlp_Random (4);
		
	 	if (randy == 0)
		{
			AI_Output			(self ,other, "DIA_RitualDementor_19_03"); //Teë pocítíš naši moc.
		};
		if (randy == 1)
		{
			AI_Output			(self ,other, "DIA_RitualDementor_19_04"); //Za Pána.
		};
		if (randy == 2)
		{
			AI_Output			(self ,other, "DIA_RitualDementor_19_05"); //Nemůžeš se skrýt.
		};
		if (randy == 3)
		{
			AI_Output			(self ,other, "DIA_RitualDementor_19_06"); //Zabijeme tę.
		};
	};
	Npc_SetRefuseTalk (self,30);
};
func void B_AssignDementorTalk_Ritual_Exit ()
{	
	Wld_StopEffect("DEMENTOR_FX");
	B_SCIsObsessed (self);
	AI_StopProcessInfos (self);
	B_Attack (self, other, AR_SuddenEnemyInferno, 1);
	Snd_Play 	("MFX_FEAR_CAST" );
	self.aivar[AIV_EnemyOverride] = FALSE;
	/*
	DMT_1201.aivar[AIV_EnemyOverride] = FALSE;
	DMT_1202.aivar[AIV_EnemyOverride] = FALSE;
	DMT_1203.aivar[AIV_EnemyOverride] = FALSE;
	DMT_1204.aivar[AIV_EnemyOverride] = FALSE;
	DMT_1205.aivar[AIV_EnemyOverride] = FALSE;
	DMT_1206.aivar[AIV_EnemyOverride] = FALSE;
	DMT_1207.aivar[AIV_EnemyOverride] = FALSE;
	DMT_1208.aivar[AIV_EnemyOverride] = FALSE;
	DMT_1209.aivar[AIV_EnemyOverride] = FALSE;
	DMT_1210.aivar[AIV_EnemyOverride] = FALSE;
	DMT_1211.aivar[AIV_EnemyOverride] = FALSE;
	*/
};
