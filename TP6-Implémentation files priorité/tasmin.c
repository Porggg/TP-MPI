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

int fg(int i){
  return 0; // TODO
}

int fd(int i){
  return 0; // TODO
}

int pere(int i){
  return 0; // TODO
}

void echanger(elem* a, int i, int j){
  /* TODO */
}

tasmin* creer_tasmin(){
  tasmin* t;
  /* TODO */
  return t;
}

int tasmin_taille(tasmin* t){
  return 0; // TODO
}

bool tasmin_est_vide(tasmin* t){
  return false; // TODO
}

int tasmin_peek(tasmin* t){
  return 0; // TODO
}

void free_tasmin(tasmin* t){
  /* TODO */
}

void monter_noeud(elem* a, int i){
  /* TODO */
}

void descendre_noeud(elem *a, int n, int i){
  /* TODO */
}

void tasmin_push(tasmin* t, int x, float p){
  /* TODO */
}

int tasmin_pop(tasmin* t){
  return 0; // TODO
}

