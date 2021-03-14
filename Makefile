default: heroku-20

heroku-20: dist/heroku-20/pixman-0.34.0-1.tar.gz dist/heroku-20/freetype-2.6.5-1.tar.gz dist/heroku-20/giflib-4.2.3-1.tar.gz dist/heroku-20/pango-1.40.1-1.tar.gz dist/heroku-20/cairo-1.14.6-1.tar.gz dist/heroku-20/fontconfig-2.12.1-1.tar.gz dist/heroku-20/harfbuzz-1.3.0-1.tar.gz

dist/heroku-20/cairo-1.14.6-1.tar.gz: cairo-heroku-20
	docker cp $<:/tmp/cairo-heroku-20.tar.gz .
	mkdir -p $$(dirname $@)
	mv cairo-heroku-20.tar.gz $@

dist/heroku-20/fontconfig-2.12.1-1.tar.gz: cairo-heroku-20
	docker cp $<:/tmp/fontconfig-heroku-20.tar.gz .
	mkdir -p $$(dirname $@)
	mv fontconfig-heroku-20.tar.gz $@

dist/heroku-20/freetype-2.6.5-1.tar.gz: cairo-heroku-20
	docker cp $<:/tmp/freetype-heroku-20.tar.gz .
	mkdir -p $$(dirname $@)
	mv freetype-heroku-20.tar.gz $@

dist/heroku-20/giflib-4.2.3-1.tar.gz: cairo-heroku-20
	docker cp $<:/tmp/giflib-heroku-20.tar.gz .
	mkdir -p $$(dirname $@)
	mv giflib-heroku-20.tar.gz $@

dist/heroku-20/harfbuzz-1.3.0-1.tar.gz: cairo-heroku-20
	docker cp $<:/tmp/harfbuzz-heroku-20.tar.gz .
	mkdir -p $$(dirname $@)
	mv harfbuzz-heroku-20.tar.gz $@

dist/heroku-20/pango-1.40.1-1.tar.gz: cairo-heroku-20
	docker cp $<:/tmp/pango-heroku-20.tar.gz .
	mkdir -p $$(dirname $@)
	mv pango-heroku-20.tar.gz $@

dist/heroku-20/librsvg-2.41.1.tar.xz: cairo-heroku-20
	docker cp $<:/tmp/librsvg-heroku-20.tar.gz .
	mkdir -p $$(dirname $@)
	mv librsvg-heroku-20.tar.gz $@

dist/heroku-20/pixman-0.34.0-1.tar.gz: cairo-heroku-20
	docker cp $<:/tmp/pixman-heroku-20.tar.gz .
	mkdir -p $$(dirname $@)
	mv pixman-heroku-20.tar.gz $@

clean:
	rm -rf src/ cedar*/*.sh dist/ cairo-cedar*/*.tar.*
	-docker rm cairo-heroku-20

src/cairo.tar.gz:
	mkdir -p $$(dirname $@)
	curl -sL https://www.cairographics.org/releases/cairo-5c-1.20.tar.gz -o $@

src/fontconfig.tar.xz:
	mkdir -p $$(dirname $@)
	curl -sL https://www.freedesktop.org/software/fontconfig/release/fontconfig-2.13.93.tar.xz -o $@

src/freetype.tar.bz2:
	mkdir -p $$(dirname $@)
	curl -sL http://download.savannah.gnu.org/releases/freetype/freetype-2.9.tar.bz2 -o $@

src/giflib.tar.bz2:
	mkdir -p $$(dirname $@)
	curl -sL "https://downloads.sourceforge.net/project/giflib/giflib-5.x/giflib-5.0.2.tar.bz2?ts=1615733507&r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fgiflib%2Ffiles%2Fgiflib-5.x%2Fgiflib-5.0.2.tar.bz2%2Fdownload" -o $@

src/harfbuzz.tar.xz:
	mkdir -p $$(dirname $@)
	curl -sL https://www.freedesktop.org/software/harfbuzz/release/harfbuzz-2.6.7.tar.xz -o $@

src/pango.tar.bz2:
	mkdir -p $$(dirname $@)
	curl -sL https://download.gnome.org/sources/pango/1.9/pango-1.9.1.tar.bz2 -o $@

src/librsvg.tar.bz2:
	mkdir -p $$(dirname $@)
	curl -sL https://download.gnome.org/sources/librsvg/2.9/librsvg-2.9.5.tar.bz2 -o $@

src/pixman.tar.gz:
	mkdir -p $$(dirname $@)
	curl -sL https://www.cairographics.org/releases/pixman-0.40.0.tar.gz -o $@

.PHONY: heroku-20-stack

heroku-20-stack: heroku-20-stack/heroku-20.sh
	@docker pull daylon/$@ && \
		(docker images -q daylon/$@ | wc -l | grep 1 > /dev/null) || \
		docker build --rm -t daylon/$@ $@

heroku-20-stack/heroku-20.sh:
	curl -sLR https://raw.githubusercontent.com/heroku/stack-images/master/bin/heroku-20.sh -o $@

.PHONY: cairo-heroku-20

cairo-heroku-20: heroku-20-stack cairo-heroku-20/pixman.tar.gz cairo-heroku-20/freetype.tar.bz2 cairo-heroku-20/giflib.tar.bz2 cairo-heroku-20/cairo.tar.gz cairo-heroku-20/pango.tar.bz2  cairo-heroku-20/librsvg.tar.bz2 cairo-heroku-20/fontconfig.tar.xz cairo-heroku-20/harfbuzz.tar.xz
	docker build --rm -t daylon/$@ $@
	-docker rm $@
	docker run --name $@ daylon/$@ /bin/echo $@

cairo-heroku-20/cairo.tar.gz: src/cairo.tar.gz
	ln -f $< $@

cairo-heroku-20/fontconfig.tar.xz: src/fontconfig.tar.xz
	ln -f $< $@

cairo-heroku-20/freetype.tar.bz2: src/freetype.tar.bz2
	ln -f $< $@

cairo-heroku-20/giflib.tar.bz2: src/giflib.tar.bz2
	ln -f $< $@

cairo-heroku-20/harfbuzz.tar.xz: src/harfbuzz.tar.xz
	ln -f $< $@

cairo-heroku-20/pango.tar.bz2: src/pango.tar.bz2
	ln -f $< $@

cairo-heroku-20/librsvg.tar.bz2: src/librsvg.tar.bz2
	ln -f $< $@

cairo-heroku-20/pixman.tar.gz: src/pixman.tar.gz
	ln -f $< $@
