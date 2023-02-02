#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <math.h>
#include "file.h"
#include "tasmin.h"

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

graphe init_graphe(int n){
  graphe G;
  G.nb_sommets = n;
  G.voisins = (arc**)malloc(n * sizeof(arc*));
  for (int s = 0; s < n; s++)
  {
    G.voisins[s] = NULL;
  }
  return G;
}

float poids(graphe G, int s, int t){
  arc* voisin = G.voisins[s];
  while (voisin != NULL)
  {
    if (voisin->sommet == t)
    {
      return voisin->poids;
    }
    voisin = voisin->next;
  }
  return -1;
}

void ajouter_arc(graphe G, int s, int t, float w){
  if (G.voisins[s] == NULL)
  {
    G.voisins[s] = (arc*)malloc(sizeof(arc));
    G.voisins[s]->sommet = t;
    G.voisins[s]->poids = w;
    G.voisins[s]->next = NULL;
  }
  else
  {
    arc* voisin = G.voisins[s];
    while (voisin->next != NULL && voisin->sommet != t)
    {
      voisin = voisin->next;
    }
    if (voisin->sommet != t)
    {
      voisin->next = (arc*)malloc(sizeof(arc));
      voisin->next->sommet = t;
      voisin->next->poids = w;
      voisin->next->next = NULL;
    }
  }
}

void free_graphe(graphe G){
  for (int s = 0; s < G.nb_sommets; s++)
  {
    // On libère la liste chaînée des voisins de s
    arc* voisin = G.voisins[s];
    while (voisin != NULL)
    {
      arc* old = voisin;
      voisin = voisin->next;
      free(old);
    }
  }
  // On libère le tableau
  free(G.voisins);
}

void distances(graphe G, int s, float* dist, int* pred){
  dist[s] = 0;
  pred[s] = s;
  file* a_traiter = creer_file();
  file_push(a_traiter,s);
  // Initialisation de deja_vu
  bool* deja_vu = (bool*)malloc(G.nb_sommets * sizeof(bool));
  for (int i = 0; i < G.nb_sommets; i++)
  {
    deja_vu[i] = false;
  }
  deja_vu[s] = true;
  while (!file_est_vide(a_traiter))
  {
    int u = file_pop(a_traiter);
    arc* voisin = G.voisins[u];
    while (voisin != NULL)
    {
      int v = voisin->sommet;
      if (!deja_vu[v])
      {
        deja_vu[v] = true;
        file_push(a_traiter,v);
        dist[v] = dist[u] + 1;
        pred[v] = u;
      }
      voisin = voisin->next;
    }
  }
  free(deja_vu);
  free_file(a_traiter);
}

void chemin(int s, int t, int* pred){
  if (pred[t] == -1)
  {
    printf("pas de chemin\n");
    return;
  }
  printf("%d ",t);
  int current = t;
  while (current != s)
  {
    current = pred[current];
    printf("<- %d ", current);
  }
  printf("\n");
}

void dijkstra(graphe G, int s, float* dist, int* pred){
  dist[s] = 0;
  pred[s] = s;
  tasmin* tas = creer_tasmin();
  tasmin_push(tas,s,dist[s]);
  // Initialisation de deja_vu
  bool* deja_vu = (bool*)malloc(G.nb_sommets * sizeof(bool));
  for (int i = 0; i < G.nb_sommets; i++)
  {
    deja_vu[i] = false;
  }
  while (!tasmin_est_vide(tas))
  {
    int u = tasmin_pop(tas);
    if (deja_vu[u]) { continue; }
    arc* voisin = G.voisins[u];
    while (voisin != NULL)
    {
      int v = voisin->sommet;
      float w = voisin->poids;
      if (dist[v] > dist[u] + w)
      {
        dist[v] = dist[u] + w;
        pred[v] = u;
        if (!deja_vu[v])
        {
          tasmin_push(tas,v,dist[v]);
        }
      }
      voisin = voisin->next;
    }
    deja_vu[u] = true;
  }
  free(deja_vu);
  free_tasmin(tas);
}

struct coord{
  float x;
  float y;
};
typedef struct coord coord;

float h(coord* pos, int i, int j){
  float dx = pos[i].x - pos[j].x;
  float dy = pos[i].y - pos[j].y;
  return sqrt(dx*dx + dy*dy);
}

float astar(graphe G, int s, int t, coord* pos, float* dist, int* pred){
  dist[s] = 0;
  pred[s] = s;
  tasmin* tas = creer_tasmin();
  tasmin_push(tas,s,dist[s]);
  // Initialisation de deja_vu
  bool* deja_vu = (bool*)malloc(G.nb_sommets * sizeof(bool));
  for (int i = 0; i < G.nb_sommets; i++)
  {
    deja_vu[i] = false;
  }
  while (!tasmin_est_vide(tas))
  {
    int u = tasmin_pop(tas);
    if (u == t) { return dist[t]; }
    if (deja_vu[u]) { continue; }
    arc* voisin = G.voisins[u];
    while (voisin != NULL)
    {
      int v = voisin->sommet;
      float w = voisin->poids;
      if (dist[v] > dist[u] + w)
      {
        dist[v] = dist[u] + w;
        pred[v] = u;
        if (!deja_vu[v])
        {
          tasmin_push(tas, v, dist[v] + h(pos,v,t));
        }
      }
      voisin = voisin->next;
    }
    deja_vu[u] = true;
  }
  free(deja_vu);
  free_tasmin(tas);
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

  // Test parcours en largeur
  printf("\nTest parcours en largeur\n");
  float dist[5] = {-1, -1, -1, -1, -1};
  int pred[5] = {-1, -1, -1, -1, -1};
  distances(G,0,dist,pred);
  printf("distance 0--3 : %f\n", dist[3]);
  chemin(0,3,pred);

  /* Déplacer cette ligne à la fin des tests souhaités
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
