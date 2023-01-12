#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
// #include <math.h> // utile pour A*
// #include "file.h" // utile pour le parcours en largeur
// #include "tasmin.h" // utile pour Dijkstra et A*

struct arc {
  int sommet; // sommet d'arrivée
  float poids;
  struct arc* next;
};

typedef struct arc arc;
struct graphe {
  int nb_sommets;
  arc** voisins;
};
typedef struct graphe graphe;

/* Partie 1 */

graphe init_graphe(int n){
  graphe g;
  g.nb_sommets = n;
  g.voisins = malloc(n*sizeof(arc*));
    for(int i = 0; i <= n-1; i++){
        g.voisins[i] = NULL;
    }
    return g;
}

float poids(graphe G, int s, int t){
  arc* voisin = G.voisins[s];
  while (voisin != NULL){
    if(voisin->sommet == t){return voisin->poids;}
    else{voisin = voisin->next;}
  }
  return -1;
}

void ajouter_arc(graphe G, int s, int t, float w){
  if(poids(G,s,t) == -1){
    arc* new = malloc(sizeof(arc));
    new->poids = w;
    new->sommet = t;
    new->next = NULL;
    if(G.voisins[s] == NULL){
      G.voisins[s]=new;
    }
    else{
      new->next = G.voisins[s] ;
      G.voisins[s] = new;
    }
  }
}

void free_graphe(graphe G){
  int n = G.nb_sommets;
  for(int i=0;i<=n-1;i++){
    arc* voisin = G.voisins[i];
    while(voisin != NULL){
      arc* v = voisin->next;

      free(voisin);
      voisin = v;
    }
  }
}

/* Partie 2 */

void distances(graphe G, int s, float* dist, int* pred){
  /* TODO */
}

void chemin(int s, int t, int* pred){
  /* TODO */
}

/* Partie 3 */

void dijkstra(graphe G, int s, float* dist, int* pred){
  /* TODO */
}

/* Partie 4 */

struct coord{
  float x;
  float y;
};
typedef struct coord coord;

float h(coord* pos, int i, int j){
  /* TODO */
  return 0;
}

float astar(graphe G, int s, int t, coord* pos, float* dist, int* pred){
  /* TODO */
  return -1;
}

int main(){
  graphe G = init_graphe(5);
  ajouter_arc(G,0,1,10);
  ajouter_arc(G,0,4,5);
  ajouter_arc(G,1,2,1);
  ajouter_arc(G,1,4,2);
  ajouter_arc(G,2,3,4);
  ajouter_arc(G,3,2,6);
  ajouter_arc(G,3,0,7);
  ajouter_arc(G,4,1,3);
  ajouter_arc(G,4,2,9);
  ajouter_arc(G,4,3,2);
  // Test partie 1
  printf("\nTest partie 1\n");
  printf("L'arc 0->4 vaut : %f\n", poids(G,0,4));
  printf("L'arc 2->3 vaut : %f\n", poids(G,2,3));
  printf("L'arc 4->2 vaut : %f\n", poids(G,4,2));
  printf("L'arc 2->4 n'existe pas : %f\n", poids(G,2,4));

  /* Déplacer cette ligne à la fin des tests souhaités
  // Test parcours en largeur
  printf("\nTest parcours en largeur\n");
  float dist[5] = {-1, -1, -1, -1, -1};
  int pred[5] = {-1, -1, -1, -1, -1};
  distances(G,0,dist,pred);
  printf("distance 0--3 : %f\n", dist[3]);
  chemin(0,3,pred);

  // Test Dijkstra
  printf("\nTest Dijkstra\n");
  // On réinitialise dist et pred
  for (int i = 0; i < 5; i++)
  {
    dist[i] = 1000;
    pred[i] = -1;
  }
  dijkstra(G,0,dist,pred);
  printf("distance 0--2 : %f\n", dist[2]);
  chemin(0,2,pred);

  // Test A*
  printf("\nTest A*\n");
  // On réinitialise dist et pred
  for (int i = 0; i < 5; i++)
  {
    dist[i] = 1000;
    pred[i] = -1;
  }
  coord pos[5] = {{.x=0,.y=0},{.x=1,.y=2}, {.x=-3,.y=-1}, {.x=4,.y=-1}, {.x=2,.y=2}};
  printf("distance 0--2 : %f\n", astar(G,0,2,pos,dist,pred));
  chemin(0,2,pred);

  printf("\nTest : mauvaise heuristique\n");
  // On réinitialise dist et pred
  for (int i = 0; i < 5; i++)
  {
    dist[i] = 1000;
    pred[i] = -1;
  }
  pos[4].x=20;
  pos[4].y=20;
  printf("distance 0--2 : %f\n", astar(G,0,2,pos,dist,pred));
  chemin(0,2,pred);

  Ignorer certains tests */

  free_graphe(G);
}
