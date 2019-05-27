dolacz_element(X,Y,[X|Y]).

p(a).
p(b).
p(c).
p(d).

silnia(1,1).
silnia(N,Y):-N>1,N1 is N-1,silnia(N1,W),Y is W*N.

element(X,[X|_]).
element(X,[_|O]):-element(X,O).

not_element(_,[]).
not_element(X,[G|O]):-X\=G,not_element(X,O).

