(* GRAPHES *)

let g1=[| [2]; [5; 9]; [0; 6; 7]; []; [6; 8]; [1]; [2; 4; 7; 8]; [2; 6]; [4; 6]; [1] |] ;;
let g2=[| []; [0]; []; []; [3; 8]; [1; 8]; [3]; [4]; [0] |];;
let g3=[| [1]; [5; 6]; [8]; [0; 4]; [3; 9]; [1; 6; 10; 11]; [5]; [8]; [2]; []; [5]; [6; 7; 12]; [13]; [12] |];;

(* FORMULES LOGIQUES 2-SAT *)

type litteral = X of int | Xb of int ;;
type clause2 = litteral * litteral ;;
type formule2sat = clause2 list ;;

let fsat3 = [(Xb 0, X 1); (X 1, X 2); (Xb 1, Xb 2); (X 0, X 2); (X 0, Xb 2)] ;; (* une formule a 3 variables satisfiable *)
let fnsat3 = [(X 0, X 1); (Xb 0, X 2); (X 0, Xb 1); (Xb 1, X 2); (Xb 0, Xb 2)] ;; (* une formule a 3 variables non satisfiable *)
let fsat5 = [(X 2, X 4); (X 1, Xb 2); (X 0, Xb 3); (X 2, X 3); (Xb 3, X 4); (Xb 1, Xb 2); (X 1, X 4); (Xb 0, Xb 2); (Xb 0, X 3); (X 1, X 2); (X 1, X 3); (Xb 2, X 4); (X 0, Xb 4); (X 1, Xb 3); (Xb 1, X 3)] ;; (* une formule a 5 variables satisfiable *)
let fnsat5 = [(Xb 2, X 4); (X 1, Xb 2); (Xb 3, Xb 4); (Xb 0, Xb 3); (Xb 0, X 1); (Xb 1, Xb 4); (Xb 0, Xb 1); (Xb 1, X 3); (Xb 1, X 4); (Xb 2, Xb 3); (X 1, X 4); (X 3, Xb 4); (X 0, X 1); (Xb 0, Xb 4); (Xb 2, Xb 4)] ;; (* une formule a 5 variables non satisfiable *)
éé
