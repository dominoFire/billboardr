context("test-basic.R")

test_that("hot100 works", {
 li_chart = hot100("1996-06-21")

 testthat::expect_true(class(li_chart) == "list")
 testthat::expect_true(length(li_chart) > 0)
})
