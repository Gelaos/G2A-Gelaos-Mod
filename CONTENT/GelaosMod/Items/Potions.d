const string HP_Percent_01_Description = "Weak healing potion";
const string HP_Percent_02_Description = "Healing potion";
const string HP_Percent_03_Description = "Strong healing potion";

const string MP_Percent_01_Description = "Weak mana potion";
const string MP_Percent_02_Description = "Mana potion";
const string MP_Percent_03_Description = "Strong mana potion";

const int HP_Percent_01_Value = 20;
const int HP_Percent_02_Value = 33;
const int HP_Percent_03_Value = 50;

const int MP_Percent_01_Value = 20;
const int MP_Percent_02_Value = 33;
const int MP_Percent_03_Value = 50;

const int HP_Percent_01_Divisor = 5; const int HP_Percent_01_Text = 20; // 100/divisor
const int HP_Percent_02_Divisor = 3; const int HP_Percent_02_Text = 33; // 100/divisor
const int HP_Percent_03_Divisor = 2; const int HP_Percent_03_Text = 50; // 100/divisor

const int MP_Percent_01_Divisor = 5; const int MP_Percent_01_Text = 20; // 100/divisor
const int MP_Percent_02_Divisor = 3; const int MP_Percent_02_Text = 33; // 100/divisor
const int MP_Percent_03_Divisor = 2; const int MP_Percent_03_Text = 50; // 100/divisor

const string NAME_Bonus_HP_Percent = "Hitpoints bonus (%):";
const string NAME_Bonus_MP_Percent = "Mana bonus (%):";

// ------------------------------------------------------------------------

func void UsePercentPotion (var C_NPC npc, var int attribute, var int divisor) {
    if (attribute != ATR_HITPOINTS && attribute != ATR_MANA) { return; };

    var int attributeMax; 
    var int points;

    // get max value of attribute
    if (attribute == ATR_HITPOINTS) { attributeMax = npc.attribute[ATR_HITPOINTS_MAX]; }
    else { attributeMax = npc.attribute[ATR_MANA_MAX]; };

    // calculate attribute increase
    points = truncf(divf(mkf(attributeMax), mkf(divisor)));

    // change attribute
    Npc_ChangeAttribute	(npc, attribute, points);
};

// ///////////////////////////////////////////////////////////
// Health potions
// ///////////////////////////////////////////////////////////
INSTANCE ItPo_Health_01_Percent(C_Item)
{
	name 			=	NAME_Trank;

	mainflag 		=	ITEM_KAT_POTIONS;
	flags 			=	ITEM_MULTI;

	value 			=	HP_Percent_01_Value;	

	visual 			=	"ItPo_Health_01.3ds";
	material 		=	MAT_GLAS;
	on_state[0]		=	Use_ItPo_Health_01_Percent;
	scemeName		=	"POTIONFAST";

	wear			= 	WEAR_EFFECT;
	effect			=	"SPELLFX_HEALTHPOTION"; 

	description		= 	HP_Percent_01_Description;
	
	TEXT[1]			= 	NAME_Bonus_HP_Percent;				
	COUNT[1]		= 	HP_Percent_01_Text;
	
	TEXT[5]			= 	NAME_Value;					
	COUNT[5]		= 	HP_Percent_01_Value;
};

FUNC VOID Use_ItPo_Health_01_Percent()
{
    UsePercentPotion(self, ATR_HITPOINTS, HP_Percent_01_Divisor);
    //Npc_ChangeAttribute	(self,	ATR_HITPOINTS,	HP_Essenz);
};

// -------------------------------------------------------	
INSTANCE ItPo_Health_02_Percent(C_Item)
{
	name 			=	NAME_Trank;

	mainflag 		=	ITEM_KAT_POTIONS;
	flags 			=	ITEM_MULTI;

	value 			=	HP_Percent_02_Value;	

	visual 			=	"ItPo_Health_02.3ds";
	material 		=	MAT_GLAS;
	on_state[0]		=	Use_ItPo_Health_02_Percent;
	scemeName		=	"POTIONFAST";

	wear			= 	WEAR_EFFECT;
	effect			=	"SPELLFX_HEALTHPOTION"; 

	description		= 	HP_Percent_02_Description;
	
	TEXT[1]			= 	NAME_Bonus_HP_Percent;				
	COUNT[1]		= 	HP_Percent_02_Text;
	
	TEXT[5]			= 	NAME_Value;					
	COUNT[5]		= 	HP_Percent_02_Value;
};

FUNC VOID Use_ItPo_Health_02_Percent()
{
    UsePercentPotion(self, ATR_HITPOINTS, HP_Percent_02_Divisor);
    //Npc_ChangeAttribute	(self,	ATR_HITPOINTS,	HP_Extrakt);
};

// -------------------------------------------------------	
INSTANCE ItPo_Health_03_Percent(C_Item)
{
	name 			=	NAME_Trank;

	mainflag 		=	ITEM_KAT_POTIONS;
	flags 			=	ITEM_MULTI;

	value 			=	HP_Percent_03_Value;	

	visual 			=	"ItPo_Health_03.3ds";
	material 		=	MAT_GLAS;
	on_state[0]		=	Use_ItPo_Health_03_Percent;
	scemeName		=	"POTIONFAST";

	wear			= 	WEAR_EFFECT;
	effect			=	"SPELLFX_HEALTHPOTION"; 

	description		= 	HP_Percent_03_Description;
	
	TEXT[1]			= 	NAME_Bonus_HP_Percent;				
	COUNT[1]		= 	HP_Percent_03_Text;
	
	TEXT[5]			= 	NAME_Value;					
	COUNT[5]		= 	HP_Percent_03_Value;
};

FUNC VOID Use_ItPo_Health_03_Percent()
{
    UsePercentPotion(self, ATR_HITPOINTS, HP_Percent_03_Divisor);
    //Npc_ChangeAttribute	(self,	ATR_HITPOINTS,	HP_Elixier);
};

// ///////////////////////////////////////////////////////////
// Mana potions
// ///////////////////////////////////////////////////////////
INSTANCE ItPo_Mana_01_Percent(C_Item)
{
	name 			=	NAME_Trank;

	mainflag 		=	ITEM_KAT_POTIONS;
	flags 			=	ITEM_MULTI;

	value 			=	MP_Percent_01_Value;	

	visual 			=	"ItPo_Mana_01.3ds";
	material 		=	MAT_GLAS;

	on_state[0]		=	Use_ItPo_Mana_01_Percent;
	scemeName		=	"POTIONFAST";

	wear			= 	WEAR_EFFECT;
	effect			=	"SPELLFX_MANAPOTION";

	description		= 	MP_Percent_01_Description;
	
	TEXT[1]			= 	NAME_Bonus_MP_Percent;				
	COUNT[1]		= 	MP_Percent_01_Text;

	TEXT[5]			= 	NAME_Value;					
	COUNT[5]		= 	MP_Percent_01_Value;

};

FUNC VOID Use_ItPo_Mana_01_Percent()
{
    UsePercentPotion(self, ATR_MANA, MP_Percent_01_Divisor);
    //Npc_ChangeAttribute	(self,	ATR_MANA, Mana_Essenz);
};

// -------------------------------------------------------
INSTANCE ItPo_Mana_02_Percent(C_Item)
{
	name 			=	NAME_Trank;

	mainflag 		=	ITEM_KAT_POTIONS;
	flags 			=	ITEM_MULTI;

	value 			=	HP_Percent_02_Value;	

	visual 			=	"ItPo_Mana_02.3ds";
	material 		=	MAT_GLAS;
	on_state[0]		=	Use_ItPo_Mana_02_Percent;
	scemeName		=	"POTIONFAST";

	wear			= 	WEAR_EFFECT;
	effect			=	"SPELLFX_MANAPOTION";

	description		= 	MP_Percent_02_Description;
	
	TEXT[1]			= 	NAME_Bonus_MP_Percent;			
	COUNT[1]		= 	MP_Percent_02_Text;
	
	TEXT[5]			= 	NAME_Value;					
	COUNT[5]		= 	HP_Percent_02_Value;

};

FUNC VOID Use_ItPo_Mana_02_Percent()
{
    UsePercentPotion(self, ATR_MANA, MP_Percent_02_Divisor);
    //Npc_ChangeAttribute	(self,	ATR_MANA,	Mana_Extrakt);
};

// -------------------------------------------------------
INSTANCE ItPo_Mana_03_Percent(C_Item)
{
	name 			=	NAME_Trank;

	mainflag 		=	ITEM_KAT_POTIONS;
	flags 			=	ITEM_MULTI;

	value 			=	HP_Percent_03_Value;	

	visual 			=	"ItPo_Mana_03.3ds";
	material 		=	MAT_GLAS;
	on_state[0]		=	Use_ItPo_Mana_03_Percent;
	scemeName		=	"POTIONFAST";

	wear			= 	WEAR_EFFECT;
	effect			=	"SPELLFX_MANAPOTION";

	description		= 	MP_Percent_03_Description;
	
	TEXT[1]			= 	NAME_Bonus_MP_Percent;				
	COUNT[1]		= 	MP_Percent_03_Text;
	
	TEXT[5]			= 	NAME_Value;					
	COUNT[5]		= 	HP_Percent_03_Value;
};

FUNC VOID Use_ItPo_Mana_03_Percent()
{
    UsePercentPotion(self, ATR_MANA, MP_Percent_03_Divisor);
    //Npc_ChangeAttribute	(self,	ATR_MANA,	Mana_Elixier);
};


