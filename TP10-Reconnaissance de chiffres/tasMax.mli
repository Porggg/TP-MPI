type ('a,'b) tasmax = { mutable nb_elem : int ; mutable tab : ('a * 'b) array }

val creer : 'a * 'b -> ('a,'b) tasmax

val taille : ('a,'b) tasmax -> int

val est_vide : ('a,'b) tasmax -> bool

val push : ('a,'b) tasmax -> 'a -> 'b -> unit

val peek : ('a,'b) tasmax -> 'a

val pop : ('a,'b) tasmax -> 'a
