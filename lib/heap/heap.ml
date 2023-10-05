open Tree;;
open Graphics;;
open Draw;;

type heap = { mutable size : int; mutable arr : int array }

let draw_heap (h : heap) (i0 : int) = 
  let n = h.size in 
  let arr = h.arr in 
  let rec aux i = 
    if i >= n then Empty
    else 
      let c = if i = i0 then red else white in 
      Node (aux (2 * i + 1), arr.(i),c, aux (2 * i + 2));
  in draw_tree (aux 0) 
  
let increase_size (h : heap) =
  let n = h.size in 
  let temp = h.arr in 
  let new_arr = Array.make (2 * n) temp.(0) in
  for i = 0 to n - 1 do 
    new_arr.(i) <- temp.(i)
  done;
  h.arr <- new_arr


let create_heap () : heap = 
  { size = 0; arr = Array.make 5 0 }


let swap arr i j = 
  let temp = arr.(i) in 
  arr.(i) <- arr.(j);
  arr.(j) <- temp

let rec sift_up (i : int) (h : heap) = 
  if i > 0 then 
    let parent = (i - 1) / 2 in
    if h.arr.(parent) < h.arr.(i) then 
      begin 
        swap h.arr parent i;
        draw_heap h parent;
        sift_up parent h
      end;;

let insert (elt : int) (h : heap) = 
  let n = h.size in 
  if n = Array.length h.arr then increase_size h;
  h.arr.(n) <- elt;
  h.size <- n + 1;
  draw_heap h n;
  sift_up n h

let son (k : int) (h : heap) = 
  if h.size <= 2 * k + 1 then None 
  else 
    if h.size = 2 * k + 2 then Some (2 * k + 1)
    else 
      if h.arr.(2 * k + 1) > h.arr.(2 * k + 2) then Some (2 * k + 1)
      else Some (2 * k + 2)

let rec sift_down (k : int) (h : heap) = 
  match son k h with 
  | Some i when h.arr.(i) > h.arr.(k) -> 
      draw_heap h k;    
      swap h.arr k i;
      sift_down i h
  | _ -> draw_heap h k;;

let extract_max (h : heap) = 
  draw_heap h 0;
  swap  h.arr 0 (h.size - 1);
  h.size <- h.size - 1;
  sift_down 0 h