"""

"""
from math import floor, exp
import numpy as np
from matplotlib import pyplot as plt

p = - 0.8 + 0.19j


def check_c(c, it_max):
    x = 0
    for i in range(it_max):
        c = c ** 2 + p
        if abs(c) >= 2:
            x = i
            break
    return x


def funkcja_mal():
    # Zbiór Mandelbrota
    # Zakres układu współrzędnych
    x_min = -1.5
    x_max = 1.5
    y_max = 1.25
    y_min = -1.25

    iterations = 50

    m = int(input('podaj szerokość:\n'))
    n = floor(m * (y_max - y_min) / (x_max - x_min))
    unit = (x_max - x_min) / m
    mal = np.zeros((n, m, 3))

    c_0 = x_min + 1j*y_max
    c = c_0

    w1 = 50
    w2 = 50
    w3 = 50

    p1 = 2.2
    p2 = 2.2
    p3 = 2.2

    c1 = 1 / 4
    c2 = 1 / 2
    c3 = 3 / 4

    # f1 = @(x) exp(-w1 * abs(x - c1). ^ p1)
    # f1 = lambda x: exp(-w1 * abs(x - c1). ^ p1)
    # f2 = @(x) exp(-w2 * abs(x - c2). ^ p2)
    # f3 = @(x) exp(-w3 * abs(x - c3). ^ p3)

    for i in range(n):
        c = c - c.real + c_0.real
        for j in range(m):
            x = check_c(c, iterations) / iterations
            mal[i, j, 0] = (exp(-w1 * abs(x - c1) ** p1))
            mal[i, j, 1] = (exp(-w2 * abs(x - c2) ** p2))
            mal[i, j, 2] = (exp(-w3 * abs(x - c3) ** p3))
            # Mal[i, j, :] = x
            c = c + unit
        c = c - 1j*unit

    plt.imshow(mal)
    plt.show()


if __name__ == "__main__":
    funkcja_mal()
