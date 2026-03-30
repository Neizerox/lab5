
is_odd_negative(X) :-
    X < 0,
    X mod 2 =\= 0.

count(List, Count) :-
    include(is_odd_negative, List, OddNegatives),
    length(OddNegatives, Count).
