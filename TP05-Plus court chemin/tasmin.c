#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include "tasmin.h"

struct elem{
  int val;
  float prio;
};

struct tasmin{
  int capacite;
  int nb_elem;
  elem* tab;
};

tasmin* creer_tasmin(){
  tasmin* t = malloc(sizeof(tasmin));
  t->capacite = 42;
  t->nb_elem = 0;
  t->tab = malloc(t->capacite * sizeof(elem));
  return t;
}

int tasmin_taille(tasmin* t){
  return t->nb_elem;
}

bool tasmin_est_vide(tasmin* t){
  return t->nb_elem == 0;
}

int fg(int i){
  return 2*i+1;
}

int fd(int i){
  return 2*i+2;
}

int pere(int i){
  return (i-1)/2;
}

void echanger(elem* a, int i, int j){
  elem tmp = a[i];
  a[i] = a[j];
  a[j] = tmp;
}

void monter_noeud(elem* a, int i){
  if (i !=0 && a[pere(i)].prio > a[i].prio){
    echanger(a,i,pere(i));
    monter_noeud(a,pere(i));
  }
}

void descendre_noeud(elem *a, int n, int i){
  int j = i;
  if (fg(i) < n && a[fg(i)].prio < a[i].prio) { j = fg(i); }
  if (fd(i) < n && a[fd(i)].prio < a[i].prio) { j = fd(i); }
  if (i != j)
  {
    echanger(a,i,j);
    descendre_noeud(a,n,j);
  }
}

void tasmin_push(tasmin* t, int x, float p){
  if (t->capacite == t->nb_elem)
  {
    t->capacite = 2 * t->capacite + 1;
    t->tab = realloc(t->tab, t->capacite);
  }
  elem e = {.val = x, .prio = p};
  t->tab[t->nb_elem] = e;
  t->nb_elem++;
  monter_noeud(t->tab, t->nb_elem-1);
}

int tasmin_peek(tasmin* t){
  return t->tab[0].val;
}

int tasmin_pop(tasmin* t){
  t->nb_elem--;
  echanger(t->tab, 0, t->nb_elem);
  descendre_noeud(t->tab, t->nb_elem, 0);
  return t->tab[t->nb_elem].val;
}

void free_tasmin(tasmin* t){
  free(t->tab);
  free(t);
}

