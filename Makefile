all: koidictall

.PHONY: koidict
.DELETE_ON_ERROR:

clean:
	rm -fv *~ resources.c koidict

ui: resources.c

resources.c: koidict.gresource.xml $(wildcard *.ui)
	glib-compile-resources $< --target=$@ --generate-source

%.vala.c:
	touch $*.vala.c
	exit 1

koidictall: ui koidict

koidict: $(wildcard *.vala) $(wildcard model/*.vala) resources.c
	valac -o $@ $^ --pkg gtk+-3.0 --pkg sqlite3 --target-glib=2.38 --gresources=koidict.gresource.xml