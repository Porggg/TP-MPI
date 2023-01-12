(* Exercice 1 *)
(* Q1 *)
let rec binaire_faible n = match n with
  | 0 -> []
  | n -> (n mod 2) :: (binaire_faible (n/2))
;;

(* Q2 *)
let binaire_fort n = List.rev (binaire_faible n)
;;

(* Version Ã  la main avec un accumulateur *)
let bin_fort n =
  let rec aux acc n = match n with
    | 0 -> acc
    | n -> aux ((n mod 2) :: acc) (n / 2)
  in aux [] n;;

binaire_faible 6 ;;

binaire_fort 6 ;;

(* Exercice 2 *)

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

(* Q3 *)
let rec mem x l = match l with
  | [] -> false
  | t::q -> (t = x) || mem x q
;;

(* Q4 *)
let rec mem_fst x l = match l with
  | [] -> false
  | (x',_)::q -> (x' = x) || mem_fst x q
;;

(* Q5 *)
let rec assoc x l = match l with
  | [] -> raise Not_found
  | (x',y)::q when x' = x -> y
  | _::q -> assoc x q
;;

mem_fst (1,1) auto3.delta ;;

mem_fst (2,2) auto3.delta ;;

assoc (1,1) auto3.delta ;;

assoc (2,2) auto3.delta ;;

(* Q6 *)
let reconnu a mot =
  let rec aux e l = match l with
    | [] -> mem e a.accept
    | t::q when (mem_fst (e, t) a.delta) -> aux (assoc (e, t) a.delta) q
    | _ -> false
  in aux a.init mot
;;

reconnu auto3 (binaire_fort 6) ;;
reconnu auto3 (binaire_fort 7) ;;
reconnu auto3 (binaire_fort 8) ;;

(* Exercice 4 *)

(* Q7 *)
let genere_fort d =
  let rec aux q = match q=d with
    | true -> []
    | false -> ((q,0), (2*q) mod d)::((q,1), (2*q+1) mod d)::(aux (q+1))
  in {init = 0; accept = [0]; delta = aux 0}
;;


(* test *)
let a3 = genere_fort 3 ;;

reconnu a3 (binaire_fort 365) ;;
reconnu a3 (binaire_fort 364) ;;
reconnu a3 (binaire_fort 363) ;;
reconnu a3 (binaire_fort 362) ;;

let a5 = genere_fort 5 ;;

reconnu a5 (binaire_fort 365) ;;
reconnu a5 (binaire_fort 364) ;;
reconnu a5 (binaire_fort 363) ;;
reconnu a5 (binaire_fort 362) ;;
reconnu a5 (binaire_fort 361) ;;
reconnu a5 (binaire_fort 360) ;;

type (' a, ' b) afnd = {
  nd_init: ' a list;
  nd_accept: ' a list;
  nd_delta: ((' a * ' b) * ' a) list
}
;;

(* Exercice 3 *)

(* Q8 *)
(* Automate miroir :
 * echanger etats initiaux et finals, et echanger le sens des fleches
 *)

let genere_faible d =
  let a = genere_fort d in
  let rec aux = function
    | [] -> []
    | ((q, a), q')::v -> ((q', a), q)::(aux v)
  in {nd_init = a.accept; nd_accept = [a.init]; nd_delta = aux a.delta}
;;

(* Q9 *)
let rec exists pred l = match l with
  | [] -> false
  | t :: q -> (pred t) || exists pred q
;;

(* Q10 *)
let reconnu2 a mot =
  let rec aux e m delta = match (m, delta) with
    | ([], _) -> mem e a.nd_accept (* fin du mot *)
    | (_, []) -> false (* pas de transition *)
    | (a1::m1, ((q, c), r)::v) when q = e && c = a1 ->
      (* la premiÃ¨re transition peut Ãªtre prise : bonne lettre et bon Ã©tat source *)
      aux r m1 a.nd_delta (* on essaye de la prendre *)
      || aux e m v (* backtracking : on ne la prend pas *)
    | (m, _::v) -> aux e m v (* la premiÃ¨re transition ne peut pas Ãªtre prise *)
  in
  (* on essaye tous les Ã©tats initiaux *)
  exists (function e -> aux e mot a.nd_delta) a.nd_init
;;

let af5 = genere_faible 5 ;;

reconnu2 af5 (binaire_faible 3664064) ;;
reconnu2 af5 (binaire_faible 3664061) ;;
reconnu2 af5 (binaire_faible 3664063) ;;
reconnu2 af5 (binaire_faible 3664065) ;;

(* Exercice 4 *)

type afd2 = {
  nb : int;
  init : int;
  final : int list;
  trans: (int*char*int) list
}
;;

type graph = int list array ;;

(* Q11 *)
let auto_to_graph a = 
  let n = a.nb in
  let g = Array.make n [] in
  let rec lire t = match t with
    | [] -> ()
    | (q,x,q')::t' ->
      if not (List.mem q' g.(q)) then g.(q) <- q' ::g.(q) ;
      lire t' 
  in
  lire a.trans ;
  g
;;

(* un exemple *)
let ex1 = {
  nb = 8 ;
  init = 0 ;
  final = [1;3] ;
  trans = [(0,'a',1);(0,'b',0);(1,'a',2);(1,'b',0);(2,'a',6);(2,'b',3);
           (4,'a',0);(4,'b',1);(5,'a',4);(5,'b',5);(6,'b',3);(7,'a',3);(7,'b',7)
          ]} ;;

let g1 = auto_to_graph ex1;;


(* Q12 *)
let transpose g =
  let n = Array.length g in
  let g' = Array.make n [] in
  let rec lire l i = match l with
    | [] -> ()
    | j::q -> g'.(j)<- i::g'.(j) ; lire q i
  in
  for i = 0 to (n-1) do
    lire g.(i) i
  done ;
  g'
;;

let g1' = transpose g1 ;;

(* Q13 *)
let rec intersecte l1 l2 =  match l1 with
  | []-> []
  | x::l1' when List.mem x l2 -> x::(intersecte l1' l2)
  | _::l1' -> intersecte l1' l2
;;

intersecte [1;2;3] [4;5;3;5;2];;

(* Q14 *)
let rec nettoie l = match l with
  | [] -> []
  | x::q when List.mem x q -> nettoie q
  | x::q -> x :: (nettoie q)
;;

nettoie [1;2;3;2;1;2;3;2;1;2;3] ;;

(* Q15 *)
let parcours g s0 = 
  let n = Array.length g in
  let dejavu = Array.make n false in
  let rec ajout_voisins l = match l with
    | [] -> []
    | x::q when dejavu.(x) -> ajout_voisins q
    | x::q -> begin dejavu.(x) <- true ; 
        x :: (ajout_voisins (g.(x)@q))
      end 
  in
  ajout_voisins [s0]
;;

parcours g1 0 ;;

parcours g1' 4 ;;
parcours g1' 5 ;;
parcours g1' 7 ;;

(* Q16 *)
let numeros nb l =
  let t = Array.make nb (-1) in
  let cpt = ref 0 in
  for i = 0 to nb-1 do
    if mem i l then
      begin
        t.(i) <- !cpt ;
        incr cpt
      end
  done;
  fun j -> t.(j)
;;

(* Q17 *)
let emonde a = 
  let g = auto_to_graph a in
  let g_tilde = transpose g in
  let access = parcours g a.init in
  let co_access = 
    let rec lire l = match l with
        [] -> []
      |f1::q -> (parcours g_tilde f1)@(lire q)
    in lire a.final
  in
  let utiles = nettoie (intersecte access co_access) in
  let num = numeros a.nb utiles in
  let new_final = 
    List.filter (fun x -> List.mem x utiles) a.final in
  let new_trans = List.filter 
      (fun (q,a,q') -> List.mem q utiles && List.mem q' utiles) a.trans
  in
  if List.mem a.init utiles then
    {
      nb = List.length utiles ;
      init = num a.init ;
      final = List.map num new_final ;
      trans = List.map (fun (q,c,q') -> (num q, c, num q')) new_trans
    }
  else
    {nb = 0 ; init = -1 ; final = [] ; trans = []}
;;

(* exemples *)
emonde ex1 ;;

let ex2 = {
  nb = 8 ;
  init = 0 ;
  final = [1;3] ; 
  trans = [(0,'a',1);(0,'b',0);(1,'b',0);(2,'a',6);(2,'b',3);(4,'a',0);
           (4,'b',1);(5,'a',4);(5,'b',5);(6,'b',3);(7,'a',3);(7,'b',7)
          ]} ;;

emonde ex2 ;;

let ex3 = {
  nb = 8 ;
  init = 0 ;
  final = [4;5;7] ; 
  trans = [(0,'a',1);(0,'b',0);(1,'a',2);(1,'b',0);(2,'a',6);(2,'b',3);
           (4,'a',0);(4,'b',1);(5,'a',4);(5,'b',5);(6,'b',3);(7,'a',3);(7,'b',7)
          ]} ;;

emonde ex3 ;; 
