%{
  open Ast
%}

%token NAME_BEGIN
%token NAME_END
%token TIMES
%token PERIOD
%token FLIP
%token ORDER
%token DOUGH
%token SAUCE
%token MOZZARELLA
%token PEPPERONI
%token <int> INTEGER
%token <string> IDENT
%token EOL

%start toplevel
%type <Ast.expression> toplevel

%%

toplevel:
  expression EOL	{ $1 }

expression:
  | NAME_BEGIN IDENT NAME_END ingredient_list FLIP PERIOD
    { Def (Defproc ($2, $4)) }
  | NAME_BEGIN IDENT NAME_END ingredient_list FLIP IDENT PERIOD
    { Def (Deffunc ($2, $4, $6)) }
  | ORDER IDENT PERIOD
    { Order $2 }

ingredient_list:
  |
    { [] }
  | ingredient TIMES INTEGER ingredient_list
    { ($1, $3) :: $4 }

ingredient:
  | DOUGH	{ Dough }
  | SAUCE	{ Sauce }
  | MOZZARELLA	{ Mozzarella }
  | PEPPERONI	{ Pepperoni }
