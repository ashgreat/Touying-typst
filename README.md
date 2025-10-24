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

## Acknowledgements

- [Touying](https://github.com/touying-typ/touying) (MIT License) — Slide engine and themes.
- [typst-fletcher](https://github.com/Jollywatt/typst-fletcher) (MIT License) — Diagram and animation helpers.

## License

Licensed under the MIT License. See [LICENSE](LICENSE) for details.
