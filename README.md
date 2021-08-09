# hexfont <img src="man/figures/logo.png" align="right" width="200px" alt="hexfont hex sticker">

[![R-CMD-check](https://github.com/trevorld/hexfont/workflows/R-CMD-check/badge.svg)](https://github.com/trevorld/hexfont/actions)

### Table of Contents

* [Overview](#overview)
* [Included hex font files](#hex)
* [unifont()](#unifont)
* [License](#license)

## <a name="overview">Overview</a>

This is an R data package that includes every "hex" font file from the [GNU Unifont](http://unifoundry.com/unifont/index.html) project compressed by `gzip`.  It includes a convenience function that loads several of them as a [{bittermelon}](https://github.com/trevorld/bittermelon) `bm_font()` object.  GNU Unifont is a monoscale bitmap font (8x16 and 16x16 glyphs) that pretty much covers all of the official Unicode glyphs plus several of the artificial scripts in the [(Under-)ConScript Unicode Registry](http://www.kreativekorp.com/ucsur/).

## <a name="hex">Included hex font files</a>

`{hexfont}` includes all the hex font files included in the [GNU Unifont](http://unifoundry.com/unifont/index.html)
source code distribution.  The version number is stripped from the file names in the `precompiled` directory and
the hex fonts are all compressed by gzip but other than that the hex fonts are otherwise unchanged.


```r
hex_dir <- system.file("font", package = "hexfont")
list.files(hex_dir, pattern = ".hex.gz", recursive = TRUE)
```

```
##  [1] "plane00/alt/codepage-437.hex.gz"           
##  [2] "plane00/alt/mongolian-vertical.hex.gz"     
##  [3] "plane00/alt/phags-pa-vertical.hex.gz"      
##  [4] "plane00/alt/quad-width.hex.gz"             
##  [5] "plane00/alt/reiwa-vertical.hex.gz"         
##  [6] "plane00/alt/uni0009-orig.hex.gz"           
##  [7] "plane00/copyleft.hex.gz"                   
##  [8] "plane00/custom00.hex.gz"                   
##  [9] "plane00/hangul-syllables.hex.gz"           
## [10] "plane00/izmg16-plane00.hex.gz"             
## [11] "plane00/omit.hex.gz"                       
## [12] "plane00/plane00-nonprinting.hex.gz"        
## [13] "plane00/plane00-unassigned.hex.gz"         
## [14] "plane00/pua.hex.gz"                        
## [15] "plane00/spaces.hex.gz"                     
## [16] "plane00/unifont-base.hex.gz"               
## [17] "plane00/wqy.hex.gz"                        
## [18] "plane00csur/plane00csur-nonprinting.hex.gz"
## [19] "plane00csur/plane00csur-spaces.hex.gz"     
## [20] "plane00csur/plane00csur.hex.gz"            
## [21] "plane01/plane01-nonprinting.hex.gz"        
## [22] "plane01/plane01.hex.gz"                    
## [23] "plane01/space.hex.gz"                      
## [24] "plane02/izmg16-plane02.hex.gz"             
## [25] "plane0E/plane0E-nonprinting.hex.gz"        
## [26] "plane0E/plane0E.hex.gz"                    
## [27] "plane0Fcsur/plane0Fcsur-nonprinting.hex.gz"
## [28] "plane0Fcsur/plane0Fcsur.hex.gz"            
## [29] "precompiled/unifont_jp_sample.hex.gz"      
## [30] "precompiled/unifont_jp.hex.gz"             
## [31] "precompiled/unifont_sample.hex.gz"         
## [32] "precompiled/unifont_upper_sample.hex.gz"   
## [33] "precompiled/unifont_upper.hex.gz"          
## [34] "precompiled/unifont.hex.gz"
```

## <a name="unifont">unifont()</a>

The function `unifont()` loads in several GNU Unifont hex files at the same time as a [{bittermelon}](https://github.com/trevorld/bittermelon) `bm_font()` object.  Arguments:

| Argument | Meaning | Default |
--- | --- | ---
| upper | Include glyphs above the Unicode Basic Multilingual plane | `TRUE` | 
| jp | Use Japanese version of Chinese characters | `FALSE` | 
| csur | Include (Under-)Conscript Unicode Registry glyphs | `TRUE` |
| sample | Add circle to "Combining" characters | `FALSE` | 


```r
library("bittermelon")
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
library("hexfont")
# Note Unifont is a **big** font
system.time(font <- unifont())
```

```
##    user  system elapsed 
##  42.326   0.072  42.398
```

```r
length(font)
```

```
## [1] 77418
```

```r
object.size(font)
```

```
## 121681880 bytes
```

```r
# Mandarin Chinese
as_bm_list("Ｒ很棒！", font = font) |> bm_call(cbind) |> print()
```

```
## ░░░░░░░░░░░░░░░░░░░░█░░░░░░░░░░░░░░█░░░░░░█░░░░░░░░░░░░░░░░░░░░░
## ░░░░░░░░░░░░░░░░░░░░█░███████░░░░░░█░░░░░░█░░░░░░░░░░░░░░░░░░░░░
## ░░░░░░░░░░░░░░░░░░░█░░█░░░░░█░░░░░░█░░█████████░░░░░░░░░░░░░░░░░
## ░░░░░░░░░░░░░░░░░░█░░░█░░░░░█░░░░░░█░░░░░░█░░░░░░░░░░░░░░░░░░░░░
## ░░██████████░░░░░█░░█░███████░░░██████░███████░░░░░░░░░██░░░░░░░
## ░░██░░░░░░░░██░░░░░░█░█░░░░░█░░░░░░█░░░░░█░░░░░░░░░░░░░██░░░░░░░
## ░░██░░░░░░░░██░░░░░█░░█░░░░░█░░░░░██░░█████████░░░░░░░░██░░░░░░░
## ░░██░░░░░░░░██░░░░██░░███████░░░░░███░░░█░░░█░░░░░░░░░░██░░░░░░░
## ░░██████████░░░░░█░█░░█░░█░░░█░░░█░█░█░█░░█░░█░░░░░░░░░██░░░░░░░
## ░░██░░░░██░░░░░░█░░█░░█░░█░░█░░░░█░█░░█░░░█░░░█░░░░░░░░██░░░░░░░
## ░░██░░░░░░██░░░░░░░█░░█░░░██░░░░█░░█░░░░█████░░░░░░░░░░██░░░░░░░
## ░░██░░░░░░██░░░░░░░█░░█░░░█░░░░░░░░█░░░░░░█░░░░░░░░░░░░░░░░░░░░░
## ░░██░░░░░░░░██░░░░░█░░█░░░░█░░░░░░░█░░█████████░░░░░░░░██░░░░░░░
## ░░██░░░░░░░░██░░░░░█░░█░█░░░█░░░░░░█░░░░░░█░░░░░░░░░░░░██░░░░░░░
## ░░░░░░░░░░░░░░░░░░░█░░██░░░░░██░░░░█░░░░░░█░░░░░░░░░░░░░░░░░░░░░
## ░░░░░░░░░░░░░░░░░░░█░░█░░░░░░░░░░░░█░░░░░░█░░░░░░░░░░░░░░░░░░░░░
```

```r
# Emoji
as_bm_list("🐭🐲🐵", font = font) |> bm_call(cbind) |> print()
```

```
## ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
## ░░██░░░░░░░██░░░░░░░░░░░███░░░░░░░░░░░░██░░░░░░░
## ░█░░█░░░░░█░░█░░░░░░░░░██░░░░░░░░░░░░██████░░░░░
## █░░░░█████░░░░█░░░░░░░██░░░░░░░░░░░░██░██░██░░░░
## █░░░░█░░░█░░░░█░░░░░░░████░░░░░░░░██░░░░░░░░██░░
## █░░░░░░░░░░░░░█░░░░░░█████░░░░░░░█░█░██░░██░█░█░
## ░█░░░█░░░█░░░█░░░░░░██░█████░░░░░█░█░██░░██░█░█░
## ██░░░░░░░░░░░██░░░██████████░░░░░░██░░░░░░░░██░░
## ░██░░░░░░░░░██░░░█░███████████░░░░░░█░░░░░░█░░░░
## ██░░░░░█░░░░░██░██████████████░░░░░█░░░░░░░░█░░░
## ░░█░░░███░░░█░░░███████████████░░░░█░█░░░░█░█░░░
## ░░░█░░░░░░░█░░░░░░░░░███░░█████░░░░█░░████░░█░░░
## ░░░░██░░░██░░░░░░░░░███░░░█████░░░░░██░░░░██░░░░
## ░░░░░░███░░░░░░░░░░████░░░████░░░░░░░░████░░░░░░
## ░░░░░░░░░░░░░░░░░░███░░░░░███░░░░░░░░░░░░░░░░░░░
## ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
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
