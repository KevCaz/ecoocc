context("Rarefaction")


mat <- rbind(c(1,1), c(1,1))
res1 <- ec_rarefaction(mat, 1)
res2 <- ec_rarefaction(mat, 5)

test_that("expected error", {
  expect_error(ec_rarefaction(1), "nrow(mat) > 1 is not TRUE", fixed = TRUE)
})

test_that("expected warning", {
  expect_warning(ec_rarefaction(rbind(c(1,0), c(0,0))), "In column 2 => 0 presence detected!", fixed = TRUE)
})


test_that("expected dimensions", {
  expect_true(all(dim(res1) == c(2,1)))
  expect_true(all(dim(res2) == c(2,5)))
})

test_that("expected value", {
  expect_true(all(res1 == matrix(2,2,1)))
  expect_true(all(res2 == matrix(2,2,5)))
})
