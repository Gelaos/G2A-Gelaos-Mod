///////////////////////////////////////////////////////////////////////
//	Info EXIT 
///////////////////////////////////////////////////////////////////////
INSTANCE DIA_Moe_EXIT   (C_INFO)
{
	npc         = VLK_432_Moe;
	nr          = 999;
	condition   = DIA_Moe_EXIT_Condition;
	information = DIA_Moe_EXIT_Info;
	permanent   = TRUE;
	description = DIALOG_ENDE;
};

FUNC INT DIA_Moe_EXIT_Condition()
{
	return TRUE;
};

FUNC VOID DIA_Moe_EXIT_Info()
{
	AI_StopProcessInfos (self);
};
// ************************************************************
// 			  				PICK POCKET
// ************************************************************
INSTANCE DIA_Moe_PICKPOCKET (C_INFO)
{
	npc			= VLK_432_Moe;
	nr			= 900;
	condition	= DIA_Moe_PICKPOCKET_Condition;
	information	= DIA_Moe_PICKPOCKET_Info;
	permanent	= TRUE;
	description = Pickpocket_40;
};                       

FUNC INT DIA_Moe_PICKPOCKET_Condition()
{
	C_Beklauen (25, 30);
};
 
FUNC VOID DIA_Moe_PICKPOCKET_Info()
{	
	Info_ClearChoices	(DIA_Moe_PICKPOCKET);
	Info_AddChoice		(DIA_Moe_PICKPOCKET, DIALOG_BACK 		,DIA_Moe_PICKPOCKET_BACK);
	Info_AddChoice		(DIA_Moe_PICKPOCKET, DIALOG_PICKPOCKET	,DIA_Moe_PICKPOCKET_DoIt);
};

func void DIA_Moe_PICKPOCKET_DoIt()
{
	B_Beklauen ();
	Info_ClearChoices (DIA_Moe_PICKPOCKET);
};
	
func void DIA_Moe_PICKPOCKET_BACK()
{
	Info_ClearChoices (DIA_Moe_PICKPOCKET);
};
// ************************************************************
// 			     Hallo
// ************************************************************
INSTANCE DIA_Moe_Hallo(C_INFO)
{
	npc			= VLK_432_Moe;
	nr			= 2;
	condition	= DIA_Moe_Hallo_Condition;
	information	= DIA_Moe_Hallo_Info;
	permanent	= FALSE;
	important   = TRUE;
};                       

FUNC INT DIA_Moe_Hallo_Condition()
{	
	if (Npc_GetDistToNpc(self, other) <= ZivilAnquatschDist)
	&& (hero.guild != GIL_PAL)
	&& (hero.guild != GIL_KDF)
	&& (hero.guild != GIL_MIL)
	&& (hero.guild != GIL_NOV)
	&& (Npc_RefuseTalk(self) == FALSE) 
	{
		return TRUE;
	};
};
FUNC VOID DIA_Moe_Hallo_Info()
{
	AI_Output (self ,other,"DIA_Moe_Hallo_01_00"); //Hej ty, tebe neznám. Co tady chceš? Máš namíâeno do hospody?
	
	Info_ClearChoices (DIA_Moe_Hallo);
	Info_AddChoice    (DIA_Moe_Hallo,"Ne, nemám namíâeno do hospody... (KONEC)",DIA_Moe_Hallo_Gehen);
	Info_AddChoice 	  (DIA_Moe_Hallo,"Aha, takže tohle je místní nálevna.",DIA_Moe_Hallo_Witz);
	Info_AddChoice 	  (DIA_Moe_Hallo,"Jo, vadí ti to?",DIA_Moe_Hallo_Reizen);
};
FUNC VOID DIA_Moe_Hallo_Gehen()
{
	AI_Output (other ,self,"DIA_Moe_Hallo_Gehen_15_00"); //Ne, nemám namíâeno do hospody.
	AI_Output (self ,other,"DIA_Moe_Hallo_Gehen_01_01"); //Jo, to bych âekl. To je ale fuk - právę proto můžeme jít pâímo k vęci.
	AI_Output (self ,other,"DIA_Moe_Hallo_Gehen_01_02"); //Když už jsi tady, nęco ti nabídnu. Dej mi 50 zlaăáků a můžeš jít dál.
	AI_Output (self ,other,"DIA_Moe_Hallo_Gehen_01_03"); //To je vstupné do hospody.
	
	Info_ClearChoices (DIA_Moe_Hallo);
	Info_AddChoice    (DIA_Moe_Hallo,"Uvidíme, jestli si to samé myslí i domobrana...",DIA_Moe_Hallo_Miliz);
	Info_AddChoice    (DIA_Moe_Hallo,"Na to zapomeŕ, nedostaneš ani męëák!",DIA_Moe_Hallo_Vergisses);
	Info_AddChoice    (DIA_Moe_Hallo,"No tak já ti teda zaplatím.",DIA_Moe_Hallo_Zahlen);
	Info_AddChoice    (DIA_Moe_Hallo,"Ale já nechci jít do hospody!",DIA_Moe_Hallo_Kneipe);
};
FUNC VOID DIA_Moe_Hallo_Kneipe()
{
	AI_Output (other ,self,"DIA_Moe_Hallo_Kneipe_15_00"); //Ale já do hospody vůbec nechci jít!
	AI_Output (self ,other,"DIA_Moe_Hallo_Kneipe_01_01"); //Víš, dâív nebo pozdęji chce do hospody každý. Takže když mi zaplatíš hned, budeš to mít pro pâíštę z krku.
};
FUNC VOID  DIA_Moe_Hallo_Witz()
{
	AI_Output (other ,self,"DIA_Moe_Hallo_Witz_15_00"); //Ahá, tohle je pâístavní nálevna? A já si myslel, že je to palác místodržícího!
	AI_Output (self ,other,"DIA_Moe_Hallo_Witz_01_01"); //Hele, nech si ty hloupé šprýmy, skrčku, nebo budeš brzo žvejkat dlažební kostky.
	
	Info_ClearChoices (DIA_Moe_Hallo);
	Info_AddChoice    (DIA_Moe_Hallo,"Chápu, budu ti muset dát pár pâes držku.",DIA_Moe_Hallo_Pruegel);
	Info_AddChoice    (DIA_Moe_Hallo,"Ty mę chceš dostat do maléru, co?",DIA_Moe_Hallo_Aerger);
	Info_AddChoice    (DIA_Moe_Hallo,"Uklidni se, chci si dát jenom jedno pivo.",DIA_Moe_Hallo_Ruhig);
	Info_AddChoice    (DIA_Moe_Hallo,"Ale já do hospody vůbec nechci jít!",DIA_Moe_Hallo_Kneipe);
};
FUNC VOID DIA_Moe_Hallo_Reizen()
{
	AI_Output (other ,self,"DIA_Moe_Hallo_Reizen_15_00"); //Jo, vadí ti to?
	AI_Output (self ,other,"DIA_Moe_Hallo_Reizen_01_01"); //Tady nemáš co pohledávat, skrčku.
	
	Info_ClearChoices (DIA_Moe_Hallo);
	Info_AddChoice    (DIA_Moe_Hallo,"Chápu, budu ti muset dát pár pâes držku.",DIA_Moe_Hallo_Pruegel);
	Info_AddChoice    (DIA_Moe_Hallo,"Ty mę chceš dostat do maléru, co?",DIA_Moe_Hallo_Aerger);
	Info_AddChoice    (DIA_Moe_Hallo,"Uklidni se, chci si dát jenom jedno pivo.",DIA_Moe_Hallo_Ruhig);
};
FUNC VOID DIA_Moe_Hallo_Miliz()
{
	AI_Output (other ,self,"DIA_Moe_Hallo_Miliz_15_00"); //Uvidíme, jestli si to samé myslí i domobrana.
	AI_Output (self ,other,"DIA_Moe_Hallo_Miliz_01_01"); //(smęje se) Nikdo z domobrany tady není. A víš proč?
	AI_Output (self ,other,"DIA_Moe_Hallo_Miliz_01_02"); //Protože tady jsi v pâístavní čtvrti, skrčku. Nikdo z domobrany se tu se mnou rvát nebude.
	AI_Output (self ,other,"DIA_Moe_Hallo_Miliz_01_03"); //Vętšinou jsou všichni nalezlí u 'Červené lucerny'. Tak vidíš - jsme tu jen my dva. (zlý úšklebek)
};
FUNC VOID DIA_Moe_Hallo_Pruegel()
{
	AI_Output (other ,self,"DIA_Moe_Hallo_Pruegel_15_00"); //Chápu. Než půjdu dál, budu tę muset stáhnout z kůže.
	AI_Output (self ,other,"DIA_Moe_Hallo_Pruegel_01_01"); //Jen si to zkus, skrčku. Ukaž, co umíš!
	
	AI_StopProcessInfos (self);
	B_Attack (self, other, AR_NONE,1);
};
FUNC VOID DIA_Moe_Hallo_Aerger()
{
	AI_Output (other ,self,"DIA_Moe_Hallo_Aerger_15_00"); //Ty mę chceš dostat do maléru, co?
	AI_Output (self ,other,"DIA_Moe_Hallo_Aerger_01_01"); //Jo, v tom, jak dostat nękoho do maléru, jsem mistr. Takže se koukej bránit, skrčku!
	
	AI_StopProcessInfos (self);
	B_Attack (self, other, AR_NONE,1);
};
FUNC VOID DIA_Moe_Hallo_Ruhig()
{
	AI_Output (other ,self,"DIA_Moe_Hallo_Ruhig_15_00"); //Uklidni se, chci si dát jenom jedno pivo.
	AI_Output (self ,other,"DIA_Moe_Hallo_Ruhig_01_01"); //Fajn, ale vstupné tę bude stát 50 zlaăáků. (šklebí se)
	
	Info_ClearChoices (DIA_Moe_Hallo);
	Info_AddChoice    (DIA_Moe_Hallo,"Na to zapomeŕ, nedostaneš ani męëák!",DIA_Moe_Hallo_Vergisses);
	Info_AddChoice    (DIA_Moe_Hallo,"No tak já ti teda zaplatím.",DIA_Moe_Hallo_Zahlen);
	
};
FUNC VOID DIA_Moe_Hallo_Zahlen()
{
	AI_Output (other ,self,"DIA_Moe_Hallo_Zahlen_15_00"); //No tak já ti teda zaplatím.
	
	if B_GiveInvItems (other, self, ItMi_Gold,50)
	{
		AI_Output (self ,other,"DIA_Moe_Hallo_Zahlen_01_01"); //Výbornę. A když jsme to tak hezky vyâešili, teë mi můžeš dát i to ostatní, co máš u sebe.
		
		Info_ClearChoices (DIA_Moe_Hallo);
		Info_AddChoice    (DIA_Moe_Hallo,"Na to zapomeŕ, nedostaneš ani męëák!",DIA_Moe_Hallo_Vergisses);
		Info_AddChoice    (DIA_Moe_Hallo,"OK, tohle je všechno, co mám.",DIA_Moe_Hallo_Alles);
	}
	else if (Npc_HasItems (hero, ItMi_Gold) > 9)
	{
		AI_Output (other ,self,"DIA_Moe_Hallo_Zahlen_15_02"); //...ale já u sebe nemám tolik zlaăáků.
		AI_Output (self ,other,"DIA_Moe_Hallo_Zahlen_01_03"); //To nevadí, tak prostę naval všechno, co máš u sebe.
		
		Info_ClearChoices (DIA_Moe_Hallo);
		Info_AddChoice    (DIA_Moe_Hallo,"Na to zapomeŕ, nedostaneš ani męëák!",DIA_Moe_Hallo_Vergisses);
		Info_AddChoice    (DIA_Moe_Hallo,"OK, tohle je všechno, co mám.",DIA_Moe_Hallo_Alles);
	}
	else
	{
		AI_Output (other ,self,"DIA_Moe_Hallo_Zahlen_15_04"); //...ale já nemám ani 10 zlaăáků.
		AI_Output (self ,other,"DIA_Moe_Hallo_Zahlen_01_05"); //Chlape, já nemám ani vindru.
		AI_Output (self ,other,"DIA_Moe_Hallo_Zahlen_01_06"); //No dobâe - povzdech - můžeš jít.
		
		AI_StopProcessInfos (self);
	};

};
FUNC VOID DIA_Moe_Hallo_Vergisses()
{
	AI_Output (other ,self,"DIA_Moe_Hallo_Vergisses_15_00"); //Na to zapomeŕ, nedostaneš ani męëák!
	AI_Output (self ,other,"DIA_Moe_Hallo_Vergisses_01_01"); //Pak si vezmu všechno, co máš - jen co mi budeš ležet u nohou.
	
	AI_StopProcessInfos (self);
	B_Attack (self, other, AR_NONE,1);
};
FUNC VOID DIA_Moe_Hallo_Alles()
{
	AI_Output (other ,self,"DIA_Moe_Hallo_Alles_15_00"); //Fajn, tohle je všechno, co mám.
	
	B_GiveInvItems (other, self, ItMi_Gold, Npc_HasItems (other,ItMi_Gold));
	
	AI_Output (self ,other,"DIA_Moe_Hallo_Alles_01_01"); //Dobrá, to mi teda stačí. To jsem celý já - vždycky velkorysý. (šklebí se)
	AI_StopProcessInfos (self);
};
//************************************************
//	Das Hafenviertel
//************************************************

INSTANCE DIA_Moe_Harbor(C_INFO)
{
	npc			= VLK_432_Moe;
	nr			= 998;
	condition	= DIA_Moe_Harbor_Condition;
	information	= DIA_Moe_Harbor_Info;
	permanent	= TRUE;
	description = "Ty se tady v pâístavu dost vyznáš, vië?";
};                       

FUNC INT DIA_Moe_Harbor_Condition()
{
		return TRUE;
};
 
FUNC VOID DIA_Moe_Harbor_Info()
{	
	AI_Output (other,self ,"DIA_Moe_Harbor_15_00"); //Ty se tady v pâístavu dost vyznáš, vië?
	AI_Output (self ,other,"DIA_Moe_Harbor_01_01"); //Jasná vęc. Proč?
	
	Info_ClearChoices (DIA_Moe_Harbor);
	Info_AddChoice		(DIA_Moe_Harbor, DIALOG_BACK, DIA_Moe_Harbor_Back);
	Info_AddChoice		(DIA_Moe_Harbor,"Jaký je tu provoz lodí?",DIA_Moe_Harbor_Ship);
	Info_AddChoice		(DIA_Moe_Harbor,"Jak to, že tu nevidím nikoho z domobrany?",DIA_Moe_Harbor_Militia);
	Info_AddChoice 		(DIA_Moe_Harbor,"O čem se tu asi tak nejvíc povídá?",DIA_Moe_Harbor_Rumors);
};

FUNC VOID DIA_Moe_Harbor_Back ()
{
	Info_ClearChoices (DIA_Moe_Harbor);
};

FUNC VOID DIA_Moe_Harbor_Ship ()
{
	AI_Output (other,self ,"DIA_Moe_Harbor_Ship_15_00"); //Jaký je tu provoz lodí?
	AI_Output (self ,other,"DIA_Moe_Harbor_Ship_01_01"); //Jediná loë, která sem v poslední dobę pâiplula, je ta paladinská galéra.
	AI_Output (self ,other,"DIA_Moe_Harbor_Ship_01_02"); //Najdeš ji tamhle za tím útesem na jihozápadę
	
};

FUNC VOID DIA_Moe_Harbor_Militia ()
{
	AI_Output (other,self ,"DIA_Moe_Harbor_Militia_15_00"); //Jak to, že tu nevidím nikoho z domobrany?
	AI_Output (self ,other,"DIA_Moe_Harbor_Militia_01_01"); //Netroufají si sem chodit - vždycky si všechno vyâídíme sami.
};

FUNC VOID DIA_Moe_Harbor_Rumors ()
{
	AI_Output (other,self ,"DIA_Moe_Harbor_Rumors_15_00"); //O čem se tu asi tak nejvíc povídá?
	
	if (Kapitel == 1)
	{
		AI_Output (self ,other,"DIA_Moe_Harbor_Rumors_01_01"); //Nemáme rádi lidi, kteâí se moc vyptávají. Zvlášă když jsou to cizinci.
	}
	else if (Kapitel == 2)
	{
		if (hero.guild == GIL_MIL)
		{
			AI_Output (self ,other,"DIA_Moe_Harbor_Rumors_01_02"); //Coby - nic. Všechno je tu v klidu a pohodę.
		}
		else if (hero.guild == GIL_KDF)
		|| (hero.guild == GIL_PAL)
		{
			AI_Output (self ,other,"DIA_Moe_Harbor_Rumors_01_03"); //(nepâirozenę) Je to špatné. Časy jsou zlé, ale všichni se snažíme zůstat čestní a poctiví.
			AI_Output (other,self ,"DIA_Moe_Harbor_Rumors_15_04"); //Nedęlej si ze mę šoufky.
			AI_Output (self ,other,"DIA_Moe_Harbor_Rumors_01_05"); //Jak si o mnę můžeš nęco takového myslet? Teë ses mę teda hluboce dotkl.
		}
		else
		{
			AI_Output (self ,other,"DIA_Moe_Harbor_Rumors_01_06"); //Je tu fakt horko. Lord Andre se už nęjakou dobu snaží strkat nos do vęcí, po kterých mu pranic není.
			AI_Output (self ,other,"DIA_Moe_Harbor_Rumors_01_07"); //Ti nafoukanci nikdy nepochopí, jak to tady dole chodí.
		};
		
	}
	else if (Kapitel == 3)
	{
		if (Mis_RescueBennet == LOG_SUCCESS)
		{
			if (hero.guild == GIL_MIL)
			|| (hero.guild == GIL_PAL)
			|| (hero.guild == GIL_KDF)
			{
				AI_Output (self ,other,"DIA_Moe_Harbor_Rumors_01_08"); //My s tím nemáme nic společného.
				AI_Output (other,self ,"DIA_Moe_Harbor_Rumors_15_09"); //S čím?
				AI_Output (self ,other,"DIA_Moe_Harbor_Rumors_01_10"); //S tím paladinem, kterého tu zabili. Opravdu by ses o ty žoldáky nemęl starat - jenom tím maâíš čas.
			}
			else
			{
				AI_Output (self ,other,"DIA_Moe_Harbor_Rumors_01_11"); //Vím, že s tím nemáš nic společného, ale ta vražda paladina všechny urozené džentlmeny poâádnę vylekala.
				AI_Output (self ,other,"DIA_Moe_Harbor_Rumors_01_12"); //Jestli ti můžu dát pâátelskou radu, tak zmiz z męsta. Aspoŕ na chvíli.
			};	
		}
		else
		{
			AI_Output (self ,other,"DIA_Moe_Harbor_Rumors_01_13"); //Když vyšlo najevo, že žoldáci s tím paladinem nemęli nic společného, domobrana si sem už netroufá ani vkročit.
			AI_Output (self ,other,"DIA_Moe_Harbor_Rumors_01_14"); //Myslím, že se bojí, aby jim nikdo nerozbil držku. Mnę osobnę to vůbec nevadí.
		};
	}
	else if (Kapitel == 4)
	{
		AI_Output (self ,other,"DIA_Moe_Harbor_Rumors_01_15"); //Nedęje se tu absolutnę nic.
	}
	else //Kapitel 5
	{
		AI_Output (self ,other,"DIA_Moe_Harbor_Rumors_01_16"); //Konečnę ti nabubâelí paladinové opustili pâístav. Bylo načase.
	};
};

///////////////////////////////////////////////////////////////////////
//	Info LehmarGeldeintreiben
///////////////////////////////////////////////////////////////////////
instance DIA_Moe_LEHMARGELDEINTREIBEN		(C_INFO)
{
	npc			 = 	VLK_432_Moe;
	nr			 =  2;
	condition	 = 	DIA_Moe_LEHMARGELDEINTREIBEN_Condition;
	information	 = 	DIA_Moe_LEHMARGELDEINTREIBEN_Info;
	permanent 	 =  FALSE;
	important	 = 	TRUE;
};
func int DIA_Moe_LEHMARGELDEINTREIBEN_Condition ()
{
	if 	((Lehmar_GeldGeliehen_Day <= (Wld_GetDay()-2))
	&&   (Lehmar_GeldGeliehen != 0))
	&& (RangerHelp_LehmarKohle == FALSE)
	&& (Lehmar.aivar[AIV_DefeatedByPlayer] == FALSE)
	{
		return TRUE;
	};
};
func void DIA_Moe_LEHMARGELDEINTREIBEN_Info ()
{
	AI_Output (self, other, "DIA_Moe_LEHMARGELDEINTREIBEN_01_00"); //Hej, ty tam! Lehmar tę zdraví.

	AI_StopProcessInfos (self);

	B_Attack (self, other, AR_NONE, 1);	
};







