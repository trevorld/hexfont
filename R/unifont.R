#' Load GNU Unifont font
#'
#' The function `unifont()` loads in several GNU Unifont hex files as a
#' single [bittermelon::bm_font()] object.
#'
#' @param upper Include glyphs above the Unicode Basic Multilingual plane.
#' @param jp Use Japanese version of Chinese characters.
#' @param csur Include (Under-)Conscript Unicode Registry glyphs.
#' @param sample Add circle to "Combining" characters.
#' @inheritParams bittermelon::read_hex
#' @param cache Use a cached version of this font from `tools::R_user_dir("hexfont", "cache")` if it exists.
#'              If it does not exist than create a cached version of this font.
#' @return A [bittermelon::bm_font()] object.
#'         If `cache` is `TRUE` then as a side effect may create an `.rds` file
#'         in `tools::R_user_dir("hexfont", "cache")`.
#' @examples
#' # Much faster to load only the subset of GNU Unifont one needs
#' # Mandarin Chinese
#' if (require("bittermelon")) {
#'   s <- "\uff32\u5f88\u68d2\uff01"
#'   font <- unifont(ucp = str2ucp(s))
#'   bm <- as_bm_bitmap(s, font = font)
#'   print(bm, px = px_ascii)
#' }
#'
#' # Emoji
#' if (require("bittermelon")) {
#'   s <- "\U0001f42d\U0001f432\U0001f435"
#'   font <- unifont(ucp = str2ucp(s))
#'   bm <- as_bm_bitmap(s, font = font)
#'   print(bm, px = px_ascii)
#' }
#'
#' \donttest{# Will take more than 5s on CRAN machines
#' # Compiling the entire font from the hex files takes a long time
#' system.time({font <- unifont()})
#' length(font) |> prettyNum(big.mark = ",") # number of glyphs
#  object.size(font) |> format(units = "MB") # memory used
#' # It is usually much faster to use a cached version of the font
#' if (file.exists(hexfont:::unifont_cache_filename())) {
#'   system.time({font_from_cache <- unifont(cache = TRUE)})
#' }
#' }
#' @import bittermelon
#' @export
unifont <- function(upper = TRUE, jp = FALSE, csur = TRUE, sample = FALSE, ucp = NULL, cache = FALSE) {
    stopifnot(is.null(ucp) || isFALSE(cache))
    if (cache) {
        f <- unifont_cache_filename(upper, jp, csur, sample)
        if (file.exists(f)) {
            font <- readRDS(f)
        } else {
            font <- unifont_from_hex(upper, jp, csur, sample)
            if (!dir.exists(dirname(f)))
                dir.create(dirname(f), recursive = TRUE)
            saveRDS(font, file = f, version = 3)
        }
    } else {
        font <- unifont_from_hex(upper, jp, csur, sample, ucp)
    }
    font
}

unifont_from_hex <- function(upper, jp, csur, sample, ucp = NULL) {
    f_base <- "unifont"
    if (jp) {
        f_base <- paste0(f_base, "_jp")
    }
    if (sample)
        f_base <- paste0(f_base, "_sample")
    f_base <- paste0(f_base, ".hex.xz")
    f_base <- system.file(file.path("font", "precompiled", f_base),
                          package = "hexfont")
    font <- bittermelon::read_hex(f_base, ucp = ucp)
    if (upper) {
        if (sample)
            f_upper <- "unifont_upper_sample.hex.xz"
        else
            f_upper <- "unifont_upper.hex.xz"
        f_upper <- system.file(file.path("font", "precompiled", f_upper),
                               package = "hexfont")
        font <- c(font, bittermelon::read_hex(f_upper, ucp = ucp))
    }
    if (csur) {
        font_dir <- system.file("font", package = "hexfont")
        csur_dirs <- list.files(font_dir, pattern = "csur$", full.names = TRUE)
        hex_files <- list.files(csur_dirs, pattern = ".hex.xz$",
                                full.names = TRUE)
        csur_fonts <- lapply(hex_files, bittermelon::read_hex, ucp = ucp)
        font <- c(font, do.call(c, csur_fonts))
    }
    font
}

unifont_cache_filename <- function(upper = TRUE, jp = FALSE, csur = TRUE, sample = FALSE) {
    cache_dir <- tools::R_user_dir("hexfont", "cache")
    filename <- paste0("unifont_", unifont_version(), "_",
                       sprintf("%d%d%d%d", upper, jp, csur, sample), ".rds")
    normalizePath(file.path(cache_dir, filename), mustWork = FALSE)
}


#' GNU Unifont version number
#'
#' The function `unifont_version()` returns the GNU Unifont version number
#' this package packed their `hex` files from.
#'
#' @return The Unifont version number as a [numeric_version()] class.
#' @examples
#' unifont_version()
#' @export
unifont_version <- function() {
    numeric_version("16.0.02")
}
