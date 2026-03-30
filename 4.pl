% Membership
in(X, [X|_]).
in(X, [_|T]) :-
    in(X, T).

% Negation (complement)
negate([], _, []).
negate([X|U], A, Res) :-
    in(X, A),
    negate(U, A, Res).
negate([X|U], A, [X|Res]) :-
    \+ in(X, A),
    negate(U, A, Res).

% Union
union([], B, B).
union([X|A], B, Res) :-
    in(X, B),
    union(A, B, Res).
union([X|A], B, [X|Res]) :-
    \+ in(X, B),
    union(A, B, Res).

% Intersection
intersect(_, [], []).
intersect(A, [X|B], [X|Res]) :-
    in(X, A),
    intersect(A, B, Res).
intersect(A, [_|B], Res) :-
    intersect(A, B, Res).

% not(A & B)
de_morgan_left(U, A, B, Res) :-
    intersect(A, B, Tmp),
    negate(U, Tmp, Res).

% not(A) + not(B)
de_morgan_right(U, A, B, Res) :-
    negate(U, A, NotA),
    negate(U, B, NotB),
    union(NotA, NotB, Res).

start :-
    write('Enter universal set U: '),
    read(U),
    write('Enter set A: '),
    read(A),
    write('Enter set B: '),
    read(B),
    de_morgan_left(U, A, B, Left),
    de_morgan_right(U, A, B, Right),
    write('Left side not(A & B): '),
    write(Left),
    nl,
    write('Right side not(A) + not(B): '),
    write(Right).