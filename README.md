# Delta Force Rounds — Tournament Casting Scenes

A collection of HTML pages for Delta Force tournament broadcasts. Each scene is a single self-contained 1920×1080 HTML file — no external scripts, no fetches, no server. Open directly via `file://`, drop into OBS, or serve over HTTP — all three work, with zero CORS errors.

![Preview](images/preview.png?v=2)

---

## Scenes

| Scene | File | Purpose |
| --- | --- | --- |
| Rounds Progression | `scenes/rounds.html` | 7-round overlay with R3/R7 map-pick locking |
| Match Rules | `scenes/rules.html` | 6-box rules announcement |

Open `index.html` for a launcher with copy-pasteable OBS URLs.

---

## Project Layout

```
index.html            — scene launcher (self-contained)
scenes/
  rounds.html         — rounds progression overlay (self-contained)
  rules.html          — match rules announcement (self-contained)
images/               — map images and mode icons
Makefile              — smoke (HTML parse) + preview (local server)
```

Each scene file embeds: design tokens (CSS), the i18n + parsing logic (JS), per-tournament config (JSON), and translations (YAML, one block per language). Browsers don't execute non-JS `<script type="...">` blocks — the boot code reads their `textContent` and parses.

---

## Opening a Scene

1. **Double-click** the `.html` file. Works in Chrome, Firefox, Brave, etc. Nothing external is loaded except Google Fonts; `file://` paths just work.
2. **OBS** Browser Source: set the URL to `file:///<full-path>/scenes/rounds.html` (or use `http://absolute/<path>/...` if your OBS install rejects raw `file://`). 1920×1080. Crop the settings/picker bar at the top.
3. **`make preview`** → `http://localhost:8000/`. Useful when you want devtools without caching surprises.

`index.html` shows the OBS URL for each scene; copy from there.

---

## Editing Per-Tournament Settings

Each scene HTML has a `<script type="application/json" id="dfconfig">` block near the top:

```json
{
  "defaultLanguage": "en",
  "brand": "Scrims.cc",
  "tournamentName": "Global League (EU) — Finals"
}
```

| Key | Effect |
| --- | --- |
| `defaultLanguage` | Initial language (`en`, `fr`, `ru`, …). Falls back to `en` if invalid. |
| `brand` | Top-left logo box. |
| `tournamentName` | Top-right badge + bottom-right footer. |

Edit it in each scene file you ship. (For multi-event work, replace the JSON block with the same content across `scenes/*.html`.)

---

## Editing Translations

Each scene HTML has one `<script type="text/yaml" data-lang="…">` block per language. The body is plain YAML:

```yaml
lang_name: English
title: Tournament Progression
picker_round: Round
# …
```

YAML format: flat `key: value` lines, `#` for comments. Use double quotes if a value contains a colon, `#`, or starts with a special character (`[`, `{`, `&`, `*`, `!`, `|`, `>`, `'`, `"`, `%`, `@`, `` ` ``). Otherwise just type it.

`lang_name` is the dropdown label. Missing keys fall back to `en` (the `en` block in the same file).

### Adding a new language

1. Inside each `scenes/<name>.html`, copy an existing `<script type="text/yaml" data-lang="…">` block.
2. Change `data-lang="X"` to your code (e.g. `it`).
3. Translate the values.
4. Reload — the dropdown updates automatically.

(If you add a new scene, do the same in that scene's HTML.)

### YAML parser scope

Inline `parseYaml()` in each scene handles flat `key: value`, `#` comments, and quoted strings. It does **not** support nesting, lists, multi-line block scalars (`|`/`>`), anchors, or merge keys — translations don't need any of that.

### Cross-scene shared keys

A few keys (e.g. `settings_language`, `lang_name`) are duplicated across `rounds.html` and `rules.html`. If you change the wording, update both. Most keys are scene-specific.

---

## Smoke Test

```
make smoke
```

Parses every HTML file. The inline `<script type="text/yaml">` and `<script type="application/json">` blocks ride along inside the HTML, so HTML-parse coverage is enough.

---

## Adding a New Scene

1. Copy `scenes/rounds.html` (or `rules.html`) to `scenes/<name>.html` as a starting template.
2. Edit the `<script type="application/json" id="dfconfig">` block, the `<script type="text/yaml" data-lang="…">` blocks, and the inline `<style>` + `<script>` for the scene's logic.
3. Reference images via `../images/<file>`.
4. Add the scene to the table above and to the launcher in `index.html`.
