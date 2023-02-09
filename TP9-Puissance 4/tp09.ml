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

let creer_p4 = 
  let g = Array.make 6 [||] in
  for i = 0 to 5 do
    g.(i) <- Array.make 7 0 ;
  done;
  let l = Array.make 7 6 in
  let j = 0 in
  let v = 42 in
  let p4 = {grille=g; libres=l; joueur=j; vides=v} in
  p4;;

afficher creer_p4;;

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

coup_possibles creer_p4 ;;

let 