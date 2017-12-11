1. NxN N=20 -> wygenerowac 200 losowych wzorcow
2. Wygenerowac 200 uszkodzonych wzorcow (10% roznicy)
3. Petla glowna po i
	a) Liczymy dJi i dodajemy do J
	b) Liczymy Hopfieldem uszkodzony wzorzec i
	c) Sprawdzamy pokrycie mi dla wszystkich od nowa = 
		abs(1/N(Sum(Wzorzec i * to co otrzymalismy i ))
	d) liczymy srednie pokrycie m = sum(mi)/M
		Dodajemy sr m do wektora.
4. Rysujemy wektor sr m.
