// 1.
// a dans le langage : -> q_i ->a -> q_f 
// ef expressions reguliere : -> q_i_e ->e* -> q_f_e ->eps ->q_i_f -> q_f_f
//
//              ->eps -> q_i_e ->e* -> q_f_e ->eps
// e|f : -> q_i                                    -> q_f 
//              ->eps -> q_i_f ->f* -> q_f_f ->eps
//
//                         eps<----------
// e* : -> q_i ->eps -> q_i_e ->e* -> q_f_e ->eps -> q_f 
//          ---------------------------------------->eps      
//

// 2.
// e? : -> q_i ->eps -> q_i_e ->e* -> q_f_e
//          -------------------------->eps

// 3.
// Avec une lette : 1
// Avec epsilon : 2
// Non 

// 4. Chaque opérateur rajoute dans le pire des cas 2 états q_i et q_f donc l'automate de thomson aura 2n états dans le pire des cas. 
 