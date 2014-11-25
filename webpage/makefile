
default:
	jekyll

install:
	rsync -avz -e ssh _site/ shell1c40.carrierzone.com:html/

edit:
	vi *.html

view:
	firefox $(PROJ).html &

go:
	make && make install

spell:
	ispell $(PROJ).tex

clean:
	rm $(PROJ).html

version:
	mkvers $(PROJ).tex

linkchecker:
	linkchecker http://phyloseminar.org/

.PHONY: install edit view go spell clean version
