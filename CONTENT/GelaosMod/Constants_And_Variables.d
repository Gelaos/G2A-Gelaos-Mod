// /////////////////////////////////////////////////
// /////////////////////////////////////////////////
// Constants and variables
// /////////////////////////////////////////////////
// ///////////////////////////////////////////////// 

const string DIA_SPINNER = "s@";
const string DIA_FORMAT_START = " o@"; // h = color when not selected, hs = color when selected, 
const string DIA_FORMAT_END = "~ ";
const string DIA_COLOR_RED = "h@FF3030 hs@FF4646:";

// /////////////////////////////////////////////////
// XP & Levelling & Teaching
// /////////////////////////////////////////////////    

const string TEACH_DIA_DESC = "(Learn)";

// LP buying ---------------------------------------
const string TEACH_LP_CANT_BUY = "Not enough XP";
const string TEACH_LP_BOUGHT_MSG = "Learning points + ";
const string TEACH_LP_DIA_DESC = "Buy Learning Points: ";
var int BuyedLPs; // count of already bought LPs
var int SpentXP; // sum of XP spent for buying LPs
var int LP_CostAndCount[2]; // count and XP cost of LPs that player can/wants to buy
const int LP_COST = 0;
const int LP_COUNT = 1;

// Attributes & Talents -----------------------------
const int START_HP      = 40;
const int START_MP      = 10;
const int TEACH_STR     = 1;
const int TEACH_DEX     = 2;
const int TEACH_1H      = 3;
const int TEACH_2H      = 4;
const int TEACH_BOW     = 5;
const int TEACH_CBOW    = 6;
const int TEACH_MP      = 7;
const int TEACH_HP      = 8;
var int Learned_HP;
var int Learned_MP;

var int Teach_Attribute[3]; // count and cost in LP and gold of attribute that player can/wants to buy
const int TEACH_ATTRIBUTE_COUNT = 0;
const int TEACH_ATTRIBUTE_COST_LP = 1;
const int TEACH_ATTRIBUTE_COST_GOLD = 2;

var int TEACH_STR_TEACHER_MIM;
var int TEACH_STR_TEACHER_MAX;
var int TEACH_DEX_TEACHER_MIM;
var int TEACH_DEX_TEACHER_MAX;
var int TEACH_1H_TEACHER_MIM;
var int TEACH_1H_TEACHER_MAX;
var int TEACH_2H_TEACHER_MIM;
var int TEACH_2H_TEACHER_MAX;
var int TEACH_BOW_TEACHER_MIM;
var int TEACH_BOW_TEACHER_MAX;
var int TEACH_CBOW_TEACHER_MIM;
var int TEACH_CBOW_TEACHER_MAX;
var int TEACH_MP_TEACHER_MIM;
var int TEACH_MP_TEACHER_MAX;
var int TEACH_HP_TEACHER_MIM;
var int TEACH_HP_TEACHER_MAX;

// /////////////////////////////////////////////////
// Character Appearance Customization
// /////////////////////////////////////////////////      

var int CharacterCustomizationFace;

var int CharacterCustomizationFacesNotBald[48];
var int CharacterCustomizationFacesNotBaldLength;

var int CharacterCustomizationFacesBald[21];
var int CharacterCustomizationFacesBaldLength;

var int CharacterCustomizationBaldness;
var int CharacterCustomizationState;
const int CHARACTERCUSTOMIZATIONSTATE_NONE = 0;
const int CHARACTERCUSTOMIZATIONSTATE_IN_PROGRESS = 1;
const int CHARACTERCUSTOMIZATIONSTATE_FINISHED = 2;

// /////////////////////////////////////////////////
// Items
// /////////////////////////////////////////////////   

// -------------------------------------------------
// Runes
// -------------------------------------------------
const string ITRU_TELEPORT_GENERAL_NAME = "Teleportation rune";
const int ITRU_TELEPORT_GENERAL_VALUE = 0;
const string ITRU_TELEPORT_GENERAL_DESCRIPTION = "Multifunctional teleport";

// /////////////////////////////////////////////////
// Teleport locations
// /////////////////////////////////////////////////  
const int TELEPORT_LOCATION_COUNT = 36;
var int Teleport_Location_IsEnabled[TELEPORT_LOCATION_COUNT];
var int TeleportLocationMainMenu;

// NewWorld - nature
const int TELEPORT_NW_NATURE_PORTAL             = 0;
const int TELEPORT_NW_NATURE_PYRAMID            = 1;
const int TELEPORT_NW_NATURE_TROLLAREA          = 2;
const int TELEPORT_NW_NATURE_SUNCIRCLE          = 3;
const int TELEPORT_NW_NATURE_BIGFORESTNORTH     = 4;
const int TELEPORT_NW_NATURE_BIGFORESTCENTER    = 5;
const int TELEPORT_NW_NATURE_LIGHTHOUSE         = 6;
const int TELEPORT_NW_NATURE_AKIL               = 7;
const int TELEPORT_NW_NATURE_TAVERNE            = 8;
const int TELEPORT_NW_NATURE_MONASTERY          = 9;
const int TELEPORT_NW_NATURE_SEKOB              = 10;
const int TELEPORT_NW_NATURE_DEXTER             = 11;
const int TELEPORT_NW_NATURE_ONARCROSSROAD      = 12;
const int TELEPORT_NW_NATURE_ONAR               = 13;
const int TELEPORT_NW_NATURE_BENGAR             = 14;
const int TELEPORT_NW_NATURE_PASSWATERFALLS     = 15;
const int TELEPORT_NW_NATURE_PASS               = 16;
const int TELEPORT_NW_NATURE_XARDAS             = 17;
const int TELEPORT_NW_NATURE_LOBART             = 18;
const int TELEPORT_NW_NATURE_SAGITTA            = 19;

// NewWorld - city
const int TELEPORT_NW_CITY_SOUTHGATE            = 20;
const int TELEPORT_NW_CITY_ADANOS               = 21;
const int TELEPORT_NW_CITY_MARKET               = 22;
const int TELEPORT_NW_CITY_KASERNE              = 23;
const int TELEPORT_NW_CITY_HARBOR               = 24;
const int TELEPORT_NW_CITY_UPPERCITY            = 25;
const int TELEPORT_NW_CITY_SEWERS               = 26;

// Valley of mines
const int TELEPORT_OW_EXCHANGEPLACE             = 27;
const int TELEPORT_OW_NORTHGATE                 = 28;
const int TELEPORT_OW_OLDMINE                   = 29;
const int TELEPORT_OW_CASTLE                    = 30;
const int TELEPORT_OW_SOUTHGATE                 = 31;
const int TELEPORT_OW_STONEFORTRESS             = 32;
const int TELEPORT_OW_CAVALORN                  = 33;
const int TELEPORT_OW_NEWCAMP                   = 34;
const int TELEPORT_OW_XARDAS                    = 35;

