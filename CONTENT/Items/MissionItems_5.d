 //**********************************************************************************
//	ItWr_XardasLetterToOpenBook_MIS  an den SC um die HALLEN von Irdorath zu öffnen!
//----------------------------------------------------------------------------------

INSTANCE ItWr_XardasLetterToOpenBook_MIS		(C_Item)
{
	name 				=	"Dopis od Xardase";

	mainflag 			=	ITEM_KAT_DOCS;
	flags 				=	ITEM_MISSION;

	value 				=	0;

	visual 				=	"ItWr_Scroll_01.3DS";
	material 			=	MAT_LEATHER;
	on_state[0]			=   Use_XardasLetterToOpenBook;
	scemeName			=	"MAP";
	description			= 	name;
};
func void Use_XardasLetterToOpenBook ()
{   
 
		
		var int nDocID;
		
		nDocID = 	Doc_Create		()			  ;							// DocManager 
					Doc_SetPages	( nDocID,  1 );                         //wieviel Pages
					Doc_SetPage 	( nDocID,  0, "letters.TGA"  , 0 		); 
					Doc_SetFont 	( nDocID, -1, FONT_Book    			); 	// -1 -> all pages 
					Doc_SetMargins	( nDocID, -1, 50, 50, 50, 50, 1   		);  //  0 -> margins are in pixels
					Doc_PrintLines	( nDocID,  0, ""					);
					Doc_PrintLines	( nDocID,  0, "Domníval jsem se, že zdrojem všeho zla jsou draci v Hornickém údolí."					);
					Doc_PrintLines	( nDocID,  0, "Mílil jsem se."					);
					Doc_PrintLines	( nDocID,  0, "Jestli se všechno stane tak, jak čekám, "					);
					Doc_PrintLines	( nDocID,  0, "męl bys teë vyhledat Irdoratské sínę. "					);
					Doc_PrintLines	( nDocID,  0, "Potâebné informace najdeš v knize, kterou jsi donesl Pyrokarovi."					);
					Doc_PrintLines	( nDocID,  0, "Męl jsem vędęt, proč se po ní Pátrači tolik"					);
					Doc_PrintLines	( nDocID,  0, "pídili."					);
					Doc_PrintLines	( nDocID,  0, "Musíš ji získat zpęt!"					);
					Doc_PrintLines	( nDocID,  0, "Otevâeš ji slovy 'XARAK BENDARDO'. Nikomu je neprozraë!"					);
					Doc_PrintLines	( nDocID,  0, "Teë půjdu zaâídit ještę další důležité vęci."					);
					Doc_PrintLines	( nDocID,  0, "V tomto závęrečném úkolu už ti má pomoc nebude nic platná. Pouze ty můžeš zničit zdroj všeho zla."					);
					Doc_PrintLines	( nDocID,  0, "Ještę se ale uvidíme! "					);
					Doc_PrintLines	( nDocID,  0, ""					);
					Doc_PrintLines	( nDocID,  0, ""					);
					Doc_PrintLines	( nDocID,  0, ""					);
					Doc_PrintLine	( nDocID,  0, "                             Xardas."					);
					Doc_Show		( nDocID );

	if(MIS_Xardas_SCCanOpenIrdorathBook == FALSE)
	{
		B_LogEntry (TOPIC_BuchHallenVonIrdorath,"V tomto dopise mi Xardas sdęlil, jaká slova otevâou knihu Irdoratské sínę."); 
	};

	MIS_Xardas_SCCanOpenIrdorathBook  = TRUE;	//Joly:  Spieler kann nun das Buch im Kloster lesen und findet so die geheime Bibliothek!
};


//**********************************************************************************
//	ItKe_MonastarySecretLibrary_Mis 		Schlüssel zur geheimen Bibliothek
//**********************************************************************************

INSTANCE ItKe_MonastarySecretLibrary_Mis (C_Item)
{
	name 				=	"Klíč" ;

	mainflag 			=	ITEM_KAT_NONE;
	flags 				=	ITEM_MISSION;

	value 				=	Value_Key_02;

	visual 				=	"ItKe_Key_02.3ds";
	material 			=	MAT_METAL;

	description			= 	name;
	
	TEXT[0]				= 	"z knihy 'Irdoratské sínę'.";
	TEXT[5]				= 	NAME_Value;	COUNT[5]	= value;
};

//**********************************************************************************
//	ItWr_HallsofIrdorath_Mis
//**********************************************************************************

INSTANCE ItWr_HallsofIrdorath_Mis (C_ITEM) 
{	
	name 					=	"Irdoratské sínę";

	mainflag 				=	ITEM_KAT_DOCS;
	flags 					=	ITEM_MISSION;

	value 					=	0;

	visual 					=	"ItWr_Book_02_05.3ds";  					//BUCH VARIATIONEN: ItWr_Book_01.3DS , ItWr_Book_02_01.3DS, ItWr_Book_02_02.3DS, ItWr_Book_02_03.3DS, ItWr_Book_02_04.3DS, ItWr_Book_02_05.3DS
	material 				=	MAT_LEATHER;

	scemeName				=	"MAPSEALED";
	description				= 	name;
	TEXT[5]					= 	NAME_Value;
	COUNT[5]				= 	value;
	on_state[0]				=	Use_HallsofIrdorath;
};

FUNC VOID Use_HallsofIrdorath ()
{   
		if (MIS_Xardas_SCCanOpenIrdorathBook == TRUE)
		{
			B_Say (self, self, "$SCOPENSIRDORATHBOOK");
		
  			Wld_PlayEffect("spellFX_LIGHTSTAR_WHITE",  hero, hero, 0, 0, 0, FALSE );
			Snd_Play ("SFX_HealObsession" );

			CreateInvItems (hero,ItWr_HallsofIrdorath_Open_Mis ,1);
			CreateInvItems (hero,ItKe_MonastarySecretLibrary_Mis ,1);
			CreateInvItems (hero,ItWr_UseLampIdiot_Mis ,1);
			
			Print	(PRINT_IrdorathBookHiddenKey);
			B_GivePlayerXP (XP_HallsofIrdorathIsOpen);
			ItWr_HallsofIrdorathIsOpen = TRUE;
			
			B_LogEntry (TOPIC_BuchHallenVonIrdorath,"Podaâilo se mi otevâít Xardasovu knihu. Obsahovala tajnou zprávu a podivný klíč. Kdo ví, na co dalšího ještę v klášterním sklepení narazím."); 
		}
		else
		{
			CreateInvItems (hero,ItWr_HallsofIrdorath_Mis ,1);	//Joly: wegen MAPSEALED!!!!!

			Print (PRINT_IrdorathBookDoesntOpen);
			Wld_PlayEffect("spellFX_Fear",  self, self, 0, 0, 0, FALSE );
			Snd_Play 	("MFX_FEAR_CAST" );
		};	
};

//**********************************************************************************
//	ItWr_HallsofIrdorath_Open_Mis
//**********************************************************************************

INSTANCE ItWr_HallsofIrdorath_Open_Mis (C_ITEM) 
{	
	name 					=	"Irdoratské sínę";

	mainflag 				=	ITEM_KAT_DOCS;
	flags 					=	ITEM_MISSION;

	value 					=	0;

	visual 					=	"ItWr_Book_02_05.3ds";  					//BUCH VARIATIONEN: ItWr_Book_01.3DS , ItWr_Book_02_01.3DS, ItWr_Book_02_02.3DS, ItWr_Book_02_03.3DS, ItWr_Book_02_04.3DS, ItWr_Book_02_05.3DS
	material 				=	MAT_LEATHER;

	scemeName				=	"MAP";
	description				= 	name;
	TEXT[5]					= 	NAME_Value;
	COUNT[5]				= 	value;
	on_state[0]				=	Use_HallsofIrdorath_Open;
};

FUNC VOID Use_HallsofIrdorath_Open ()
{   	 
	if (ItWr_SCReadsHallsofIrdorath == FALSE)
	{
		B_LogEntry (TOPIC_BuchHallenVonIrdorath,"Pâečetl jsem Xardasovu knihu. Zmiŕovala se o tajné knihovnę, která se musí nacházet nękde v klášterním sklepení."); 
	};
	
	ItWr_SCReadsHallsofIrdorath = TRUE;
		
	var int nDocID;
		
		nDocID = 	Doc_Create		()			  ;								// DocManager 
					Doc_SetPages	( nDocID,  2 );                         //wieviel Pages

					Doc_SetPage 	( nDocID,  0, "BOOK_MAGE_L.tga"  , 0 	); // VARIATIONEN: BOOK_BROWN_L.tga , BOOK_MAGE_L.tga , BOOK_RED_L.tga
					Doc_SetPage 	( nDocID,  1, "BOOK_MAGE_R.tga" , 0	); // VARIATIONEN: BOOK_BROWN_R.tga , BOOK_MAGE_R.tga , BOOK_RED_R.tga
					
					//1.Seite

 					Doc_SetMargins	( nDocID,  0,  275, 20, 30, 20, 1   		);  //  0 -> margins are in pixels 					
					Doc_SetFont 	( nDocID,  0, FONT_BookHeadline	   			); 	// -1 -> all pages 
 					Doc_PrintLine	( nDocID,  0, ""					);										
					Doc_SetFont 	( nDocID,  0, FONT_Book	   			); 	// -1 -> all pages 
					Doc_PrintLine	( nDocID,  0, ""					);										
					Doc_PrintLines	( nDocID,  0, "...a tak se do knihovny nyní dá vejít pouze tajnými dveâmi. Ochráním tím své záznamy o Beliarových chrámech. ");
					Doc_PrintLines	( nDocID,  0, "Kdyby se o nich dozvędęli moji bratâi, určitę by je všechny zničili, zaslepenci!");		
					
					//2.Seite
					Doc_SetMargins	( nDocID, -1, 30, 20, 275, 20, 1   		);  //  0 -> margins are in pixels (Position des Textes von den Ränder des TGAs aus, links,oben,rechts,unten)
					Doc_SetFont 	( nDocID,  1, FONT_BookHeadline	   			); 	// -1 -> all pages 
					Doc_PrintLine	( nDocID,  1, ""					);										
					Doc_SetFont 	( nDocID,  1, FONT_Book	   			); 	// -1 -> all pages 
					Doc_PrintLine	( nDocID,  1, ""					);
					Doc_PrintLines	( nDocID,  1, "Ne, vędí pouze to, že tyto chrámy kdysi existovaly."	);
					Doc_PrintLine	( nDocID,  1, ""					);
					//Absatz
					Doc_PrintLines	( nDocID,  1, "Jen tak pro jistotu jsem povęâil nękolik služebníků, aby stâežili knihovnu.");
					Doc_PrintLine	( nDocID,  1, ""					);
					//Absatz
					Doc_PrintLine	( nDocID,  1, ""					);
					//Absatz
					Doc_PrintLines	( nDocID,  1, "Tento klíč otvírá poslední dveâe.");
					
					Doc_Show		( nDocID );

	
};
//**********************************************************************************
//	ItWr_XardasSeamapBook_Mis
//**********************************************************************************

INSTANCE ItWr_XardasSeamapBook_Mis (C_ITEM) 
{	
	name 					=	"Zaprášená kniha";

	mainflag 				=	ITEM_KAT_DOCS;
	flags 					=	ITEM_MISSION;

	value 					=	0;

	visual 					=	"ItWr_Book_02_01.3ds";  					//BUCH VARIATIONEN: ItWr_Book_01.3DS , ItWr_Book_02_01.3DS, ItWr_Book_02_02.3DS, ItWr_Book_02_03.3DS, ItWr_Book_02_04.3DS, ItWr_Book_02_05.3DS
	material 				=	MAT_LEATHER;

	scemeName				=	"MAP";
	description				= 	name;
	TEXT[5]					= 	NAME_Value;
	COUNT[5]				= 	value;
	on_state[0]				=	Use_XardasSeamapBook_Mis;
};

FUNC VOID Use_XardasSeamapBook_Mis ()
{   	 

	var int nDocID;
		
		nDocID = 	Doc_Create		()			  ;								// DocManager 
					Doc_SetPages	( nDocID,  2 );                         //wieviel Pages

					Doc_SetPage 	( nDocID,  0, "BOOK_BROWN_L.tga"  , 0 	); // VARIATIONEN: BOOK_BROWN_L.tga , BOOK_MAGE_L.tga , BOOK_RED_L.tga
					Doc_SetPage 	( nDocID,  1, "BOOK_BROWN_R.tga" , 0		); // VARIATIONEN: BOOK_BROWN_R.tga , BOOK_MAGE_R.tga , BOOK_RED_R.tga
					
					//1.Seite

 					Doc_SetMargins	( nDocID,  0,  275, 20, 30, 20, 1   		);  //  0 -> margins are in pixels 					
					Doc_SetFont 	( nDocID,  0, FONT_BookHeadline	   			); 	// -1 -> all pages 
 					Doc_SetFont 	( nDocID,  0, FONT_Book	   			); 	// -1 -> all pages 
					Doc_PrintLine	( nDocID,  0, ""					);										
					Doc_PrintLines	( nDocID,  0, "...nyní vím jistę, že tou stavbou jsou Irdoratské sínę. Leží na ostrovę nedaleko khorinisského pâístavu. Už je tedy jasné, proč męl Beliar o rudné doly takový zájem...");
					Doc_PrintLines	( nDocID,  0, "");		
	
					if (hero.guild == GIL_PAL)
					{
						Doc_PrintLines	( nDocID,  0, "...čím jsou silnęjší, tím lépe mu budou sloužit jako nemrtví otroci. Takto promęnęní paladinové pak dokáží každému válečníkovi poâádnę zatopit. Jeden z nich mi padl do rukou a já jen doufám, že si ostatní nevšimnou, že se dostal až sem dolů...");		
						
						//2.Seite
						Doc_SetMargins	( nDocID, -1, 30, 20, 275, 20, 1   		);  //  0 -> margins are in pixels (Position des Textes von den Ränder des TGAs aus, links,oben,rechts,unten)
						Doc_SetFont 	( nDocID,  1, FONT_BookHeadline	   			); 	// -1 -> all pages 
						Doc_SetFont 	( nDocID,  1, FONT_Book	   			); 	// -1 -> all pages 
						Doc_PrintLine	( nDocID,  1, ""					);
						Doc_PrintLines	( nDocID,  1, "...ten paladin snad nereaguje vůbec na nic. Jeho zbroj i ostatní vęci jsem uložil v zadní komoâe, jejíž dveâe lze otevâít pouze zevnitâ. Vytvoâil jsem teleportační runu, která mę tam v pâípadę potâeby pâenese. Instrukce pro Vyvoleného jsem ukryl v almanachu..."	);
					};
					
					if (hero.guild == GIL_KDF)
					{
						Doc_PrintLines	( nDocID,  0, "...znamení hovoâí jasnę! Až pâijde Vyvolený, bude potâebovat veškerou pomoc, kterou mu budeme moci poskytnout. Beliar už je pâíliš silný. Snad se Vyvolený dostane k cenným artefaktům, které ukryji právę tady. Domnívám se totiž, že bude pocházet pâímo z našich âad, ");
						
						//2.Seite
						Doc_SetMargins	( nDocID, -1, 30, 20, 275, 20, 1   		);  //  0 -> margins are in pixels (Position des Textes von den Ränder des TGAs aus, links,oben,rechts,unten)
						Doc_SetFont 	( nDocID,  1, FONT_BookHeadline	   			); 	// -1 -> all pages 
						Doc_SetFont 	( nDocID,  1, FONT_Book	   			); 	// -1 -> all pages 
						Doc_PrintLines	( nDocID,  1, "a právę proto jsem pâíslušné pokyny zapsal do almanachu."					);
						Doc_PrintLine	( nDocID,  1, ""					);
						Doc_PrintLines	( nDocID,  1, "...teë už to vím jistę - nesmíme se jen tak vzdát. Až Beliar získá potâebnou moc, povstane a bude se snažit ovládnout svęt. Musím vyhledat Vyvoleného, jinak je náš osud zpečetęn."); 
					};
					
					if (hero.guild == GIL_DJG)
					{
						Doc_PrintLines	( nDocID,  0, "...pâijde válka, válka pro všechny vęâící na svętę. Ale zdá se mi, že znamení dokážu rozpoznat jenom já - všichni ostatní si jich vůbec nevšímají. Já však vím, že se objeví Vyvolený a jeho pâíchod bude vęstit válku. Válku tak starou jako sám čas - konec je však už na obzoru.");
						
						//2.Seite
						Doc_SetMargins	( nDocID, -1, 30, 20, 275, 20, 1   		);  //  0 -> margins are in pixels (Position des Textes von den Ränder des TGAs aus, links,oben,rechts,unten)
						Doc_SetFont 	( nDocID,  1, FONT_BookHeadline	   			); 	// -1 -> all pages 
						Doc_SetFont 	( nDocID,  1, FONT_Book	   			); 	// -1 -> all pages 
						Doc_PrintLines	( nDocID,  1, "Nebudu tu jen tak stát s rukama v klínę a pozorovat, jak ostatní berou osud svęta do svých rukou!"					);
						Doc_PrintLine	( nDocID,  1, ""					);
						Doc_PrintLines	( nDocID,  1, "...prostudoval jsem staré spisy a zjistil, jak vytvoâit legendární zbranę dávných dračích pánů. Zatím ale nemám ponętí, jak získat potâebné ingredience - pro jistotu jsem ale návod také zaznamenal do almanachu. Kdo ví, jaké hrůzy nám budoucnost pâinese - možná se budeme muset postavit i lítým drakům."); 
					};					
					
					Doc_Show		( nDocID );
};


//**********************************************************************
//	geheime Nachricht geheimer Schalter Lampe
//**********************************************************************


INSTANCE ItWr_UseLampIdiot_Mis	(C_Item)
{
	name 				=	"Zmačkaný dopis";

	mainflag 			=	ITEM_KAT_DOCS;
	flags 				=	ITEM_MISSION;

	value 				=	50;

	visual 				=	"ItWr_Scroll_01.3DS";
	material 			=	MAT_LEATHER;
	on_state[0]			=   UseItWr_UseLampIdiot_Mis;
	scemeName			=	"MAP";
	description			= 	name;
	TEXT[0]				=	"z knihy 'Irdoratské sínę'";
};
func void UseItWr_UseLampIdiot_Mis ()
{   
		var int nDocID;
		
		nDocID = 	Doc_Create		();
					Doc_SetPages	(nDocID,  1);
					Doc_SetPage		(nDocID,  0, "letters.TGA", 0);
					Doc_SetFont		(nDocID, -1, FONT_BookHeadline);
					Doc_SetMargins	(nDocID, -1, 50, 50, 50, 50, 1);
					Doc_PrintLine	(nDocID,  0, ""													);
					Doc_PrintLine	(nDocID,  0, ""													);
					Doc_PrintLine	(nDocID,  0, ""													);
					Doc_PrintLine	(nDocID,  0, ""													);
					Doc_PrintLine	(nDocID,  0, ""													);
					Doc_SetFont		(nDocID,  0, FONT_Book);
					Doc_PrintLine	(nDocID,  0, "     Lampa vnáší svętlo "						);
					Doc_PrintLine	(nDocID,  0, "     do podzemí"						);
					Doc_PrintLine	(nDocID,  0, ""													);
					Doc_PrintLine	(nDocID,  0, ""													);
					Doc_PrintLine	(nDocID,  0, ""													);
					Doc_PrintLine	(nDocID,  0, ""													);
					Doc_PrintLine	(nDocID,  0, ""													);
					Doc_PrintLine	(nDocID,  0, ""													);
					Doc_PrintLine	(nDocID,  0, ""													);
					Doc_PrintLine	(nDocID,  0, ""													);
					Doc_PrintLine	(nDocID,  0, ""													);
					Doc_PrintLine	(nDocID,  0, ""													);
					Doc_SetMargins	(nDocID, -1, 200, 50, 50, 50, 1);
					Doc_Show		(nDocID);
		
}; 



//**********************************************************************************
//	ItWr_Seamap_Irdorath
//**********************************************************************************

INSTANCE ItWr_Seamap_Irdorath (C_Item)
{	
	name 					=	"Námoâní mapa k Irdoratskému ostrovu";
	
	mainflag 				=	ITEM_KAT_DOCS;
	flags 					=	ITEM_MISSION;

	value 					=	50;

	visual 					=	"ItWr_Map_01.3DS";
	material 				=	MAT_LEATHER;

	scemeName				=	"MAP";	
	on_state[0]				=	Use_Seamap_Irdorath;

	description				= name;
	TEXT[0]					= "";
	TEXT[1]					= "";
	TEXT[5]					= NAME_Value;
	COUNT[5]				= value;
};


FUNC VOID Use_Seamap_Irdorath ()
{
	var int nDocID;
	
	nDocID = 	Doc_CreateMap	()			  ;							// DocManager 
				Doc_SetPages	( nDocID, 1 );                         
				Doc_SetPage 	( nDocID, 0, "Map_NewWorld_Seamap.tga", 	1	);  //  1 -> DO NOT SCALE 
				Doc_Show		( nDocID 	);
	
	if  (MIS_ShipIsFree == FALSE)
		&& (Kapitel < 6)
	 	{
			B_Say (self, self, "$IRDORATHTHEREYOUARE");
		};
	
	if (MIS_SCKnowsWayToIrdorath == FALSE)
	{
		Log_CreateTopic (TOPIC_SHIP, LOG_MISSION);                                                                   
	    Log_SetTopicStatus(TOPIC_SHIP, LOG_RUNNING);                                                                 
	    B_LogEntry (TOPIC_SHIP,"Nejspíš se budu muset dostat na podivný ostrov našich nepâátel. K tomu budu ale potâebovat loë, posádku a kapitána.");
		B_GivePlayerXP (XP_SCKnowsWayToIrdorath);
	};

	MIS_SCKnowsWayToIrdorath  = TRUE;
};

//**********************************************************************
//	Gefälschter Brief von Lee zum benutzen des Schiffes
//**********************************************************************


INSTANCE ITWr_ForgedShipLetter_MIS	(C_Item)
{
	name 				=	"Lodní lístek";

	mainflag 			=	ITEM_KAT_DOCS;
	flags 				=	ITEM_MISSION;

	value 				=	50;

	visual 				=	"ItWr_Scroll_02.3DS";
	material 			=	MAT_LEATHER;
	on_state[0]			=   UseITWr_ForgedShipLetter_MIS;
	scemeName			=	"MAP";
	description			= 	name;
	TEXT[3]				=	"Plná moc";
	TEXT[4]				=   "pro paladinskou loë.";
};
func void UseITWr_ForgedShipLetter_MIS ()
{   
		var int nDocID;
		
//Joly:VORSICHT : Dieser Brief ist ein ERMÄCHTIGUNGSSCHREIBEN für das Schiff und kann von LEE oder dem Richter stammen. NICHT zwangsläufig von Lord Hagen oder gefälscht!!!!!!!!!

		nDocID = 	Doc_Create		();
					Doc_SetPages	(nDocID,  1);
					Doc_SetPage		(nDocID,  0, "letters.TGA", 0);
					Doc_SetFont		(nDocID, -1, FONT_BookHeadline);
					Doc_SetMargins	(nDocID, -1, 50, 50, 50, 50, 1);
					Doc_PrintLine	(nDocID,  0, ""													);
					Doc_PrintLine	(nDocID,  0, " Plná moc"							);
					Doc_PrintLine	(nDocID,  0, ""													);
					Doc_PrintLine	(nDocID,  0, ""													);
					Doc_PrintLine	(nDocID,  0, ""													);
					Doc_SetFont		(nDocID,  0, FONT_Book);
					Doc_PrintLine	(nDocID,  0, " Držitel tohoto dokumentu"					);
					Doc_PrintLine	(nDocID,  0, " se může po neomezenou dobu"		);
					Doc_PrintLine	(nDocID,  0, " na královské válečné galéâe volnę plavit,"		);
					Doc_PrintLine	(nDocID,  0, " kamkoliv uzná za vhodné."			);
					Doc_PrintLine	(nDocID,  0, ""													);
					Doc_PrintLine	(nDocID,  0, ""													);
					Doc_PrintLine	(nDocID,  0, ""													);
					Doc_PrintLine	(nDocID,  0, ""													);
					Doc_PrintLine	(nDocID,  0, "     Královská pečeă"							);
					Doc_PrintLine	(nDocID,  0, ""													);
					Doc_PrintLine	(nDocID,  0, ""													);
					Doc_PrintLine	(nDocID,  0, ""													);
					Doc_SetMargins	(nDocID, -1, 200, 50, 50, 50, 1);
					Doc_Show		(nDocID);
		
}; 

INSTANCE ITKE_OC_MAINGATE_MIS(C_Item)
{
	name 				=	"Klíč od vęže hlavní brány";

	mainflag 			=	ITEM_KAT_NONE;
	flags 				=	ITEM_MISSION;

	value 				=	Value_Key_01;

	visual 				=	"ItKe_Key_01.3ds";
	material 			=	MAT_METAL;

	description			= 	name;
	TEXT[5]				= 	NAME_Value;	COUNT[5]	= value;
};

INSTANCE ITKE_SHIP_LEVELCHANGE_MIS(C_Item)	//Joly: führt zum Levelchange Kapitel 6!!!!!!!!!!!!!!!!!!!!!!
{
	name 				=	"Klíč od kapitánské kajuty";

	mainflag 			=	ITEM_KAT_NONE;
	flags 				=	ITEM_MISSION;

	value 				=	Value_Key_03;

	visual 				=	"ItKe_Key_03.3ds";
	material 			=	MAT_METAL;

	description			= 	name;
	TEXT[5]				= 	NAME_Value;	COUNT[5]	= value;
};

INSTANCE ItPo_PotionOfDeath_01_Mis(C_Item)
{
	name 			=	NAME_Trank;

	mainflag 		=	ITEM_KAT_POTIONS;
	flags 			=	ITEM_MULTI;

	value 			=	10;	

	visual 			=	"ItMi_Flask.3ds";
	material 		=	MAT_GLAS;
	on_state[0]		=	UseItPo_PotionOfDeath;
	scemeName		=	"POTIONFAST";

	wear			= 	WEAR_EFFECT;
	effect			=	"SPELLFX_ITEMGLIMMER"; 

	description		= 	"Innosovy slzy";
	
	TEXT[1]			= 	"???";				
	COUNT[1]		= 	Mana_Essenz;
	
	TEXT[5]			= 	NAME_Value;					
	COUNT[5]		= 	value;

};

	FUNC VOID UseItPo_PotionOfDeath()
	{
		IF (hero.guild == GIL_KDF)
		{
 			Wld_PlayEffect("spellFX_LIGHTSTAR_BLUE",  hero, hero, 0, 0, 0, FALSE );
			Snd_Play ("SFX_HealObsession" );
			self.attribute[ATR_HITPOINTS] = self.attribute[ATR_HITPOINTS_MAX];		 
			self.attribute[ATR_MANA] = self.attribute[ATR_MANA_MAX];
			
			Npc_ChangeAttribute (self,	ATR_STRENGTH  	,5);
			self.aivar[REAL_STRENGTH] = self.aivar[REAL_STRENGTH] + 5;
			Npc_ChangeAttribute (self,	ATR_DEXTERITY  	,5);
			self.aivar[REAL_DEXTERITY] = self.aivar[REAL_DEXTERITY] + 5;
			
			PrintScreen	(PRINT_LearnSTR5, -1, 45, FONT_SCREEN, 2);
			PrintScreen	(PRINT_LearnDex5, -1, 55, FONT_SCREEN, 2);
			PrintScreen (PRINT_FullyHealed, - 1, 65, FONT_Screen, 2); 
			Mdl_ApplyOverlayMDSTimed	(self, "HUMANS_SPRINT.MDS", Time_Speed);
		}
		else
		{
			
												
			AI_Wait (hero,3);
			AI_PlayAni (self, "S_FIRE_VICTIM"); 
			Wld_PlayEffect("VOB_MAGICBURN",  hero, hero, 0, 0, 0, FALSE );
			B_Say (self,self, "$Dead");
			AI_StopFX	(self, "VOB_MAGICBURN");
			Npc_ChangeAttribute	(self,ATR_HITPOINTS,-self.attribute[ATR_HITPOINTS_MAX]);	
			NPC_StopAni (self,"S_FIRE_VICTIM");
			
			
		};
	};
	

	
INSTANCE ItPo_PotionOfDeath_02_Mis(C_Item)
{
	name 			=	NAME_Trank;

	mainflag 		=	ITEM_KAT_POTIONS;
	flags 			=	ITEM_MULTI;

	value 			=	10;	

	visual 			=	"ItMi_Flask.3ds";
	material 		=	MAT_GLAS;
	on_state[0]		=	UseItPo_PotionOfDeath;
	scemeName		=	"POTIONFAST";

	wear			= 	WEAR_EFFECT;
	effect			=	"SPELLFX_ITEMGLIMMER"; 

	description		= 	"Innosovy slzy";
	TEXT[1]			= 	"Tento lektvar propůjčí mágům ohnę zvláštní moc.";
	Text[2]			=   "Tomu, kdo k nim nepatâí, pâinese leda smrt.";
	
	TEXT[5]			= 	NAME_Value;					
	COUNT[5]		= 	value;

};

//************************************************
//	Amulett des Todes
//************************************************

INSTANCE  ItAm_AmulettOfDeath_Mis(C_Item)
{
	name 			=	"Božská Innosova aura.";

	mainflag 		=	ITEM_KAT_MAGIC;
	flags 			=	ITEM_AMULET;

	value 			=	1000;

	visual 			=	"ItAm_Prot_Fire_01.3ds";

	visual_skin 	=	0;
	material 		=	MAT_METAL;
	on_equip		=	Equip_ItAm_AmulettOfDeath_Mis;
	on_unequip		=	UnEquip_ItAm_AmulettOfDeath_Mis;

	wear			= 	WEAR_EFFECT;
	effect			=	"SPELLFX_ITEMGLIMMER"; 

	description		= "Božská Innosova aura.";
	
	TEXT[2]			= "Tento amulet chrání svého nositele ";
	TEXT[3]			= "pâed veškerou újmou.";
	TEXT[5]			= NAME_Value;
	COUNT[5]		= value;
	
	INV_ZBIAS				= INVCAM_ENTF_AMULETTE_STANDARD;
	
};

	FUNC VOID Equip_ItAm_AmulettOfDeath_Mis()
	{
	 	self.protection [PROT_EDGE]   += 30;
		self.protection [PROT_BLUNT]  += 30;
		self.protection [PROT_POINT]  += 30;
		self.protection [PROT_FIRE]   += 30;
		self.protection [PROT_MAGIC]  += 30;
		Wld_PlayEffect("spellFX_LIGHTSTAR_WHITE",  self, self, 0, 0, 0, FALSE );
		Wld_PlayEffect("FX_EarthQuake",  self, self, 0, 0, 0, FALSE );
		Wld_PlayEffect("spellFX_INCOVATION_WHITE",  self, self, 0, 0, 0, FALSE );
		AI_PlayAni (self,"T_MAGRUN_2_HEASHOOT");	
		AI_StandUp (self);
		Snd_Play ("MFX_FIRERAIN_INVEST"); 
	};

	FUNC VOID UnEquip_ItAm_AmulettOfDeath_Mis()
	{
		self.protection [PROT_EDGE]   -= 30;
		self.protection [PROT_BLUNT]  -= 30;
		self.protection [PROT_POINT]  -= 30;
		self.protection [PROT_FIRE]   -= 30;
		self.protection [PROT_MAGIC]  -= 30;
	};
	
/******************************************************************************************/
//	Heiltrank für Randolph																	//
/******************************************************************************************/
INSTANCE ItPo_HealRandolph_MIS(C_Item)
{
	name 			=	NAME_Trank;

	mainflag 		=	ITEM_KAT_POTIONS;
	flags 			=	ITEM_MULTI|ITEM_MISSION;

	value 			=	Value_HpEssenz;	

	visual 			=	"ItMi_Flask.3ds";
	material 		=	MAT_GLAS;
	on_state[0]		=	Use_HealRandolph;
	scemeName		=	"POTIONFAST";

	wear			= 	WEAR_EFFECT;
	effect			=	"SPELLFX_ITEMGLIMMER"; 

	description		= 	"Lék proti závislosti";
	
	TEXT[1]			= 	NAME_Bonus_HP;				
	COUNT[1]		= 	HP_Essenz;
	
	TEXT[5]			= 	NAME_Value;					
	COUNT[5]		= 	Value_HpEssenz;
};

	FUNC VOID Use_HealRandolph()
	{
		Npc_ChangeAttribute	(self,	ATR_HITPOINTS,	HP_Essenz);
	};	
