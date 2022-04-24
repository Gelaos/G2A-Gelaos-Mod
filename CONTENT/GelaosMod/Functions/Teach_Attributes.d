func void Teach_Attributes_Costs_Initialize() {
    var int attrMax; attrMax = 100000;

    TEACH_STR_TEACHER_MIM = -1;
    TEACH_STR_TEACHER_MAX = attrMax;

    TEACH_DEX_TEACHER_MIM = -1;
    TEACH_DEX_TEACHER_MAX = attrMax;

    TEACH_1H_TEACHER_MIM = -1;
    TEACH_1H_TEACHER_MAX = attrMax;

    TEACH_2H_TEACHER_MIM = -1;
    TEACH_2H_TEACHER_MAX = attrMax;

    TEACH_BOW_TEACHER_MIM = -1;
    TEACH_BOW_TEACHER_MAX = attrMax;

    TEACH_CBOW_TEACHER_MIM = -1;
    TEACH_CBOW_TEACHER_MAX = attrMax;

    TEACH_MP_TEACHER_MIM = -1;
    TEACH_MP_TEACHER_MAX = attrMax;

    TEACH_HP_TEACHER_MIM = -1;
    TEACH_HP_TEACHER_MAX = attrMax;
};

// ------------------------------------------

func int Get_Attribute_Cost_LP(var int attribute) {
    // attribute costs are fixed
    return 1;
};

// ------------------------------------------

func int Get_Attribute_Cost_Gold (var int attribute, var int targetValue) {
    var int goldCost; goldCost = 0;
    var int currentValue;

    if      ( attribute == TEACH_STR  )   { currentValue = hero.aivar[REAL_STRENGTH];       }
    else if ( attribute == TEACH_DEX  )   { currentValue = hero.aivar[REAL_DEXTERITY];      }
    else if ( attribute == TEACH_1H   )   { currentValue = hero.aivar[REAL_TALENT_1H];      }
    else if ( attribute == TEACH_2H   )   { currentValue = hero.aivar[REAL_TALENT_2H];      }
    else if ( attribute == TEACH_BOW  )   { currentValue = hero.aivar[REAL_TALENT_BOW];     }
    else if ( attribute == TEACH_CBOW )   { currentValue = hero.aivar[REAL_TALENT_CROSSBOW];}
    else if ( attribute == TEACH_MP   )   { currentValue = START_MP + Learned_MP;           }
    else if ( attribute == TEACH_HP   )   { currentValue = START_HP + Learned_HP;           };

    if (attribute != TEACH_HP) {        
        goldCost = targetValue/2 * (targetValue + 1) - currentValue/2*(currentValue + 1); // = currentValue + (currentValue + 1) + ... + targetValue
    };

    return goldCost;
};

// ------------------------------------------

func void Get_Attribute_Count_And_Cost(var int teach_attribute) {
    
};
