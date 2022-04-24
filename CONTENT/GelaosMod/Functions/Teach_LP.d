var string lastSpinnerID;
var int spinnerLPMin;
var int spinnerLPMax;
var int spinnerLPActive;
var string spinnerLPDescription;
var int spinnerLPValue;
const string TEACH_LP_SPINNER_ID = "Teach_LP";

// -----------------------------------------------------

func void Teach_LP_Spinner_Setup() {
    // set range
    GetLP_CostAndCount(BuyedLPs, -1, hero.exp - SpentXP); // how many LPs at most can player buy and for what XP cost? 
    spinnerLPMin = 0;
    spinnerLPMax = LP_CostAndCount[LP_COUNT];

    // check boundaries
    if (spinnerLPValue < spinnerLPMin) { spinnerLPValue = spinnerLPMin; };
    if (spinnerLPValue > spinnerLPMax) { spinnerLPValue = spinnerLPMax; };

    spinnerLPActive = Hlp_StrCmp (InfoManagerSpinnerID, TEACH_LP_SPINNER_ID);

    // setup spinner
    if (spinnerLPActive) {
        // setup spinner value if spinner ID has changed
        if (!Hlp_StrCmp (InfoManagerSpinnerID, lastSpinnerID)) {
            InfoManagerSpinnerValue = spinnerLPMin;
        };
        
        InfoManagerSpinnerPageSize = 1; // page Up/Down quantities         
        InfoManagerSpinnerValueMin = spinnerLPMin; // min/max values (Home/End keys)
        InfoManagerSpinnerValueMax = spinnerLPMax;

        spinnerLPValue = InfoManagerSpinnerValue; // update value
    };    

    // update spinner description
    var string spinnerLPValueStr; spinnerLPValueStr = IntToString (spinnerLPValue);
    spinnerLPDescription = ConcatStrings7("s@", TEACH_LP_SPINNER_ID, " ", TEACH_LP_DIA_DESC, spinnerLPValueStr, " / ", IntToString (spinnerLPMax));
    InfoManager_SetInfoChoiceText_BySpinnerID (spinnerLPDescription, TEACH_LP_SPINNER_ID);

    lastSpinnerID = InfoManagerSpinnerID;
};

// -----------------------------------------------------

func void Teach_LP() {
    if (spinnerLPValue <= 0) {
        // no LPs can be bought
        if (LP_CostAndCount[LP_COUNT] <= 0) {
            PrintScreen (TEACH_LP_CANT_BUY, -1, YPOS_LevelUp, FONT_Screen, 5);
        };
        return; 
    };

    // buy LPs
    GetLP_CostAndCount(BuyedLPs, spinnerLPValue, hero.exp - SpentXP); // get cost for LPs
    hero.LP  += spinnerLPValue;
    BuyedLPs += spinnerLPValue;    
    SpentXP  += LP_CostAndCount[LP_COST];

    // print message    
    var string message; message = "";
    message = ConcatStrings(TEACH_LP_BOUGHT_MSG, IntToString(spinnerLPValue));
    PrintScreen (message, -1, YPOS_LevelUp, FONT_Screen, 5);
};

// -----------------------------------------------------

