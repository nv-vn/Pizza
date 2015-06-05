open Ast
open Runtime

let get_ingredient = function
  | Dough -> "dough"
  | Sauce -> "sauce"
  | Mozzarella -> "mozzarella"
  | Pepperoni -> "pepperoni"
  | _ -> "w0t"

let rec extract_ingredients = function
  | [] -> ""
  | [(ingredient, amount)] -> string_of_int amount ^ " " ^ get_ingredient ingredient ^ "s }"
  | (ingredient, amount) :: t -> string_of_int amount ^ " " ^ get_ingredient ingredient ^ "s, " ^ extract_ingredients t

let extract_def = function
  | Defproc (name, ingredients) -> "recipe " ^ name ^ " { " ^ extract_ingredients ingredients
  | Deffunc (name, ingredients, call) -> "recipe " ^ name ^ " { " ^ extract_ingredients ingredients ^ " -> " ^ call

let extract = function
  | Def d -> extract_def d
  | Order s -> "Ordered " ^ s
  | Cook -> "Cooking... "
  | Serve -> "Serving... "

let rec extract_expression = function
  | [] -> ""
  | a :: t -> extract a ^ "\n" ^ extract_expression t

let _ =
  try
    let lexbuf = Lexing.from_channel stdin in
    while true do
      Printf.printf "🍕> ";
      flush stdout;
      let result = Parser.toplevel Lexer.token lexbuf in
        extract result |>
        Printf.printf "%s\n";
        eval_expression result;
        flush stdout
    done
  with Lexer.Eof ->
    exit 0
