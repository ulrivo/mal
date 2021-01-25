# MAL - Make-A-Lisp

## Links

[Make-A-Lisp by Joel Martin](https://github.com/kanaka/mal)i

[The Make-A-Lisp Process](https://github.com/kanaka/mal/blob/master/process/guide.md)

## Start in Slime

To start a step in Slime:

```
    (load "step0_repl.asd")
```

Omit the load if there is a link:

```
    ln -s ~/dev/lisp/mal/impls/lisp ~/common-lisp/mal
```

```
    (ql:quickload :step0_repl)
    ,in-package :mal
```

## Build and test process

In directory ~/dev/lisp/mal do one of

``` 
    make "build^lisp^step2"
    make "test^lisp^step2"
```

*Or*: in directory ~/common-lisp/mal (which is linked with ~/dev/lisp/mal/impls/lisp), do

`make step2_eval`

which builds an executable named step2_eval.

## Development

There is a Git branch for every step which is made by

`git checkout -b step2`

``` common-lisp
    (ql:quickload :step0_repl)
    ,in-package :mal

```

`
bc
`
