type couleur =  Blanc | Gris | Noir ;;
(* GRAPHES *)

let g1=[| [2]; [5; 9]; [0; 6; 7]; []; [6; 8]; [1]; [2; 4; 7; 8]; [2; 6]; [4; 6]; [1] |] ;;
let g2=[| []; [0]; []; []; [3; 8]; [1; 8]; [3]; [4]; [0] |];;
let g3=[| [1]; [5; 6]; [8]; [0; 4]; [3; 9]; [1; 6; 10; 11]; [5]; [8]; [2]; []; [5]; [6; 7; 12]; [13]; [12] |];;


let creer_liste i = 
  let rec aux l k = match k with 
  | 0 -> l
  | _ -> k::(aux l (k-1))
  in 0::List.rev (aux [] (i-1))
  ;;

creer_liste 10;;

let parcours_prof_gen g liste_som =
  let n = Array.length g in
  let color = Array.make n Blanc in
  let enum_glob = ref [] in
  let enum = ref [] in
  let enums = ref [] in
  let gris_encore = ref false in
  let rec pp u =
    color.(u) <- Gris ;
    let rec aux l = match l with
      | [] -> color.(u) <- Noir ;
              enum := u::!enum ;
              enum_glob := u::!enum_glob
      | v::q when color.(v) = Gris -> gris_encore := true ; aux q
      | v::q when color.(v) = Blanc -> pp v ; aux q
      | v::q -> aux q
    in aux g.(u)
  in
  let rec pp_principal l = match l with
    | [] -> ( !gris_encore, !enums , !enum_glob)
    | u::q when color.(u) = Blanc -> enum := [] ;
                                     pp u ;
                                     enums := !enum::!enums ;
                                     pp_principal q
    | u::q -> pp_principal q
  in pp_principal liste_som
;;
;;

parcours_prof_gen g1 (creer_liste 10) ;;

parcours_prof_gen g2 (creer_liste 9) ;;

parcours_prof_gen g3 (creer_liste 14) ;;

(* Exercice 3 *)

let tri_topologique g =
  let n = Array.length g in
  let (b, _, p) = parcours_prof_gen g (creer_liste n) in
  if not b then p
  else failwith "Il y a un cycle"
;;

tri_topologique g2 ;;

tri_topologique g3 ;;

(* Exercice 4 *)

let composantes_connexes g =
  let n = Array.length g in
  let (_, l, _) = parcours_prof_gen g (creer_liste n) in
  l
;;

composantes_connexes g1 ;;

(* Exercice 5 *)

let graphe_transpose g =
  let n = Array.length g in
  let tg = Array.make n [] in
  let rec aux l i = match l with
    | [] -> ()
    | j::q -> tg.(j) <- i::tg.(j) ; aux q i
  in
  for i=0 to n-1 do
    aux g.(i) i
  done ;
  tg
;;

let kosaraju g = 
  let n = Array.length g in
  let tg = graphe_transpose g in

  let (_, _, k) = parcours_prof_gen g (creer_liste n) in
  let (_, l, _) = parcours_prof_gen tg k in
  l
  ;;

kosaraju g1;;  
kosaraju g2;;
kosaraju g3;;


  
  
   

