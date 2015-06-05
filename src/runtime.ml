open Ast
open Util

type recipe =
  | Simple of string * (ingredient * int) list		(* name, (ingredient, amount) *)
  | Chain of string * (ingredient * int) list * string	(* name, (ingredient, amount), call *)

let recipes = ref []
let add_recipe recipe =
  recipes := recipe :: !recipes
let get_recipe query =
  let rec inner = function
    | [] -> Simple ("Empty", [])
    | a :: t ->
      begin
        match a with
        | Simple (name, _) | Chain (name, _, _) ->
          begin
            if name = query then
              a
            else
              inner t
          end
      end
  in inner !recipes

let rtstack = ref []
let push i =
  rtstack := i :: !rtstack 
let pop () =
  match !rtstack with
  | [] -> None
  | a :: t ->
    begin
      rtstack := t;
      Some a
    end

let sum_ingredient = function
  | (Dough, i) -> i
  | (Sauce, i) -> -i
  | (Mozzarella, i) ->
    begin
      let ch = get_char () in
      if ch = (char_of_int i) then
        1
      else
        0
    end
  | (Pepperoni, i) ->
    begin
      Printf.printf "%c\n" @@ char_of_int i;
      -i
    end

let sum_ingredients = 
  let rec inner total = function
    | [] -> total + 0
    | a :: t -> inner (total + (sum_ingredient a)) t
  in inner 0

let rec eval_recipe = function
  | Simple (_, ingredients) ->
    push (sum_ingredients ingredients)
  | Chain (_, ingredients, call) ->
    begin
      let sum = sum_ingredients ingredients in
      if sum = 0 then
        eval_recipe (get_recipe call)
      else
        push sum
    end

let eval_expression = function
  | Def def ->
    begin
      match def with
      | Defproc (name, ingredients) -> add_recipe (Simple (name, ingredients))
      | Deffunc (name, ingredients, call) -> add_recipe (Chain (name, ingredients, call))
    end
  | Order order -> eval_recipe (get_recipe order)
  | _ -> ()
