context("Pairwise cooccurrence")

mat1 <- rbind(c(0,0,1), c(0,1,0))
res1 <- ec_cooccurrence(mat1)$counts
#
set.seed(2391)
mat2 <- matrix(stats::runif(1000000) > .1,  ncol = 10)
res2 <- ec_cooccurrence(mat2, test = c('bi', 'hy'))$counts


test_that("expected names", {
  expect_true(all(names(res1) == c("species1", "species2", "case_10", "case_01", "case_11", "case_00", "case_spc1", "case_spc2")))
  expect_true(all(names(res2) == c(names(res1), "zs_bi", "zs_hy")))
})

test_that("expected values", {
  expect_true(all(res1$case_10 == c(0, 0, 1)))
  expect_true(all(res1$case_01 == c(1, 1, 1)))
  expect_true(all(res1$case_11 == c(0, 0, 0)))
  expect_true(all(res1$case_00 == c(1, 1, 0)))
  expect_true(all(res1$case_spc1 == res1$case_10 + res1$case_11))
  expect_true(all(res1$case_spc2 == res1$case_01 + res1$case_11))
})

test_that("asymptotic behavior", {
  expect_true(stats::cor(res2$zs_hy, res2$zs_bi) > .9999)
})



context("Tripletwise cooccurrence")

mat3 <- matrix(c(1, 1, 0, 1), 2)

test_that("expected values", {
  expect_error(ec_cooccurrence_triplet(mat3))
})
# res3 <- ec_cooccurrence(mat3, test = c('bi', 'hy'))




context("Checkerboard score")
# example in Stone & Roberts 

mat0 <- matrix(0, 10, 10)
mat1 <- matrix(1, 10, 10)
matU <- rbind(cbind(mat1, mat0), cbind(mat0, mat1))
resU <- ec_checkerboard(matU)

test_that("expected values", {
  expect_equal(unique(resU$c_units$c_units), c(0, 100))
  expect_equal(round(resU$c_score, 1), 52.6)
  expect_equal(ec_checkerboard(matrix(c(1, 1, 1, 0), 2))$c_score, 0)
  expect_equal(ec_checkerboard(matrix(c(1, 1, 1, 0), 2))$c_score_s2, 0)
  expect_equal(ec_checkerboard(matrix(c(0, 1, 1, 0), 2))$c_score, 1)
})
