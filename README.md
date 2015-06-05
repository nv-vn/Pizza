# Pizza - An esoteric programming language

Pizza is an interpreted, esoteric programming language based around the concept of, well, Pizza.
Programs in Pizza are written as a series of recipes followed by an order. For example:

```
(>pepperoni_no_cheese<)
  dough * 1
  sauce * 1
  pepperoni * 65
flip pepperoni_no_cheese.
```
(note: at this point in time, only the REPL is available, so recipes must be condensed to a single 
line)

defines a recursive function that, upon each call, prints a capital 'A'.
To execute the function for the first time, call it with `order pepperoni_no_cheese.`.

## Building

To compile the program, simply type `./build` from the base directory. Make sure not to Ctrl+C out
of the REPL if you want to delete compiled files. If you need to exit, just cause a syntax error.

By the way, it's an absolute pain to use Makefiles for OCaml and I'm too lazy to learn ocamlbuild,
so that's why I'm using a shell script in case you were wondering.

## Ingredients

Whenever you're cooking yourself a pizza, it's important to know what each ingredient tastes like.
The table below describes each ingredient in depth:

| Ingredient | Return value/weight   | Taste                                                          |
|------------|-----------------------|----------------------------------------------------------------|
| Dough      | _n_                   | None                                                           |
| Sauce      | -_n_                  | None                                                           |
| Mozzarella | 0 if true, 1 if false | Takes 1 character of input and compares it against _n_ (ASCII) |
| Pepperoni  | _n_                   | Prints _n_ (ASCII)                                             |

## Instructions

To cook your pizza, you need to know how to put these ingredients together. The following section
describes how to do so in detail:

### Recipe format:

* `(>name<) ... flip.` or

* `(>name<) ... flip other_name.` (cooks another recipe if the weight of the pizza is 0)

### Ingredient lists:

When listing your ingredients, make sure to specify the amount of it (_n_), like so:
`sauce * 5`

### Orders:

Orders follow a very simple syntax: `order your_order.`
