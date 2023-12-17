test_that("unifont_combining()", {
    expect_equal(unifont_version(),
                 numeric_version("15.1.04"))

    expect_length(unifont_combining(), 184L)
    expect_length(unifont_combining(upper = FALSE), 184L)
    expect_length(unifont_combining(csur = FALSE), 0L)
    expect_length(unifont_combining(unicode = TRUE), 2356L)
})
