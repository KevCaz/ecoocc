context("Cooccurrence")

mat1 <- rbind(c(0,0,1), c(0,1,0))
res1 <- ec_cooccurrence(mat1, species_names = LETTERS[1:3])
#
set.seed(2391)
mat2 <- matrix(stats::runif(1000000)>.1,  ncol = 10)
res2 <- ec_cooccurrence(mat2, test = c('bi', 'hy'))


test_that("expected error", {
  expect_error(ec_cooccurrence(mat1, species_names = "A"), "length(species_names) == ncol(mat) is not TRUE", fixed = TRUE)
})

test_that("expected names", {
  expect_true(all(names(res1) == c("species1", "species2", "case_10", "case_01", "case_11", "case_00", "case_sp1", "case_sp2")))
  expect_true(all(names(res2) == c(names(res1), "zs_bi", "zs_hy")))
  expect_true(all(res1$species1 == LETTERS[c(1, 1, 2)]))
  expect_true(all(res1$species2 == LETTERS[c(2, 3, 3)]))
})

test_that("expected values", {
  expect_true(all(res1$case_10 == c(0, 0, 1)))
  expect_true(all(res1$case_01 == c(1, 1, 1)))
  expect_true(all(res1$case_11 == c(0, 0, 0)))
  expect_true(all(res1$case_00 == c(1, 1, 0)))
  expect_true(all(res1$case_sp1 == res1$case_10 + res1$case_11))
  expect_true(all(res1$case_sp2 == res1$case_01 + res1$case_11))
})

test_that("asymptotic behaviour", {
  expect_true(stats::cor(res2$zs_hy, res2$zs_bi)>.9999)
})
