#import "@preview/touying:0.6.1": *
#import themes.default: default-theme
#import themes.simple: simple-theme
#import themes.metropolis: metropolis-theme
#import themes.dewdrop: dewdrop-theme
#import themes.university: university-theme
#import themes.aqua: aqua-theme
#import themes.stargazer: stargazer-theme

#import "@preview/fletcher:0.5.4": diagram, node, edge, hide, shapes

#let touying-themes = (
  "default": default-theme,
  "simple": simple-theme,
  "metropolis": metropolis-theme,
  "dewdrop": dewdrop-theme,
  "university": university-theme,
  "aqua": aqua-theme,
  "stargazer": stargazer-theme,
)

$if(theme)$
#let touying-theme-key = "$theme$"
$else$
#let touying-theme-key = "simple"
$endif$

$if(aspect-ratio)$
#let touying-aspect = "$aspect-ratio$"
$else$
#let touying-aspect = "16-9"
$endif$

$if(handout)$
#let touying-handout = $handout$
$else$
#let touying-handout = false
$endif$

#let touying-theme = touying-themes.at(touying-theme-key, default: simple-theme)

#let fletcher-diagram = touying-reducer.with(reduce: diagram, cover: hide)

#let touying-info = config-info(
$if(title)$
  title: [$title$],
$endif$
$if(subtitle)$
  subtitle: [$subtitle$],
$endif$
$if(by-author)$
  author: [$for(by-author)$$it.name.literal$$sep$, $endfor$],
$elseif(author)$
  author: ["$author$"],
$endif$
$if(date)$
  date: [$date$],
$endif$
$if(institute)$
  institution: [$institute$],
$elseif(institution)$
  institution: [$institution$],
$endif$
$if(logo)$
  logo: image("$logo$"),
$endif$
)

$if(base-font)$
#let touying-base-font = ("$base-font$")
$else$
#let touying-base-font = none
$endif$

$if(heading-font)$
#let touying-heading-font = ("$heading-font$")
$else$
#let touying-heading-font = none
$endif$

$if(code-font)$
#let touying-code-font = ("$code-font$")
$else$
#let touying-code-font = none
$endif$

$if(font-size)$
#let touying-font-size = $font-size$
$else$
#let touying-font-size = none
$endif$

#let touying-config-base = touying-theme.with(
  aspect-ratio: touying-aspect,
  config-common(handout: touying-handout),
  touying-info,
)

#let touying-config = if (
  touying-base-font != none or
  touying-heading-font != none or
  touying-code-font != none or
  touying-font-size != none
) {
  touying-config-base.with(
    config-common(
      preamble: self => {
        self.default-preamble(self)
        if touying-base-font != none and touying-font-size != none {
          set text(font: touying-base-font, size: touying-font-size)
        } else if touying-base-font != none {
          set text(font: touying-base-font)
        } else if touying-font-size != none {
          set text(size: touying-font-size)
        }
        if touying-heading-font != none {
          set heading(font: touying-heading-font)
        }
        if touying-code-font != none {
          show raw: set text(font: touying-code-font)
        }
      },
    ),
  )
} else {
  touying-config-base
}

#show: touying-config
