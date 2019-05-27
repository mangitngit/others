import numpy as np
from PyQt5.QtGui import QGuiApplication as App
from PyQt5 import QtCore, QtGui
from PyQt5.QtWidgets import QApplication, QWidget, QLabel, QGridLayout, QPushButton, QHBoxLayout
from PyQt5.QtGui import QPixmap
import sys

class losowanie(QWidget):

    def __init__(self, parent=None):
        super().__init__(parent)
        self.ar = np.array([])
        self.randomy = 56
        self.interfejs()

    def interfejs(self):
        # etykiety
        etykieta1 = QLabel("Wylosowana:", self)
        etykieta2 = QLabel("Pytania:", self)

        # przypisanie widgetów do układu tabelarycznego
        ukladT = QGridLayout()
        ukladT.addWidget(etykieta1, 0, 0)
        ukladT.addWidget(etykieta2, 0, 2)

        # 1-liniowe pola edycyjne
        self.wynikEdt = QLabel("-")
        self.pytaniaEdt = QLabel("0 / "+str(self.randomy), self)

        ukladT.addWidget(self.wynikEdt, 0, 1)
        ukladT.addWidget(self.pytaniaEdt, 0, 3)

        # przyciski
        losujBtn = QPushButton("&Losuj", self)
        koniecBtn = QPushButton("&Koniec", self)

        adrianBtn = QPushButton("0", self)
        maciekBtn = QPushButton("0", self)
        mariuszBtn = QPushButton("0", self)

        # zdjecia

        adrian = QLabel(self)  # ustawienie obrazka ze wzorem
        obrazek = QPixmap('adrian.jpg')
        adrian.setPixmap(obrazek)

        maciek = QLabel(self)  # ustawienie obrazka ze wzorem
        obrazek = QPixmap('maciek.jpg')
        maciek.setPixmap(obrazek)

        mariusz = QLabel(self)  # ustawienie obrazka ze wzorem
        obrazek = QPixmap('mariusz.jpg')
        mariusz.setPixmap(obrazek)

        #koniecBtn.resize(koniecBtn.sizeHint())

        ukladZ = QHBoxLayout()
        ukladZ.addWidget(adrianBtn)
        ukladZ.addWidget(maciekBtn)
        ukladZ.addWidget(mariuszBtn)

        ukladH = QHBoxLayout()
        ukladH.addWidget(adrian)
        ukladH.addWidget(maciek)
        ukladH.addWidget(mariusz)

        ukladT.addLayout(ukladH, 1, 0, 1, 4)
        ukladT.addLayout(ukladZ, 2, 0, 1, 4)
        ukladT.addWidget(losujBtn, 3, 0, 1, 4)
        ukladT.addWidget(koniecBtn, 4, 0, 1, 4)

        # przypisanie utworzonego układu do okna
        self.setLayout(ukladT)

        losujBtn.clicked.connect(self.dzialanie)
        koniecBtn.clicked.connect(self.koniec)

        adrianBtn.clicked.connect(self.punkty)
        maciekBtn.clicked.connect(self.punkty)
        mariuszBtn.clicked.connect(self.punkty)

        #self.resize(500, 200)
        self.setWindowTitle("Randomy")
        self.resize(600, 400)
        self.show()

    def dzialanie(self):
        while True:
            random = np.random.randint(self.randomy) + 1
            check = [x for x in self.ar if x == random]

            if not check:
                self.ar = np.append(self.ar, random)
                self.ar = np.sort(self.ar)
                self.wynikEdt.setText(str(random))
                self.pytaniaEdt.setText(str(len(self.ar))+' / '+str(self.randomy))
                break
            elif len(self.ar) == self.randomy:
                self.wynikEdt.setText("Pula pytań została wyczerpana")
                break
            else:
                continue

    def punkty(self, event):
        nadawca = self.sender()
        a = (int)(nadawca.text())

        a += 1

        nadawca.setText(str(a))

    def koniec(self):
        self.close()


if __name__ == '__main__':

    app = QApplication(sys.argv)
    okno = losowanie()
    sys.exit(app.exec_())
