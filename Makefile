INSTALL_TOP = /usr/local/stow/koidict
INSTALL_BIN = $(INSTALL_TOP)/bin
INSTALL_SHARE = $(INSTALL_TOP)/share/koidict

TO_BIN = koidict
TO_SHARE = data/dict-revised.db

#uninstall:
#	cd $(INSTALL_BIN) && $(RM) $(TO_BIN)
#	cd $(INSTALL_SHARE) && $(RM) $(TO_SHARE)


all: koidictall

.PHONY: koidict install uninstall dummy
.DELETE_ON_ERROR:

clean:
	rm -fv *~ resources.c *.vala.c koidict

ui: resources.c

resources.c: koidict.gresource.xml $(wildcard ui/*.ui) $(wildcard *.ui) $(wildcard ui/*.css)
	glib-compile-resources $< --target=$@ --generate-source

%.vala.c:
	touch $*.vala.c
	exit 1

koidictall: ui koidict db

db: ~/.local/share/koidict/dict-revised.sqlite3

~/.local/share/koidict/dict-revised.sqlite3: data/dict-revised.sqlite3
	mkdir -p ~/.local/share/koidict
	cp $< $@

koidict: $(wildcard *.vala) $(wildcard model/*.vala) resources.c
	valac -o $@ $^ --pkg gtk+-3.0 --pkg sqlite3 --target-glib=2.38 --gresources=koidict.gresource.xml
