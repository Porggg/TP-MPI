 
(* Automates dÃ©terministes *)

type (' a, ' b) afd = {
  init: ' a;
  accept: ' a list;
  delta: ((' a * ' b) * ' a) list
}
;;

(* L'automate A3 *)
let auto3 = {
  init = 0;
  accept = [0];
  delta = [
    ((0, 0), 0);
    ((0, 1), 1);
    ((1, 0), 2);
    ((1, 1), 0);
    ((2, 0), 1);
    ((2, 1), 2);
  ]}
;;

(* Automates non dÃ©terministes *)

type (' a, ' b) afnd = {
  nd_init: ' a list;
  nd_accept: ' a list;
  nd_delta: ((' a * ' b) * ' a) list
}
;;

(* Partie 4 *)

type afd2 = {
  nb : int;
  init : int;
  final : int list;
  trans: (int*char*int) list
}
;;

type graph = int list array ;;

(* un exemple *)
let ex1 = {
  nb = 8 ;
  init = 0 ;
  final = [1;3] ;
  trans = [(0,'a',1);(0,'b',0);(1,'a',2);(1,'b',0);(2,'a',6);(2,'b',3);
           (4,'a',0);(4,'b',1);(5,'a',4);(5,'b',5);(6,'b',3);(7,'a',3);(7,'b',7)
          ]} ;;
