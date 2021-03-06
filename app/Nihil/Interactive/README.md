## Nihili

*Nihili* is a REPL (Read-Eval-Print-Loop) for Nihil.
It allows anyone to write/execute some Nihil code, imports libraries (WIP), load files, and get insights like the type of a function, the kind of a type, etc.

### List of commands

|       Command       |   Alias(es)   |        Description
|:-------------------:|:-------------:|-----------------------------
| `:help`             | `:?` \| `:h`  | Show the help menu
| `:quit`             | `:q`          | Exit the REPL
| `:load [file]`      | `:l`          | Load a file directly into the REPL
| `:type [expr]`      | `:t`          | Print the type of an expression
| `:kind [type]`      | `:k`          | Print the kind of a type
| `:reset {symbols}`  | `:r`          | Either reset the REPL completely (that is, remove all the user defined symbols) or just remove the specified ones
| `:time [expr]`      |               | Print the execution time of the evaluation of an expression
| `:bench [n] [expr]` |               | Create a bench of an expression ran `n` times
| `:env`              |               | Print the whole current environment
| `:! [command]`      |               | Execute a shell command directly inside the REPL

### How to run

First make sure that you have [stack](https://docs.haskellstack.org/en/stable/README/) installed and in your path.

```bash
# If you do not have cloned the repo already:
git clone https://github.com/mesabloo/nihil.git && cd nihil

# If you just cloned the repo:
stack setup # this will download everything needed by stack

# If you didn't build it
stack build

# Run nihili
stack run -- repl
```

### Command arguments

```bash
$ stack run -- repl --help
Usage: Nihili repl [FILES...] [-v|--version]
  Run Nihil's REPL

Available options:
  -v,--version             Print the version
  -h,--help                Show this help text
```

### Customization

Nihili is customizable. All you need to do is to create a file named `.nihili` in your home directory.

These are the current options which can be modified and that will be recognized by the REPL:

| Option name | Default value | Description
|:-----------:|:-------------:|-------------
| `prompt`    | `">"`         | Modify the REPL prompt symbol
| `preload`   | `[]`          | Add files to preload each time the REPL is launched

Here is an example sample:
```haskell
prompt = "\ESC[1;38;5;69;1mβ> \ESC[0m"
-- Sets a custom prompt in Nihili.
preload = ["./std/Prelude.nhl"]
-- list of files to preload
```