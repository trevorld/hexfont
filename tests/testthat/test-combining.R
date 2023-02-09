test_that("unifont_combining()", {
    expect_length(unifont_combining(), 178L)
    expect_length(unifont_combining(upper = FALSE), 178L)
    expect_length(unifont_combining(csur = FALSE), 0L)
    expect_length(unifont_combining(unicode = TRUE), 2350L)
})
