%Laborka nr 1 :
posiada(jan,auto).
posiada(ewa,radio).
posiada(tomasz,video).
posiada(monika,auto).
posiada(jan,radio).
ma_dostep(monika,video).
ma_dostep(monika,radio).
ma_dostep(monika,ksiazki).
lubi(ewa,radio).
lubi(monika,ksiazki).
lubi(tomasz,video).
lubi(ewa,video).
lubi(_,auto).
korzysta(ewa,plyty).
korzysta(X,Y):-posiada(X,Y),lubi(X,Y).
korzysta(X,Y):-ma_dostep(X,Y),lubi(X,Y).

%Laborka nr 2:
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

%Laborka nr 3 :wykonaj:-kolor(X),write(X),write(' ').
kolor(czerwony).
kolor(zielony).
kolor(niebieski).
pp(X,Y,Z):-p(X),p(Y),!,p(Z).
pp(aa,bb,cc):-p(c).
p(a).
p(b).
p(c).
p(d).
rejestracja(X):-student(X),pom(X,Y),Y<10000.
pom(X,Y):-doch�d(X,Y),!.
student(321).
student(444).
student(222).
student(123).
student(124).
doch�d(321,12000).
doch�d(444,9000).
doch�d(311,8800).
doch�d(541,18000).
doch�d(222,2400).
doch�d(123,13000).
doch�d(124,11500).
doch�d(311,8800).
wsp�lny(X,L1,L2):-element(X,L1),element(X,L2).
element(X,[X|_]).
element(X,[_|O]):-element(X,O).
czesc_wspolna(L1,L2,L):-findall(X,wsp�lny(X,L1,L2),L).
zatrudni(X):-not(s_c(X,z)),not(plec(X,m)).
s_c(barbara,z).
s_c(jan,w).
s_c(ewa,w).
plec(barabara,k).
plec(jan,m).
plec(ewa,k).

%Laborka nr 4/cwiczenia :

/* dolacz element do konca listy*/
dolaczk(X,[],[X]).
dolaczk(X,[G|O],[G|O1]):-dolaczk(X,O,O1).
/* usun element z listy*/
usunel(X,[X],[]).
usunel(X,[G|O],[G1|O1]):-usunel(X,G,G1).
usunel(X,[G|O],[G1|O1]):-usunel(X,O,O1).
/* zlicza elementy w liscie */

dlugosc([],0).
dlugosc([G|O],N):-dlugosc(O,N1),N is N1+1.

/* zwr�c element o zadanym indeksie */
indeks(1,[G|_],G).
indeks(X,[G|O],N):-indeks(X1,O,N),X1 is X-1.
/*znajdz ostatni element w liscie */
ostatni([X],X).
ostatni([G|O],N):-ostatni(O,N).

/*duplikuj elementy z listy */

duplikuj([],[]).
duplikuj([G|O],[G,G|O1]):-duplikuj(O,O1).
















