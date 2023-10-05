open Graphics;;
open Tree;;
open Draw;;
open Heap;;

let () = 
  open_graph " 1900x900+950-0";
  set_window_title "TreeViewer, made by Esteban795 on Github";
  (*create your own trees here *)
  let _ = wait_next_event [Button_down] in close_graph ();; 