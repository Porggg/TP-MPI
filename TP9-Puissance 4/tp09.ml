type puissance4 = { grille : int array array ;
                    libres : int array ;
                    mutable joueur : int ;
                    mutable vides : int
                  }
;;

let afficher jeu =   
  let symb = [|"_"; "X"; "O"|] in
  print_string " _ _ _ _ _ _ _\n" ;
  for i = 0 to 5 do
    print_string "|" ;
    for j = 0 to 6 do
      Printf.printf "%s|" symb.(jeu.grille.(i).(j))
    done ;
    print_newline ()
  done ;
  print_string " 0 1 2 3 4 5 6\n\n"
;;

let p4 = {
  grille = [| [|0; 0; 0; 0; 0; 0; 0|];
              [|0; 0; 0; 0; 0; 0; 0|];
              [|0; 0; 1; 0; 0; 0; 0|];
              [|0; 0; 2; 1; 2; 0; 0|];
              [|0; 1; 2; 2; 1; 0; 0|];
              [|2; 1; 1; 1; 2; 2; 0|]
           |] ;
  libres = [|5; 4; 2; 3; 3; 5; 6|] ;
  joueur = 1 ;
  vides = 28 }
;;

let points = [| [|3;4;5;7;5;4;3|];
                [|4;6;8;10;8;6;4|];
                [|5;8;11;13;11;8;5|];
                [|5;8;11;13;11;8;5|];
                [|4;6;8;10;8;6;4|];
                [|3;4;5;7;5;4;3|] |]
;;

let f n = (n mod 2) - n/2 ;;
afficher p4;;

let creer_p4 () = 
  let g = Array.make 6 [||] in
  for i = 0 to 5 do
    g.(i) <- Array.make 7 0 ;
  done;
  let l = Array.make 7 6 in
  let j = 1 in
  let v = 42 in
  let p = {grille=g; libres=l; joueur=j; vides=v} in
  p;;

afficher (creer_p4 ());;

let coup_possible p4 n =
  match p4.libres.(n) with
  | 0 -> false
  | _ -> true
;;

let coup_possibles p4 = 
  let l = ref [] in
  for i = 0 to 6 do
    match coup_possible p4 i with
    | true -> l:=i::!l
    | false -> ()
  done;
  List.rev !l
;;

coup_possibles (creer_p4 ()) ;;

let jouer_coup p4 n = 
  if (coup_possible p4 n) = true then ( 
  p4.grille.(p4.libres.(n)-1).(n) <- p4.joueur;
  p4.libres.(n) <- p4.libres.(n)- 1;
  p4.vides <- p4.vides -1;
  p4.joueur <- match p4.joueur with | 1 -> 2 | 2 -> 1 | _ -> 0;
  )
  else failwith "impossible"
  ;;

afficher p4;
jouer_coup p4 1;
afficher p4;;

let annuler_coup p4 n =
  p4.grille.(p4.libres.(n)-1).(n) <- 0;
  p4.libres.(n) <- p4.libres.(n)+ 1;
  p4.vides <- p4.vides +1;
  p4.joueur <- match p4.joueur with | 1 -> 2 | 2 -> 1 | _ -> 0;
;;

let valide (x, y) = 
  0 <= x && x < 6 && 0 <= y && y < 7
;;

let nb_cases jeu joueur (lgn, col) (dl, dc) =
  let i = ref 0 in
  let x = ref (lgn + dl) and y = ref (col + dc) in
  while !i < 3 && valide (!x, !y) && jeu.grille.(!x).(!y) = joueur do
    incr i ;
    x := !x + dl ;
    y := !y + dc
  done ;
  !i
;;

let directions = [|(1,0);(1,1);(0,1);(-1,1);(-1,0);(-1,-1);(0,-1);(1,-1)|] ;;

let coup_gagnant jeu col joueur =
  let max_cases = ref 0 in
  let lgn = jeu.libres.(col) - 1 in
  for dir = 0 to 3 do
    let nb1 = nb_cases jeu joueur (lgn, col) directions.(dir) in
    let nb2 = nb_cases jeu joueur (lgn, col) directions.(dir + 4) in
    max_cases := max !max_cases (nb1 + nb2 + 1)
  done ;
  !max_cases >= 4
;;

(*2. Strategie*)

let strategie_alea p4 = 
  let l = coup_possibles p4 in
  let n = Random.int (List.length l) in
  let rec aux l i = match l with
  | [] -> -1
  | t::q when i <> 0 -> aux q (i-1)
  | t::q -> t
  in
  aux l n ;;

let compare s1 s2 =
  let p4 = creer_p4 () in
  let win = ref 0 in
  while p4.vides <> 0 && !win = 0 do
    let j = match p4.joueur with | 1 -> s1 p4 | _ -> s2 p4 in 
    if coup_gagnant p4 j (p4.joueur) then (
      win := p4.joueur 
    );
    jouer_coup p4 j
  done; 
  afficher p4 ;
  !win
;;

compare (strategie_alea) (strategie_alea) ;;