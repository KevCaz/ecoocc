mat <- matrix(stats::runif(1000000)>.1,  ncol = 2)
out <- ec_cooccurrence(mat, test = c('bi', 'hy'))
