#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

#ifndef FILE
#define FILE

typedef struct maillon maillon;
typedef struct file file;

file* creer_file(void);
int file_taille(file* f);
bool file_est_vide(file* f);
void file_push(file* f, int x);
int file_peek(file* f);
int file_pop(file* f);
void free_file(file* f);

#endif
