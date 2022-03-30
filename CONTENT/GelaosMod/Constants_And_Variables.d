// /////////////////////////////////////////////////
// /////////////////////////////////////////////////
// Constants and variables
// /////////////////////////////////////////////////
// /////////////////////////////////////////////////

// /////////////////////////////////////////////////
// Character Appearance Customization
// /////////////////////////////////////////////////      

var int CharacterCustomizationFace;

var int CharacterCustomizationFacesNotBald[48];
var int CharacterCustomizationFacesNotBaldLength;

var int CharacterCustomizationFacesBald[21];
var int CharacterCustomizationFacesBaldLength;

var int CharacterCustomizationBaldness;
var int CharacterCustomizationFinished;

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

