
digits(Number, Max, Min) :-
    Number >= 0,
    Number < 10,
    Max is Number,
    Min is Number.
    
digits(Number, Max, Min) :-
    Number >= 10,
    LastDigit is Number mod 10,
    Remainder is Number // 10,
    digits(Remainder, MaxRemainder, MinRemainder),
    Max is max(LastDigit, MaxRemainder),
    Min is min(LastDigit, MinRemainder).