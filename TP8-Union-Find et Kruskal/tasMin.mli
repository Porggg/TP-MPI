type ('a,'b) tasmin = { mutable nb_elem : int ; mutable tab : ('a * 'b) array } ;;

val creer : 'a * 'b -> ('a,'b) tasmin

val taille : ('a,'b) tasmin -> int

val est_vide : ('a,'b) tasmin -> bool

val push : ('a,'b) tasmin -> 'a -> 'b -> unit

val peek : ('a,'b) tasmin -> 'a

val pop : ('a,'b) tasmin -> 'a
