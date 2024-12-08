let rec first_duplicate alist = 
  match alist with
  | [] -> -100000
  | x :: xs ->
    if List.mem x xs then x
    else first_duplicate xs;;

let first_nonrepeating lst = 
  let rec seen_counter x lst =
    match lst with
    | [] -> 0
    | y :: ys ->
      if x = y then 1 + seen_counter x ys
      else seen_counter x ys
  in
  let rec find_nonrepeating lst seen = 
    match lst with
    | [] -> -100000
    | x :: xs ->
      if seen_counter x (x :: seen @ xs) = 1 then x
      else find_nonrepeating xs (x :: seen)
  in
  find_nonrepeating lst [];;

let sumOfTwo (a,b,v) = 
  let rec exists b v x = 
    match b with
    | [] -> false
    | y :: ys -> if x + y = v then true else exists ys v x
  in
  let rec sumOfTwo (a,b,v) = 
    match a with 
    | [] -> false
    | x :: xs -> if exists b v x then true else sumOfTwo (xs,b,v)
  in
  sumOfTwo (a,b,v);;


let rec take (n, lst) =
  match n, lst with 
  | n, _ when n <= 0 -> []
  | _, [] -> []
  | n, x :: xs -> x :: take (n-1, xs);;

let rec drop (n, lst) = 
  match n, lst with
  | n, _ when n <= 0 -> lst
  | _, [] -> []
  | n, x :: xs -> drop (n-1, xs);;

let rec map_add x subsets =
  match subsets with
  | [] -> []
  | subset :: rest -> (x :: subset) :: map_add x rest;;

let rec powerset lst = 
  match lst with 
  | [] -> [[]]
  | x :: xs -> 
    match powerset xs with
    | subsets -> subsets @ map_add x subsets;;

  
  