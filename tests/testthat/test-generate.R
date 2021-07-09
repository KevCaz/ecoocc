
test_that("expected generate", {
  expect_equal(ec_generate(10, 10, 0), matrix(0, 10, 10))
  expect_equal(ec_generate(10, 10, 1), matrix(1, 10, 10))
})