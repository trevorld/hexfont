# hexfont <img src="man/figures/logo.png" align="right" width="200px" alt="hexfont hex sticker">

[![CRAN Status Badge](https://www.r-pkg.org/badges/version/hexfont)](https://cran.r-project.org/package=hexfont)
[![R-CMD-check](https://github.com/trevorld/hexfont/workflows/R-CMD-check/badge.svg)](https://github.com/trevorld/hexfont/actions)

### Table of Contents

* [Overview](#overview)
* [Included hex font files](#hex)
* [Examples](#examples)
* [License](#license)

**Please note this README is best [viewed elsewhere](https://trevorldavis.com/R/hexfont/) than `github.com`**. `github.com`'s default `line-height` setting causes distracting extraneous horizontal lines to appear when "printing" bitmaps and `github.com` [does not allow using CSS](https://gist.github.com/kivikakk/622b5dcf395e26c49e2334f0eb19e6f9) to set a more reasonable `line-height` value.

## <a name="overview">Overview</a>

This is an R data package that includes every "hex" font file from the [GNU Unifont](http://unifoundry.com/unifont/index.html) project compressed by `xz`.  It includes a convenience function that loads several of them as a [{bittermelon}](https://github.com/trevorld/bittermelon) `bm_font()` object.  GNU Unifont is a duospaced bitmap font (8x16 and 16x16 glyphs) that pretty much covers all of the official Unicode glyphs plus several of the artificial scripts in the [(Under-)ConScript Unicode Registry](http://www.kreativekorp.com/ucsur/).

## <a name="hex">Included hex font files</a>

`{hexfont}` includes all the hex font files included in the [GNU Unifont](http://unifoundry.com/unifont/index.html)
source code distribution.  The version number is stripped from the file names in the `precompiled` directory and
the hex fonts are all compressed by `xz` but other than that the hex fonts are otherwise unchanged.


```r
hex_dir <- system.file("font", package = "hexfont")
list.files(hex_dir, pattern = ".hex.xz", recursive = TRUE)
```

```
##  [1] "plane00/alt/codepage-437.hex.xz"           
##  [2] "plane00/alt/mongolian-vertical.hex.xz"     
##  [3] "plane00/alt/phags-pa-vertical.hex.xz"      
##  [4] "plane00/alt/quad-width.hex.xz"             
##  [5] "plane00/alt/reiwa-vertical.hex.xz"         
##  [6] "plane00/alt/uni0009-orig.hex.xz"           
##  [7] "plane00/copyleft.hex.xz"                   
##  [8] "plane00/custom00.hex.xz"                   
##  [9] "plane00/hangul-syllables.hex.xz"           
## [10] "plane00/izmg16-plane00.hex.xz"             
## [11] "plane00/omit.hex.xz"                       
## [12] "plane00/plane00-nonprinting.hex.xz"        
## [13] "plane00/plane00-unassigned.hex.xz"         
## [14] "plane00/pua.hex.xz"                        
## [15] "plane00/spaces.hex.xz"                     
## [16] "plane00/unifont-base.hex.xz"               
## [17] "plane00/wqy.hex.xz"                        
## [18] "plane00csur/plane00csur-nonprinting.hex.xz"
## [19] "plane00csur/plane00csur-spaces.hex.xz"     
## [20] "plane00csur/plane00csur.hex.xz"            
## [21] "plane01/plane01-nonprinting.hex.xz"        
## [22] "plane01/plane01.hex.xz"                    
## [23] "plane01/space.hex.xz"                      
## [24] "plane02/izmg16-plane02.hex.xz"             
## [25] "plane0E/plane0E-nonprinting.hex.xz"        
## [26] "plane0E/plane0E.hex.xz"                    
## [27] "plane0Fcsur/plane0Fcsur-nonprinting.hex.xz"
## [28] "plane0Fcsur/plane0Fcsur.hex.xz"            
## [29] "precompiled/unifont_jp_sample.hex.xz"      
## [30] "precompiled/unifont_jp.hex.xz"             
## [31] "precompiled/unifont_sample.hex.xz"         
## [32] "precompiled/unifont_upper_sample.hex.xz"   
## [33] "precompiled/unifont_upper.hex.xz"          
## [34] "precompiled/unifont.hex.xz"
```

## <a name="examples">Examples</a>

The main function `unifont()` loads in several GNU Unifont hex files at the same time as a [{bittermelon}](https://github.com/trevorld/bittermelon) `bm_font()` object.  Arguments:

| Argument | Meaning | Default |
--- | --- | ---
| upper | Include glyphs above the Unicode Basic Multilingual plane | `TRUE` | 
| jp | Use Japanese version of Chinese characters | `FALSE` | 
| csur | Include (Under-)Conscript Unicode Registry glyphs | `TRUE` |
| sample | Add circle to "Combining" characters | `FALSE` | 
| ucp | Character vector of Unicode Code Points to only load | `NULL` |


```r
library("bittermelon") # remotes::install_github("trevorld/bittermelon")
```

```
## 
## Attaching package: 'bittermelon'
```

```
## The following object is masked from 'package:base':
## 
##     which
```

```r
library("hexfont") # remotes::install_github("trevorld/hexfont")
system.time(font <- unifont()) # Unifont is a **big** font
```

```
##    user  system elapsed 
##  52.149   0.148  52.324
```

```r
length(font) |> prettyNum(big.mark = ",") # number of glyphs
```

```
## [1] "79,162"
```

```r
object.size(font) |> format(units = "MB") # memory used
```

```
## [1] "118.4 Mb"
```

```r
# Faster to load from a cache
saveRDS(font, "unifont.rds")
system.time(font <- readRDS("unifont.rds"))
```

```
##    user  system elapsed 
##   0.411   0.000   0.411
```

```r
# Or just load the subset of GNU Unifont you need
s <- "Ｒ很棒！"
system.time(font_s <- unifont(ucp = str2ucp(s)))
```

```
##    user  system elapsed 
##   0.662   0.000   0.662
```

```r
# Mandarin Chinese
as_bm_bitmap(s, font = font_s) |>
    bm_compress("v")
```

```
##                     █ ▄▄▄▄▄▄▄      █      █                     
##                   ▄▀  █     █      █  ▀▀▀▀█▀▀▀▀                 
##   ██▀▀▀▀▀▀▀▀▄▄   ▀  █ █▀▀▀▀▀█   ▀▀▀█▀▀ ▀▀█▀▀▀▀         ██       
##   ██        ██    ▄█  █▄▄▄▄▄█     ██▄ ▀▀█▀▀▀█▀▀        ██       
##   ██▀▀▀▀██▀▀    ▄▀ █  █  █  ▄▀   █ █ ▀▄▀  █  ▀▄        ██       
##   ██      ██       █  █   █▀    ▀  █    ▀▀█▀▀          ▀▀       
##   ██        ██     █  █ ▄  ▀▄      █  ▀▀▀▀█▀▀▀▀        ██       
##                    █  █▀     ▀▀    █      █
```

```r
# Emoji
as_bm_bitmap("🐭🐲🐵", font = font) |>
    bm_compress("v")
```

```
##   ▄▄       ▄▄           ▄▄▄            ▄▄       
## ▄▀  ▀▄▄▄▄▄▀  ▀▄       ▄█▀           ▄█▀██▀█▄    
## █    ▀   ▀    █      ▄████       ▄▀█ ▄▄  ▄▄ █▀▄ 
## ▄█   ▀   ▀   █▄   ▄▄██▄█████     ▀▄█ ▀▀  ▀▀ █▄▀ 
## ▄█▀    ▄    ▀█▄ ▄█▄███████████     ▄▀      ▀▄   
##   ▀▄  ▀▀▀  ▄▀   ▀▀▀▀▀███▀▀█████    █ ▀▄▄▄▄▀ █   
##     ▀▀▄▄▄▀▀        ▄███   ████▀     ▀▀▄▄▄▄▀▀    
##                   ▀▀▀     ▀▀▀
```

```r
# Klingon
as_bm_list("", font = font) |>
    bm_pad(type = "trim", left = 1L, right = 1L) |>
    bm_call(cbind) |>
    bm_compress("v")
```

```
##                                                                               
##     ▄█▄ ▄▄██▀▀  ▀▀████████               ▄▀       ▄█▄    ▄█▀  ▀█▄    ▄▄       
##  ▄▄██████▀            ▀██ ▀            ▄█▀       ███▀▀  ███    ██   ▀████████ 
##   ▀██  ██             ▄███    ▄█      ▄██       ██▀      ▀██▄▄█▀      ██▀ ▀██ 
##    ▀    █▄           ███      ███▄▄▄▄▄██      ▄███        ▀███▀      ▄█▀   █▀ 
##          █▄          ▀█▄      ██▀▀▀▀▀▀███    ▄██████▄       ▀█▄     ▄█▀   █▀  
##           ▀▄           ▀▀▄   ▄▀        ▀█▄         ▀▀▄        ▀▀▄  ▄▀    ▀    
## 
```

```r
# Tengwar with combining glyphs
bml <- as_bm_list("", font = font)
to_raise <- which(names(bml) %in% c("U+E04A", "U+E04E"))
bml[to_raise] <- bm_shift(bml[to_raise], top = 1L)
bml |> bm_compose(pua_combining = unifont_combining()) |>
    bm_pad(type = "trim", left = 1L, right = 1L) |>
    bm_call(cbind) |>
    bm_compress("v")
```

```
##                  ▄                    ██       ▄      ▄ ▄   
##                 █ ▀                 ▄▄  ▄▄    █ ▀    █ █ ▀  
##                 ▀                   ▀▀  ▀▀    ▀      ▀ ▀    
##  █▄▀▀█▄▄▀▀█▄  █▄▀▀█▄  █▄▀▀█▄▄▀▀█▄   █▄▀▀█▄ ▀▀▀█▀▀▀▀ ▀██▀▀▀█ 
##  █    █    █  █    █  █   ▄█   ▄█   █    █   █       █▄  ▄█ 
##  █  ▀▀   ▀▀   ▀  ▀▀   █▀▀▀▀▀▀▀▀▀▀▀  █  ▀▀   ▄▀        ▀▀▀ █ 
##  █                    █             █       █             █ 
##  █                    █             █       ▀█▄▄▄▀        █
```

## <a name="license">License</a>

The overall license for this package is GPL (>=2) but the bundled hex font files 
are also available under more permissive terms.  Excerpt from `font/COPYING` 

> License for font/plane00/jiskan16-plane00.hex and
> font/plane02/jiskan16-plane02.hex:
> 
>      These two files are in the Public Domain.  They were created
>      from Public Domain BDF font files jiskan16-2004-1.bdf and
>      jiskan16-2000-2.bdf.
> 
> 
> License for font files except the jiskan16 files mentioned above
> are dual-licensed under the SIL Open Font License version 1.1,
> and under this GNU license:
> 
>      All glyphs are released under the GNU General Public License
>      (GPL) version 2 or (at your option) a later version, with the
>      GNU font embedding exception:
> 
>           ** GPL v2.0 license with font embedding exception:
> 
>           As a special exception, if you create a document which
>           uses this font, and embed this font or unaltered portions
>           of this font into the document, this font does not by
>           itself cause the resulting document to be covered by
>           the GNU General Public License. This exception does not
>           however invalidate any other reasons why the document
>           might be covered by the GNU General Public License.
>           If you modify this font, you may extend this exception
>           to your version of the font, but you are not obligated
>           to do so. If you do not wish to do so, delete this
>           exception statement from your version.
