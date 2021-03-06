///////////////////////////////////////////////////////////////////////
// Info EXIT
///////////////////////////////////////////////////////////////////////
INSTANCE DIA_Rosi_EXIT   (C_INFO)
{
 npc         = BAU_936_Rosi;
 nr          = 999;
 condition   = DIA_Rosi_EXIT_Condition;
 information = DIA_Rosi_EXIT_Info;
 permanent   = TRUE;
 description = DIALOG_ENDE;
};

FUNC INT DIA_Rosi_EXIT_Condition()
{
 if (Kapitel < 3)
  {
    return TRUE;
  };
};

FUNC VOID DIA_Rosi_EXIT_Info()
{
 AI_StopProcessInfos (self);
};

///////////////////////////////////////////////////////////////////////
// Info Hallo
///////////////////////////////////////////////////////////////////////
instance DIA_Rosi_HALLO  (C_INFO)
{
 npc   =  BAU_936_Rosi;
 nr   =  3;
 condition  =  DIA_Rosi_HALLO_Condition;
 information  =  DIA_Rosi_HALLO_Info;

 description  =  "Jsi v poâádku?";
};

func int DIA_Rosi_HALLO_Condition ()
{
 return TRUE;
};

func void DIA_Rosi_HALLO_Info ()
{
 AI_Output   (other, self, "DIA_Rosi_HALLO_15_00"); //Jsi v poâádku?
 AI_Output   (self, other, "DIA_Rosi_HALLO_17_01"); //Dobrá, je to tak, tak. Bolí mę záda ze vší té tvrdé dâiny. Co tady dęláš? Návštęvníky tu nemáme pâíliš často.

 if ((hero.guild != GIL_MIL))
 {
  AI_Output   (self, other, "DIA_Rosi_HALLO_17_02"); //Když už, tak ty hrdloâezy z hor nebo vojáky z męstské domobrany.
  AI_Output   (self, other, "DIA_Rosi_HALLO_17_03"); //Poslední dobou rabujou naší farmu čím dál tím častęji. Ale ty nevypadáš jako jeden z nich, nebo se pletu?
 };
};


///////////////////////////////////////////////////////////////////////
// Info wasmachstdu
///////////////////////////////////////////////////////////////////////
instance DIA_Rosi_WASMACHSTDU  (C_INFO)
{
 npc   =  BAU_936_Rosi;
 nr   =  4;
 condition  =  DIA_Rosi_WASMACHSTDU_Condition;
 information  =  DIA_Rosi_WASMACHSTDU_Info;

 description  =  "Co tady dęláš?";
};

func int DIA_Rosi_WASMACHSTDU_Condition ()
{
 if (Npc_KnowsInfo(other, DIA_Rosi_HALLO))
 && (Kapitel < 5)
  {
    return TRUE;
  };
};

func void DIA_Rosi_WASMACHSTDU_Info ()
{
 AI_Output   (other, self, "DIA_Rosi_WASMACHSTDU_15_00"); //Co tady dęláš?

 if (Npc_IsDead(Sekob)== FALSE)
 {
 AI_Output   (self, other, "DIA_Rosi_WASMACHSTDU_17_01"); //Tak to se ptám sama sebe už nękolik let. Sekob, můj manžel, už se tady pohádal snad s každým.
 AI_Output   (self, other, "DIA_Rosi_WASMACHSTDU_17_02"); //Všude má dluhy. Proto krade zboží z Onarových zásob a prodává je ve męstę.
 AI_Output   (self, other, "DIA_Rosi_WASMACHSTDU_17_03"); //Ale teë už z té své podfukaâiny má celé jmęní.
 AI_Output   (self, other, "DIA_Rosi_WASMACHSTDU_17_04"); //A dâe naše dęlníky, dokud jim nezničí záda. Jeho vlastní lidé mu už neâeknou jinak než otrokáâ.
 AI_Output   (self, other, "DIA_Rosi_WASMACHSTDU_17_05"); //Nejsem vůbec pyšná na to, že se můžu nazývat Sekobovou ženou, to mi vęâ. Občas si pâeju, aby bariéra zůstala stále na svém místę.
 };

 AI_Output   (self, other, "DIA_Rosi_WASMACHSTDU_17_06"); //Rosi prodává na Sekobovę statku různé vęci.
 Log_CreateTopic (Topic_OutTrader,LOG_NOTE);
 B_LogEntry (Topic_OutTrader,"Rosi obchoduje se zbranęmi a dalším užitečným zbožím. Je na Sekobovę farmę.");
};

///////////////////////////////////////////////////////////////////////
// Info WAREZ
///////////////////////////////////////////////////////////////////////
instance DIA_Rosi_WAREZ  (C_INFO)
{
 npc    =  BAU_936_Rosi;
 nr    =  2;
 condition  =  DIA_Rosi_WAREZ_Condition;
 information  =  DIA_Rosi_WAREZ_Info;
 permanent  =  TRUE;
 trade   =  TRUE;
 description  =  "Co mi můžeš nabídnout?";
};

func int DIA_Rosi_WAREZ_Condition ()
{
 if  (
  (Npc_KnowsInfo(other, DIA_Rosi_WASMACHSTDU))
  || ((Kapitel >= 5) && (Npc_KnowsInfo(other, DIA_Rosi_FLEEFROMSEKOB)))
  ||  (Npc_IsDead(Sekob))
  )
  && (MIS_bringRosiBackToSekob != LOG_SUCCESS)
  {
    return TRUE;
  };
};
func void DIA_Rosi_WAREZ_Info ()
{
 B_GiveTradeInv (self);
 AI_Output (other, self, "DIA_Rosi_WAREZ_15_00"); //Co mi můžeš nabídnout?
 AI_Output (self, other, "DIA_Rosi_WAREZ_17_01"); //Co chceš?
};

///////////////////////////////////////////////////////////////////////
// Info barriere
///////////////////////////////////////////////////////////////////////
instance DIA_Rosi_BARRIERE  (C_INFO)
{
 npc   =  BAU_936_Rosi;
 nr   =  6;
 condition  =  DIA_Rosi_BARRIERE_Condition;
 information  =  DIA_Rosi_BARRIERE_Info;

 description  =  "Bariéra?";
};

func int DIA_Rosi_BARRIERE_Condition ()
{
 if (Npc_KnowsInfo(other, DIA_Rosi_WASMACHSTDU))
 && (Npc_IsDead(Sekob)== FALSE)
  {
    return TRUE;
  };
};

func void DIA_Rosi_BARRIERE_Info ()
{
 AI_Output   (other, self, "DIA_Rosi_BARRIERE_15_00"); //Bariéra?
 AI_Output   (self, other, "DIA_Rosi_BARRIERE_17_01"); //Jo, kopule, která uzavírala Hornické údolí.
 AI_Output   (self, other, "DIA_Rosi_BARRIERE_17_02"); //Svrhli tam spoustu lidí, co se dopustili nęjaké nezákonné činnosti. A nękteâí z nich už se nikdy nevrátili zpęt.

};

///////////////////////////////////////////////////////////////////////
// Info DuInBarriere
///////////////////////////////////////////////////////////////////////
instance DIA_Rosi_DuInBarriere  (C_INFO)
{
 npc   =  BAU_936_Rosi;
 nr   =  10;
 condition  =  DIA_Rosi_DuInBarriere_Condition;
 information  =  DIA_Rosi_DuInBarriere_Info;

 description  =  "Byla jsi nękdy za bariérou?";
};

func int DIA_Rosi_DuInBarriere_Condition ()
{
 if (Npc_KnowsInfo(other, DIA_Rosi_BARRIERE))
  {
    return TRUE;
  };
};

func void DIA_Rosi_DuInBarriere_Info ()
{
 AI_Output   (other, self, "DIA_Rosi_DuInBarriere_15_00"); //Byla jsi nękdy za bariérou?
 AI_Output   (self, other, "DIA_Rosi_DuInBarriere_17_01"); //Ne. Jen jsme o ní slyšeli. Bengar, farmáâ z náhorních pastvin, ti o tom určitę poví víc.
 AI_Output   (self, other, "DIA_Rosi_DuInBarriere_17_02"); //Jeho farma není pâíliš daleko od Hornického údolí.

};


///////////////////////////////////////////////////////////////////////
// Info Bengar
///////////////////////////////////////////////////////////////////////
instance DIA_Rosi_BENGAR  (C_INFO)
{
 npc   =  BAU_936_Rosi;
 nr   =  11;
 condition  =  DIA_Rosi_BENGAR_Condition;
 information  =  DIA_Rosi_BENGAR_Info;

 description  =  "Jak se dostanu na Bengarovu farmu?";
};

func int DIA_Rosi_BENGAR_Condition ()
{
 if (Npc_KnowsInfo(other, DIA_Rosi_DuInBarriere))
 && (Npc_IsDead(Balthasar)==FALSE)
  {
    return TRUE;
  };
};

func void DIA_Rosi_BENGAR_Info ()
{
 AI_Output   (other, self, "DIA_Rosi_BENGAR_15_00"); //Jak se dostanu na Bengarovu farmu?
 AI_Output   (self, other, "DIA_Rosi_BENGAR_17_01"); //Bęž se zeptat Balthazara. To je náš ovčák. Občas svoje zvíâata vodí na pastvu nahoru na Bengarovy pozemky.
 AI_Output   (self, other, "DIA_Rosi_BENGAR_17_02"); //Męl by být schopen ti âíct, jak se tam dostat.

};


///////////////////////////////////////////////////////////////////////
// Info
///////////////////////////////////////////////////////////////////////
instance DIA_Rosi_Miliz  (C_INFO)
{
 npc   =  BAU_936_Rosi;
 nr   =  7;
 condition  =  DIA_Rosi_Miliz_Condition;
 information  =  DIA_Rosi_Miliz_Info;

 description  =  "Proč vás domobrana na farmę napadá? ";
};

func int DIA_Rosi_Miliz_Condition ()
{
 if (Npc_KnowsInfo(other, DIA_Rosi_WASMACHSTDU))
 && ((hero.guild != GIL_MIL))
  {
    return TRUE;
  };
};

func void DIA_Rosi_Miliz_Info ()
{
 AI_Output   (other, self, "DIA_Rosi_Miliz_15_00"); //Proč vás domobrana na farmę napadá?
 AI_Output   (self, other, "DIA_Rosi_Miliz_17_01"); //Protože tu není nikdo, kdo by zabránil tomu, že se zboží místo nakoupení jednoduše ukradne.
 AI_Output   (self, other, "DIA_Rosi_Miliz_17_02"); //Král je daleko a nám nezbývá než dâít pro Onara a doufat, že Onar pošle pomoc, když to bude opravdu zapotâebí.
};


///////////////////////////////////////////////////////////////////////
// Info Onar
///////////////////////////////////////////////////////////////////////
instance DIA_Rosi_ONAR  (C_INFO)
{
 npc   =  BAU_936_Rosi;
 nr   =  8;
 condition  =  DIA_Rosi_ONAR_Condition;
 information  =  DIA_Rosi_ONAR_Info;

 description  =  "V čem ta Onarova pomoc spočívá?";
};

func int DIA_Rosi_ONAR_Condition ()
{
 if (Npc_KnowsInfo(other, DIA_Rosi_Miliz))
  {
    return TRUE;
  };
};

func void DIA_Rosi_ONAR_Info ()
{
 AI_Output   (other, self, "DIA_Rosi_ONAR_15_00"); //V čem ta Onarova pomoc spočívá?
 AI_Output   (self, other, "DIA_Rosi_ONAR_17_01"); //Občas se k nám dostane varování, že se k nám chystá pár vojáků z domobrany, aby se nás pokusili okrást na vlastní pęst.
 AI_Output   (self, other, "DIA_Rosi_ONAR_17_02"); //Pak pošleme k velkostatkáâi nękoho pro pomoc.
 AI_Output   (self, other, "DIA_Rosi_ONAR_17_03"); //A pak to obvykle netrvá dlouho, než se sem žoldáci dostanou a vypoâádají se s domobranou.
 AI_Output   (self, other, "DIA_Rosi_ONAR_17_04"); //Ale když je po všem, nechovají se žoldáci o nic líp.
};

///////////////////////////////////////////////////////////////////////
// Info Permkap1
///////////////////////////////////////////////////////////////////////
instance DIA_Rosi_PERMKAP1  (C_INFO)
{
 npc   =  BAU_936_Rosi;
 nr   =  80;
 condition  =  DIA_Rosi_PERMKAP1_Condition;
 information  =  DIA_Rosi_PERMKAP1_Info;
 permanent  = TRUE;
 description  =  "No tak, trochu kuráže.";
};

func int DIA_Rosi_PERMKAP1_Condition ()
{
 if (Npc_KnowsInfo(other, DIA_Rosi_WASMACHSTDU))
 || ((Kapitel >= 5) && (Npc_KnowsInfo(other, DIA_Rosi_FLEEFROMSEKOB)))
  {
     return TRUE;
   };
};

func void DIA_Rosi_PERMKAP1_Info ()
{
 AI_Output   (other, self, "DIA_Rosi_PERMKAP1_15_00"); //No tak, trochu kuráže.


 if ((MIS_bringRosiBackToSekob == LOG_SUCCESS))
  {
   AI_Output   (self, other, "DIA_Rosi_PERMKAP1_17_01"); //Bęž si skočit do jezera.
  }
 else
  {
   AI_Output   (self, other, "DIA_Rosi_PERMKAP1_17_02"); //Dávej na sebe pozor a nedej se.
  };
 AI_StopProcessInfos (self);
};


//#####################################################################
//##
//##
//##       KAPITEL 3
//##
//##
//#####################################################################

// ************************************************************
//           EXIT KAP3
// ************************************************************

INSTANCE DIA_Rosi_KAP3_EXIT(C_INFO)
{
 npc   = BAU_936_Rosi;
 nr   = 999;
 condition = DIA_Rosi_KAP3_EXIT_Condition;
 information = DIA_Rosi_KAP3_EXIT_Info;
 permanent = TRUE;
 description = DIALOG_ENDE;
};
FUNC INT DIA_Rosi_KAP3_EXIT_Condition()
{
 if (Kapitel == 3)
 {
  return TRUE;
 };
};
FUNC VOID DIA_Rosi_KAP3_EXIT_Info()
{
 AI_StopProcessInfos (self);
};


//#####################################################################
//##
//##
//##       KAPITEL 4
//##
//##
//#####################################################################


// ************************************************************
//           EXIT KAP4
// ************************************************************

INSTANCE DIA_Rosi_KAP4_EXIT(C_INFO)
{
 npc   = BAU_936_Rosi;
 nr   = 999;
 condition = DIA_Rosi_KAP4_EXIT_Condition;
 information = DIA_Rosi_KAP4_EXIT_Info;
 permanent = TRUE;
 description = DIALOG_ENDE;
};
FUNC INT DIA_Rosi_KAP4_EXIT_Condition()
{
 if (Kapitel == 4)
 {
  return TRUE;
 };
};
FUNC VOID DIA_Rosi_KAP4_EXIT_Info()
{
 AI_StopProcessInfos (self);
};


//#####################################################################
//##
//##
//##       KAPITEL 5
//##
//##
//#####################################################################

// ************************************************************
//           EXIT KAP5
// ************************************************************

INSTANCE DIA_Rosi_KAP5_EXIT(C_INFO)
{
 npc   = BAU_936_Rosi;
 nr   = 999;
 condition = DIA_Rosi_KAP5_EXIT_Condition;
 information = DIA_Rosi_KAP5_EXIT_Info;
 permanent = TRUE;
 description = DIALOG_ENDE;
};
FUNC INT DIA_Rosi_KAP5_EXIT_Condition()
{
 if (Kapitel == 5)
 {
  return TRUE;
 };
};
FUNC VOID DIA_Rosi_KAP5_EXIT_Info()
{
 AI_StopProcessInfos (self);
};

///////////////////////////////////////////////////////////////////////
// Info FleefromSekob
///////////////////////////////////////////////////////////////////////
instance DIA_Rosi_FLEEFROMSEKOB  (C_INFO)
{
 npc   =  BAU_936_Rosi;
 nr   =  50;
 condition  =  DIA_Rosi_FLEEFROMSEKOB_Condition;
 information  =  DIA_Rosi_FLEEFROMSEKOB_Info;

 description  =  "Co dęláš tady v divočinę?";
};

func int DIA_Rosi_FLEEFROMSEKOB_Condition ()
{
 if (Kapitel == 5)
 && (Rosi_FleeFromSekob_Kap5 == TRUE)
 {
  return TRUE;
 };
};

func void DIA_Rosi_FLEEFROMSEKOB_Info ()
{
 AI_Output   (other, self, "DIA_Rosi_FLEEFROMSEKOB_15_00"); //Co dęláš tady v divočinę?
 AI_Output   (self, other, "DIA_Rosi_FLEEFROMSEKOB_17_01"); //Na Sekobovę farmę už se to nedalo vydržet. Sekob dostával jeden hysterický záchvat za druhým.
 AI_Output   (self, other, "DIA_Rosi_FLEEFROMSEKOB_17_02"); //Nakonec už se s ním nedalo vůbec mluvit. Nakonec na všechny akorát âval.
 AI_Output   (self, other, "DIA_Rosi_FLEEFROMSEKOB_17_03"); //Musela jsem se odtamtud dostat, ale nevím, kam se vrtnout.
 AI_Output   (self, other, "DIA_Rosi_FLEEFROMSEKOB_17_04"); //Nemáš zájem o menší dohodu?
 B_GivePlayerXP (XP_Ambient);
 RosiFoundKap5 = TRUE;
};

///////////////////////////////////////////////////////////////////////
// Info Hilfe
///////////////////////////////////////////////////////////////////////
instance DIA_Rosi_HILFE  (C_INFO)
{
 npc   =  BAU_936_Rosi;
 nr   =  51;
 condition  =  DIA_Rosi_HILFE_Condition;
 information  =  DIA_Rosi_HILFE_Info;

 description  =  "Vezmu tę odsud pryč.";
};

func int DIA_Rosi_HILFE_Condition ()
{
 if (Npc_KnowsInfo(other, DIA_Rosi_FLEEFROMSEKOB))
 && (Rosi_FleeFromSekob_Kap5 == TRUE)
  {
    return TRUE;
  };
};

func void DIA_Rosi_HILFE_Info ()
{
 AI_Output   (other, self, "DIA_Rosi_HILFE_15_00"); //Vezmu tę odsud pryč.

 self.aivar[AIV_PARTYMEMBER] = TRUE;
 Till.aivar[AIV_PARTYMEMBER] = TRUE;

 if ((hero.guild == GIL_MIL) || (hero.guild == GIL_PAL))
  {
   AI_Output   (other, self, "DIA_Rosi_HILFE_15_01"); //Mohl bych tę vzít do męsta.
  };

  if ((hero.guild == GIL_SLD) || (hero.guild == GIL_DJG))
  {
   AI_Output   (other, self, "DIA_Rosi_HILFE_15_02"); //Vezmu tę na farmu velkostatkáâe
  };

  if (hero.guild == GIL_KDF)
  {
   AI_Output   (other, self, "DIA_Rosi_HILFE_15_03"); //Tak odejdi do kláštera. Budeš tam vítána.
  };

  AI_Output   (self, other, "DIA_Rosi_HILFE_17_04"); //Nikdy ti nezapomenu, cos pro mę udęlal. Samozâejmę ti zaplatím.

   if (Npc_IsDead(Till))
   {
    AI_Output   (self, other, "DIA_Rosi_HILFE_17_05"); //Bęž první, budu tę následovat.
   }
   else
   {
    AI_Output   (self, other, "DIA_Rosi_HILFE_17_06"); //Bęž první, budeme tę následovat.
   };

  AI_StopProcessInfos (self);
  if ((hero.guild == GIL_MIL) || (hero.guild == GIL_PAL))
  {
   Npc_ExchangeRoutine (self,"FollowCity");
   B_StartOtherRoutine (Till,"FollowCity");
  };

  if ((hero.guild == GIL_SLD) || (hero.guild == GIL_DJG))
  {
   Npc_ExchangeRoutine (self,"FollowBigfarm");
   B_StartOtherRoutine (Till,"FollowBigfarm");
  };

  if (hero.guild == GIL_KDF)
  {
   Npc_ExchangeRoutine (self,"FollowKloster");
   B_StartOtherRoutine (Till,"FollowKloster");
  };
  Log_CreateTopic (TOPIC_RosisFlucht, LOG_MISSION);
  Log_SetTopicStatus(TOPIC_RosisFlucht, LOG_RUNNING);
  B_LogEntry (TOPIC_RosisFlucht,"Rosi už to nemohla na Sekobovę statku déle vydržet a teë neví, kam jít. Vyvedu ji ven z divočiny.");
  MIS_RosisFlucht = LOG_RUNNING;
};

///////////////////////////////////////////////////////////////////////
// Info angekommen
///////////////////////////////////////////////////////////////////////
instance DIA_Rosi_ANGEKOMMEN  (C_INFO)
{
 npc   =  BAU_936_Rosi;
 nr   =  55;
 condition  =  DIA_Rosi_ANGEKOMMEN_Condition;
 information  =  DIA_Rosi_ANGEKOMMEN_Info;
 important  =  TRUE;

};

func int DIA_Rosi_ANGEKOMMEN_Condition ()
{
 if  (Kapitel == 5)
 && (MIS_bringRosiBackToSekob != LOG_SUCCESS)
 && (Rosi_FleeFromSekob_Kap5 == TRUE)
 && (
   ( (Npc_GetDistToWP(self,"CITY2")<6000)  && (hero.guild == GIL_PAL) )
  || ( (Npc_GetDistToWP(self,"NW_BIGFARM_KITCHEN_02")<6000)  && (hero.guild == GIL_DJG) )
  || ( (Npc_GetDistToWP(self,"KLOSTER")<6000)  && (hero.guild == GIL_KDF) )
  )
   {
    return TRUE;
   };
};

func void DIA_Rosi_ANGEKOMMEN_Info ()
{
 AI_Output   (self, other, "DIA_Rosi_ANGEKOMMEN_17_00"); //Cestu už najdu sama.
 AI_Output   (self, other, "DIA_Rosi_ANGEKOMMEN_17_01"); //Díky. Nevím, co bych si bez tebe počala.

 self.aivar[AIV_PARTYMEMBER] = FALSE;
 Till.aivar[AIV_PARTYMEMBER] = FALSE;

 MIS_bringRosiBackToSekob = LOG_OBSOLETE;
 MIS_RosisFlucht = LOG_SUCCESS;
  AI_Output   (self, other, "DIA_Rosi_ANGEKOMMEN_17_02"); //Prosím, vezmi si tenhle skromný dárek jako vyjádâení mých díků.

  CreateInvItems (Rosi, ItMi_Gold, 650);
  B_GiveInvItems (self, other, ItMi_Gold, 450);

  if (Npc_IsDead(Till))
  {
   B_GivePlayerXP (XP_SavedRosi);
  }
  else
  {
   var int XPForBoth;
   XPForBoth = (XP_SavedRosi + XP_Ambient);
   B_GivePlayerXP (XPForBoth);
  };

  AI_StopProcessInfos (self);

   if (Npc_GetDistToWP(self,"CITY2")<8000)
   {
    Npc_ExchangeRoutine (self,"CITY");
    B_StartOtherRoutine (Till,"CITY");
   }
   else if (Npc_GetDistToWP(self,"BIGFARM")<8000)
   {
    Npc_ExchangeRoutine (self,"BIGFARM");
    B_StartOtherRoutine (Till,"BIGFARM");
   }
   else if (Npc_GetDistToWP(self,"KLOSTER")<8000)
   {
    Npc_ExchangeRoutine (self,"KLOSTER");
    B_StartOtherRoutine (Till,"KLOSTER");
   };
};

///////////////////////////////////////////////////////////////////////
// Info trait
///////////////////////////////////////////////////////////////////////
instance DIA_Rosi_TRAIT  (C_INFO)
{
 npc   =  BAU_936_Rosi;
 nr   =  55;
 condition  =  DIA_Rosi_TRAIT_Condition;
 information  =  DIA_Rosi_TRAIT_Info;

 description  =  "Tak zase doma, co?";
};

func int DIA_Rosi_TRAIT_Condition ()
{
 if (MIS_bringRosiBackToSekob == LOG_SUCCESS)
 && (Rosi_FleeFromSekob_Kap5 == TRUE)
  {
    return TRUE;
  };
};

func void DIA_Rosi_TRAIT_Info ()
{
 AI_Output   (other, self, "DIA_Rosi_TRAIT_15_00"); //Tak zase doma, co?
 AI_Output   (self, other, "DIA_Rosi_TRAIT_17_01"); //Ty jsi ten nejhnusnęjší kýbl hnoje, co jsem kdy ve svým životę potkala, ty mizerná svinę.
 AI_StopProcessInfos (self);
 self.aivar[AIV_PARTYMEMBER] = FALSE;
 Till.aivar[AIV_PARTYMEMBER] = FALSE;
 MIS_RosisFlucht = LOG_FAILED;
 B_GivePlayerXP (XP_Ambient);
};


///////////////////////////////////////////////////////////////////////
// Info MinenAnteil
///////////////////////////////////////////////////////////////////////
instance DIA_Rosi_MinenAnteil  (C_INFO)
{
 npc   =  BAU_936_Rosi;
 nr   =  3;
 condition  =  DIA_Rosi_MinenAnteil_Condition;
 information  =  DIA_Rosi_MinenAnteil_Info;

 description  =  "Prodávat nelegální důlní akcie - nestydíš se??";
};

func int DIA_Rosi_MinenAnteil_Condition ()
{
 if (hero.guild == GIL_KDF)
 && (MIS_Serpentes_MinenAnteil_KDF == LOG_RUNNING)
 && (Npc_KnowsInfo(other, DIA_Rosi_WASMACHSTDU))
  {
    return TRUE;
  };
};

func void DIA_Rosi_MinenAnteil_Info ()
{
 AI_Output (other, self, "DIA_Rosi_Minenanteil_15_00"); //Prodávat nelegální důlní akcie - nestydíš se?
 AI_Output (self, other, "DIA_Rosi_Minenanteil_17_01"); //Ne. Z nęčeho žít musím. A taky nejsem jediná, kdo je pustil do obęhu.
 B_GivePlayerXP (XP_Ambient);
};

//#####################################################################
//##
//##
//##       KAPITEL 6
//##
//##
//#####################################################################

// ************************************************************
//           EXIT KAP6
// ************************************************************


INSTANCE DIA_Rosi_KAP6_EXIT(C_INFO)
{
 npc   = BAU_936_Rosi;
 nr   = 999;
 condition = DIA_Rosi_KAP6_EXIT_Condition;
 information = DIA_Rosi_KAP6_EXIT_Info;
 permanent = TRUE;
 description = DIALOG_ENDE;
};
FUNC INT DIA_Rosi_KAP6_EXIT_Condition()
{
 if (Kapitel == 6)
 {
  return TRUE;
 };
};
FUNC VOID DIA_Rosi_KAP6_EXIT_Info()
{
 AI_StopProcessInfos (self);
};




// ************************************************************
//          PICK POCKET
// ************************************************************

INSTANCE DIA_Rosi_PICKPOCKET (C_INFO)
{
 npc   = BAU_936_Rosi;
 nr   = 900;
 condition = DIA_Rosi_PICKPOCKET_Condition;
 information = DIA_Rosi_PICKPOCKET_Info;
 permanent = TRUE;
 description = Pickpocket_40_Female;
};

FUNC INT DIA_Rosi_PICKPOCKET_Condition()
{
 C_Beklauen (30, 75);
};

FUNC VOID DIA_Rosi_PICKPOCKET_Info()
{
 Info_ClearChoices (DIA_Rosi_PICKPOCKET);
 Info_AddChoice  (DIA_Rosi_PICKPOCKET, DIALOG_BACK   ,DIA_Rosi_PICKPOCKET_BACK);
 Info_AddChoice  (DIA_Rosi_PICKPOCKET, DIALOG_PICKPOCKET ,DIA_Rosi_PICKPOCKET_DoIt);
};

func void DIA_Rosi_PICKPOCKET_DoIt()
{
 B_Beklauen ();
 Info_ClearChoices (DIA_Rosi_PICKPOCKET);
};

func void DIA_Rosi_PICKPOCKET_BACK()
{
 Info_ClearChoices (DIA_Rosi_PICKPOCKET);
};

















































