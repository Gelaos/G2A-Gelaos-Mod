// -----------------------------------
// simulates ternary operator ? :
// ----------------------------------- 
func int iif(var int condition, var int valueIfTrue, var int valueIfFalse) {
    if (condition == TRUE) {
        return valueIfTrue;
    };

    return valueIfFalse;
};

func string iifStr(var int condition, var string valueIfTrue, var string valueIfFalse) {
    if (condition == TRUE) {
        return valueIfTrue;
    };

    return valueIfFalse;
};

