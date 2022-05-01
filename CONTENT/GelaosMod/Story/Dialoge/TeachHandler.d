// //////////////////////////////////////////////////
// Teach Dialogue
// //////////////////////////////////////////////////
instance DIA_TeachHandler (C_INFO) {
   nr          = 998;
   npc         = PC_Rockefeller;
   condition   = DIA_TeachHandler_Condition;
   information = DIA_TeachHandler_Info;
   important   = FALSE;
   permanent   = TRUE;
   description = TEACH_DIA_DESC;
};
// --------------------------------------------------------------
func int DIA_TeachHandler_Condition() {
   Teach_LP_Spinner_Setup(); // LP buying is enabled for all teachers
   
   if (Teach_IsAvailable ( TEACH_STR  ) )  { Teach_Attribute_Spinner_Setup ( TEACH_STR  ); };
   if (Teach_IsAvailable ( TEACH_DEX  ) )  { Teach_Attribute_Spinner_Setup ( TEACH_DEX  ); };
   if (Teach_IsAvailable ( TEACH_1H   ) )  { Teach_Attribute_Spinner_Setup ( TEACH_1H   ); };
   if (Teach_IsAvailable ( TEACH_2H   ) )  { Teach_Attribute_Spinner_Setup ( TEACH_2H   ); };
   if (Teach_IsAvailable ( TEACH_BOW  ) )  { Teach_Attribute_Spinner_Setup ( TEACH_BOW  ); };
   if (Teach_IsAvailable ( TEACH_CBOW ) )  { Teach_Attribute_Spinner_Setup ( TEACH_CBOW ); };
   if (Teach_IsAvailable ( TEACH_MP   ) )  { Teach_Attribute_Spinner_Setup ( TEACH_MP   ); };
   //if (Teach_IsAvailable ( 1 << TEACH_HP   )  { Teach_Attribute_Spinner_Setup ( TEACH_HP   ); };

   return TRUE;
};
// --------------------------------------------------------------
func void DIA_TeachHandler_Info() {
   Info_ClearChoices(DIA_TeachHandler);

   Info_AddChoice(DIA_TeachHandler, DIALOG_BACK, DIA_TeachHandler_Back);
   
   // LP buying is enabled for all teachers
   Info_AddChoice(DIA_TeachHandler, ConcatStrings(DIA_SPINNER,TEACH_SPINNER_ID_LP), DIA_TeachHandler_LP);
   
   if (Teach_IsAvailable ( TEACH_CBOW ) )  { Info_AddChoice(DIA_TeachHandler, ConcatStrings(DIA_SPINNER,TEACH_SPINNER_ID_CBOW), DIA_TeachHandler_CBOW ); };
   if (Teach_IsAvailable ( TEACH_BOW  ) )  { Info_AddChoice(DIA_TeachHandler, ConcatStrings(DIA_SPINNER,TEACH_SPINNER_ID_BOW ), DIA_TeachHandler_BOW  ); };
   if (Teach_IsAvailable ( TEACH_2H   ) )  { Info_AddChoice(DIA_TeachHandler, ConcatStrings(DIA_SPINNER,TEACH_SPINNER_ID_2H  ), DIA_TeachHandler_2H   ); };
   if (Teach_IsAvailable ( TEACH_1H   ) )  { Info_AddChoice(DIA_TeachHandler, ConcatStrings(DIA_SPINNER,TEACH_SPINNER_ID_1H  ), DIA_TeachHandler_1H   ); };
   if (Teach_IsAvailable ( TEACH_MP   ) )  { Info_AddChoice(DIA_TeachHandler, ConcatStrings(DIA_SPINNER,TEACH_SPINNER_ID_MP  ), DIA_TeachHandler_MP   ); };
   if (Teach_IsAvailable ( TEACH_DEX  ) )  { Info_AddChoice(DIA_TeachHandler, ConcatStrings(DIA_SPINNER,TEACH_SPINNER_ID_DEX ), DIA_TeachHandler_DEX  ); };
   if (Teach_IsAvailable ( TEACH_STR  ) )  { Info_AddChoice(DIA_TeachHandler, ConcatStrings(DIA_SPINNER,TEACH_SPINNER_ID_STR ), DIA_TeachHandler_STR  ); };            

};

// --------------------------------------------------------------
func void DIA_TeachHandler_Back() {
   Info_ClearChoices(DIA_TeachHandler);
};
// --------------------------------------------------------------
func void DIA_TeachHandler_LP() {
   Teach_LP();
   DIA_TeachHandler_Info();
};
// --------------------------------------------------------------
func void DIA_TeachHandler_STR() {
   Teach(TEACH_STR);
   DIA_TeachHandler_Info();
};
// --------------------------------------------------------------
func void DIA_TeachHandler_DEX() {
   Teach(TEACH_DEX);
   DIA_TeachHandler_Info();
};
// --------------------------------------------------------------
func void DIA_TeachHandler_1H() {
   Teach(TEACH_1H);
   DIA_TeachHandler_Info();
};
// --------------------------------------------------------------
func void DIA_TeachHandler_2H() {
   Teach(TEACH_2H);
   DIA_TeachHandler_Info();
};
// --------------------------------------------------------------
func void DIA_TeachHandler_BOW() {
   Teach(TEACH_BOW);
   DIA_TeachHandler_Info();
};
// --------------------------------------------------------------
func void DIA_TeachHandler_CBOW() {
   Teach(TEACH_CBOW);
   DIA_TeachHandler_Info();
};
// --------------------------------------------------------------
func void DIA_TeachHandler_MP() {
   Teach(TEACH_MP);
   DIA_TeachHandler_Info();
};
// --------------------------------------------------------------
func void DIA_TeachHandler_HP() {
   Teach(TEACH_HP);
   DIA_TeachHandler_Info();
};


// ///////////////////////////////
// DIA_<NPC>_Teach_Setup
// defines what the NPC teaches
// ///////////////////////////////
instance DIA_GelaosModHelper_Teach_Setup (C_INFO) {
   nr          = 998;
   npc         = GelaosModHelper;
   condition   = DIA_GelaosModHelper_Teach_Setup_Condition;
   information = DIA_GelaosModHelper_Teach_Setup_Info;
   // --------------------------------
   // Must be set to 'TRUE'. 
   // _Condition() of dialogue with permanent=TRUE is always evaluated and thus the available teachings are defined.
   permanent   = TRUE;
   // --------------------------------
   description = "__Teach_Setup";
};

func int DIA_GelaosModHelper_Teach_Setup_Condition() {   
   // set up which things will be available for teaching & initialize their default range
   // setting is done via bit-wise operations, thus the '1 << xxx' in the code
   Teach_Setup(
        1 << TEACH_STR    
      | 1 << TEACH_DEX 
      | 1 << TEACH_1H  
      | 1 << TEACH_2H  
      | 1 << TEACH_BOW 
      | 1 << TEACH_CBOW
      | 1 << TEACH_MP  
      //| (1 << TEACH_HP   )
   );

   // (optional): restrict range
   //Teach_SetRange(TEACH_STR, 0, 1000);      
   //Teach_SetRange(TEACH_STR, 0, 1000);  
   //Teach_SetRange(TEACH_DEX, 0, 1000);  
   //Teach_SetRange(TEACH_MP, 0, 1000);  

   DIA_TeachHandler.npc = Hlp_GetinstanceID (self);

    return false;
};
func void DIA_GelaosModHelper_Teach_Setup_Info() {         
};
