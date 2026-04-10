.PHONY: smoke

smoke:
	@python3 -c "from html.parser import HTMLParser; HTMLParser().feed(open('delta_force_rounds.html').read())" && echo "smoke: html parse ok" || (echo "smoke: html parse fail" && exit 1)
