type uf = { link: int array; rank: int array } ;;

let create n =
  let a = Array.init n (fun i -> i) in
  let b = Array.make n 0 in
  { link = a;
    rank = b}
  
;;

let rec find uf i =
  match uf.link.(i) with
  | k when k=i -> i
  | k -> let h = find uf k in uf.link.(i) <- h; h
;;

let union uf i j =
  let rep_i = find uf i in
  let rep_j = find uf j in
  if rep_i <> rep_j then match uf.rank.(rep_i), uf.rank.(rep_j) with
    | r1, r2 when r1 < r2 -> uf.link.(rep_i) <- rep_j
    | r1, r2 when r1 > r2 -> uf.link.(rep_j) <- rep_i
    | r1, r2 -> uf.link.(rep_j) <- rep_i; uf.rank.(rep_i) <- r1+1
;;



