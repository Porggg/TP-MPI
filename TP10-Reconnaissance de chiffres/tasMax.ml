type ('a,'b) tasmax = { mutable nb_elem : int ; mutable tab : ('a * 'b) array } ;;

let creer (a,b) = { nb_elem = 0 ; tab = Array.make 42 (a,b) } ;;

let taille t = t.nb_elem ;;

let est_vide t = t.nb_elem = 0 ;;

let fg i = 2*i+1 ;;

let fd i = 2*i+2 ;;

let pere i = (i-1)/2 ;;

let echanger tab i j =
  let tmp = tab.(i) in
  tab.(i) <- tab.(j) ;
  tab.(j) <- tmp
;;

let value = fst ;;
let prio = snd ;;

let rec monter_noeud tab i =
  if i <> 0 && prio tab.(pere i) < prio tab.(i) then
    begin
      echanger tab i (pere i) ;
      monter_noeud tab (pere i)
    end
;;

let rec descendre_noeud tab n i =
  let j = ref i in
  if fg i < n && prio tab.(fg i) > prio tab.(i) then j := fg i ;
  if fd i < n && prio tab.(fd i) > prio tab.(!j) then j := fd i ;
  if i <> !j then
    begin
      echanger tab i !j ;
      descendre_noeud tab n !j
    end
;;

let push t x p =
  let capacite = Array.length t.tab in
  if capacite = t.nb_elem then
    begin
      let tab' = Array.make (2*capacite+1) t.tab.(0) in
      for i = 0 to capacite - 1 do
        tab'.(i) <- t.tab.(i)
      done ;
      t.tab <- tab'
    end ;
  t.tab.(t.nb_elem) <- (x,p) ;
  t.nb_elem <- t.nb_elem + 1 ;
  monter_noeud t.tab (t.nb_elem - 1)
;;

let peek t = value t.tab.(0) ;;

let pop t =
  t.nb_elem <- t.nb_elem - 1 ;
  echanger t.tab 0 t.nb_elem ;
  descendre_noeud t.tab t.nb_elem 0 ;
  value t.tab.(t.nb_elem)
;;

