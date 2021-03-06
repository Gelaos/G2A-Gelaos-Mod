///////////////////////////////////////////////////////////////////////
// Info EXIT
///////////////////////////////////////////////////////////////////////
INSTANCE DIA_Grimbald_EXIT   (C_INFO)
{
 npc         = BAU_982_Grimbald;
 nr          = 999;
 condition   = DIA_Grimbald_EXIT_Condition;
 information = DIA_Grimbald_EXIT_Info;
 permanent   = TRUE;
 description = DIALOG_ENDE;
};

FUNC INT DIA_Grimbald_EXIT_Condition()
{
 return TRUE;
};

FUNC VOID DIA_Grimbald_EXIT_Info()
{
 AI_StopProcessInfos (self);
};

///////////////////////////////////////////////////////////////////////
// Info Hallo
///////////////////////////////////////////////////////////////////////
instance DIA_Grimbald_HALLO  (C_INFO)
{
 npc   =  BAU_982_Grimbald;
 nr   =  3;
 condition  =  DIA_Grimbald_HALLO_Condition;
 information  =  DIA_Grimbald_HALLO_Info;

 description  =  "Čekáš na nęco?";
};

func int DIA_Grimbald_HALLO_Condition ()
{
 return TRUE;
};
var int Grimbald_PissOff;

func void DIA_Grimbald_HALLO_Info ()
{
 AI_Output   (other, self, "DIA_Grimbald_HALLO_15_00"); //Čekáš na nęco?

 if  (
  (Npc_IsDead(Grimbald_Snapper1))
  && (Npc_IsDead(Grimbald_Snapper2))
  && (Npc_IsDead(Grimbald_Snapper3)))
   {
    AI_Output   (self, other, "DIA_Grimbald_HALLO_07_01"); //Jsem na lovu. To je snad jasné.
    Grimbald_PissOff = TRUE;
   }
   else
   {
    AI_Output   (self, other, "DIA_Grimbald_HALLO_07_02"); //Už ne. Teë jsi tady, ne?

    Info_ClearChoices (DIA_Grimbald_HALLO);
    Info_AddChoice (DIA_Grimbald_HALLO, "Čeká na mę práce.", DIA_Grimbald_HALLO_nein );
    Info_AddChoice (DIA_Grimbald_HALLO, "Co tím myslíš?", DIA_Grimbald_HALLO_Was );
    Info_AddChoice (DIA_Grimbald_HALLO, "Proč já?", DIA_Grimbald_HALLO_ich );
   };
};

func void DIA_Grimbald_HALLO_ich ()
{
 AI_Output   (other, self, "DIA_Grimbald_HALLO_ich_15_00"); //Proč já?
 AI_Output   (self, other, "DIA_Grimbald_HALLO_ich_07_01"); //Vypadáš silnę. Chlápek jako ty se mi může hodit.
};

func void DIA_Grimbald_HALLO_Was ()
{
 AI_Output   (other, self, "DIA_Grimbald_HALLO_Was_15_00"); //Co tím myslíš?
 AI_Output   (self, other, "DIA_Grimbald_HALLO_Was_07_01"); //Chtęl bych ulovit ty chŕapavce támhle nahoâe, ale mám dojem, že je jich na mę samotného moc.

 Info_AddChoice (DIA_Grimbald_HALLO, "Se mnou nepočítej..", DIA_Grimbald_HALLO_Was_neinnein );
 Info_AddChoice (DIA_Grimbald_HALLO, "Dobrá. Pomůžu ti. Jdi první.", DIA_Grimbald_HALLO_Was_ja );
};
func void DIA_Grimbald_HALLO_Was_neinnein ()
{
 AI_Output   (other, self, "DIA_Grimbald_HALLO_Was_neinnein_15_00"); //Se mnou nepočítej.
 AI_Output   (self, other, "DIA_Grimbald_HALLO_Was_neinnein_07_01"); //Tak to vypadni, babo.
 Grimbald_PissOff = TRUE;
 Info_ClearChoices (DIA_Grimbald_HALLO);
};

func void DIA_Grimbald_HALLO_Was_ja ()
{
 AI_Output   (other, self, "DIA_Grimbald_HALLO_Was_ja_15_00"); //Dobrá. Pomůžu ti. Jdi první.
 AI_Output   (self, other, "DIA_Grimbald_HALLO_Was_ja_07_01"); //Jasná vęc. Ale moc se nepâibližuj k tomu černému trolovi tam nahoâe. Jinak tę rozseká na kousky, jasný?
 AI_Output   (self, other, "DIA_Grimbald_HALLO_Was_ja_07_02"); //Čeho se bojíš, že se držíš tak zpátky.
 B_StartOtherRoutine (self,"Lov");
 AI_StopProcessInfos (self);
};

func void DIA_Grimbald_HALLO_nein ()
{
 AI_Output   (other, self, "DIA_Grimbald_HALLO_nein_15_00"); //Čeká na mę práce.
 AI_Output   (self, other, "DIA_Grimbald_HALLO_nein_07_01"); //Nevykládej nesmysly. Co by mohlo být tady uprostâed divočiny tak důležitého?
};

///////////////////////////////////////////////////////////////////////
// Info Jagd
///////////////////////////////////////////////////////////////////////
instance DIA_Grimbald_Jagd  (C_INFO)
{
 npc   =  BAU_982_Grimbald;
 nr   =  3;
 condition  =  DIA_Grimbald_Jagd_Condition;
 information  =  DIA_Grimbald_Jagd_Info;
 permanent  =  TRUE;

 description  =  "Můžeš mę naučit nęco o lovu?";
};

func int DIA_Grimbald_Jagd_Condition ()
{
 if (Npc_KnowsInfo(other, DIA_Grimbald_HALLO))
 && (Grimbald_TeachAnimalTrophy == FALSE)
  {
    return TRUE;
  };
};

func void DIA_Grimbald_Jagd_Info ()
{
 AI_Output   (other, self, "DIA_Grimbald_Jagd_15_00"); //Můžeš mę naučit nęco o lovu?
 if  ((Npc_IsDead(Grimbald_Snapper1))
  && (Npc_IsDead(Grimbald_Snapper2))
  && (Npc_IsDead(Grimbald_Snapper3)))
  || (Grimbald_PissOff == FALSE)
 {
  AI_Output   (self, other, "DIA_Grimbald_Jagd_07_01"); //Mmh. Dobrá. Nebyl jsi mi sice zrovna moc platný, ale nebudu na tebe tak tvrdý.
  Grimbald_TeachAnimalTrophy = TRUE;
 }
 else
 {
  AI_Output   (self, other, "DIA_Grimbald_Jagd_07_02"); //Jasnę. Ale bude tę to nęco stát.
  B_Say_Gold (self, other, 200);

  Info_ClearChoices (DIA_Grimbald_Jagd);
  Info_AddChoice (DIA_Grimbald_Jagd, "Budu o tom pâemýšlet.", DIA_Grimbald_Jagd_zuviel );
  Info_AddChoice (DIA_Grimbald_Jagd, "Dobrá.", DIA_Grimbald_Jagd_ja );
 };
};

func void DIA_Grimbald_Jagd_ja ()
{
 AI_Output   (other, self, "DIA_Grimbald_Jagd_ja_15_00"); //Dobrá. Tady jsou peníze

  if (B_GiveInvItems (other, self, ItMi_Gold,200))
  {
   AI_Output   (self, other, "DIA_Grimbald_Jagd_ja_07_01"); //Fajn. Tak mi âekni, až se budeš chtít nęco naučit.
   Grimbald_TeachAnimalTrophy = TRUE;
  }
  else
  {
   AI_Output   (self, other, "DIA_Grimbald_Jagd_ja_07_02"); //Dej mi ty prachy a pak tę můžu nęco naučit.
  };
 Info_ClearChoices (DIA_Grimbald_Jagd);
};

func void DIA_Grimbald_Jagd_zuviel ()
{
 AI_Output   (other, self, "DIA_Grimbald_Jagd_zuviel_15_00"); //Budu o tom pâemýšlet.
 AI_Output   (self, other, "DIA_Grimbald_Jagd_zuviel_07_01"); //Když to âíkáš.
 Info_ClearChoices (DIA_Grimbald_Jagd);
};


///////////////////////////////////////////////////////////////////////
// Info TeachHunting
///////////////////////////////////////////////////////////////////////
instance DIA_Grimbald_TEACHHUNTING  (C_INFO)
{
 npc       =  BAU_982_Grimbald;
 nr           =  12;
 condition  =  DIA_Grimbald_TEACHHUNTING_Condition;
 information  =  DIA_Grimbald_TEACHHUNTING_Info;
 permanent  =  TRUE;
 description  =  "Rád bych se naučil nęjakým loveckým technikám.";
};

func int DIA_Grimbald_TEACHHUNTING_Condition ()
{
 if (Grimbald_TeachAnimalTrophy == TRUE)
  {
    return TRUE;
  };
};
var int DIA_Grimbald_TEACHHUNTING_OneTime;
func void DIA_Grimbald_TEACHHUNTING_Info ()
{
 AI_Output   (other, self, "DIA_Grimbald_TEACHHUNTING_15_00"); //Rád bych se naučil nęjakým loveckým technikám.
 if (DIA_Grimbald_TEACHHUNTING_OneTime == FALSE)
 {
  B_StartOtherRoutine (self,"JagdOver");
  DIA_Grimbald_TEACHHUNTING_OneTime = TRUE;
 };

 if   (
    (PLAYER_TALENT_TAKEANIMALTROPHY [TROPHY_BFSting] == FALSE)
    ||(PLAYER_TALENT_TAKEANIMALTROPHY [TROPHY_BFWing] == FALSE)
    ||(PLAYER_TALENT_TAKEANIMALTROPHY [TROPHY_Claws] == FALSE)
    ||(PLAYER_TALENT_TAKEANIMALTROPHY [TROPHY_Mandibles] == FALSE)
    ||(PLAYER_TALENT_TAKEANIMALTROPHY [TROPHY_CrawlerPlate] == FALSE)
   )
   {
    AI_Output   (self, other, "DIA_Grimbald_TEACHHUNTING_07_01"); //Co pâesnę bys chtęl vędęt?

    Info_AddChoice  (DIA_Grimbald_TEACHHUNTING, DIALOG_BACK, DIA_Grimbald_TEACHHUNTING_BACK);

    if (PLAYER_TALENT_TAKEANIMALTROPHY [TROPHY_BFSting] == FALSE)
    {
     Info_AddChoice (DIA_Grimbald_TEACHHUNTING, B_BuildLearnString ("Žihadlo krvavé mouchy",B_GetLearnCostTalent (other,NPC_TALENT_TAKEANIMALTROPHY, TROPHY_BFSting)),  DIA_Grimbald_TEACHHUNTING_BFSting);
    };
    if (PLAYER_TALENT_TAKEANIMALTROPHY [TROPHY_BFWing] == FALSE)
    {
     Info_AddChoice (DIA_Grimbald_TEACHHUNTING, B_BuildLearnString ("Kâídla krvavé mouchy",B_GetLearnCostTalent (other,NPC_TALENT_TAKEANIMALTROPHY, TROPHY_BFWing)),  DIA_Grimbald_TEACHHUNTING_BFWing );
    };
    if (PLAYER_TALENT_TAKEANIMALTROPHY [TROPHY_Claws] == FALSE)
    {
     Info_AddChoice (DIA_Grimbald_TEACHHUNTING, B_BuildLearnString ("Vyjmutí drápů",B_GetLearnCostTalent (other,NPC_TALENT_TAKEANIMALTROPHY, TROPHY_Claws)),  DIA_Grimbald_TEACHHUNTING_Claws );
    };
    if (PLAYER_TALENT_TAKEANIMALTROPHY [TROPHY_Mandibles] == FALSE)
    {
     Info_AddChoice (DIA_Grimbald_TEACHHUNTING, B_BuildLearnString ("Vyjmutí kusadel",B_GetLearnCostTalent (other,NPC_TALENT_TAKEANIMALTROPHY, TROPHY_Mandibles)),  DIA_Grimbald_TEACHHUNTING_Mandibles);
    };
    if (PLAYER_TALENT_TAKEANIMALTROPHY [TROPHY_CrawlerPlate] == FALSE)
    {
     Info_AddChoice (DIA_Grimbald_TEACHHUNTING, B_BuildLearnString ("Oddęlení červích krunýâů",B_GetLearnCostTalent (other,NPC_TALENT_TAKEANIMALTROPHY, TROPHY_CrawlerPlate)),  DIA_Grimbald_TEACHHUNTING_CrawlerPlate);
    };
   }
   else
   {
    AI_Output   (self, other, "DIA_Grimbald_TEACHHUNTING_07_02"); //Už znáš vše, co bych tę mohl naučit.
   };
};

func void DIA_Grimbald_TEACHHUNTING_BACK()
{
 Info_ClearChoices (DIA_Grimbald_TEACHHUNTING);
};

func void DIA_Grimbald_TEACHHUNTING_BFSting()
{
 if (B_TeachPlayerTalentTakeAnimalTrophy (self, other, TROPHY_BFSting))
  {
   AI_Output   (self, other, "DIA_Grimbald_TEACHHUNTING_BFSting_07_00"); //Opravdu není problém dostat z krvavé mouchy její žihadlo. Stačí jen najít jeho koâen a vrazit tam nůž.
  };
 Info_ClearChoices (DIA_Grimbald_TEACHHUNTING);
};

func void DIA_Grimbald_TEACHHUNTING_BFWing()
{
 if (B_TeachPlayerTalentTakeAnimalTrophy (self, other, TROPHY_BFWing))
  {
   AI_Output   (self, other, "DIA_Grimbald_TEACHHUNTING_BFWing_07_00"); //Buë můžeš kâídla z krvavé mouchy dostat tak, že je prostę utrhneš, nebo je oddęlíš ostrým nožem.
  };
 Info_ClearChoices (DIA_Grimbald_TEACHHUNTING);
};

func void DIA_Grimbald_TEACHHUNTING_Claws ()
{
 if (B_TeachPlayerTalentTakeAnimalTrophy (self, other, TROPHY_Claws))
  {
   AI_Output   (self, other, "DIA_Grimbald_TEACHHUNTING_Claws_07_00"); //Je nękolik způsobů, jak získat drápy. Na nękterá zvíâata budeš potâebovat hodnę síly, u jiných ti stačí jen odâíznout je nožem.
  };
 Info_ClearChoices (DIA_Grimbald_TEACHHUNTING);
};

func void DIA_Grimbald_TEACHHUNTING_Mandibles ()
{
 if (B_TeachPlayerTalentTakeAnimalTrophy (self, other, TROPHY_Mandibles))
  {
   AI_Output   (self, other, "DIA_Grimbald_TEACHHUNTING_Mandibles_07_00"); //Důlní červi a polní škůdci mají silná kusadla, která můžeš z jejich hlavy dostat silným trhnutím...
  };
 Info_ClearChoices (DIA_Grimbald_TEACHHUNTING);
};

func void DIA_Grimbald_TEACHHUNTING_CrawlerPlate ()
{
 if (B_TeachPlayerTalentTakeAnimalTrophy (self, other, TROPHY_CrawlerPlate))
  {
   AI_Output   (self, other, "DIA_Grimbald_TEACHHUNTING_CrawlerPlate_07_00"); //Krunýâ důlních červů pâiléhá k jejich tęlu velmi tęsnę, ale velkým ostrým pâedmętem se dá snadno oddęlit.
  };
 Info_ClearChoices (DIA_Grimbald_TEACHHUNTING);
};


///////////////////////////////////////////////////////////////////////
// Info NovChase
///////////////////////////////////////////////////////////////////////
instance DIA_Grimbald_NovChase  (C_INFO)
{
 npc   =  BAU_982_Grimbald;
 nr   =  3;
 condition  =  DIA_Grimbald_NovChase_Condition;
 information  =  DIA_Grimbald_NovChase_Info;

 description  =  "Nevidęl jsi tudy procházet nęjakého novice?";

};

func int DIA_Grimbald_NovChase_Condition ()
{
 if (MIS_NOVIZENCHASE == LOG_RUNNING)
  {
    return TRUE;
  };
};

func void DIA_Grimbald_NovChase_Info ()
{
 AI_Output   (other, self, "DIA_Grimbald_NovChase_15_00"); //Nevidęl jsi tudy procházet nęjakého novice?
 AI_Output   (self, other, "DIA_Grimbald_NovChase_07_01"); //Dneska tudy prošlo hodnę podivných osob - včetnę tęch dvou vtipálků od toho kamenného oblouku.
 AI_Output   (self, other, "DIA_Grimbald_NovChase_07_02"); //Taky s nima byl nęjaký novic od mágů ohnę.
 B_GivePlayerXP (XP_Ambient);
};

///////////////////////////////////////////////////////////////////////
// Info Trolltot
///////////////////////////////////////////////////////////////////////
instance DIA_Grimbald_Trolltot  (C_INFO)
{
 npc   =  BAU_982_Grimbald;
 nr   =  3;
 condition  =  DIA_Grimbald_Trolltot_Condition;
 information  =  DIA_Grimbald_Trolltot_Info;
 important  =  TRUE;

};

func int DIA_Grimbald_Trolltot_Condition ()
{
 if (Npc_IsDead(Troll_Black))
  {
    return TRUE;
  };
};

func void DIA_Grimbald_Trolltot_Info ()
{
 AI_Output   (self, other, "DIA_Grimbald_Trolltot_07_00"); //Černý trol je mrtev. Skvęlá práce. Nikdy jsem si nemyslel, že ho lze zabít. Na tohle nikdy nezapomenu.
 B_GivePlayerXP (XP_Ambient);
};

// ************************************************************
//          PICK POCKET
// ************************************************************

INSTANCE DIA_Grimbald_PICKPOCKET (C_INFO)
{
 npc   = BAU_982_Grimbald;
 nr   = 900;
 condition = DIA_Grimbald_PICKPOCKET_Condition;
 information = DIA_Grimbald_PICKPOCKET_Info;
 permanent = TRUE;
 description = Pickpocket_100;
};

FUNC INT DIA_Grimbald_PICKPOCKET_Condition()
{
 C_Beklauen (85, 250);
};

FUNC VOID DIA_Grimbald_PICKPOCKET_Info()
{
 Info_ClearChoices (DIA_Grimbald_PICKPOCKET);
 Info_AddChoice  (DIA_Grimbald_PICKPOCKET, DIALOG_BACK   ,DIA_Grimbald_PICKPOCKET_BACK);
 Info_AddChoice  (DIA_Grimbald_PICKPOCKET, DIALOG_PICKPOCKET ,DIA_Grimbald_PICKPOCKET_DoIt);
};

func void DIA_Grimbald_PICKPOCKET_DoIt()
{
 B_Beklauen ();
 Info_ClearChoices (DIA_Grimbald_PICKPOCKET);
};

func void DIA_Grimbald_PICKPOCKET_BACK()
{
 Info_ClearChoices (DIA_Grimbald_PICKPOCKET);
};

