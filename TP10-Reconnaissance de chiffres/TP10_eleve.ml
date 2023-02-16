(* #require "graphics" ;; *) ;;

type image = int array;;

(* Question 1 *) ;;

let lire_lignes_fichier flux_entree =
  let b = ref true in
  let s = ref [] in
  
  while !b do 
    try 
      let s' = input_line flux_entree in 
      s := s' ::!s ;

    with End_of_file -> b := false ;
  done;
  List.rev !s
;;

lire_lignes_fichier (open_in "test.txt") ;;

(* Question 2 *)

let parser_ligne_image s =
  let l = String.split_on_char ',' s in
  let l' = List.map (fun x -> int_of_string x) l in
  Array.of_list l'
;;

parser_ligne_image "12,42,0,255" ;;

(* Question 3 *)

let lire_images (nom_fichier : string) : image array  =
  let fichier = open_in nom_fichier in
  let imgs = lire_lignes_fichier fichier in
  let im = Array.make (List.length imgs) ([||]) in
  let rec aux l i = match l with
  | [] -> ()
  | p::q -> im.(i) <- parser_ligne_image p ; aux q (i+1)
  in
  aux imgs 0 ;
  im 

;;

let x_test_complet = lire_images "data_mnist/x_test.csv" ;;

let x_train_complet = lire_images "data_mnist/x_train.csv" ;;

(* Question 4 *)

let lire_etiquettes nom_fichier =
  let fichier = open_in nom_fichier in
  let imgs = lire_lignes_fichier fichier in
  let im = Array.make (List.length imgs) (0) in
  let rec aux l i = match l with
  | [] -> ()
  | p::q -> im.(i) <- int_of_string p ; aux q (i+1)
  in
  aux imgs 0 ;
  im 
;;

let y_test_complet = lire_etiquettes "data_mnist/y_test.csv" ;;

let y_train_complet = lire_etiquettes "data_mnist/y_train.csv" ;;


(* Question 5 *)

let jeu_donnees (x : image array) (y : int array) : (image * int) array =
  let a = Array.make (Array.length x) ([||],0) in
  for i = 0 to Array.length x -1 do
    a.(i) <- (x.(i),y.(i)) 
  done;
  a 
;;

let jeu_entrainement = jeu_donnees x_train_complet y_train_complet;;

let jeu_test = jeu_donnees x_test_complet y_test_complet;;


(*** Affichage ***)

(* fonction de secours si le module Graphics n'est pas détecté *)
let afficher_ascii (image:image) :unit =
  for i = 0 to 27 do
    for j = 0 to 27 do
      if image.(i*28+j) > 240 then
        Printf.printf "x"
      else if image.(i*28+j) <= 140 then
        Printf.printf " "
      else
        Printf.printf "."
    done;
    print_string "|\n"
  done
;;

(* Attention : ne jamais fermer la fenêtre, ou la console OCaml va planter !*)
Graphics.open_graph " 280x280+500+500" ;;

let afficher (im:image) =
  Graphics.clear_graph () ;
  for i = 0 to 27 do
    for j = 0 to 27 do
      let pixel = im.(i*28+j) in
      let color = Graphics.rgb pixel pixel pixel in
      Graphics.set_color color ;
      for x = 0 to 9 do
        for y = 0 to 9 do
          Graphics.plot (10*j+x) (279-10*i-y)
        done
      done
    done
  done
;;

afficher x_train_complet.(590) ;;

(*** k plus proches voisins ***)

type modele = { distance : image -> image -> float ;
                k : int ;
                donnees : (image * int) array }
;;

(* Question 6 *)

let norme_1 (im1:image) (im2:image) =
  let s = ref 0. in 
  for i = 0 to Array.length im1 -1 do
    s := float_of_int (abs(im1.(i) - im2.(i))) +. !s
  done;
  !s
;;

norme_1 x_train_complet.(0) x_train_complet.(1) ;;

(* Question 7 *)

let nb_elements l =
  let a = Array.make 10 0 in 
  for i = 0 to Array.length l - 1 do
    a.(l.(i)) <- a.(l.(i)) + 1 
  done;
  a
;;

nb_elements [|0;0;0;0;4;5;7;0;2;3;3;3|] ;;

(* Question 8 *)

let classe_plus_frequente l =
  let nb = ref 0 in 
  let maxi = ref 0 in
  let a = nb_elements l in
  for i = 0 to 9 do
    if a.(i) > !maxi then (nb:=i; maxi:=a.(i))
  done;
  !nb
;;

classe_plus_frequente [|0;0;0;0;4;5;7;0;2;3;3;3|] ;;

(* Question 9 *)

let construire_modele dist k donnees =
  {distance = dist ; k = k ; donnees = donnees }
;;

(* Question 10 *)

let determiner_classe m im =
  let n = Array.length m.donnees in
  let tas = TasMax.creer (0,0.) in
  for i = 0 to m.k-1 do
    let x,y = m.donnees.(i) in
    let d = m.distance x im in
    TasMax.push tas y d
  done ;
  for i = m.k to n-1 do
    let x,y = m.donnees.(i) in
    let d = m.distance x im in
    let d_max = snd tas.tab.(0) in
    if d_max > d then
      begin
        let _ = TasMax.pop tas in
        TasMax.push tas y d
      end
  done ;
  let rec creer_liste k = match k with
    | 0 -> []
    | _ -> (TasMax.pop tas) :: creer_liste (k-1)
  in classe_plus_frequente (creer_liste m.k)
;;

(* Question 11 *)

let m = construire_modele norme_1 2 jeu_entrainement ;;

let i = 94 in
let im,y = jeu_test.(i) in
afficher im ;
y, determiner_classe m im
;;

for i = 0 to 100 do
  let im,y = jeu_test.(i) in
  if y != determiner_classe m im then
    begin
      print_int i ;
      print_newline ()
    end
done
;;

(* Question 12 *)

let pourcentage_erreur m d_test =
  0. (* TODO *)
;;

pourcentage_erreur m jeu_test ;;

(* Question 13 *)

let matrice_confusion m d_test =
  [||] (* TODO *)
;;

matrice_confusion m jeu_test ;;

