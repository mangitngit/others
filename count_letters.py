wzor = "COŚSIĘKOŃCZYCOŚSIĘZACZYNA"

wzor2 = "LEPIEJBEZCELUIŚĆNAPRZÓDNIŻBEZCELUSTAĆWMIEJSCUAZPEWNOŚCIĄONIEBOLEPIEJNIŻBEZCELUSIĘCOFAĆ"

#########################

odczyt = "MOKSŻĘKOŃCZYCOSSŹĘŻGCZYNM"

odczyt2 = "LEPIEJPEZCELUFŚĆNWPRZÓDNEZEEJCELUSTĄĆWMEEJSCUWZPEWNOSĆEĄONYEGOLEPYEJNIŻDEZEELUSIĘCOFJĆ"

#########################

liczba = 0

dlugie = 1

if dlugie:
    for i in range(len(wzor2)):
        if wzor2[i] == odczyt2[i]:
            liczba += 1

    print('Dokładność: ', liczba/len(wzor2), '%')
else:
    for i in range(len(wzor)):
        if wzor[i] == odczyt[i]:
            liczba += 1

    print('Dokładność: ', liczba/len(wzor), '%')
