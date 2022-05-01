const int TEACH_ATTR_DEFAULT_MIN = 0;
const int TEACH_ATTR_DEFAULT_MAX = 1000;

const string TEACH_SPINNER_ID_STR   = "Teach_STR";
const string TEACH_SPINNER_ID_DEX   = "Teach_DEX";
const string TEACH_SPINNER_ID_1H    = "Teach_1H";
const string TEACH_SPINNER_ID_2H    = "Teach_2H";
const string TEACH_SPINNER_ID_BOW   = "Teach_BOW";
const string TEACH_SPINNER_ID_CBOW  = "Teach_CBOW";
const string TEACH_SPINNER_ID_MP    = "Teach_MP";
const string TEACH_SPINNER_ID_HP    = "Teach_HP";

const string TEACH_ATTR_NOT_ENOUGH_LP = "Not enough LP";
const string TEACH_STR_DIA_DESC       = "Strength:       ";
const string TEACH_DEX_DIA_DESC       = "Dexterity:      ";
const string TEACH_1H_DIA_DESC        = "One-handed:    ";
const string TEACH_2H_DIA_DESC        = "Two-handed:    ";
const string TEACH_BOW_DIA_DESC       = "Bow:           ";
const string TEACH_CBOW_DIA_DESC      = "Crossbow:      ";
const string TEACH_MP_DIA_DESC        = "Mana:          ";
const string TEACH_HP_DIA_DESC        = "Health:        ";

const string TEACH_DIA_DESC = "(Learn)";

const int TEACH_ATTRIBUTE_STATUS_NOK = 0;
const int TEACH_ATTRIBUTE_STATUS_OK = 1;

const int START_HP      = 40;
const int START_MP      = 10;

const int TEACH_STR     = 0;  
const int TEACH_DEX     = 1;  
const int TEACH_1H      = 2;  
const int TEACH_2H      = 3;  
const int TEACH_BOW     = 4;  
const int TEACH_CBOW    = 5;  
const int TEACH_MP      = 6;  
const int TEACH_HP      = 7;  
const int TEACH_ATTRIBUTES_COUNT = 8; 

var int teachingFlags;

var int Teach_Attribute_SpinnerMin      [TEACH_ATTRIBUTES_COUNT];
var int Teach_Attribute_SpinnerMax      [TEACH_ATTRIBUTES_COUNT];
var int Teach_Attribute_CurrentValue    [TEACH_ATTRIBUTES_COUNT];
var int Teach_Attribute_SpinnerValue    [TEACH_ATTRIBUTES_COUNT];
var int Teach_Attribute_Status          [TEACH_ATTRIBUTES_COUNT];
var int Teach_Attribute_SpinnerReset    [TEACH_ATTRIBUTES_COUNT];
var int Teach_Attribute_TeacherMin      [TEACH_ATTRIBUTES_COUNT];
var int Teach_Attribute_TeacherMax      [TEACH_ATTRIBUTES_COUNT];

var int attributeCostLP;
var int attributeCostGold;
var int availableGold; 

var string attributeCostLPStr;
var string attributeCostGoldStr; 
var string availableGoldStr;
var string dialogueFullDescription;
var string attributeDialogueDescription;
var string attributeMaxStr; 
var string attributeValueStr; 

// ------------------------------------------
// Teach_SetRange()
// sets the teaching range of given attribute
func void Teach_SetRange(var int attributeType, var int min, var int max) {
    MEM_WriteStatArr(Teach_Attribute_TeacherMin, attributeType, min);
    MEM_WriteStatArr(Teach_Attribute_TeacherMax, attributeType, max);
};

// ------------------------------------------
// Teach_Setup()
// Sets which teaching is enabled and initializes default teaching range. 
func void Teach_Setup(var int flags) {
    teachingFlags = flags;

    Teach_SetRange ( TEACH_STR , TEACH_ATTR_DEFAULT_MIN, TEACH_ATTR_DEFAULT_MAX);
    Teach_SetRange ( TEACH_DEX , TEACH_ATTR_DEFAULT_MIN, TEACH_ATTR_DEFAULT_MAX);    
    Teach_SetRange ( TEACH_MP  , TEACH_ATTR_DEFAULT_MIN, TEACH_ATTR_DEFAULT_MAX);
    Teach_SetRange ( TEACH_HP  , TEACH_ATTR_DEFAULT_MIN, TEACH_ATTR_DEFAULT_MAX);
    Teach_SetRange ( TEACH_1H  , TEACH_ATTR_DEFAULT_MIN, 100);
    Teach_SetRange ( TEACH_2H  , TEACH_ATTR_DEFAULT_MIN, 100);
    Teach_SetRange ( TEACH_BOW , TEACH_ATTR_DEFAULT_MIN, 100);
    Teach_SetRange ( TEACH_CBOW, TEACH_ATTR_DEFAULT_MIN, 100);  
};

// ------------------------------------------
// Get_Attribute_SpinnerID()
// returns string with spinner ID for given attribute
func string Get_Attribute_SpinnerID (var int attributeType) {
    var string id; id = "";

    if      ( attributeType == TEACH_STR  )   { id = TEACH_SPINNER_ID_STR;  }
    else if ( attributeType == TEACH_DEX  )   { id = TEACH_SPINNER_ID_DEX;  }
    else if ( attributeType == TEACH_1H   )   { id = TEACH_SPINNER_ID_1H;   }
    else if ( attributeType == TEACH_2H   )   { id = TEACH_SPINNER_ID_2H;   }
    else if ( attributeType == TEACH_BOW  )   { id = TEACH_SPINNER_ID_BOW;  }
    else if ( attributeType == TEACH_CBOW )   { id = TEACH_SPINNER_ID_CBOW; }
    else if ( attributeType == TEACH_MP   )   { id = TEACH_SPINNER_ID_MP;   }
    else if ( attributeType == TEACH_HP   )   { id = TEACH_SPINNER_ID_HP;   };

    return id;
};

// ------------------------------------------
// Get_Attribute_Teach_DialogueDescription()
// returns string with dialogue description for given attribute
func string Get_Attribute_Teach_DialogueDescription (var int attributeType) {
    var string desc; desc = "";

    if      ( attributeType == TEACH_STR  )   { desc = TEACH_STR_DIA_DESC;  }
    else if ( attributeType == TEACH_DEX  )   { desc = TEACH_DEX_DIA_DESC;  }
    else if ( attributeType == TEACH_1H   )   { desc = TEACH_1H_DIA_DESC;   }
    else if ( attributeType == TEACH_2H   )   { desc = TEACH_2H_DIA_DESC;   }
    else if ( attributeType == TEACH_BOW  )   { desc = TEACH_BOW_DIA_DESC;  }
    else if ( attributeType == TEACH_CBOW )   { desc = TEACH_CBOW_DIA_DESC; }
    else if ( attributeType == TEACH_MP   )   { desc = TEACH_MP_DIA_DESC;   }
    else if ( attributeType == TEACH_HP   )   { desc = TEACH_HP_DIA_DESC;   };

    return desc;
};

// ------------------------------------------
// Get_Attribute_CurrentValue()
// returns the current value of given attribute
func int Get_Attribute_CurrentValue (var int attributeType) {
    var int currentValue;

    if      ( attributeType == TEACH_STR  )   { currentValue = hero.aivar[REAL_STRENGTH];       }
    else if ( attributeType == TEACH_DEX  )   { currentValue = hero.aivar[REAL_DEXTERITY];      }
    else if ( attributeType == TEACH_1H   )   { currentValue = hero.aivar[REAL_TALENT_1H];      }
    else if ( attributeType == TEACH_2H   )   { currentValue = hero.aivar[REAL_TALENT_2H];      }
    else if ( attributeType == TEACH_BOW  )   { currentValue = hero.aivar[REAL_TALENT_BOW];     }
    else if ( attributeType == TEACH_CBOW )   { currentValue = hero.aivar[REAL_TALENT_CROSSBOW];}
    else if ( attributeType == TEACH_MP   )   { currentValue = START_MP + Attribute_Real_MP;    }
    else if ( attributeType == TEACH_HP   )   { currentValue = START_HP + Learned_HP;           };

    return currentValue;
};

// ------------------------------------------
// Get_Attribute_Cost_LP()
// returns LP cost for given current and target value
func int Get_Attribute_Cost_LP(var int attributeType, var int currentValue, var int targetValue) {
    return (targetValue - currentValue); // attributes LP costs are fixed: 1 point = 1 LP
};

// ------------------------------------------
// Get_Attribute_Count()
// returns count of attribute points that the player can have for LP amount
func int Get_Attribute_Count(var int attributeType, var int currentValue, var int LP) {
    var int attributePoints; attributePoints = 0;
    var int budgetLP; budgetLP = LP;
    var int costLP; costLP = Get_Attribute_Cost_LP(attributeType, currentValue, currentValue + 1);

    while (budgetLP >= costLP);
        attributePoints += 1;
        budgetLP -= costLP;
        costLP = Get_Attribute_Cost_LP(attributeType, currentValue + attributePoints, currentValue + attributePoints + 1);
    end;

    return attributePoints;
};

// ------------------------------------------
// Attributes cost = sum from current up to target attribute level
// i.e. raising STR from 18 to 21 will cost (19 + 20 + 21) = 60 gold
func int Get_Attribute_Cost_Gold (var int attributeType, var int currentValue, var int targetValue) {
    var int goldCost; goldCost = 0;
    var int value; value = currentValue + 1;    

    if (attributeType != TEACH_HP) 
    {        
        while (value <= targetValue);
            goldCost += value;
            value += 1;
        end;    
    };    

    return goldCost;
};

// -----------------------------------------------------
// Teach_IsAvailable()
func int Teach_IsAvailable (var int attributeType) {
//    var string msg; msg = "";
//    if (attributeType == TEACH_STR) {
//        if (( teachingFlags & attributeType )) { msg = ConcatStrings(msg, "1"); }
//        else { msg = ConcatStrings(msg, "0"); };
//
//        if (Get_Attribute_CurrentValue(attributeType) >= MEM_ReadStatArr(Teach_Attribute_TeacherMin, attributeType)) { msg = ConcatStrings(msg, "1"); }
//        else { msg = ConcatStrings(msg, "0"); };
//
//        if (Get_Attribute_CurrentValue(attributeType) < MEM_ReadStatArr(Teach_Attribute_TeacherMax, attributeType)) { msg = ConcatStrings(msg, "1"); }
//        else { msg = ConcatStrings(msg, "0"); };
//    };
//
//    PrintScreen	(msg, -1, -1, FONT_SCREEN, 5);

    return (
        ( teachingFlags & 1 << attributeType ) // is teaching enabled?
        // is player's attribute in teacher's range?
        && Get_Attribute_CurrentValue(attributeType) >= MEM_ReadStatArr(Teach_Attribute_TeacherMin, attributeType)
        && Get_Attribute_CurrentValue(attributeType) < MEM_ReadStatArr(Teach_Attribute_TeacherMax, attributeType)
    );
};

// ------------------------------------------
// Teach_Attribute_Spinner_Setup()
// handles spinner for given attribute
//
// At first the range is checked (including teacher's maximum) so that the spinner value is correct.
// Then the spinner itself is set up.
// Then the dialogue description is updated & teaching status is set (prevents accidental teaching).
func void Teach_Attribute_Spinner_Setup (var int attributeType) {

    MEM_WriteStatArr(Teach_Attribute_CurrentValue, attributeType, Get_Attribute_CurrentValue(attributeType));

    // set range
    MEM_WriteStatArr(Teach_Attribute_SpinnerMax, attributeType, Get_Attribute_Count(attributeType, MEM_ReadStatArr(Teach_Attribute_CurrentValue, attributeType), hero.LP));
    MEM_WriteStatArr(Teach_Attribute_SpinnerMin, attributeType,  iif(MEM_ReadStatArr(Teach_Attribute_SpinnerMax, attributeType) > 0,  1, 0));

    // check teacher's maximum
    if (MEM_ReadStatArr(Teach_Attribute_CurrentValue, attributeType) + MEM_ReadStatArr(Teach_Attribute_SpinnerMax, attributeType) > MEM_ReadStatArr(Teach_Attribute_TeacherMax, attributeType)) {
        // change teaching range maximum so that teacher's range isn't exceeded
        MEM_WriteStatArr(Teach_Attribute_SpinnerMax, attributeType, MEM_ReadStatArr(Teach_Attribute_TeacherMax, attributeType) - MEM_ReadStatArr(Teach_Attribute_CurrentValue, attributeType));
    };

    // check range
    if (MEM_ReadStatArr(Teach_Attribute_SpinnerValue, attributeType) < MEM_ReadStatArr(Teach_Attribute_SpinnerMin, attributeType)) {
        MEM_WriteStatArr(Teach_Attribute_SpinnerValue, attributeType, MEM_ReadStatArr(Teach_Attribute_SpinnerMin, attributeType));
    };
    if (MEM_ReadStatArr(Teach_Attribute_SpinnerValue, attributeType) > MEM_ReadStatArr(Teach_Attribute_SpinnerMax, attributeType)) {
        MEM_WriteStatArr(Teach_Attribute_SpinnerValue, attributeType, MEM_ReadStatArr(Teach_Attribute_SpinnerMax, attributeType));
    };

    // ----------------------    

    var string idStr; idStr = Get_Attribute_SpinnerID(attributeType);

    // setup spinner
    if (Hlp_StrCmp (InfoManagerSpinnerID, idStr)) {
        // setup spinner value if spinner ID has changed        
        if (MEM_ReadStatArr(Teach_Attribute_SpinnerReset, attributeType)) {
            InfoManagerSpinnerValue = MEM_ReadStatArr(Teach_Attribute_SpinnerValue, attributeType);
            MEM_WriteStatArr(Teach_Attribute_SpinnerReset, attributeType, false);
        };

        // check InfoManagerSpinnerValue, just in case...
        if (InfoManagerSpinnerValue <  MEM_ReadStatArr(Teach_Attribute_SpinnerMin, attributeType)) {
            InfoManagerSpinnerValue = MEM_ReadStatArr(Teach_Attribute_SpinnerMin, attributeType);
        };
        if (InfoManagerSpinnerValue > MEM_ReadStatArr(Teach_Attribute_SpinnerMax, attributeType)) {
            InfoManagerSpinnerValue = MEM_ReadStatArr(Teach_Attribute_SpinnerMax, attributeType);
        };
        
        InfoManagerSpinnerPageSize = 1; // page Up/Down quantities
        InfoManagerSpinnerValueMin = MEM_ReadStatArr(Teach_Attribute_SpinnerMin, attributeType); // min/max values (Home/End keys)
        InfoManagerSpinnerValueMax = MEM_ReadStatArr(Teach_Attribute_SpinnerMax, attributeType);

        MEM_WriteStatArr(Teach_Attribute_SpinnerValue, attributeType, InfoManagerSpinnerValue); // update value
    }
    else { MEM_WriteStatArr(Teach_Attribute_SpinnerReset, attributeType, true); };

    // ----------------------
    // set dialogue description

    attributeDialogueDescription = Get_Attribute_Teach_DialogueDescription(attributeType);

    // not enough LPs
    if (MEM_ReadStatArr(Teach_Attribute_SpinnerMax, attributeType) < 1) {
        MEM_WriteStatArr(Teach_Attribute_Status, attributeType,TEACH_ATTRIBUTE_STATUS_NOK);

        attributeCostLP = Get_Attribute_Cost_LP(attributeType, MEM_ReadStatArr(Teach_Attribute_CurrentValue, attributeType), 1 + MEM_ReadStatArr(Teach_Attribute_CurrentValue, attributeType));
        attributeCostLPStr = IntToString(attributeCostLP);

        dialogueFullDescription = ConcatStrings13(
            DIA_SPINNER, idStr, " ", attributeDialogueDescription,
            DIA_FORMAT_START, DIA_COLOR_RED,
                TEACH_ATTR_NOT_ENOUGH_LP, "  (", IntToString(hero.LP), " / ", attributeCostLPStr, " LP)", 
            DIA_FORMAT_END
        );
    }
    // enough LPs
    else {        
        availableGold = Npc_HasItems(hero, itmi_gold);
        attributeCostGold = Get_Attribute_Cost_Gold(attributeType, MEM_ReadStatArr(Teach_Attribute_CurrentValue, attributeType), MEM_ReadStatArr(Teach_Attribute_CurrentValue, attributeType) + MEM_ReadStatArr(Teach_Attribute_SpinnerValue, attributeType));        
        attributeCostLP = Get_Attribute_Cost_LP(attributeType, MEM_ReadStatArr(Teach_Attribute_CurrentValue, attributeType), MEM_ReadStatArr(Teach_Attribute_CurrentValue, attributeType) + MEM_ReadStatArr(Teach_Attribute_SpinnerValue, attributeType));
        attributeCostLPStr = IntToString(attributeCostLP);
        
        availableGoldStr = IntToString(availableGold);
        attributeCostGoldStr = IntToString(attributeCostGold);
        attributeMaxStr = IntToString(MEM_ReadStatArr(Teach_Attribute_SpinnerMax, attributeType));
        attributeValueStr = IntToString(MEM_ReadStatArr(Teach_Attribute_SpinnerValue, attributeType));        

        // not enough gold
        if (availableGold < attributeCostGold) {
            MEM_WriteStatArr(Teach_Attribute_Status, attributeType,TEACH_ATTRIBUTE_STATUS_NOK);

            dialogueFullDescription = ConcatStrings18(
                DIA_SPINNER, idStr, " ", attributeDialogueDescription,
                attributeValueStr, " / ", attributeMaxStr, 
                " (Total LP: ", attributeCostLPStr, ",",
                DIA_FORMAT_START, DIA_COLOR_RED,                    
                     "Total Gold: ", availableGoldStr, " / " , attributeCostGoldStr,                     
                ")", 
                DIA_FORMAT_END
            );            
        }        
        // enough gold & LPs
        else {
            MEM_WriteStatArr(Teach_Attribute_Status, attributeType,TEACH_ATTRIBUTE_STATUS_OK);

            dialogueFullDescription = ConcatStrings12(
                DIA_SPINNER, idStr, " ", attributeDialogueDescription,
                attributeValueStr, " / ", attributeMaxStr, 
                " (Total LP: ", attributeCostLPStr, ", Gold: ", attributeCostGoldStr, ")"
            );
        };
    };    

    // ----------------------
    // update description
    InfoManager_SetInfoChoiceText_BySpinnerID (dialogueFullDescription, idStr);
};

// ------------------------------------------
// Teach_Combat_SetFightAnimation()
// sets fight animation of given attribute acccording to its level
func void Teach_Combat_SetFightAnimation(var int combatType, var int percent) {
    if (combatType == TEACH_1H) {
		if (hero.HitChance[NPC_TALENT_1H] >=0)	        {	Npc_SetTalentSkill (hero, NPC_TALENT_1H, 0);	};
		if (hero.HitChance[NPC_TALENT_1H] >=30)	        {	Npc_SetTalentSkill (hero, NPC_TALENT_1H, 1);	};
		if (hero.HitChance[NPC_TALENT_1H] >=60)	        {	Npc_SetTalentSkill (hero, NPC_TALENT_1H, 2);	};
	};
	
	if (combatType == TEACH_2H) {
		if (hero.HitChance[NPC_TALENT_1H] >=0)	        {	Npc_SetTalentSkill (hero, NPC_TALENT_2H, 0);	};
		if (hero.HitChance[NPC_TALENT_2H] >=30)	        {	Npc_SetTalentSkill (hero, NPC_TALENT_2H, 1);	};
		if (hero.HitChance[NPC_TALENT_2H] >=60)	        {	Npc_SetTalentSkill (hero, NPC_TALENT_2H, 2);	};
	};
	
	if (combatType == TEACH_BOW) {		
		if (hero.HitChance[NPC_TALENT_BOW] >=0)         {	Npc_SetTalentSkill (hero, NPC_TALENT_BOW, 0);	};
		if (hero.HitChance[NPC_TALENT_BOW] >=30)	    {	Npc_SetTalentSkill (hero, NPC_TALENT_BOW, 1);	};
		if (hero.HitChance[NPC_TALENT_BOW] >=60)        {	Npc_SetTalentSkill (hero, NPC_TALENT_BOW, 2);	};
	};
	
	if (combatType == TEACH_CBOW) {	
		if (hero.HitChance[NPC_TALENT_CROSSBOW] >=0)    {	Npc_SetTalentSkill (hero, NPC_TALENT_CROSSBOW, 0);	};
		if (hero.HitChance[NPC_TALENT_CROSSBOW] >=30)   {	Npc_SetTalentSkill (hero, NPC_TALENT_CROSSBOW, 1);	};
		if (hero.HitChance[NPC_TALENT_CROSSBOW] >=60)   {	Npc_SetTalentSkill (hero, NPC_TALENT_CROSSBOW, 2);	};
	};
};
// ------------------------------------------

func void Teach (var int attributeType) {
    // prevent accidental learning
    if (MEM_ReadStatArr(Teach_Attribute_Status, attributeType) != TEACH_ATTRIBUTE_STATUS_OK) { 
        return; 
    };
    
    var int currentValue; currentValue = MEM_ReadStatArr(Teach_Attribute_CurrentValue, attributeType);
    var int targetValue; targetValue = currentValue + MEM_ReadStatArr(Teach_Attribute_SpinnerValue, attributeType);
    var int points; points = targetValue - currentValue;
    var int costGold; costGold = Get_Attribute_Cost_Gold(attributeType, currentValue, targetValue);
    var int costLP; costLP = Get_Attribute_Cost_LP(attributeType, currentValue, targetValue);
    var string message;

    if (attributeType == TEACH_STR) {
        hero.attribute  [ATR_STRENGTH ] += points;
        hero.aivar      [REAL_STRENGTH] += points;        
        
        message = PRINT_LearnSTR;
    }
    // -------------------------------------------------
    else if (attributeType == TEACH_DEX) {
        hero.attribute  [ATR_DEXTERITY ] += points;
        hero.aivar      [REAL_DEXTERITY] += points;        
        
        message = PRINT_LearnDEX;
    }
    // -------------------------------------------------
    else if (attributeType == TEACH_1H) {
        hero.aivar[REAL_TALENT_1H] += points;
        hero.HitChance[NPC_TALENT_1H] += points;   
        
        Teach_Combat_SetFightAnimation(TEACH_1H, hero.HitChance[NPC_TALENT_1H]); 
        
        message = "";
    }
    // -------------------------------------------------
    else if (attributeType == TEACH_2H) {
        hero.aivar[REAL_TALENT_2H] += points;
        hero.HitChance[NPC_TALENT_2H] += points;    

        Teach_Combat_SetFightAnimation(TEACH_2H, hero.HitChance[NPC_TALENT_2H]); 
        
        message = PRINT_Learn2H;
    }
    // -------------------------------------------------
    else if (attributeType == TEACH_BOW) {
        hero.aivar[REAL_TALENT_BOW] += points;
        hero.HitChance[NPC_TALENT_BOW] += points;    

        Teach_Combat_SetFightAnimation(TEACH_BOW, hero.HitChance[NPC_TALENT_BOW]); 
        
        message = PRINT_LearnBow;
    }
    // -------------------------------------------------
    else if (attributeType == TEACH_CBOW) {
        hero.aivar[REAL_TALENT_CROSSBOW] += points;
        hero.HitChance[NPC_TALENT_CROSSBOW] += points;    

        Teach_Combat_SetFightAnimation(TEACH_CBOW, hero.HitChance[NPC_TALENT_CROSSBOW]); 
        
        message = PRINT_LearnCrossbow;
    }
    // -------------------------------------------------
    else if (attributeType == TEACH_MP) {
        hero.attribute[ATR_MANA] += points;
        hero.attribute[ATR_MANA_MAX] += points;
        
        Attribute_Real_MP += points;
        message = PRINT_LearnMANA_MAX;         
    };
			
    Npc_RemoveInvItems  (hero, ItMi_Gold, costGold);
    hero.LP -= costLP;
    PrintScreen	(ConcatStrings(message, IntToString(points)), -1, -1, FONT_SCREEN, 2);
};

// ------------------------------------------




