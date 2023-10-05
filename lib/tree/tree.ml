open Graphics;;

type tree =
 | Empty 
 | Node of tree * int * color * tree;;

let rec size (t : tree) =
match t with 
| Empty -> (0,0)
|Node(t1, _, _ , t2 ) ->
  let (w1, h1) = size t1 in 
  let (w2, h2) = size t2 in
  (w1 + w2 + 2,max h1 h2 + 1);;

let rotation_right (t : tree) = 
  match t with
  |Node (Node (gg,rg,cg,gd),r,c,d) -> Node (gg,rg,cg,Node (gd,r,c,d))
  |_ -> t;;

let rotation_left (t : tree) =
  match t with 
  | Node (g,r,c, Node(dg,rd,cd,dd)) -> Node (Node (g,r,c,dg),rd,cd,dd)
  |_ -> t;;
  
  