context("Generate random pa objects")

test_that("expected generate", {
  expect_equal(ec_generate_pa(10, 10, 0), ec_pa(matrix(0, 10, 10)))
  expect_equal(ec_generate_pa(10, 10, 1), ec_pa(matrix(1, 10, 10)))
})


context("Order pa object")

mat1 <- matrix(c(0, 1, 1, 1), 2)

test_that("expected order", {
  expect_equal(ec_order_pa(mat1), ec_as_pa(matrix(c(1, 1, 1, 0), 2)))
  expect_equal(ec_order_pa(mat1, "species"), ec_as_pa(matrix(c(1, 1, 0, 1), 2)))
  expect_equal(ec_order_pa(mat1, "site"), ec_as_pa(matrix(c(1, 0, 1, 1), 2)))
  expect_equal(
    ec_order_pa(mat1, decreasing = FALSE), 
    ec_as_pa(mat1)
  )
})