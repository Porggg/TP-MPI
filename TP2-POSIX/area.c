// Nombre d'Avogadro
double Na = 6.02214076e23;

// Constante gravitationnelle
double G = 6.6742E-11;

// Charge élémentaire d'un électron
double c_e = -1.602e-19;

// Autres constantes
double a = -12;
double b = 42;

double disk_area(double r) {
  double pi = 3.14159265;
  if (r < 0.0) {
    // on considère les longueurs négatives comme nulles
    r = 0.0;
  }
  return pi * r * r;
}
