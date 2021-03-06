context("Betadiversity")

mat <- matrix(c(0,0,1,1,1,0), ncol = 2)
res1 <- ec_betadiversity(mat)
res2 <- ec_betadiversity(mat, "ra")
res3 <- ec_betadiversity(mat, c("bc", "wi"))
#
mat2 <- matrix(c(0,1,1,1,1,0), ncol = 2)
res4 <- ec_betadiversity(mat2, c("bc", "wi", "ja"))
res5 <- ec_betadiversity(mat2, site_names = LETTERS[1:3])

test_that("expected errors", {
  expect_error(ec_betadiversity(c(1)), "nrow(mat) > 1 is not TRUE", fixed = TRUE)
  expect_error(ec_betadiversity(mat, c("bcz")), "any(methods %in% c(\"ra\", \"bc\", \"wi\", \"ja\")) is not TRUE", fixed = TRUE)
  expect_error(ec_betadiversity(mat2, site_names = LETTERS[1:2]), "length(site_names) == nrow(mat_pa) is not TRUE", fixed = TRUE)
})

test_that("check data.frame names", {
  expect_true(all(names(res1) == c("site1", "site2", "bc")))
  expect_true(all(names(res2) == c("site1", "site2", "site1_only", "site2_only", "both", "none")))
  expect_true(all(names(res3) == c("site1", "site2", "bc", "wi")))
  expect_true(nrow(res1) == 3)
  expect_true(all(res5$site1 == LETTERS[c(1, 1, 2)]))
  expect_true(all(res5$site2 == LETTERS[c(2, 3, 3)]))
})


test_that("check raw", {
  expect_true(all(res2[1:2,3:6] == matrix(c(0,1,0,1,1,0,1,0), 2)))
})

test_that("check bc and wi", {
  expect_true(all(res3$bc == c(0,1,1)))
  expect_true(all(res3$wi == c(0,1,1)))
  expect_true(all(res4$bc == c(1/3,1,1/3)))
  expect_true(all(res4$ja == 1- res4$wi))
  expect_true(all(res4$wi == c(0.5,1,0.5)))
})
