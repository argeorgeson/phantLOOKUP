
# creates data-raw
# usethis::use_data_raw("Lookup_Table")

## code to prepare `Lookup_Table` dataset goes here

usethis::use_data(Lookup_Table, overwrite = TRUE)



library(corpcor)


observedall <- expand.grid(corxm = seq(-.9, .9, .1), corxy = seq(-.9, .9, .1), cormy = seq(-.9, .9, .1))


observedall$cond <- seq(1, nrow(observedall), 1)


test <- data.frame(NA)
for (i in 1:nrow(observedall)) {
  df <- matrix(c(1, observedall[i, 1], observedall[i, 2], observedall[i, 1], 1, observedall[i, 3], observedall[i, 2], observedall[i, 3], 1), nrow = 3)
  test[i, ] <- is.positive.definite(df)
}

observedall <- cbind(observedall, test)
observed <- observedall[which(observedall$NA. == TRUE), ]

obs2 <- observed[, 1:4]

results_noNA <- readRDS("G:/My Drive/ASU/Dave lab/temporal bias/Manuscript/Revision/Lookup Table/lookup_table_noNA.rds")

# this puts it in the package
usethis::use_data(results_noNA, obs2, internal = TRUE)
