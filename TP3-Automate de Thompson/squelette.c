#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <stdio.h>
#include <assert.h>


#define EPS 256
#define ALL 257
#define MATCH 258

#define MAX_LINE_LENGTH 1024

struct state {
    int c;
    struct state *out1;
    struct state *out2;
    int last_set;
};

typedef struct state state_t;

struct nfa {
    state_t *start;
    state_t *final;
    int n;
};

typedef struct nfa nfa_t;

struct stack {
    int length;
    int capacity;
    nfa_t *data;
};

typedef struct stack stack_t;

struct set {
    int length;
    int id;
    state_t **states;
};

typedef struct set set_t;

state_t* new_state(int c, state_t *out1, state_t *out2){
    state_t* state = (state_t*)malloc(sizeof(stack_t));
    state->c = c ;
    state->out1 = out1 ;
    state->out2 = out2 ;
    state->last_set = -1 ; 
    return state ; 
}

nfa_t character(int c){
    state_t* final = new_state(MATCH,NULL, NULL) ;
    state_t* start = new_state(c,final,NULL) ;
    nfa_t nfa = {.start = start, .final = final, .n = 2} ;
    return nfa ;
}
nfa_t all(void){
    state_t* final = new_state(MATCH,NULL, NULL) ;
    state_t* start = new_state(ALL,final,NULL) ;
    nfa_t nfa = {.start = start, .final = final, .n = 2} ;
    return nfa ;
}

nfa_t concat(nfa_t a, nfa_t b){
    state_t* final = b.final;
    state_t* start = a.start;
    a.final->c = EPS;
    a.final->out1 = b.start;
    int n = a.n + b.n;
    nfa_t concat = {.start = start, .final = final, .n = n};
    return concat;
}

nfa_t alternative(nfa_t a, nfa_t b){
    state_t* final = new_state(MATCH,NULL,NULL);
    state_t* start = new_state(EPS,a.start,b.start);
    a.final->c = EPS;
    b.final->c = EPS;
    a.final->out1 = final;
    b.final->out1 = final;
    int n = 2+a.n+b.n;
    nfa_t alt = {.start = start, .final = final, .n = n};
    return alt;
}

nfa_t star(nfa_t a){
    state_t* final = new_state(MATCH,NULL,NULL);
    state_t* start = new_state(EPS,a.start,final);
    a.final->c = EPS;
    a.final->out1 = final;
    a.final->out2 = a.start;
    int n = 2+a.n;
    nfa_t star = {.start = start, .final = final, .n = n};
    return star;
}

nfa_t maybe(nfa_t a){
    state_t* start = new_state(EPS,a.start,a.final);
    nfa_t maybe = {.start = start, .final = a.final, .n = 1+a.n};
    return maybe;
}

stack_t *stack_new(int capacity){
    stack_t *s = malloc(sizeof(stack_t));
    s->data = malloc(capacity * sizeof(nfa_t));
    s->capacity = capacity;
    s->length = 0;
    return s;
}

void stack_free(stack_t *s){
    free(s->data);
    free(s);
}

nfa_t pop(stack_t *s){
    assert(s->length > 0);
    nfa_t result = s->data[s->length - 1];
    s->length--;
    return result;
}

void push(stack_t *s, nfa_t a){
    assert(s->capacity > s->length);
    s->data[s->length] = a;
    s->length++;
}

nfa_t build(char *regex);

bool backtrack(state_t *state, char *s);

//bool accept_backtrack(nfa_t a, char *s){
//    return backtrack(a.start, s);
//}

//void match_stream_backtrack(nfa_t a, FILE *in){
//    char *line = malloc((MAX_LINE_LENGTH + 1) * sizeof(char));
//    while (true) {
//        if (fgets(line, MAX_LINE_LENGTH, in) == NULL) break;
//        if (accept_backtrack(a, line)) {
//            printf("%s", line);
//        }
//    }
//    free(line);
//}


set_t *empty_set(int capacity, int id){
    state_t **arr = malloc(capacity * sizeof(state_t*));
    set_t *s = malloc(sizeof(set_t));
    s->length = 0;
    s->id = id;
    s->states = arr;
    return s;
}

void set_free(set_t *s){
    free(s->states);
    free(s);
}


void add_state(set_t *set, state_t *s);

void step(set_t *old_set, char c, set_t *new_set);

bool accept(nfa_t a, char *s, set_t *s1, set_t *s2);

void match_stream(nfa_t a, FILE *in);

int main(int argc, char* argv[]){

    return 0;
}
