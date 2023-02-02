#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include "file.h"

struct maillon{
  int value;
  maillon* next;
};

struct file{
  int size;
  maillon* first;
  maillon* last;
};

file* creer_file(){
  file* f = malloc(sizeof(file));
  f->size = 0;
  f->first = NULL;
  f->last = NULL;
  return f;
}

int file_taille(file *f){
  return f->size;
}

bool file_est_vide(file* f){
  return f->size == 0;
}

void file_push(file* f, int x){
  maillon* new = malloc(sizeof(maillon));
  new->value = x;
  new->next = NULL;
  if (f->first == NULL)
  {
    f->first = new;
    f->last = new;
  }
  else
  {
    f->last->next = new;
    f->last = new;
  }
  f->size++;
}

int file_peek(file* f){
  return f->first->value;
}

int file_pop(file* f){
  int v = f->first->value;
  maillon* old = f->first;
  f->first = f->first->next;
  f->size--;
  free(old);
  if (f->first == NULL)
  {
    f->last = NULL;
  }
  return v;
}

void free_file(file* f){
  while (!file_est_vide(f))
  {
    file_pop(f);
  }
  free(f);
}
