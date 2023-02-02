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

file* new_file(){
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
  maillon* m = malloc(sizeof(maillon));
  m->value = x;
  m->next = NULL;
  if(file_est_vide(f)){
    f->first = m;
    f->last = m;
  }else{
    f->last->next = m;
    f->last = m;
  }
  f->size++;
}

int file_peek(file* f){
  return f->first->value;
}

int file_pop(file* f){
  int x = file_peek(f);
  maillon* m = f->first;
  f->first = f->first->next;
  free(m);
  f->size--;
  return x;
}

void free_file(file* f){
  while(!file_est_vide(f)){
    file_pop(f);
  }
  free(f);
}


