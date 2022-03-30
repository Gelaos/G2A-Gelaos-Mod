// ----------------------------------------------------------------------
INSTANCE ItRu_Teleport_General (C_Item) 
{
	name 				=	ITRU_TELEPORT_GENERAL_NAME;

	mainflag 			=	ITEM_KAT_RUNE;
	flags 				=	0;
	
	value 				=	ITRU_TELEPORT_GENERAL_VALUE;

	
	visual				=	"ItRu_TeleportMonastery.3ds";	
	material			=	MAT_STONE;

	spell				= 	SPL_PalTeleportSecret;


	wear				= 	WEAR_EFFECT;
	effect				=	"SPELLFX_WEAKGLIMMER";

	description			= 	ITRU_TELEPORT_GENERAL_DESCRIPTION;
	
	
	TEXT	[1]			=	NAME_Manakosten;			
	COUNT	[1]			=	SPL_COST_TELEPORT;
	TEXT	[5]			=	NAME_Value;					
	COUNT	[5]			=	value;
};
// ----------------------------------------------------------------------
