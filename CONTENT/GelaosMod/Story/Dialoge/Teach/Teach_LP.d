var string lastSpinnerID;
var int spinnerLPMin;
var int spinnerLPMax;
var int spinnerLPActive;
var string spinnerLPDescription;
var string editedNumber;
var int spinnerLPValue;

func void Teach_LP_Spinner_Setup() {
    // set range
    GetLP_CostAndCount(BuyedLPs, 9999, hero.exp - SpentXP); // how many LPs at most can player buy and for what XP cost? 
    spinnerLPMin = 0;
    spinnerLPMax = LP_CostAndCount[LP_COUNT];

    // check boundaries
    if (spinnerLPValue < spinnerLPMin) { spinnerLPValue = spinnerLPMin; };
    if (spinnerLPValue > spinnerLPMax) { spinnerLPValue = spinnerLPMax; };

    spinnerLPActive = Hlp_StrCmp (InfoManagerSpinnerID, "Teach_LP");

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
    spinnerLPDescription = "";
    spinnerLPDescription = ConcatStrings (spinnerLPDescription, "s@Teach_LP Buy Learning Points: "); //Cook some meat     
    spinnerLPDescription = ConcatStrings (spinnerLPDescription, IntToString (spinnerLPValue));
    spinnerLPDescription = ConcatStrings (spinnerLPDescription, " / ");
    spinnerLPDescription = ConcatStrings (spinnerLPDescription, IntToString (spinnerLPMax));

    InfoManager_SetInfoChoiceText_BySpinnerID (spinnerLPDescription, "Teach_LP");

    lastSpinnerID = InfoManagerSpinnerID;
};

// Info_ClearChoices(DIA_Teach_LP);
// Info_AddChoice(DIA_Teach_LP, DIALOG_BACK, DIA_Teach_LP_Back);  
// Info_AddChoice(DIA_Teach_LP, "s@Teach_LP Buy Learning Points: ", DIA_Teach_LP_Teach_LP);

func void Teach_LP() {
    GetLP_CostAndCount(BuyedLPs, spinnerLPValue, hero.exp - SpentXP); // get cost for LPs

    hero.LP = hero.LP + spinnerLPValue;
    BuyedLPs = BuyedLPs + spinnerLPValue;    
    SpentXP = SpentXP + LP_CostAndCount[LP_COST];

    PrintScreen (ConcatStrings("LP:       ", IntToString(spinnerLPValue)),              -1, YPOS_LevelUp,       FONT_Screen, 5);
    PrintScreen (ConcatStrings("LP total: ", IntToString(BuyedLPs)),                    -1, YPOS_LevelUp + 5,   FONT_Screen, 5);
    PrintScreen (ConcatStrings("XP total: ", IntToString(SpentXP)),                     -1, YPOS_LevelUp + 15,  FONT_Screen, 5);
};