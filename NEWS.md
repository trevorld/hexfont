hexfont 0.4.0
=============

* We update the hex font files to match [GNU Unifont](http://unifoundry.com/unifont/index.html) v15.1.04 (previously matched v15.0.01).
* `unifont_version()` returns the GNU Unifont version number this package packed their `hex` files from (#6).
* Bumps minimum version number of `{bittermelon}` so the examples/tests continue to work after a breaking change 
  in `Unicode::u_char_property()`'s behavior introduced in `{Unicode}` v15.1.0-1 (#7).

hexfont 0.3.1
=============

* We update the hex font files to match [GNU Unifont](http://unifoundry.com/unifont/index.html) v15.0.01 (previously matched v14.0.01) (#3).
* `unifont_combining()` returns a character vector of Unicode code points that are "combining" glyphs (#4).
* The `unifont()`'s new argument `ucp` can restrict which Unicode code points are read (which can be faster than loading all of them).

hexfont 0.2.1
=============

* We update the hex font files to match [GNU Unifont](http://unifoundry.com/unifont/index.html) v14.0.01 (previously matched v13.0.06).

Breaking Changes
----------------

* Included hex font files are now compressed by `xz` instead `gzip`
  and now end with a `.xz` instead of `.gz`.
  This reduces file sizes by about a third.
  Please note the function `unifont()` is still backwards compatible.

hexfont 0.1.1
=============

* Initial release
* Includes all the hex font files included in the [GNU Unifont](http://unifoundry.com/unifont/index.html) 
  source code distribution (v13.0.06).
  The version number is stripped from the file names in the `precompiled` directory and
  the hex fonts are all compressed by `gzip` but other than that the hex fonts are otherwise unchanged.
* The function `unifont()` loads in several GNU Unifont hex files as a
  single `bittermelon::bm_font()` object.
