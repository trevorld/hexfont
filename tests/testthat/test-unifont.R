test_that("unifont() works", {

    font <- unifont()
    expect_length(font, 77418)

    skip_on_os("windows")

    # Mandarin Chinese
    verify_output("txt/mandarin.txt",
        as_bm_list("Ｒ很棒！", font = font) |> bm_call(cbind) |> print())

    # Emoji
    verify_output("txt/emoji.txt",
        as_bm_list("🐭🐲🐵", font = font) |> bm_call(cbind) |> print())
})
