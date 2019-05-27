wykonaj:-kolor(X),write(X),write(' '),fail.
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
pom(X,Y):-dochod(X,Y),!.
student(321).
student(444).
student(222).
student(123).
student(124).
dochod(321,12000).
dochod(541,18000).
dochod(444,9000).
dochod(222,2400).
dochod(123,13000).
dochod(124,11500).
dochod(311,8800).

wspolny(X,L1,L2):-element(X,L1),element(X,L2).
element(X,[X|_]).
element(X,[_|O]):-element(X,O).
czesc_wspolna(L1,L2,L):-findall(X,wspolny(X,L1,L2),L).

zatrudni(X):-not(s_c(X,z)),not(plec(X,m)).
s_c(barbary,z).
s_c(jan,w).
s_c(ewa,w).
plec(barbary,k).
plec(jan,m).
plec(ewa,k).

