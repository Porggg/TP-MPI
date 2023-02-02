let rec binaire_faible n = match n with 
  | 0 -> []
  | _ -> (n mod 2):: (binaire_faible (n/2)) ;;
binaire_faible 6;;


let binaire_fort n = List.rev(binaire_faible n) ;;
binaire_fort 6;;

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

let rec mem x l = match l with 
  | [] -> false
  | a::q when a = x -> true
  | a::q -> mem x q
  ;;
mem 6 [1;2;3;4;5];; 

let rec mem_fst x l = match l with 
  | [] -> false
  | (b,_)::q when b = x -> true
  | (_,_)::q -> mem_fst x q 
;;
mem_fst (1,1) auto3.delta;;
mem_fst (2,2) auto3.delta;;

let rec assoc x l = match l with 
  | [] -> raise Not_found
  | (a,b)::q when a=x -> b
  | (a,b)::q -> assoc x q
;;
assoc (1,1) auto3.delta ;;
assoc (2,2) auto3.delta ;;

let reconnu auto l =
  let rec reconnu_aux auto l actuel = match l with
    | [] -> actuel
    | a::q -> reconnu_aux auto q (assoc (actuel,a) auto.delta)
  in mem (reconnu_aux auto l auto.init) auto.accept 
;;
reconnu auto3 (binaire_fort 6) ;;
reconnu auto3 (binaire_fort 7) ;;
reconnu auto3 (binaire_fort 8) ;;

let genere_fort d =
  let f = ref [] in
  for i = 0 to 2*d-1 do
    f := ((i/2,i mod 2),i mod d)::!f ;
  done;
  let auto = {init = 0; accept=[0]; delta = List.rev !f } in 
  auto
;;
let a3 = genere_fort 3;;
reconnu a3 (binaire_fort 365) ;;
reconnu a3 (binaire_fort 364) ;;
reconnu a3 (binaire_fort 363) ;;
reconnu a3 (binaire_fort 362) ;;
let a5 = genere_fort 5;;
reconnu a5 (binaire_fort 365) ;;
reconnu a5 (binaire_fort 364) ;;
reconnu a5 (binaire_fort 363) ;;
reconnu a5 (binaire_fort 361) ;;
reconnu a5 (binaire_fort 360) ;;


type (' a, ' b) afnd = {
  nd_init: ' a list;
  nd_accept: ' a list;
  nd_delta: ((' a * ' b) * ' a) list
}
;;

let genere_faible d =
  let auto_d = genere_fort d in
  let rec aux = function
    | [] -> []
    | ((q, a), q')::v -> ((q', a), q)::(aux v) 
  in
  {nd_init = auto_d.accept; nd_accept = auto_d.init::[] ; nd_delta = aux auto_d.delta}
;;




  

