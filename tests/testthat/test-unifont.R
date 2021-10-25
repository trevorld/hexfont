test_that("unifont() works", {

    font <- unifont()
    expect_length(font, 78121L)

    skip_on_os("windows")

    # Mandarin Chinese
    verify_output("txt/mandarin.txt", {
        bml <- as_bm_list("Ｒ很棒！", font = font)
        print(bm_call(bml, cbind))
    })

    # Emoji
    verify_output("txt/emoji.txt", {
        bml <- as_bm_list("🐭🐲🐵", font = font)
        print(bm_call(bml, cbind))
    })
})
