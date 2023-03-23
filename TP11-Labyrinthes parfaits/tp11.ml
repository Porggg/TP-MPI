(* structure Union-find *)

type uf = { link: int array;
            rank: int array;
} ;;

let create n =
  { link = Array.init n (fun i -> i);
    rank = Array.make n 0; }
;;

let rec find uf i =
  let p = uf.link.(i) in
  if p = i then i else
    begin
      let r = find uf p in
      uf.link.(i) <- r;
      r
    end
;;

let union uf i j =
  let ri = find uf i in
  let rj = find uf j in
  if ri <> rj then
    if uf.rank.(ri) < uf.rank.(rj) then
      uf.link.(ri) <- rj
    else 
      begin
        uf.link.(rj) <- ri;
        if uf.rank.(ri) = uf.rank.(rj) then
          uf.rank.(ri) <- uf.rank.(ri) + 1
      end
;;

(* MÃ©lange Ã©quitable *)

Random.self_init () ;; (* initialise la seed du module Random *)

let melange_knuth tab =
  () (* TODO *)
;;

let tab = Array.init 10 (fun i -> i) in
melange_knuth tab ;
tab ;;

(* GÃ©nÃ©rateur de labyrinthes parfaits *)

type direction = H | V ;; (* horizontal ou vertical *)

type arete = int * int * direction ;;

let generer_aretes n : arete array =
  [||] (* TODO *)
;;

generer_aretes 3 ;;

let labyrinthe_parfait n =
  ([||], [||]) (* TODO *)
;;

labyrinthe_parfait 3 ;; (* le rÃ©sultat obtenu change Ã  chaque exÃ©cution *)

let afficher horiz vert =
  let n = Array.length horiz in
  print_newline () ;
  for i = 0 to n-1 do
    for j = 0 to n-1 do
      print_string "+" ;
      if i = 0 || vert.(i-1).(j)
      then print_string "--"
      else print_string "  "
    done ;
    print_string "+\n" ;
    for j = 0 to n-1 do
      if i = 0 && j = 0
      then print_string ">"
      else if j = 0 || horiz.(i).(j-1)
      then print_string "|"
      else print_string " " ;
      print_string "  "
    done ;
    if i = n-1
    then print_string ">\n"
    else print_string "|\n"
  done ;
  for j = 0 to n-1 do
    print_string "+--"
  done ;
  print_string "+\n" ;
  print_newline ()
;;

(* test final *)
let (horiz, vert) = labyrinthe_parfait 10 in
afficher horiz vert ;;
