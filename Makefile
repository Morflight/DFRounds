.PHONY: smoke preview

smoke:
	@for f in index.html scenes/*.html; do \
		python3 -c "from html.parser import HTMLParser; HTMLParser().feed(open('$$f').read())" \
			&& echo "smoke: $$f parse ok" \
			|| (echo "smoke: $$f parse fail" && exit 1); \
	done

preview:
	@echo "Serving on http://localhost:8000/ — Ctrl+C to stop"
	@python3 -m http.server 8000
