open Graphics;;
let step_h = 75;;
let step_v = 75;;
let x0 = 20;;
let y0 = 400;;
let edge = 10;;
let radius = 30;;

type tree =
 | Empty 
 | Node of tree * int * color * tree;;

let rec size (t : tree) =
  match t with 
  | Empty -> (0,0)
  |Node(t1, _, _ , t2 ) ->
    let (w1, h1) = size t1 in 
    let (w2, h2) = size t2 in
    (w1 + w2 + 2,max h1 h2 + 1)


let draw_rectangles (t : tree) = 
  let rec aux x y a = 
    match a with 
    | Empty -> x,y
    | Node (l,_,_ ,r) -> 
      let x1, y1 = aux x (y - step_v) l in 
      let x2, y2 = aux (x1 + 2 * step_h) (y - step_v) r in
      let yy = min y1 y2 in 
      draw_rect x yy (x2 - x) (y - yy);
      x2, yy 
  in
  let _ = aux x0 y0 t in 
  ()


let skeleton (t : tree) =
  let rec aux x y tr = 
    match tr with
    | Empty -> x,x
    | Node (l,_,_ ,r) -> 
      let x1, xr1 = aux x (y - step_v) l in 
      let x2, xr2  = aux (x1 + 2 * step_h) (y - step_v) r in
      moveto xr1 (y - step_v);
      lineto (x1 + step_h) y;
      lineto xr2 (y - step_v);  
      x2, (x1 + step_h) 
  in 
  let _ = aux x0 y0 t in 
  ()


let draw_node (t : tree) x y = 
  match t with 
  | Empty -> 
    set_color blue;
    fill_rect (x - edge / 2) (y - edge / 2) edge edge;
    set_color black;
    draw_rect (x - edge / 2) (y - edge / 2) edge edge;
  | Node (_,v,c,_) -> 
    set_color c;
    fill_circle x y radius;
    set_color black;
    draw_circle x y radius;
    moveto (x - 5) (y - 5);
    draw_string (string_of_int v);;

let draw_nodes (t : tree) = 
  let rec aux x y tr = 
    match tr with 
    | Empty -> draw_node tr x y;
              x,y
    | Node (l,_,_ ,r) -> 
      let x1, _ = aux x (y - step_v) l in
      draw_node tr (x1 + step_h) y;
      let x2, _ = aux (x1 + 2 * step_h) (y - step_v) r in
      x2, (x1 + step_h)
  in
  let _ = aux x0 y0 t in 
  ()


let draw_tree (t : tree) = 
  let rec aux x y tr = 
    match tr with
    | Empty -> x,x
    | Node(l,_,_ ,r) ->
      let x1, xr1 = aux x (y - step_v) l in
      let x2, xr2 = aux (x1 + 2 * step_h) (y - step_v) r in
      moveto xr1 (y - step_v);
      lineto (x1 + step_h) y;
      lineto xr2 (y - step_v);
      draw_node l xr1 (y - step_v);
      draw_node r xr2 (y - step_v);
      x2, (x1 + step_h) 
  in 
  open_graph " ";
  let _, xr = aux x0 y0 t in 
  draw_node t xr y0;;


let a0 = Node(Empty,45,white ,Node(Node(Empty,63,white,Empty),71 , red , Empty ) );;

let () = 
  open_graph " ";
  let h,w = size a0 in
  Printf.printf "h = %d, w = %d\n" h w;
  skeleton a0;
  draw_nodes a0;
  draw_rectangles a0;
  draw_tree a0;;
  let _ = wait_next_event [Button_down] in close_graph ();; 