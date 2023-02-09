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
  let e = ref [] in
  for i = 0 to Array.length g - 1 do
    List.iter (fun (s, ds) -> if s > i then e:=((i,s),ds)::!e) g.(i)
  done;
  !e
;;

edges g ;;

let kruskal g =
  let n = Array.length g in
  let u = UnionFind.create n in
  let q = TasMin.creer ((0,0),0.) in
  let t = ref [] in
  List.iter (fun ((x,y),d) -> TasMin.push q (x,y) d) (edges g);
  let taille = ref 0 in
  while !taille < n-1 do
    let arc = TasMin.pop q in
    if UnionFind.find u (fst arc) <> UnionFind.find u (snd arc) then (t:=arc::!t; incr taille;UnionFind.union u (fst arc) (snd arc);)
  done;
  !t  
;;

kruskal g ;;

(* couplage maximum dans un graphe biparti *)

let couplage_maximum g fX =
  let n = Array.length g in
  let c = Array.make n (-1) in (*arrete de y vers x qui sont couplées*)
  let rec augment x visited = 
    let visit y = not visited.(y) && 
                  (visited.(y) <- true; 
                  (c.(y) = -1 || augment c.(y) visited) &&
                  (c.(y) <- x; true)) in
    List.exists visit g.(x) in (*retourne qu'i y a un chemin augmentant des que visit renvoie true pour 1 voisin*)
    for i = 0 to n-1 do
      if fX i = true then let _ = augment i (Array.make n false) in () (*modifier c par effet de bord*)
    done ;
    let rec build acc y =
      if y >= n then acc else
      build (if c.(y) = -1 then acc else (c.(y),y)::acc) (y+1) in
    build [] 0
;;

(* exemple d'ensembles X et Y  : sommets pairs et impairs *)
let fX s = s mod 2 = 0 ;; (* on donne la fonction caractéristique de X *)

let g1 = [| [3;1] ; [0;2] ; [5;3;1] ; [0;2;4] ; [3] ; [2] |] ;;

couplage_maximum g1 fX ;;

let g2 = [| [3;7] ; [2;4] ; [1;3;5;7] ; [0;2;6] ; [1] ; [2] ; [3;7] ; [0;2;6] |] ;;

couplage_maximum g2 fX ;;

