type ingredient =
  | Dough
  | Sauce
  | Mozzarella
  | Pepperoni

type proc_or_fun =
  | Defproc of string * (ingredient * int) list
  | Deffunc of string * (ingredient * int) list * string

type expression =
  | Def of proc_or_fun
  | Order of string
