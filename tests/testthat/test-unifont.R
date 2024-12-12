test_that("unifont() works", {

    skip_on_os("windows")

    # Mandarin Chinese
    verify_output("txt/mandarin.txt", {
        s <- "\uff32\u5f88\u68d2\uff01"
        font <- unifont(ucp = str2ucp(s))
        bm <- as_bm_bitmap(s, font = font)
        print(bm)
    }, unicode = TRUE)

    # Emoji
    verify_output("txt/emoji.txt", {
        s <- "\U0001f42d\U0001f432\U0001f435"
        font <- unifont(ucp = str2ucp(s))
        bm <- as_bm_bitmap(s, font = font)
        print(bm)
    }, unicode = TRUE)
})
