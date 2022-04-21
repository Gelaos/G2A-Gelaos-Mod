func int GetPriceNthLP (var int N) {
    // XP threshold for next level:     250*(next_level + 1)*(next_level)
    // XP sum for next level:           250*(next_level + 2)*(next_level + 1) - 250*(next_level + 1)*(next_level) --> 500*(next_level + 1)

    var int level; level = truncf(divf (mkf(N), mkf(10))); // get current level
    return 50*(level + 1);
};

// --------------------------------

// GetLP_CostAndCount()
// Returns how many LPs and for what XP cost player can get for an XP amount
//
// i.e. if player is on level 0 and has already bought 9 LPs and has 180 XP available for buying,
// then he can, at most, buy additional two LPs (one for 50 XP and the other for 100 XP, in total 150 XP)
//
// if he wants to buy only 1 LP (LPsToBuy = 1), then the cost will be 50 XP

func void GetLP_CostAndCount(var int ownedLPs, var int LPsToBuy, var int availableXPs) {    
    var int countLP; countLP = 0;
    var int budgetXP; budgetXP = availableXPs;
    var int priceLP; priceLP = GetPriceNthLP(ownedLPs);

    // get LPs one by one while XP budgetXP is large enough OR until target LP count is reached
    while (budgetXP >= priceLP && countLP != LPsToBuy);      
        budgetXP = budgetXP - priceLP;
        countLP = countLP + 1;
        priceLP = GetPriceNthLP(ownedLPs + countLP);
    end;

    // "return" LP cost and count
    LP_CostAndCount[LP_COST] = availableXPs - budgetXP;
    LP_CostAndCount[LP_COUNT] = countLP;
};
