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

#let touying-config = touying-theme.with(
  aspect-ratio: touying-aspect,
  config-common(handout: touying-handout),
  touying-info,
)

#show: touying-config
