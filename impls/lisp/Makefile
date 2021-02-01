LISP ?= sbcl

step% : src/main.lisp src/reader.lisp src/printer.lisp src/env.lisp src/util.lisp src/package.lisp

	$(LISP) --load $@.asd \
		--eval '(ql:quickload :$@)' \
		--eval \
	"(sb-ext:save-lisp-and-die #p\"$@\" :toplevel #'mal:main :executable t)"
