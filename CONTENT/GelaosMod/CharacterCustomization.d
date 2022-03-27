func void CharacterCustomizationInitFaces() {

    if (!CharacterCustomizationFinished) {

        // face textures for bald hero 
        CharacterCustomizationFacesBaldLength = 21;
        CharacterCustomizationFacesBald[0] = 163;
        CharacterCustomizationFacesBald[1] = 164;
        CharacterCustomizationFacesBald[2] = 165;
        CharacterCustomizationFacesBald[3] = 166;
        CharacterCustomizationFacesBald[4] = 167;
        CharacterCustomizationFacesBald[5] = 168;
        CharacterCustomizationFacesBald[6] = 169;
        CharacterCustomizationFacesBald[7] = 170;
        CharacterCustomizationFacesBald[8] = 171;
        CharacterCustomizationFacesBald[9] = 172;
        CharacterCustomizationFacesBald[10] = 173;
        CharacterCustomizationFacesBald[11] = 174;
        CharacterCustomizationFacesBald[12] = 175;
        CharacterCustomizationFacesBald[13] = 176;
        CharacterCustomizationFacesBald[14] = 177;
        CharacterCustomizationFacesBald[15] = 178;
        CharacterCustomizationFacesBald[16] = 179;
        CharacterCustomizationFacesBald[17] = 180;
        CharacterCustomizationFacesBald[18] = 181;
        CharacterCustomizationFacesBald[19] = 182;
        CharacterCustomizationFacesBald[20] = 183;    

        // face textures for hero with hair 
        CharacterCustomizationFacesNotBaldLength = 48;
        CharacterCustomizationFacesNotBald[0] = 184;
        CharacterCustomizationFacesNotBald[1] = 185;
        CharacterCustomizationFacesNotBald[2] = 186;
        CharacterCustomizationFacesNotBald[3] = 187;
        CharacterCustomizationFacesNotBald[4] = 188;
        CharacterCustomizationFacesNotBald[5] = 189;
        CharacterCustomizationFacesNotBald[6] = 190;
        CharacterCustomizationFacesNotBald[7] = 191;
        CharacterCustomizationFacesNotBald[8] = 192;
        CharacterCustomizationFacesNotBald[9] = 193;
        CharacterCustomizationFacesNotBald[10] = 194;
        CharacterCustomizationFacesNotBald[11] = 195;
        CharacterCustomizationFacesNotBald[12] = 196;
        CharacterCustomizationFacesNotBald[13] = 197;
        CharacterCustomizationFacesNotBald[14] = 198;
        CharacterCustomizationFacesNotBald[15] = 199;
        CharacterCustomizationFacesNotBald[16] = 200;
        CharacterCustomizationFacesNotBald[17] = 201;
        CharacterCustomizationFacesNotBald[18] = 202;
        CharacterCustomizationFacesNotBald[19] = 203;
        CharacterCustomizationFacesNotBald[20] = 204;
        CharacterCustomizationFacesNotBald[21] = 205;
        CharacterCustomizationFacesNotBald[22] = 206;
        CharacterCustomizationFacesNotBald[23] = 207;
        CharacterCustomizationFacesNotBald[24] = 208;
        CharacterCustomizationFacesNotBald[25] = 209;
        CharacterCustomizationFacesNotBald[26] = 210;
        CharacterCustomizationFacesNotBald[27] = 211;
        CharacterCustomizationFacesNotBald[28] = 212;
        CharacterCustomizationFacesNotBald[29] = 213;
        CharacterCustomizationFacesNotBald[30] = 214;
        CharacterCustomizationFacesNotBald[31] = 215;
        CharacterCustomizationFacesNotBald[32] = 216;
        CharacterCustomizationFacesNotBald[33] = 217;
        CharacterCustomizationFacesNotBald[34] = 218;
        CharacterCustomizationFacesNotBald[35] = 219;
        CharacterCustomizationFacesNotBald[36] = 220;
        CharacterCustomizationFacesNotBald[37] = 221;
        CharacterCustomizationFacesNotBald[38] = 222;
        CharacterCustomizationFacesNotBald[39] = 223;
        CharacterCustomizationFacesNotBald[40] = 224;
        CharacterCustomizationFacesNotBald[41] = 225;
        CharacterCustomizationFacesNotBald[42] = 226;
        CharacterCustomizationFacesNotBald[43] = 227;
        CharacterCustomizationFacesNotBald[44] = 228;
        CharacterCustomizationFacesNotBald[45] = 229;
        CharacterCustomizationFacesNotBald[46] = 230;
        CharacterCustomizationFacesNotBald[47] = 231;
    };
};

// ---------------------------------------------------

func int CharacterCustomizationGetFace() {
    var int faceTex;

    if (CharacterCustomizationBaldness == true) {
        faceTex = MEM_ReadStatArr(CharacterCustomizationFacesBald, CharacterCustomizationFace);
    }
    else {
        faceTex = MEM_ReadStatArr(CharacterCustomizationFacesNotBald, CharacterCustomizationFace);
    };

    return faceTex;
};

// ---------------------------------------------------

func void CharacterCustomizationApply(var C_NPC npc) {
    var string headMeshStr;  
    var int faceTex;  
    
    faceTex = CharacterCustomizationGetFace();

    headMeshStr = "Hum_Head_Pony";    
    if (CharacterCustomizationBaldness == true) {
        headMeshStr = "Hum_Head_Bald";
    };

    Mdl_SetVisualBody (npc, "hum_body_Naked0", BodyTex_N, 0, headMeshStr, faceTex, 0, NO_ARMOR);
};

