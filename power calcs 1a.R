
# To detect a difference in group 1 (n=278) vs group 2 (n=20), 
# we assume detection of 3000 tests, FDR adjustment, we will detect effect size ___ at 80% power 
# using ANOVA for log-transformed values.

source("src/helper_funcs.R")
source("src/power_1wayANOVA_G.R")

m = 3000
effect_size_vector = seq(0.1, 0.5, by = 0.01) # Considering a range of effect sizes

## Using the approach of Jung 2005 Bioinformatics to estimate power/sample size control for FDR
## Let's vary p0, which is the proportion of tests that are truly null, since we don't know what it is
p0_vector = seq(0.2, 0.8, by = 0.1) 
min_eff_sizes = rep(NA, length(p0_vector)) # save minimum detectable effects sizes for each p0
for (i in 1:length(p0_vector)){
  print(i)
  tmp_power = unlist(lapply(effect_size_vector, 
                            power_1wayANOVA_G, 
                            n = 298, # total N
                            alpha = alpha_threshold(m = m, p0 = p0_vector[i], fdr = 0.05, beta = 0.2), # From Jung
                            group_n_vec = c(278), # For G groups, vector of sample sizes of first G-1 groups
                            R = 1000, # number of simulated datasets to estimate power for 1-way ANOVA with G groups of unequal size
                            seed = 37)
  )
  min_eff_sizes[i] = effect_size_vector[min(which(tmp_power >= 0.8))]
}

min_eff_sizes
# 0.14 0.15 0.16 0.17 0.18 0.19 0.20