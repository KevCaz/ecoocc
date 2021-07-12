context("Create pa object")


mat <- matrix(c(0, 0, 2, 1, 1, 0), 3, 2)
res1 <- ec_pa(mat, spc_name = "Lynx", sit_name = "GHQ")
res2 <- ec_as_pa(mat, spc_name = "Lynx", sit_name = "GHQ")

test_that("expected error", {
  expect_equal(res1, res2)
  expect_equal(attributes(res1)$noccur, 3)
  expect_error(ec_as_pa(matrix(data.frame())))
})


