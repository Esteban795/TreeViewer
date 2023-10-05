open Heap
open Graphics

let test_heap () = 
  let h = create_heap () in
  insert 10 h;
  insert 20 h;
  insert 30 h;
  insert 40 h;
  insert 50 h;
  insert 60 h;
  insert 70 h;
  insert 80 h;
  insert 90 h;
  insert 100 h;
  insert 110 h;
  insert 120 h; 
  insert 130 h;
  insert 140 h;
  insert 150 h;
  insert 160 h;
  extract_max h;;

let () =
  open_graph " 1900x900+950-0";
  set_window_title "TreeViewerTestArea, made by Esteban795 on Github";
  test_heap ();
  print_endline "done";
  let _ = wait_next_event [Button_down] in close_graph ();;