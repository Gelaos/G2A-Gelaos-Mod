var string changeFaceSpinnerLastID;
var int changeFaceSpinnerIsActive;
var string changeFaceSpinnerDescription;
var int changeFaceSpinnerFaceMin;
var int changeFaceSpinnerFaceMax;

// //////////////////////////////////////////////////
// EXIT
// //////////////////////////////////////////////////

INSTANCE DIA_GelaosModHelper_EXIT   (C_INFO)
{
   npc         = GelaosModHelper;
   nr          = 999;
   condition   = DIA_GelaosModHelper_EXIT_Condition;
   information = DIA_GelaosModHelper_EXIT_Info;
   permanent   = TRUE;
   description = DIALOG_ENDE;
};
FUNC INT DIA_GelaosModHelper_EXIT_Condition()
{
   return TRUE;
};
FUNC VOID DIA_GelaosModHelper_EXIT_Info()
{  
   CharacterCustomizationState = CHARACTERCUSTOMIZATIONSTATE_FINISHED;
   AI_StopProcessInfos (self);   
};

// //////////////////////////////////////////////////
// Change Face
// //////////////////////////////////////////////////

instance DIA_GelaosModHelper_ChangeFace (C_INFO) {
   nr          = 1;
   npc         = GelaosModHelper;
   condition   = DIA_GelaosModHelper_ChangeFace_Condition;
   information = DIA_GelaosModHelper_ChangeFace_Info;
   important   = FALSE;
   permanent   = TRUE;
   description = "dummy";
};

func int DIA_GelaosModHelper_ChangeFace_Condition() {
      if (CharacterCustomizationState == CHARACTERCUSTOMIZATIONSTATE_FINISHED) {
         return false;
      };
      CharacterCustomizationState = CHARACTERCUSTOMIZATIONSTATE_IN_PROGRESS;

      // set range
      changeFaceSpinnerFaceMin = 0; 
      if (CharacterCustomizationBaldness == true) {
         changeFaceSpinnerFaceMax = CharacterCustomizationFacesBaldLength - 1;
      }
      else {         
         changeFaceSpinnerFaceMax = CharacterCustomizationFacesNotBaldLength - 1;
      };      

      // check range
      if (CharacterCustomizationFace < changeFaceSpinnerFaceMin) { 
         CharacterCustomizationFace = changeFaceSpinnerFaceMin; 
      };
      if (CharacterCustomizationFace > changeFaceSpinnerFaceMax) { 
         CharacterCustomizationFace = changeFaceSpinnerFaceMax; 
      };
      
      changeFaceSpinnerIsActive = Hlp_StrCmp (InfoManagerSpinnerID, "ChangeFace");

      // setup spinner
      if (changeFaceSpinnerIsActive) {
         // what is current InfoManagerSpinnerID ?
         if (!Hlp_StrCmp (InfoManagerSpinnerID, changeFaceSpinnerLastID)) {
            InfoManagerSpinnerValue = CharacterCustomizationFace; // update value
         };
                  
         InfoManagerSpinnerPageSize = 5; // page-up/down quantity
         InfoManagerSpinnerValueMin = changeFaceSpinnerFaceMin; // min/max values (Home/End keys)
         InfoManagerSpinnerValueMax = changeFaceSpinnerFaceMax;

         CharacterCustomizationFace = InfoManagerSpinnerValue;
      };

      changeFaceSpinnerLastID = InfoManagerSpinnerID;   

      // update dialogue description
      changeFaceSpinnerDescription = "";
      changeFaceSpinnerDescription = ConcatStrings (changeFaceSpinnerDescription, "s@ChangeFace Change face: ");
      changeFaceSpinnerDescription = ConcatStrings (changeFaceSpinnerDescription, IntToString (CharacterCustomizationFace));
      changeFaceSpinnerDescription = ConcatStrings (changeFaceSpinnerDescription, " / ");
      changeFaceSpinnerDescription = ConcatStrings (changeFaceSpinnerDescription, IntToString (changeFaceSpinnerFaceMax));
      DIA_GelaosModHelper_ChangeFace.description = changeFaceSpinnerDescription;

      // set face
      //Mdl_SetVisualBody (self, "hum_body_Naked0", BodyTex_N, 0, "Hum_Head_Pony", CharacterCustomizationFace, 0, NO_ARMOR);
      CharacterCustomizationApply(self);      
      CharacterCustomizationApply(other);

   return TRUE;
};


func void DIA_GelaosModHelper_ChangeFace_Info() {
};

// //////////////////////////////////////////////////
// Change Baldness
// //////////////////////////////////////////////////
instance DIA_GelaosModHelper_ChangeBaldness (C_INFO) {
   nr          = 1;
   npc         = GelaosModHelper;
   condition   = DIA_GelaosModHelper_ChangeBaldness_Condition;
   information = DIA_GelaosModHelper_ChangeBaldness_Info;
   important   = FALSE;
   permanent   = TRUE;
   description = "o@h@FF6363 hs@FF3030:Not Bald~ / Bald";
};

func int DIA_GelaosModHelper_ChangeBaldness_Condition() {
   return (CharacterCustomizationState == CHARACTERCUSTOMIZATIONSTATE_IN_PROGRESS);
};

func void DIA_GelaosModHelper_ChangeBaldness_Info() {
   if (CharacterCustomizationBaldness == true) {
      CharacterCustomizationBaldness = false;
      DIA_GelaosModHelper_ChangeBaldness.description = "o@h@FF6363 hs@FF3030:Not Bald~ / Bald";
   }
   else {
      CharacterCustomizationBaldness = true;
      DIA_GelaosModHelper_ChangeBaldness.description = "Not Bald / o@h@FF6363 hs@FF3030:Bald~";
   };

   // set face selection to the start
   InfoManagerSpinnerValue = 0; 
   CharacterCustomizationFace = 0;
};





























