#' Load Unifont font
#'
#' The function `unifont()` loads in several GNU Unifont hex files as a
#' single [bittermelon::bm_font()] object.
#'
#' @param upper Include glyphs above the Unicode Basic Multilingual plane.
#' @param jp Use Japanese version of Chinese characters.
#' @param csur Include (Under-)Conscript Unicode Registry glyphs.
#' @param sample Add circle to "Combining" characters.
#' @return A [bittermelon::bm_font()] object.
#' @examples
#' if (require("bittermelon")) {
#'   # Note Unifont is a **big** font
#'   system.time(font <- unifont())
#'   length(font)
#'   object.size(font)
#'
#'   # Mandarin Chinese
#'   as_bm_list("Ｒ很棒！", font = font) |> bm_call(cbind) |> print()
#'
#'   # Emoji
#'   as_bm_list("🐭🐲🐵", font = font) |> bm_call(cbind) |> print()
#' }
#' @import bittermelon
#' @export
unifont <- function(upper = TRUE, jp = FALSE, csur = TRUE, sample = FALSE) {
    f_base <- "unifont"
    if (jp) {
        f_base <- paste0(f_base, "_jp")
    }
    if (sample)
        f_base <- paste0(f_base, "_sample")
    f_base <- paste0(f_base, ".hex.gz")
    f_base <- system.file(file.path("font", "precompiled", f_base),
                          package = "hexfont")
    font <- bittermelon::read_hex(f_base)
    if (upper) {
        if (sample)
            f_upper <- "unifont_upper_sample.hex.gz"
        else
            f_upper <- "unifont_upper.hex.gz"
        f_upper <- system.file(file.path("font", "precompiled", f_upper),
                               package = "hexfont")
        font <- c(font, bittermelon::read_hex(f_upper))
    }
    if (csur) {
        font_dir <- system.file("font", package = "hexfont")
        csur_dirs <- list.files(font_dir, pattern = "csur$", full.names = TRUE)
        hex_files <- list.files(csur_dirs, pattern = ".hex.gz$",
                                full.names = TRUE)
        csur_fonts <- lapply(hex_files, bittermelon::read_hex)
        font <- c(font, do.call(c, csur_fonts))
    }
    font
}
