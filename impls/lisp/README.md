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


