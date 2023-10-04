open Graphics;;

type tree =
 | Empty 
 | Node of tree * int * color * tree;;