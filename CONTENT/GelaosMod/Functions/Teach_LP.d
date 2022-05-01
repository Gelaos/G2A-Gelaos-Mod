const string TEACH_SPINNER_ID_LP    = "Teach_LP";
const string TEACH_LP_CANT_BUY      = "Not enough XP";
const string TEACH_LP_DIA_DESC      = "Buy Learning Points: ";

var int spinnerLPActive;
var int spinnerLPMin;
var int spinnerLPMax;
var int spinnerLPValue;

var string spinnerLPDescription;
var string availableXPStr;
var string xpCostSelectedStr;
var string spinnerLPValueStr;

var string lastSpinnerLPID;

// -----------------------------------------------------

func void Teach_LP_Spinner_Setup() {
    // set range
    GetLP_CostAndCount(BuyedLPs, -1, hero.exp - SpentXP); // how many LPs at most can player buy and for what XP cost? 
    spinnerLPMax = LP_CostAndCount[LP_COUNT];    
    spinnerLPMin = iif(spinnerLPMax >= 1, 1, 0); // if max >= 1, set min to 1, otherwise to 0

    // check boundaries
    if (spinnerLPValue < spinnerLPMin) { spinnerLPValue = spinnerLPMin; };
    if (spinnerLPValue > spinnerLPMax) { spinnerLPValue = spinnerLPMax; };

    spinnerLPActive = Hlp_StrCmp (InfoManagerSpinnerID, TEACH_SPINNER_ID_LP);

    // setup spinner
    if (spinnerLPActive) {
        // setup spinner value if spinner ID has changed
        if (!Hlp_StrCmp (InfoManagerSpinnerID, lastSpinnerLPID)) {
            InfoManagerSpinnerValue = spinnerLPValue;
        };
        
        // check InfoManagerSpinnerValue, just in case...
        if (InfoManagerSpinnerValue <  spinnerLPMin) {
            InfoManagerSpinnerValue = spinnerLPMin;
        };
        if (InfoManagerSpinnerValue > spinnerLPMax) {
            InfoManagerSpinnerValue = spinnerLPMax;
        };
        
        InfoManagerSpinnerPageSize = 1; // page Up/Down quantities         
        InfoManagerSpinnerValueMin = spinnerLPMin; // min/max values (Home/End keys)
        InfoManagerSpinnerValueMax = spinnerLPMax;

        spinnerLPValue = InfoManagerSpinnerValue; // update value
    };    

    availableXPStr = IntToString(hero.exp - SpentXP);    

    // update spinner description
    // not enough XP to buy LP
    if (spinnerLPMax < 1) {
        var string currentXP; currentXP = IntToString(hero.exp - SpentXP);
        var string requiredXP; requiredXP = IntToString(GetPriceNthLP(BuyedLPs));
        
        spinnerLPDescription = ConcatStrings13(
            DIA_SPINNER, TEACH_SPINNER_ID_LP, " ", TEACH_LP_DIA_DESC, 
            DIA_FORMAT_START, DIA_COLOR_RED, 
                TEACH_LP_CANT_BUY,  "  (", currentXP, " / ", requiredXP, " XP)", 
            DIA_FORMAT_END
        );     
    }
    // enough XP to buy LP
    else {
        // get XP cost for given LP amount
        GetLP_CostAndCount(BuyedLPs, spinnerLPValue, hero.exp - SpentXP);
        
        spinnerLPValueStr = IntToString (spinnerLPValue);
        xpCostSelectedStr = IntToString(LP_CostAndCount[LP_COST]);    
        
        spinnerLPDescription = ConcatStrings12(
            DIA_SPINNER, TEACH_SPINNER_ID_LP,  " ",  TEACH_LP_DIA_DESC, 
            spinnerLPValueStr,  " / ",  IntToString (spinnerLPMax), 
            "  (",  xpCostSelectedStr,  " / ", availableXPStr, " XP)" 
        );
    };    
    
    InfoManager_SetInfoChoiceText_BySpinnerID (spinnerLPDescription, TEACH_SPINNER_ID_LP);

    lastSpinnerLPID = InfoManagerSpinnerID;
};

// -----------------------------------------------------

func void Teach_LP() {
    if (spinnerLPValue <= 0 || InfoManagerSpinnerValue < 0) {
        return; 
    };

    // buy LPs
    GetLP_CostAndCount(BuyedLPs, spinnerLPValue, hero.exp - SpentXP); // get cost for LPs
    hero.LP  += spinnerLPValue;
    BuyedLPs += spinnerLPValue;    
    SpentXP  += LP_CostAndCount[LP_COST];

    // print message    
    var string message; message = "";
    message = ConcatStrings(PRINT_LearnLP, IntToString(spinnerLPValue));
    PrintScreen (message, -1, YPOS_LevelUp, FONT_Screen, 5);
};

// -----------------------------------------------------

