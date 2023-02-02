(* a mettre dans la console directement
#load "tasMin.cmo" ;;
#load "unionFind.cmo" ;;*)

(* Kruskal *)

let g = [|
  [(1,1.0); (2,2.0)] ;
  [(0,1.0); (2,3.0); (3,3.0)] ;
  [(0,2.0); (1,3.0); (3,4.0); (4,6.0)] ;
  [(1,3.0); (2,4.0); (4,4.0); (5,5.0)] ;
  [(2,6.0); (3,4.0); (5,2.0)] ;
  [(3,5.0); (4,2.0)]
|] ;;

let edges g =
  [] (* TODO *)
;;

edges g ;;

let kruskal g =
  [] (* TODO *)
;;

kruskal g ;;

(* couplage maximum dans un graphe biparti *)

let couplage_maximum g fX =
  [] (* TODO *)
;;

(* exemple d'ensembles X et Y  : sommets pairs et impairs *)
let fX s = s mod 2 = 0 ;; (* on donne la fonction caractéristique de X *)

let g1 = [| [3;1] ; [0;2] ; [5;3;1] ; [0;2;4] ; [3] ; [2] |] ;;

couplage_maximum g1 fX ;;

let g2 = [| [3;7] ; [2;4] ; [1;3;5;7] ; [0;2;6] ; [1] ; [2] ; [3;7] ; [0;2;6] |] ;;

couplage_maximum g2 fX ;;

