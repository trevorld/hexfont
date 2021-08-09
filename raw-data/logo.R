library("bittermelon")
library("grid")
library("hexfont")
library("piecepackr")

font <- unifont()
hex <- pp_shape("convex6")

draw_logo <- function() {
    grid.newpage()
    grid.draw(hex$shape(gp = gpar(col = NA, fill = "yellow")))
    grid.draw(hex$mat(0.03, gp = gpar(fill = "black")))
    hexfont <- as_bm_list("hexfont", font = font) |> bm_call(cbind)
    plot(hexfont, col = c(NA, "black"),
         vp = viewport(y=0.7, width=0.8, height=0.2))
    emoji <- as_bm_list("🐝", font = font) |> bm_call(cbind)
    # emoji <- as_bm_list("\u2b21", font = font) |> bm_call(cbind)
    plot(emoji, col = c(NA, "black"),
         vp = viewport(y = 0.35, width = 0.5, height = 0.5))
}

w <- 3.0
svg("man/figures/logo.svg", width = w, height = w, bg = "transparent")
draw_logo()
dev.off()

png("man/figures/logo.png", width = w, height = w, units = "in",
    res = 72, bg = "transparent")
draw_logo()
dev.off()
