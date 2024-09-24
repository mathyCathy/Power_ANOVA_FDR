
source("src/helper_funcs.R")
source("src/power_1wayANOVA_G.R")

# To detect a difference in measures across 4 groups (4 groups of n=127, 74, 45, 32), 
# we assume detection of 3000 tests, FDR adjustment, we will detect effect size ___ at 80% power 
# using ANOVA for log-transformed values.

m = 3000
effect_size_vector = seq(0.1, 0.5, by = 0.01)

## Using the approach of Jung 2005 Bioinformatics to estimate power/sample size control for FDR
## Let's vary p0, which is the proportion of tests that are truly null, since we don't know what it is
p0_vector = seq(0.2, 0.8, by = 0.1) # prop of tests that are truly null
min_eff_sizes = rep(NA, length(p0_vector))
for (i in 1:length(p0_vector)){
  print(i)
  tmp_power = unlist(lapply(effect_size_vector, 
                        power_1wayANOVA_G, n = 278, 
                        alpha = alpha_threshold(m = m, p0 = p0_vector[i], fdr = 0.05, beta = 0.2), 
                        group_n_vec = c(127, 74, 45), R = 1000, seed = 37)
  )
  min_eff_sizes[i] = effect_size_vector[min(which(tmp_power >= 0.8))]
}

# > min_eff_sizes
# [1] 0.16 0.18 0.20 0.21 0.22 0.23 0.24

