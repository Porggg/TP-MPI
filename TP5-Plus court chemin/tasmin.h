#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

#ifndef TASMIN
#define TASMIN

typedef struct elem elem;
typedef struct tasmin tasmin;

tasmin* creer_tasmin(void);
int tasmin_taille(tasmin* t);
bool tasmin_est_vide(tasmin* t);
void tasmin_push(tasmin* t, int x, float p); // O(log n)
int tasmin_peek(tasmin* t); // O(1)
int tasmin_pop(tasmin* t); // O(log n)
void free_tasmin(tasmin* t);

#endif
