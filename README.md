# Delta Force Rounds — Tournament Overlay

A fullscreen broadcast overlay for displaying tournament round progression. Designed for 1920×1080 capture in OBS or any similar tool.

![Preview](images/preview.png?v=2)

---

## Features

### Round Progression
The overlay displays all 7 rounds as cards side by side. Each card shows the map name, a map thumbnail, and the game mode icon. Cards are automatically styled as **past** (greyed out), **current** (highlighted in teal), or **upcoming** based on the selected round.

### Round Picker
A control bar above the canvas lets the operator switch the active round at any time. Rounds 3 and 7 have sub-options (e.g. `3.1`, `3.2`) to reveal the chosen map once it has been decided.

### Round 3 Map Lock
When the operator selects a map for Round 3 (either `3.1` or `3.2`), that choice is **locked for the rest of the session**. Navigating away to Round 4, 5, or 6 and coming back will always show the same map — it will not revert to the split preview. A **Reset R3 pick** button in the settings panel clears the lock if needed.

### Multi-language Support
The overlay supports multiple languages. The language can be switched instantly at any time using the dropdown in the settings panel. Currently available languages are **English**, **French**, and **Russian**.

### Settings Panel
Located to the left of the round picker. Always visible to the operator. Contains the language selector and the Round 3 reset button. This area is not intended to appear on stream — position your OBS crop accordingly.

---

## Editing Translations

All translated strings live in the `LANGS` object at the top of `delta_force_rounds.html` (first `<script>` block in `<head>`). The language picker is built dynamically from `LANGS` at page load.

### How to update a translation

1. Open `delta_force_rounds.html` in a text editor.
2. Find the `LANGS` object at the top — locate the block for your language (e.g. `fr: { ... }`).
3. Edit the values. Do not rename keys.
4. Save and refresh.

### Adding a new language

1. Add a new block inside `LANGS` (e.g. `it: { lang_name: "Italiano", title: "...", ... }`).
2. The `lang_name` key is used as the display label in the dropdown. If omitted, the language code is shown.
3. Any key left blank will fall back to English automatically.
4. Save and refresh — the dropdown updates automatically.

---

## File Structure

```
delta_force_rounds.html        — Main overlay page (includes all translations)
images/
  barrage.png                  — Map image: Zero Dam
  brakkesh.webp                — Map image: Brakkesh
  Prison.webp                  — Map image: Tidal Prison
  cite.png                     — Map image: Space City
  airdrop.png                  — Game mode icon: Airdrop
  mandel.png                   — Game mode icon: Mandlebrick
```

The HTML file references images by relative path.

---

## OBS Setup

1. Add a **Browser Source** or use a **Window Capture** on the browser window.
2. Set the resolution to **1920×1080**.
3. Crop out the settings/picker bar at the top — only the canvas below it should be visible on stream.
