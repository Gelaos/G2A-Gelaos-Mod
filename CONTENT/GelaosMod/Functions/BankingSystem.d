var int Bank_SavingsStartDate;
var int Bank_InitialDeposit;
var int Bank_InterestRate;
var int Bank_InterestRateBase;
var int Bank_TotalSavingsMax;
var int Bank_AccountIsActive;
var int Bank_WithdrawalDelay; // in days, ie. if Bank_WithdrawalDelay = 30 it means that player can make first withdrawal after 30 days from initial day 

// Bank_GetInterestFromDeposit()
// returns interest calculated as deposit*interest_rate
// the interest is rounded down
// 
// i.e. if deposit is 120 and interest rate is 3/100, the interest is floor(120*3/100) = floor(3.6) = 3
func int Bank_GetInterestFromDeposit(var int deposit, var int interestRate, var int interestRateBase) {
    var int depositF; depositF = mkf(deposit);
    var int interestRateF; interestRateF = divf(mkf(interestRate), mkf(interestRateBase));

    return truncf( mulf( depositF, interestRateF ) );
};

// Bank_GetTotalInterest()
// returns total interest from deposit saved for a given amount of time
// the interest is rounded down
// 
// i.e. if deposit is 120 and interest rate is 3/100, the basic interest is floor(120*3/100) = floor(3.6) = 3
//      if start date = 1 and end date = 20, then total interest is (20-1)*3 = 57
func int Bank_GetTotalInterest(var int deposit, var int interestRate, var int interestRateBase, var int startDay, var int endDay) {
    var int interest; interest = Bank_GetInterestFromDeposit(deposit, interestRate, interestRateBase);
    var int days; days = endDay - startDay;

    if (days < 0) {days = 0; };

    return days*interest;
};

// Bank_GetTotalValue()
// returns total value of deposit (including interest) saved for a given amount of time
// the interest is rounded down & total value can't exceed maximum
// 
// i.e. if deposit is 120 and interest rate is 3/100, the basic interest is floor(120*3/100) = floor(3.6) = 3
//      if the deposit was saved for 20 days, then total interest after 20 days is 20*3 = 60
//      therefore the total value is 120 + 60 = 180
//      however if the maximum value is set to 140, then after 20 days the total value is 140 and not 180
func int Bank_GetTotalValue(var int deposit, var int interestRate, var int interestRateBase, var int startDay, var int endDay, var int maximumValue) {
    var int total; total = deposit + Bank_GetTotalInterest(deposit, interestRate, interestRateBase, startDay, endDay);
    total = iif(total > maximumValue, maximumValue, total);

    return total;
};

// Bank_CanWithdraw()
// returns TRUE or FALSE whether player can make a withdrawal
func int Bank_CanWithdraw(var int currentDay, var int earliestWithdrawalDay) {
    return (currentDay >= earliestWithdrawalDay);
};

// Bank_SetupAccount()
func void Bank_SetupAccount(
    var int _startDay,
    var int _initialDeposit,
    var int _interestRate,
    var int _interestRateBase,
    var int _totalSavingsMaximum,
    var int _withdrawalDelay 
) {
    Bank_SavingsStartDate     = _startDay;
    Bank_InitialDeposit       = _initialDeposit;    
    Bank_InterestRate         = _interestRate;    
    Bank_InterestRateBase     = _interestRateBase;        
    Bank_TotalSavingsMax      = _totalSavingsMaximum;        
    Bank_WithdrawalDelay      = _withdrawalDelay;    

    Bank_AccountIsActive  = true;        
};







