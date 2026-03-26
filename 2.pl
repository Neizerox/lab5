% Проверка, является ли число нечётным отрицательным
is_odd_negative(X) :-
    X < 0,
    X mod 2 =\= 0.  % \= - для сравнения термов, =\= - для арифметики

count(List, Count) :-
    include(is_odd_negative, List, OddNegatives),
    length(OddNegatives, Count).