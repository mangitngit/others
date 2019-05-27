posiada(jan,auto).
posiada(ewa,radio).
posiada(tomasz,wideo).
posiada(monika,auto).
posiada(jan,radio).

ma_dostep(monika,wideo).
ma_dostep(monika,radio).
ma_dostep(monika,ksiazki).

lubi(ewa,radio).
lubi(monika,ksiazki).
lubi(tomasz,wideo).
lubi(ewa,wideo).
lubi(_,auto).

korzysta(ewa,plyty).
korzysta(X,Y):- posiada(X,Y), lubi(X,Y).
korzysta(X,Y):- ma_dostep(X,Y), lubi(X,Y).

