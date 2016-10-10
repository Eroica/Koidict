all: koidict

clean:
	rm -fv *~ resources.c koidict

ui: resources.c $(wildcard *.ui)

resources.c: koidict.gresource.xml
	glib-compile-resources $< --target=$@ --generate-source

koidict: ui code

code: $(wildcard *.vala) model/dict_entry.vala resources.c
	valac -o $@ $^ --pkg gtk+-3.0 --target-glib=2.38 --gresources=koidict.gresource.xml