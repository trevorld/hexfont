#' Get combining character information
#'
#' `unifont_combining()` returns a character vector of the code points
#' for all the "combining" characters in Unifont.
#'
#' @param upper Include glyphs above the Unicode Basic Multilingual plane.
#' @param csur Include (Under-)Conscript Unicode Registry glyphs.
#' @param unicode Include combining glyphs assigned by the Unicode Consortium
#'                (i.e. not ones in the Private Use Area like the CSUR ones).
#'                By default `FALSE` since [bittermelon::bm_compose()] can usually guess that
#'                a Unicode Consortium assigned glyph is a combining glyph by
#'                using [Unicode::u_char_property()].
#' @return A character vector of Unicode code points
#' @seealso  Can be used with the `pua_combining` argument of [bittermelon::bm_compose()]
#'           and [bittermelon::as_bm_bitmap()].
#' @examples
#'   df <- unifont_combining()
#'   utils::head(df)
#'
#' \dontrun{ # Unifont is a **big** font, will take more than 10 seconds
#'   if (require("bittermelon")) {
#'     system.time(font <- unifont())
#'
#'     # Tengwar with combining glyphs
#'     bml <- as_bm_list("\ue004\ue014\ue04a\ue005\ue000\ue040\ue022\ue04a\ue003\ue04e",
#'                       font = font)
#'     to_raise <- which(names(bml) %in% c("U+E04A", "U+E04E"))
#'     bml[to_raise] <- bm_shift(bml[to_raise], top = 1L)
#'     bml <- bm_compose(bml, pua_combining = unifont_combining())
#'     bml <- bm_pad(bml, type = "trim", left = 1L, right = 0L)
#'     bm <- bm_call(bml, cbind)
#'     print(bm, px = px_ascii)
#'   }
#' }
#' @export
unifont_combining <- function(upper = TRUE, csur = TRUE, unicode = FALSE) {
    font_dir <- system.file("font", package = "hexfont")
    combining_files <- list.files(font_dir, pattern = "combining.txt",
                                  full.names = TRUE, recursive = TRUE)
    if (!upper)
        combining_files <- grep("plane00(csur)*-combining.txt$", combining_files,
                                value = TRUE)
    if (!csur)
        combining_files <- grep("csur-combining.txt$", combining_files,
                                invert = TRUE, value = TRUE)
    if (!unicode)
        combining_files <- grep("csur-combining.txt$", combining_files,
                                value = TRUE)
    read_fn <- function(x) {
        utils::read.delim(x, header = FALSE, sep = ":",
                          col.names = c("ucp", "width"),
                          stringsAsFactors = FALSE)
    }
    dfs <- lapply(combining_files, read_fn)
    df <- do.call(rbind, dfs)
    if (!is.null(df) && nrow(df) > 0L)
        paste0("U+", df$ucp)
    else
        character(0)
}
