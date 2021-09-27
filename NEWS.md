hexfont 0.1.2
=============

* Initial release
* Includes all the hex font files included in the [GNU Unifont](http://unifoundry.com/unifont/index.html) 
  source code distribution (v13.0.06).
  The version number is stripped from the file names in the `precompiled` directory and
  the hex fonts are all compressed by `xz` but other than that the hex fonts are otherwise unchanged.
* The function `unifont()` loads in several GNU Unifont hex files as a
  single `bittermelon::bm_font()` object.
