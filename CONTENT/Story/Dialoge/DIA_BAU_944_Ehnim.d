///////////////////////////////////////////////////////////////////////
// Info EXIT
///////////////////////////////////////////////////////////////////////
INSTANCE DIA_Ehnim_EXIT   (C_INFO)
{
 npc         = BAU_944_Ehnim;
 nr          = 999;
 condition   = DIA_Ehnim_EXIT_Condition;
 information = DIA_Ehnim_EXIT_Info;
 permanent   = TRUE;
 description = DIALOG_ENDE;
};

FUNC INT DIA_Ehnim_EXIT_Condition()
{
 return TRUE;
};

FUNC VOID DIA_Ehnim_EXIT_Info()
{
 AI_StopProcessInfos (self);
};

///////////////////////////////////////////////////////////////////////
// Info Hallo
///////////////////////////////////////////////////////////////////////
instance DIA_Ehnim_HALLO  (C_INFO)
{
 npc   =  BAU_944_Ehnim;
 nr   =  3;
 condition  =  DIA_Ehnim_HALLO_Condition;
 information  =  DIA_Ehnim_HALLO_Info;

 description  =  "Kdo jsi?";
};

func int DIA_Ehnim_HALLO_Condition ()
{
 return TRUE;
};

func void DIA_Ehnim_HALLO_Info ()
{
 AI_Output   (other, self, "DIA_Ehnim_HALLO_15_00"); //Kdo jsi?
 AI_Output   (self, other, "DIA_Ehnim_HALLO_12_01"); //Jmenuju se Ehnim. Jsem jedním z námezdních rolníků.

 if (
  (Hlp_IsValidNpc (Egill))
  && (!C_NpcIsDown (Egill))
  )
   {
    AI_Output   (self, other, "DIA_Ehnim_HALLO_12_02"); //A támhleten prcek je můj bratr Egill.
   };
 AI_Output   (self, other, "DIA_Ehnim_HALLO_12_03"); //Už tady na farmę pracuju pro Akila nękolik let.

};


///////////////////////////////////////////////////////////////////////
// Info Feldarbeit
///////////////////////////////////////////////////////////////////////
instance DIA_Ehnim_FELDARBEIT  (C_INFO)
{
 npc   =  BAU_944_Ehnim;
 nr   =  4;
 condition  =  DIA_Ehnim_FELDARBEIT_Condition;
 information  =  DIA_Ehnim_FELDARBEIT_Info;

 description  =  "Jak jdou polní práce?";
};

func int DIA_Ehnim_FELDARBEIT_Condition ()
{
 if (Npc_KnowsInfo(other, DIA_Ehnim_HALLO))
  {
    return TRUE;
  };
};

func void DIA_Ehnim_FELDARBEIT_Info ()
{
 AI_Output   (other, self, "DIA_Ehnim_FELDARBEIT_15_00"); //Jak jdou polní práce?
 AI_Output   (self, other, "DIA_Ehnim_FELDARBEIT_12_01"); //Chceš pomoct? Támhle je další motyka. Vezmi si ji a vyraz na pole.
 AI_Output   (self, other, "DIA_Ehnim_FELDARBEIT_12_02"); //Męl by ses jen mít na pozoru pâed polními škůdci. Utrhnou ti ruku, ani nemrkneš.

};

///////////////////////////////////////////////////////////////////////
// Info feldraeuber
///////////////////////////////////////////////////////////////////////
instance DIA_Ehnim_FELDRAEUBER  (C_INFO)
{
 npc   =  BAU_944_Ehnim;
 nr   =  5;
 condition  =  DIA_Ehnim_FELDRAEUBER_Condition;
 information  =  DIA_Ehnim_FELDRAEUBER_Info;

 description  =  "Proč s tęmi škůdci nęco neudęláte?";
};

func int DIA_Ehnim_FELDRAEUBER_Condition ()
{
 if (Npc_KnowsInfo(other, DIA_Ehnim_FELDARBEIT))
  {
    return TRUE;
  };
};

func void DIA_Ehnim_FELDRAEUBER_Info ()
{
 AI_Output   (other, self, "DIA_Ehnim_FELDRAEUBER_15_00"); //Proč s tęmi škůdci nęco neudęláte?
 AI_Output   (self, other, "DIA_Ehnim_FELDRAEUBER_12_01"); //Zabil už jsem jich víc, než dokážu spočítat. Jedinej problém je, že zase pâijdou další.

};

///////////////////////////////////////////////////////////////////////
// Info Streit1
///////////////////////////////////////////////////////////////////////
instance DIA_Ehnim_STREIT1  (C_INFO)
{
 npc   =  BAU_944_Ehnim;
 nr   =  6;
 condition  =  DIA_Ehnim_STREIT1_Condition;
 information  =  DIA_Ehnim_STREIT1_Info;

 description  =  "Tvůj bratr mi âíkal to samé.";
};

func int DIA_Ehnim_STREIT1_Condition ()
{
 if  (
   (
   (Npc_KnowsInfo(other, DIA_Egill_FELDRAEUBER))
   && (Npc_KnowsInfo(other, DIA_Ehnim_FELDRAEUBER))
   && ((Npc_KnowsInfo(other, DIA_Egill_STREIT2))== FALSE)
   )
  &&
   (
   (Hlp_IsValidNpc (Egill))
   && (!C_NpcIsDown (Egill))
   )
  )
    {
     return TRUE;
    };

};

func void DIA_Ehnim_STREIT1_Info ()
{
 AI_Output   (other, self, "DIA_Ehnim_STREIT1_15_00"); //Tvůj bratr mi âíkal to samé.
 AI_Output   (self, other, "DIA_Ehnim_STREIT1_12_01"); //Co? Ten sralbotka? Vždycky se vytratí hned, jak se ty bestie objeví na našem pozemku.
 AI_Output   (self, other, "DIA_Ehnim_STREIT1_12_02"); //Nemęl by âíkat takový nesmysly.
};

///////////////////////////////////////////////////////////////////////
// Info Streit3
///////////////////////////////////////////////////////////////////////
instance DIA_Ehnim_STREIT3  (C_INFO)
{
 npc   =  BAU_944_Ehnim;
 nr   =  7;
 condition  =  DIA_Ehnim_STREIT3_Condition;
 information  =  DIA_Ehnim_STREIT3_Info;

 description  =  "Tvůj bratr si myslí, že se akorát vytahuješ.";
};

func int DIA_Ehnim_STREIT3_Condition ()
{
 if  (
   (Npc_KnowsInfo(other, DIA_Egill_STREIT2))
  &&
   (
   (Hlp_IsValidNpc (Egill))
   && (!C_NpcIsDown (Egill))
   )
  )
   {
     return TRUE;
   };
};

func void DIA_Ehnim_STREIT3_Info ()
{
 AI_Output   (other, self, "DIA_Ehnim_STREIT3_15_00"); //Tvůj bratr si myslí, že se akorát vytahuješ.
 AI_Output   (self, other, "DIA_Ehnim_STREIT3_12_01"); //Co? To má vážnę odvahu tohle âíct?
 AI_Output   (self, other, "DIA_Ehnim_STREIT3_12_02"); //Radęj by si męl dávat pozor, než mu uštędâím poâádnou lekci.
 AI_Output   (self, other, "DIA_Ehnim_STREIT3_12_03"); //Tak mu to bęž âíct.
 AI_StopProcessInfos (self);
};

///////////////////////////////////////////////////////////////////////
// Info Streit5
///////////////////////////////////////////////////////////////////////
instance DIA_Ehnim_STREIT5  (C_INFO)
{
 npc   =  BAU_944_Ehnim;
 nr   =  8;
 condition  =  DIA_Ehnim_STREIT5_Condition;
 information  =  DIA_Ehnim_STREIT5_Info;
 permanent  =  TRUE;

 description  =  "Mám dojem, že byste se męli oba trochu zklidnit.";
};

var int DIA_Ehnim_STREIT5_noPerm;

func int DIA_Ehnim_STREIT5_Condition ()
{
 if  (
   (Npc_KnowsInfo(other, DIA_Egill_STREIT4))
  &&
   (
   (Hlp_IsValidNpc (Egill))
   && (!C_NpcIsDown (Egill))
   )
  && (DIA_Ehnim_STREIT5_noPerm == FALSE)
  )
    {
      return TRUE;
    };
};

func void DIA_Ehnim_STREIT5_Info ()
{
 AI_Output   (other, self, "DIA_Ehnim_STREIT5_15_00"); //Mám dojem, že byste se męli oba trochu zklidnit.
 AI_Output   (self, other, "DIA_Ehnim_STREIT5_12_01"); //Ten bastard to ještę nevzdal, co?
 AI_Output   (self, other, "DIA_Ehnim_STREIT5_12_02"); //Já ho roztrhnu. Âekni mu to.

 Info_ClearChoices (DIA_Ehnim_STREIT5);

 Info_AddChoice (DIA_Ehnim_STREIT5, "Dęlej si, co chceš. Odcházím.", DIA_Ehnim_STREIT5_gehen );
 Info_AddChoice (DIA_Ehnim_STREIT5, "Proč mu to neâekneš sám?", DIA_Ehnim_STREIT5_Attack );


};
func void DIA_Ehnim_STREIT5_Attack ()
{
 AI_Output   (other, self, "DIA_Ehnim_STREIT5_Attack_15_00"); //Proč mu to neâekneš sám?
 AI_Output   (self, other, "DIA_Ehnim_STREIT5_Attack_12_01"); //To pâesnę udęlám.

 AI_StopProcessInfos (self);

 DIA_Ehnim_STREIT5_noPerm = TRUE;
 other.aivar[AIV_INVINCIBLE] = FALSE;
 B_Attack (self, Egill, AR_NONE, 0);

 B_GivePlayerXP (XP_EgillEhnimStreit);

};

func void DIA_Ehnim_STREIT5_gehen ()
{
 AI_Output   (other, self, "DIA_Ehnim_STREIT5_gehen_15_00"); //Dęlej si, co chceš. Odcházím.
 AI_Output   (self ,other, "DIA_Ehnim_STREIT5_gehen_12_01"); //Jo, jen se rychle ztraă.

 AI_StopProcessInfos (self);
};


///////////////////////////////////////////////////////////////////////
// Info permKap1
///////////////////////////////////////////////////////////////////////
instance DIA_Ehnim_PERMKAP1  (C_INFO)
{
 npc   =  BAU_944_Ehnim;
 condition  =  DIA_Ehnim_PERMKAP1_Condition;
 information  =  DIA_Ehnim_PERMKAP1_Info;
 important  =  TRUE;
 permanent  = TRUE;
};

func int DIA_Ehnim_PERMKAP1_Condition ()
{
 if  (
  (DIA_Ehnim_STREIT5_noPerm == TRUE)
  && (Npc_IsInState (self,ZS_Talk))
  && ((Kapitel < 3) || (hero.guild == GIL_KDF))
  )
   {
     return TRUE;
   };
};

func void DIA_Ehnim_PERMKAP1_Info ()
{
 AI_Output   (self, other, "DIA_Ehnim_PERMKAP1_12_00"); //Chceš dęlat další problémy? Mám dojem, že bude lepší, když se hned ztratíš.

 AI_StopProcessInfos (self);
};

///////////////////////////////////////////////////////////////////////
// Info MoleRatFett
///////////////////////////////////////////////////////////////////////
instance DIA_Ehnim_MoleRatFett  (C_INFO)
{
 npc   =  BAU_944_Ehnim;
 condition  =  DIA_Ehnim_MoleRatFett_Condition;
 information  =  DIA_Ehnim_MoleRatFett_Info;
 important  =  TRUE;
};

func int DIA_Ehnim_MoleRatFett_Condition ()
{
 if  (
  (DIA_Ehnim_STREIT5_noPerm == TRUE)
  && (Kapitel >= 3)
  && (hero.guild != GIL_KDF)
  )
   {
     return TRUE;
   };
};

func void DIA_Ehnim_MoleRatFett_Info ()
{
 AI_Output   (self, other, "DIA_Ehnim_MoleRatFett_12_00"); //Ty jsi tu JEŠTĘ.
 AI_Output   (other, self, "DIA_Ehnim_MoleRatFett_15_01"); //Vypadá to tak. Poâád vytočenej?
 AI_Output   (self, other, "DIA_Ehnim_MoleRatFett_12_02"); //Nic se nedęje, zapomeŕ na to. Âekni, byl jsi poslední dobou na Lobartovę farmę?
 AI_Output   (other, self, "DIA_Ehnim_MoleRatFett_15_03"); //Možná. Proč?
 AI_Output   (self, other, "DIA_Ehnim_MoleRatFett_12_04"); //Ó, nic důležitýho. Jen jsem chtęl mluvit s Vinem o jeho palírnę.

 Info_ClearChoices (DIA_Ehnim_MoleRatFett);
 Info_AddChoice (DIA_Ehnim_MoleRatFett, "Právę teë nemám čas.", DIA_Ehnim_MoleRatFett_nein );
 Info_AddChoice (DIA_Ehnim_MoleRatFett, "Palírna? Jaká palírna?", DIA_Ehnim_MoleRatFett_was );

 if (Npc_IsDead(Vino))
 {
  Info_AddChoice (DIA_Ehnim_MoleRatFett, "Vino je mrtvý.", DIA_Ehnim_MoleRatFett_tot );
 };

};
func void DIA_Ehnim_MoleRatFett_tot ()
{
 AI_Output   (other, self, "DIA_Ehnim_MoleRatFett_tot_15_00"); //Vino je mrtvý.
 AI_Output   (self, other, "DIA_Ehnim_MoleRatFett_tot_12_01"); //Proboha. No nic. Tak to se nedá nic dęlat.

};

func void DIA_Ehnim_MoleRatFett_was ()
{
 AI_Output   (other, self, "DIA_Ehnim_MoleRatFett_was_15_00"); //Palírna? Jaká palírna?
 AI_Output   (self, other, "DIA_Ehnim_MoleRatFett_was_12_01"); //Ó. Asi jsem to nemęl âíkat. Vino byl na to své malé tajemství vždycky hodnę citlivý.
 AI_Output   (self, other, "DIA_Ehnim_MoleRatFett_was_12_02"); //Ale teë jsem si to nechal vyklouznout. Tam vzadu v lese si Vino zaâídil tajnou palírnu.
 AI_Output   (self, other, "DIA_Ehnim_MoleRatFett_was_12_03"); //Nedávno mę žádal o nęco, čím by mohl promazat padací mâíž.
 AI_Output   (self, other, "DIA_Ehnim_MoleRatFett_was_12_04"); //V poslední dobę hodnę pršelo a začala ho zlobit rez. Teë je naviják zaseknutý a nikdo už se tam nedostane. To jsme v pękný bryndę.

 Log_CreateTopic (TOPIC_FoundVinosKellerei, LOG_MISSION);
 Log_SetTopicStatus(TOPIC_FoundVinosKellerei, LOG_RUNNING);
 B_LogEntry (TOPIC_FoundVinosKellerei,"Podle Ehnima se Vino stále ukrývá v lesích poblíž Akilova statku. Ale mechanismus dveâí je zadâený a dokud jej nenamažu krysokrtím sádlem, dovnitâ se nedostanu.");

 Info_AddChoice (DIA_Ehnim_MoleRatFett, "A? Máš nęjaký mazivo?", DIA_Ehnim_MoleRatFett_was_Fett );
};
func void DIA_Ehnim_MoleRatFett_was_Fett ()
{
 AI_Output   (other, self, "DIA_Ehnim_MoleRatFett_was_Fett_15_00"); //A? Máš nęjaký mazivo?
 AI_Output   (self, other, "DIA_Ehnim_MoleRatFett_was_Fett_12_01"); //Jo, jasnę. Nejlepší, co se tu dá sehnat. Krysokrtí sádlo. Pâíšerná vęc, to ti povím. Taky se používá na promazání lodních dęl.

 Info_AddChoice (DIA_Ehnim_MoleRatFett, "Prodej mi ten tuk.", DIA_Ehnim_MoleRatFett_was_Fett_habenwill );

};
var int Ehnim_MoleRatFettOffer;
func void DIA_Ehnim_MoleRatFett_was_Fett_habenwill ()
{
 AI_Output   (other, self, "DIA_Ehnim_MoleRatFett_was_Fett_habenwill_15_00"); //Prodej mi ten tuk.
 AI_Output   (self, other, "DIA_Ehnim_MoleRatFett_was_Fett_habenwill_12_01"); //To nebude levný, kámo. V tomhle kraji to je zatracenę vzácná vęc.
 AI_Output   (other, self, "DIA_Ehnim_MoleRatFett_was_Fett_habenwill_15_02"); //Kolik?
 AI_Output   (self, other, "DIA_Ehnim_MoleRatFett_was_Fett_habenwill_12_03"); //Mmh. 100 zlatých?
 Ehnim_MoleRatFettOffer = 100;

 Info_ClearChoices (DIA_Ehnim_MoleRatFett);
 Info_AddChoice (DIA_Ehnim_MoleRatFett, "To je pâíliš.", DIA_Ehnim_MoleRatFett_was_Fett_habenwill_zuviel );
 Info_AddChoice (DIA_Ehnim_MoleRatFett, "Dohodnuto.", DIA_Ehnim_MoleRatFett_was_Fett_habenwill_ja );

};
func void DIA_Ehnim_MoleRatFett_was_Fett_habenwill_ja ()
{
 AI_Output   (other, self, "DIA_Ehnim_MoleRatFett_was_Fett_habenwill_ja_15_00"); //Dohodnuto.

 if (B_GiveInvItems (other, self, ItMi_Gold,Ehnim_MoleRatFettOffer))
  {
   AI_Output   (self, other, "DIA_Ehnim_MoleRatFett_was_Fett_habenwill_ja_12_01"); //Dobrá. Tady to máš.

   if (Npc_HasItems (self,ItMi_Moleratlubric_MIS))
   {
    B_GiveInvItems (self, other, ItMi_Moleratlubric_MIS, 1);

    if (Npc_IsDead(Vino) == FALSE)
     {
      AI_Output   (self, other, "DIA_Ehnim_MoleRatFett_was_Fett_habenwill_ja_12_02"); //(pro sebe) Zatracenę. Vino mę zabije.
     };
   }
   else
   {
    AI_Output   (self, other, "DIA_Ehnim_MoleRatFett_was_Fett_habenwill_ja_12_03"); //Sakra, kam jsme se to dostali? To je zatracenę mrzutá vęc. Tak fajn, promiŕ. Jak se zdá, už to nemám. Vem si svý prachy zpátky.
    B_GiveInvItems (self, other, ItMi_Gold,Ehnim_MoleRatFettOffer);

    if (Npc_IsDead(Egill) == FALSE)
     {
      AI_Output   (self, other, "DIA_Ehnim_MoleRatFett_was_Fett_habenwill_ja_12_04"); //Vsadím se, že to můj brácha udęlá znovu. Ten bastard
      AI_StopProcessInfos (self);
      other.aivar[AIV_INVINCIBLE] = FALSE;
      B_Attack (self, Egill, AR_NONE, 0);
     };
   };
  }
 else
  {
   AI_Output   (self, other, "DIA_Ehnim_MoleRatFett_was_Fett_habenwill_ja_12_05"); //No to je bezvadný. Nejdâív chceš udęlat velkej kšeft a pak nemáš dost prachů. Ztraă se.
  };
 AI_StopProcessInfos (self);
};

func void DIA_Ehnim_MoleRatFett_was_Fett_habenwill_zuviel ()
{
 AI_Output   (other, self, "DIA_Ehnim_MoleRatFett_was_Fett_habenwill_zuviel_15_00"); //To je pâíliš.
 AI_Output   (self, other, "DIA_Ehnim_MoleRatFett_was_Fett_habenwill_zuviel_12_01"); //Fajn, fajn. Tak teda 70 zlatých. Ale to je moje poslední nabídka.
 Ehnim_MoleRatFettOffer = 70;

 Info_ClearChoices (DIA_Ehnim_MoleRatFett);
 Info_AddChoice (DIA_Ehnim_MoleRatFett, "To je ještę poâád moc.", DIA_Ehnim_MoleRatFett_was_Fett_habenwill_zuviel_immernoch );
 Info_AddChoice (DIA_Ehnim_MoleRatFett, "Dohodnuto.", DIA_Ehnim_MoleRatFett_was_Fett_habenwill_ja );

};
func void DIA_Ehnim_MoleRatFett_was_Fett_habenwill_zuviel_immernoch ()
{
 AI_Output   (other, self, "DIA_Ehnim_MoleRatFett_was_immernoch_15_00"); //To je ještę poâád moc.
 AI_Output   (self, other, "DIA_Ehnim_MoleRatFett_was_immernoch_12_01"); //(naštvanę) Tak si trhni. Męj se.
 AI_StopProcessInfos (self);
};

func void DIA_Ehnim_MoleRatFett_nein ()
{
 AI_Output   (other, self, "DIA_Ehnim_MoleRatFett_nein_15_00"); //Právę teë nemám čas.
 AI_Output   (self, other, "DIA_Ehnim_MoleRatFett_nein_12_01"); //Nenech se zdržovat, chlape.
 AI_StopProcessInfos (self);
};


///////////////////////////////////////////////////////////////////////
// Info permKap3
///////////////////////////////////////////////////////////////////////
instance DIA_Ehnim_PERMKAP3  (C_INFO)
{
 npc   =  BAU_944_Ehnim;
 condition  =  DIA_Ehnim_PERMKAP3_Condition;
 information  =  DIA_Ehnim_PERMKAP3_Info;
 important  =  TRUE;
 permanent  = TRUE;
};

func int DIA_Ehnim_PERMKAP3_Condition ()
{
 if  (
  (Npc_KnowsInfo(other, DIA_Ehnim_MoleRatFett))
  && (Npc_IsInState (self,ZS_Talk))
  )
   {
     return TRUE;
   };
};

func void DIA_Ehnim_PERMKAP3_Info ()
{
 AI_Output   (self, other, "DIA_Ehnim_PERMKAP3_12_00"); //Teë nemám čas.
 AI_StopProcessInfos (self);
};


// ************************************************************
//          PICK POCKET
// ************************************************************

INSTANCE DIA_Ehnim_PICKPOCKET (C_INFO)
{
 npc   = BAU_944_Ehnim;
 nr   = 900;
 condition = DIA_Ehnim_PICKPOCKET_Condition;
 information = DIA_Ehnim_PICKPOCKET_Info;
 permanent = TRUE;
 description = Pickpocket_80;
};

FUNC INT DIA_Ehnim_PICKPOCKET_Condition()
{
 C_Beklauen (76, 35);
};

FUNC VOID DIA_Ehnim_PICKPOCKET_Info()
{
 Info_ClearChoices (DIA_Ehnim_PICKPOCKET);
 Info_AddChoice  (DIA_Ehnim_PICKPOCKET, DIALOG_BACK   ,DIA_Ehnim_PICKPOCKET_BACK);
 Info_AddChoice  (DIA_Ehnim_PICKPOCKET, DIALOG_PICKPOCKET ,DIA_Ehnim_PICKPOCKET_DoIt);
};

func void DIA_Ehnim_PICKPOCKET_DoIt()
{
 B_Beklauen ();
 Info_ClearChoices (DIA_Ehnim_PICKPOCKET);
};

func void DIA_Ehnim_PICKPOCKET_BACK()
{
 Info_ClearChoices (DIA_Ehnim_PICKPOCKET);
};























