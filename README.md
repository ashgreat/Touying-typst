# Touying Slides for Quarto

This folder packages the [Touying](https://github.com/touying-typ/touying) Typst presentation system and the
[Fletcher](https://github.com/Jollywatt/typst-fletcher) diagram toolkit for use inside Quarto documents.
It adds a custom Typst template/partial set so you can render Touying slide decks directly from `.qmd`
sources while still mixing in raw Typst blocks whenever you need fine‑grained control.

## Project Layout

- `_extensions/touying-slides/` — Quarto Typst template pieces that import Touying + Fletcher and wire the
  configuration into Quarto metadata (`theme`, `aspect-ratio`, `handout`, etc.).
- `touying-slides.qmd` — Example slide deck demonstrating animated Touying slides and Fletcher diagrams.
- `typst-slides.pdf` — Rendered output generated with `quarto render touying-slides.qmd`.

## Getting Started

1. Install [Quarto](https://quarto.org) and [Typst](https://typst.app).
2. Render the sample deck:

   ```bash
   cd typst-slides
   quarto render touying-slides.qmd
   ```

3. To reuse in another project, copy `_extensions/touying-slides` into your Quarto project and point the
   Typst format at these template partials (see the YAML front matter in `touying-slides.qmd` for an example).

## Touying Themes

Touying ships with six ready-made themes. Switch between them by setting the `theme` option under the
`format.typst` block in your `.qmd`. Each snippet below renders the same deck with a different look:

```yaml
format:
  typst:
    template: _extensions/touying-slides/template.typ
    template-partials:
      - _extensions/touying-slides/typst-show.typ
      - _extensions/touying-slides/page.typ
      - _extensions/touying-slides/biblio.typ
    theme: default        # other options shown below
    aspect-ratio: "16-9"
```

| Theme key    | Look & Feel | Sample setting                                                    |
|--------------|-------------|-------------------------------------------------------------------|
| `default`    | Minimal, neutral accents. | `theme: default` |
| `simple`     | Clean header/footer with bold section breaks. | `theme: simple` |
| `metropolis` | Modern flat design inspired by Metropolis. | `theme: metropolis` |
| `dewdrop`    | Frosted navigation bar and accent highlights. | `theme: dewdrop` |
| `university` | Academic styling with title bar and metadata blocks. | `theme: university` |
| `aqua`       | Gradient-based palette with prominent primary color. | `theme: aqua` |
| `stargazer`  | Dark-space aesthetic ready for high-contrast slides. | `theme: stargazer` |

Render the sample deck with each theme to preview the differences:

```bash
for t in default simple metropolis dewdrop university aqua stargazer; do
  quarto render touying-slides.qmd -P theme:$t -o "touying-slides-$t.pdf"
done
```

## Creating a Custom Theme

Touying themes are regular Typst functions that call `touying-slides.with(...)` to set up page geometry,
colors, and layout. To build your own:

1. Create a new Typst file under `_extensions/touying-slides` (for example `my-theme.typ`).
2. Import Touying exports and use the existing themes as templates. A minimal example:

   ```typst
   #import "@preview/touying:0.6.1": *

   #let my-theme(aspect-ratio: "16-9", ..opts) = touying-slides.with(
     config-page(paper: "presentation-" + aspect-ratio, margin: 1.5em),
     config-colors(primary: rgb("#004d9d"), neutral-lightest: white),
     config-common(slide-fn: slide),
     config-info(title: [Custom Deck]), // can be overridden at runtime
     ..opts,
   )
   ```

3. Import the theme in `typst-show.typ` and add it to the `touying-themes` dictionary so it can be selected
   from YAML.
4. Iterate on typography, headers, footers, and subslide behavior by combining the helper functions
   documented at <https://touying-typ.github.io/docs/themes/>.

### Font and Typography Overrides

For quicker tweaks without writing a full theme, you can override typography *and* navigation defaults
directly from YAML. The extension recognizes these optional keys under `format.typst`:

```yaml
format:
  typst:
    template: _extensions/touying-slides/template.typ
    template-partials:
      - _extensions/touying-slides/typst-show.typ
      - _extensions/touying-slides/page.typ
      - _extensions/touying-slides/biblio.typ
    theme: dewdrop
    base-font: "Inter"
    heading-font: "Roboto Slab"
    code-font: "Fira Code"
    font-size: 24pt
    navigation: "mini-slides"         # or "sidebar" (theme default)
    sidebar-width: 6em                # only used when navigation is "sidebar"
    sidebar-filled: true
    sidebar-short-headings: false
    mini-slides-section: true         # only used when navigation is "mini-slides"
    mini-slides-subsection: true
    mini-slides-short-headings: false
```

- `base-font`, `heading-font`, `code-font`, `font-size` update the typographic foundations. Specify font
  names available on your system and include units for the size.
- `navigation` flips Touying between its sidebar and mini-slide navigation layouts (useful for Dewdrop).
- `sidebar-*` keys tweak the sidebar width and appearance.
- `mini-slides-*` keys control how much context appears in the top navigation strip.

All of these run inside the Touying preamble, so they layer cleanly on top of the selected theme while
preserving theme-specific styling.

### Theme-Specific Tips

Touying themes expose additional knobs beyond the generic options above. A few common customisations:

- **Stargazer spacing** – level-3 headings (`###`) sit directly under the gradient title bar. Add a short
  spacer at the top of each slide (for example `#v(1em)` after the heading) or override the subslide
  preamble:

  ```{=typst}
  #show: touying-config.with(
    config-common(subslide-preamble: self => [ #v(1em) ])
  )
  ```

- **Dewdrop navigation** – the default is a left-hand sidebar. Use the YAML keys to pick `navigation:
  "mini-slides"` (for the frosted top bar) or adjust the sidebar width/filling directly.

- **Aqua gradients** – the signature background shapes appear on the title, outline, and section slides.
  Drop in the dedicated helpers to showcase them:

  ```{=typst}
  #title-slide

  #outline-slide

  = Section
  == Slide with content
  ```

Refer to the official theme docs for a deeper catalogue of per-theme options:
<https://touying-typ.github.io/docs/category/themes>.

## Acknowledgements

- [Touying](https://github.com/touying-typ/touying) (MIT License) — Slide engine and themes.
- [typst-fletcher](https://github.com/Jollywatt/typst-fletcher) (MIT License) — Diagram and animation helpers.

## License

Licensed under the MIT License. See [LICENSE](LICENSE) for details.
