{
  open Parser
  exception Eof
}

rule token = parse
  | [' ' '\t']		{ token lexbuf }
  | '\n'		{ EOL }
  | "(>"		{ NAME_BEGIN }
  | "<)"		{ NAME_END }
  | '*'			{ TIMES }
  | '.'			{ PERIOD }
  | "flip"		{ FLIP }
  | "cook"		{ COOK }
  | "order"		{ ORDER }
  | "serve"		{ SERVE }
  | "dough"		{ DOUGH }
  | "sauce"		{ SAUCE }
  | "mozzarella"	{ MOZZARELLA }
  | "pepperoni"		{ PEPPERONI }
  | ['0'-'9']+ as int							{ INTEGER (int_of_string int) }
  | ['a'-'z' 'A'-'Z' '_']+ as id					{ IDENT id }
  | eof		{ raise Eof }
