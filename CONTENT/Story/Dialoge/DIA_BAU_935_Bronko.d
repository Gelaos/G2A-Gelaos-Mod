///////////////////////////////////////////////////////////////////////
// Info EXIT
///////////////////////////////////////////////////////////////////////
INSTANCE DIA_Bronko_EXIT   (C_INFO)
{
 npc         = BAU_935_Bronko;
 nr          = 999;
 condition   = DIA_Bronko_EXIT_Condition;
 information = DIA_Bronko_EXIT_Info;
 permanent   = TRUE;
 description = DIALOG_ENDE;
};

FUNC INT DIA_Bronko_EXIT_Condition()
{
 return TRUE;
};

FUNC VOID DIA_Bronko_EXIT_Info()
{
 AI_StopProcessInfos (self);
};

///////////////////////////////////////////////////////////////////////
// Info Hallo
///////////////////////////////////////////////////////////////////////
instance DIA_Bronko_HALLO  (C_INFO)
{
 npc   =  BAU_935_Bronko;
 nr   =  1;
 condition  =  DIA_Bronko_HALLO_Condition;
 information  =  DIA_Bronko_HALLO_Info;
 important  =  TRUE;
};

func int DIA_Bronko_HALLO_Condition ()
{
 return TRUE;
};

func void DIA_Bronko_HALLO_Info ()
{
 AI_Output   (self, other, "DIA_Bronko_HALLO_06_00"); //(otcovsky) Tak kampak, co?
 AI_Output   (other, self, "DIA_Bronko_HALLO_15_01"); //Ty jsi tady šéf?

 if (hero.guild == GIL_NONE)
  {
   AI_Output   (self, other, "DIA_Bronko_HALLO_06_02"); //Nęjakou ti vrazím, ty lotâe.
  };

 AI_Output   (self, other, "DIA_Bronko_HALLO_06_03"); //Jestli se chceš poflakovat po mém pozemku, zaplaă mi 5 zlatých, jinak si koleduješ o pękný náâez!

 Info_ClearChoices (DIA_Bronko_HALLO);

 Info_AddChoice (DIA_Bronko_HALLO, "Zapomeŕ na to. Nic ode mę nedostaneš.", DIA_Bronko_HALLO_vergisses );
 Info_AddChoice (DIA_Bronko_HALLO, "Když jinak nedáš - tady jsou peníze.", DIA_Bronko_HALLO_hiergeld );
 Info_AddChoice (DIA_Bronko_HALLO, "Tvůj pozemek? Ty jsi tady farmáâem?", DIA_Bronko_HALLO_deinland );

};

func void DIA_Bronko_HALLO_deinland ()
{
 AI_Output   (other, self, "DIA_Bronko_HALLO_deinland_15_00"); //Tvůj pozemek? Ty jsi tady farmáâem?
 AI_Output   (self, other, "DIA_Bronko_HALLO_deinland_06_01"); //To se můžeš vsadit. Proč bych po tobę jinak chtęl mýtný?
 AI_Output   (self, other, "DIA_Bronko_HALLO_deinland_06_02"); //Je mi jedno, jestli se na mę budeš vyptávat ostatních. He he!

};

func void DIA_Bronko_HALLO_hiergeld ()
{
 AI_Output   (other, self, "DIA_Bronko_HALLO_hiergeld_15_00"); //Když jinak nedáš - tady jsou peníze.

 if ((Npc_HasItems (other,ItMi_Gold)) >= 5)
  {
   B_GiveInvItems (other, self, ItMi_Gold, 5);

   AI_Output   (self, other, "DIA_Bronko_HALLO_hiergeld_06_01"); //(škodolibę) Díky. A hezký den.

   AI_StopProcessInfos (self);
  }
 else
  {
    AI_Output   (self, other, "DIA_Bronko_HALLO_hiergeld_06_02"); //Nemáš ani 5 zlatých. Snažíš se mę oblafnout, co?

    AI_StopProcessInfos (self);
    B_Attack (self, other, AR_NONE, 1);
  };
};

func void DIA_Bronko_HALLO_vergisses ()
{
 AI_Output   (other, self, "DIA_Bronko_HALLO_vergisses_15_00"); //Zapomeŕ na to. Nic ode mę nedostaneš.

 if ((hero.guild == GIL_NONE)||(hero.guild == GIL_SLD) || (hero.guild == GIL_DJG))
  {
   AI_Output   (self, other, "DIA_Bronko_HALLO_vergisses_06_01"); //Tak to je mi líto. Trochu ti pâismahnu kůži.
  }
 else
  {
   if ((hero.guild == GIL_MIL) || (hero.guild == GIL_PAL))
   {
    AI_Output   (self, other, "DIA_Bronko_HALLO_vergisses_06_02"); //Vy hoši od męstské stráže nemáte dost penęz, co?
   };

   if (hero.guild == GIL_KDF)
   {
    AI_Output   (self, other, "DIA_Bronko_HALLO_vergisses_06_03"); //Je mi jedno, jestli jsi mág. Musíš zaplatit, jasný?
   };
  };

 Info_ClearChoices (DIA_Bronko_HALLO);

 Info_AddChoice (DIA_Bronko_HALLO, "Když jinak nedáš - tady jsou peníze.", DIA_Bronko_HALLO_hiergeld );
 Info_AddChoice (DIA_Bronko_HALLO, "Tak to teda zkus.", DIA_Bronko_HALLO_attack );
};

func void DIA_Bronko_HALLO_attack ()
{
 AI_Output   (other, self, "DIA_Bronko_HALLO_attack_15_00"); //Tak to teda zkus.
 AI_Output   (self, other, "DIA_Bronko_HALLO_attack_06_01"); //Fajn, v tom pâípadę...

 AI_StopProcessInfos (self);
 B_Attack (self, other, AR_NONE, 1);
};

///////////////////////////////////////////////////////////////////////
// Info keinBauer
///////////////////////////////////////////////////////////////////////
instance DIA_Bronko_KEINBAUER  (C_INFO)
{
 npc   =  BAU_935_Bronko;
 nr   =  2;
 condition  =  DIA_Bronko_KEINBAUER_Condition;
 information  =  DIA_Bronko_KEINBAUER_Info;
 permanent  =  TRUE;

 description  =  "Ty, farmáâ? Nenech se vysmát. Ve skutečnosti nejsi nikdo.";
};

var int DIA_Bronko_KEINBAUER_noPerm;

func int DIA_Bronko_KEINBAUER_Condition ()
{
 if  (
  ((MIS_Sekob_Bronko_eingeschuechtert == LOG_RUNNING) || (Babera_BronkoKeinBauer == TRUE))
  &&  (self.aivar[AIV_LastFightAgainstPlayer] != FIGHT_LOST)
  && (DIA_Bronko_KEINBAUER_noPerm == FALSE)
  )
  {
    return TRUE;
  };
};

func void DIA_Bronko_KEINBAUER_Info ()
{
 AI_Output   (other, self, "DIA_Bronko_KEINBAUER_15_00"); //Ty, farmáâ? Nenech se vysmát. Ve skutečnosti nejsi nikdo.
 AI_Output   (self, other, "DIA_Bronko_KEINBAUER_06_01"); //Cooo? Chceš, abych ti zmaloval ksicht?

 Info_ClearChoices (DIA_Bronko_KEINBAUER);

 if (hero.guild == GIL_NONE)
  {
   if(Babera_BronkoKeinBauer == TRUE)
    {
     Info_AddChoice (DIA_Bronko_KEINBAUER, "(Vyhrožovat Broncovi, že pâivedeš žoldnéâe.)", DIA_Bronko_KEINBAUER_SLD );
    };
   if (MIS_Sekob_Bronko_eingeschuechtert == LOG_RUNNING)
    {
     Info_AddChoice (DIA_Bronko_KEINBAUER, "Sekob je zdejší sedlák a ty nejsi nic jiného než druhoâadý podvodníček.", DIA_Bronko_KEINBAUER_sekobderbauer );
    };
  };

 Info_AddChoice (DIA_Bronko_KEINBAUER, "Dobrá, tak se teda podíváme, co máš. ", DIA_Bronko_KEINBAUER_attack );
 Info_AddChoice (DIA_Bronko_KEINBAUER, "Nevadí!", DIA_Bronko_KEINBAUER_schongut );

};

func void DIA_Bronko_KEINBAUER_attack ()
{
 AI_Output   (other, self, "DIA_Bronko_KEINBAUER_attack_15_00"); //Dobrá, tak se teda podíváme, co máš.
 AI_Output   (self, other, "DIA_Bronko_KEINBAUER_attack_06_01"); //Doufal jsem, že to âekneš.

 AI_StopProcessInfos (self);
 B_Attack (self, other, AR_NONE, 1);
};

func void DIA_Bronko_KEINBAUER_sekobderbauer ()
{
 AI_Output   (other, self, "DIA_Bronko_KEINBAUER_sekobderbauer_15_00"); //Zdejší farmáâ je Sekob a ty nejsi nic než mizerný podvodník, co se snaží lidem tahat peníze z kapes.
 AI_Output   (self, other, "DIA_Bronko_KEINBAUER_sekobderbauer_06_01"); //To âíká kdo?
 AI_Output   (other, self, "DIA_Bronko_KEINBAUER_sekobderbauer_15_02"); //To âíkám já. Sekob chce, aby ses vrátil k práci místo toho, aby ses tady flákal.
 AI_Output   (self, other, "DIA_Bronko_KEINBAUER_sekobderbauer_06_03"); //Tak co? Co udęláš teë?
};

func void DIA_Bronko_KEINBAUER_schongut ()
{
 AI_Output   (other, self, "DIA_Bronko_KEINBAUER_schongut_15_00"); //Nevadí!
 AI_Output   (self, other, "DIA_Bronko_KEINBAUER_schongut_06_01"); //Zmiz!

  AI_StopProcessInfos (self);
};

func void DIA_Bronko_KEINBAUER_SLD ()
{
 AI_Output   (other, self, "DIA_Bronko_KEINBAUER_SLD_15_00"); //Fajn, tak to bych męl Onarovi âíct, že je tady nęjakej užvanęnej farmáâ, co odmítá platit nájem.
 AI_Output   (self, other, "DIA_Bronko_KEINBAUER_SLD_06_01"); //Ehm. Počkej chvilku. Onar na mę pošle všechny svoje žoldáky.
 AI_Output   (other, self, "DIA_Bronko_KEINBAUER_SLD_15_02"); //A co?
 AI_Output   (self, other, "DIA_Bronko_KEINBAUER_SLD_06_03"); //Dobrá, dobrá. Dám ti, co chceš, ale netahej do toho žoldáky, fajn?

 if (B_GiveInvItems (self, other, ItMi_Gold, Npc_HasItems (self,ItMi_Gold)))
 {
  AI_Output   (self, other, "DIA_Bronko_KEINBAUER_SLD_06_04"); //Tady, dám ti všechno svoje zlato.
 };
 AI_Output   (self, other, "DIA_Bronko_KEINBAUER_SLD_06_05"); //A vrátím se na pole. Všechno, jen ne žoldáky.

 AI_StopProcessInfos (self);
 DIA_Bronko_KEINBAUER_noPerm = TRUE;
 Npc_ExchangeRoutine (self,"Start");
 MIS_Sekob_Bronko_eingeschuechtert = LOG_SUCCESS;
 B_GivePlayerXP (XP_Ambient);
};

///////////////////////////////////////////////////////////////////////
// Info fleissig
///////////////////////////////////////////////////////////////////////
instance DIA_Bronko_FLEISSIG  (C_INFO)
{
 npc   =  BAU_935_Bronko;
 nr   =  3;
 condition  =  DIA_Bronko_FLEISSIG_Condition;
 information  =  DIA_Bronko_FLEISSIG_Info;
 permanent  =  TRUE;

 description  =  "(Vysmívat se Broncovi)";
};

func int DIA_Bronko_FLEISSIG_Condition ()
{
 if  (
  (MIS_Sekob_Bronko_eingeschuechtert == LOG_SUCCESS)
  || (self.aivar[AIV_LastFightAgainstPlayer] == FIGHT_LOST)
  )
   {
     return TRUE;
   };
};

func void DIA_Bronko_FLEISSIG_Info ()
{

 if (MIS_Sekob_Bronko_eingeschuechtert == LOG_SUCCESS)
  {
   AI_Output   (other, self, "DIA_Bronko_FLEISSIG_15_00"); //Tak? Pilný jako včelička, co?
  }
 else
  {
   AI_Output   (other, self, "DIA_Bronko_FLEISSIG_15_01"); //Tak? Poâád ještę máš tak nevymáchanou hubu?
  };

 if ((hero.guild == GIL_SLD) || (hero.guild == GIL_DJG))
  {
   AI_Output   (self, other, "DIA_Bronko_FLEISSIG_06_02"); //Ty jsi žoldák, že jo? Męl jsem to vędęt.
  }
 else if (MIS_Sekob_Bronko_eingeschuechtert == LOG_SUCCESS)
  {
   AI_Output   (self, other, "DIA_Bronko_FLEISSIG_06_03"); //(vystrašenę) Nevykecáš to žoldákům, že ne?
  };

 if  (
   (self.aivar[AIV_LastFightAgainstPlayer] == FIGHT_LOST)
  ||  (hero.guild == GIL_SLD)
  ||  (hero.guild == GIL_DJG)
  )
   {
    AI_Output   (self, other, "DIA_Bronko_FLEISSIG_06_04"); //Nemlaă mę, prosím.
   };

 AI_Output   (self, other, "DIA_Bronko_FLEISSIG_06_05"); //Vrátím se ke své práci, fajn?

 MIS_Sekob_Bronko_eingeschuechtert = LOG_SUCCESS;
 AI_StopProcessInfos (self);
 Npc_ExchangeRoutine (self,"Start");
};



// ************************************************************
//          PICK POCKET
// ************************************************************

INSTANCE DIA_Bronko_PICKPOCKET (C_INFO)
{
 npc   = BAU_935_Bronko;
 nr   = 900;
 condition = DIA_Bronko_PICKPOCKET_Condition;
 information = DIA_Bronko_PICKPOCKET_Info;
 permanent = TRUE;
 description = Pickpocket_60;
};

FUNC INT DIA_Bronko_PICKPOCKET_Condition()
{
 C_Beklauen (54, 80);
};

FUNC VOID DIA_Bronko_PICKPOCKET_Info()
{
 Info_ClearChoices (DIA_Bronko_PICKPOCKET);
 Info_AddChoice  (DIA_Bronko_PICKPOCKET, DIALOG_BACK   ,DIA_Bronko_PICKPOCKET_BACK);
 Info_AddChoice  (DIA_Bronko_PICKPOCKET, DIALOG_PICKPOCKET ,DIA_Bronko_PICKPOCKET_DoIt);
};

func void DIA_Bronko_PICKPOCKET_DoIt()
{
 B_Beklauen ();
 Info_ClearChoices (DIA_Bronko_PICKPOCKET);
};

func void DIA_Bronko_PICKPOCKET_BACK()
{
 Info_ClearChoices (DIA_Bronko_PICKPOCKET);
};

















