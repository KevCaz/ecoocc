context("Temporal betadiversity")

mat1 <- rbind(c(1, 1), c(1, 0), c(0,0))
mat2 <- rbind(c(0 ,1), c(0, 1), c(0,0))
res1 <- ec_temporal_betadiversity(mat1, mat2)
res2 <- ec_temporal_betadiversity(mat1, mat2, c("ra", "bc", "wi"), site_names = LETTERS[1:3])

test_that("expected errors", {
  expect_error(ec_temporal_betadiversity(mat1, mat2, "bcz"), "any(methods %in% c(\"ra\", \"bc\", \"wi\")) is not TRUE", fixed = TRUE)
  expect_error(ec_temporal_betadiversity(mat1, mat2[-1,]), "all(dim(mat1) == dim(mat2)) is not TRUE", fixed = TRUE)
})


test_that("check data.frame names", {
  expect_true(all(names(res1) == c("site", "bc")))
  expect_true(all(names(res2) == c("site", "site_t1_only", "site_t2_only", "both", "none", "bc", "wi")))
})

test_that("check values", {
  expect_true(all(res2$site == LETTERS[1:3]))
  expect_true(all(res2$site_t1_only == c(1,1,0)))
  expect_true(all(res2$site_t2_only == c(0,1,0)))
  expect_true(all(res2$site_both == c(1,0,0)))
  expect_true(all(res2$site_none == c(0,0,2)))
  expect_true(all(res2$bc[1:2] == c(1/3,1)))
  expect_true(all(res2$wi[1:2] == c(1/2,1)))
  expect_true(is.nan(res2$bc[3]))
  expect_true(is.nan(res2$wi[3]))
})
