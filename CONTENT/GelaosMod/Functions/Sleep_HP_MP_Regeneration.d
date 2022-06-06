var int Sleep_RegenerationLevel;

func int GetSleepRegenerationAmount(var int attributeCurrentValue, var int attributeMaxValue) {
    var int percent; 
    var int regenerated;

    if      (Sleep_RegenerationLevel == 1) { percent = divf(mkf(1), mkf(2)); }
    else if (Sleep_RegenerationLevel == 2) { percent = divf(mkf(2), mkf(3)); }
    else                                   { percent = divf(mkf(1), mkf(3)); };

    regenerated = truncf(mulf(percent, mkf(attributeMaxValue)));
    regenerated = iif(attributeCurrentValue > regenerated, attributeCurrentValue, regenerated);

    return regenerated;
};

func void SleepRegeneration(var C_NPC npc) {
    npc.attribute[ATR_HITPOINTS] = GetSleepRegenerationAmount(npc.attribute[ATR_HITPOINTS], npc.attribute[ATR_HITPOINTS_MAX] );
    npc.attribute[ATR_MANA]      = GetSleepRegenerationAmount(npc.attribute[ATR_MANA],      npc.attribute[ATR_MANA_MAX]      );
};

