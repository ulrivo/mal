LISP ?= sbcl

step% : src/step%.lisp

	$(LISP) --load $@.asd \
		--eval '(ql:quickload :$@)' \
		--eval \
	"(sb-ext:save-lisp-and-die #p\"$@\" :toplevel #'mal:main :executable t)"
