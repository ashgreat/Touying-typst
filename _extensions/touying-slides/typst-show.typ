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

$if(navigation)$
#let touying-navigation = "$navigation$"
$else$
#let touying-navigation = none
$endif$

$if(sidebar-width)$
#let touying-sidebar-width = $sidebar-width$
$else$
#let touying-sidebar-width = none
$endif$

$if(sidebar-filled)$
#let touying-sidebar-filled = $sidebar-filled$
$else$
#let touying-sidebar-filled = none
$endif$

$if(sidebar-short-headings)$
#let touying-sidebar-short = $sidebar-short-headings$
$else$
#let touying-sidebar-short = none
$endif$

$if(mini-slides-section)$
#let touying-mini-section = $mini-slides-section$
$else$
#let touying-mini-section = none
$endif$

$if(mini-slides-subsection)$
#let touying-mini-subsection = $mini-slides-subsection$
$else$
#let touying-mini-subsection = none
$endif$

$if(mini-slides-short-headings)$
#let touying-mini-short = $mini-slides-short-headings$
$else$
#let touying-mini-short = none
$endif$

#let touying-sidebar = utils.merge-dicts(
  (:),
  if touying-sidebar-width != none { (width: touying-sidebar-width) } else { (:) },
  if touying-sidebar-filled != none { (filled: touying-sidebar-filled) } else { (:) },
  if touying-sidebar-short != none { (short-heading: touying-sidebar-short) } else { (:) },
)

#let touying-mini = utils.merge-dicts(
  (:),
  if touying-mini-section != none { (display-section: touying-mini-section) } else { (:) },
  if touying-mini-subsection != none { (display-subsection: touying-mini-subsection) } else { (:) },
  if touying-mini-short != none { (short-heading: touying-mini-short) } else { (:) },
)

#let touying-store = utils.merge-dicts(
  (:),
  if touying-navigation != none { (navigation: touying-navigation) } else { (:) },
  if touying-sidebar.len() > 0 { (sidebar: touying-sidebar) } else { (:) },
  if touying-mini.len() > 0 { (mini-slides: touying-mini) } else { (:) },
)

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

#let touying-config-base = touying-theme.with(
  aspect-ratio: touying-aspect,
  config-common(handout: touying-handout),
  touying-info,
  if touying-navigation != none { config-store(navigation: touying-navigation) } else { (:) },
  if touying-sidebar.len() > 0 { config-store(sidebar: touying-sidebar) } else { (:) },
  if touying-mini.len() > 0 { config-store(mini-slides: touying-mini) } else { (:) },
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
