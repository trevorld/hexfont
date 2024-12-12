test_that("unifont_combining()", {
    expect_equal(unifont_version(),
                 numeric_version("16.0.02"))

    expect_length(unifont_combining(), 231L)
    expect_length(unifont_combining(upper = FALSE), 216L)
    expect_length(unifont_combining(csur = FALSE), 0L)
    expect_length(unifont_combining(unicode = TRUE), 2454L)
})
