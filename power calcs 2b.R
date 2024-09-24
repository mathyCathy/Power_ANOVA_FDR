
# Each patient will have 15 different cell types and a distribution of percentages that add up to 100%. 
# Then you will look at each cell type separately, e.g., B-cells, and compare the B-cell percentages 
# between cases and controls. The way you propose to report the findings makes it sound like you are 
# viewing the B-cell percentages as continuous. So, it seems like we will be looking at 15 tests 
# (one for each cell type) comparing the distribution of continuous percentages between case (n=80) and control *n=20)

source("src/helper_funcs.R")
source("src/power_1wayANOVA_G.R")

m = 15
effect_size_vector = seq(0.1, 1, by = 0.01) # Considering a range of effect sizes

## Using the approach of Jung 2005 Bioinformatics to estimate power/sample size control for FDR
## Let's vary p0, which is the proportion of tests that are truly null, since we don't know what it is
p0_vector = seq(0.2, 0.8, by = 0.2) 
min_eff_sizes = rep(NA, length(p0_vector)) # save minimum detectable effects sizes for each p0
for (i in 1:length(p0_vector)){
  print(i)
  tmp_power = unlist(lapply(effect_size_vector, 
                            power_1wayANOVA_G, 
                            n = 80, # total N
                            alpha = alpha_threshold(m = m, p0 = p0_vector[i], fdr = 0.05, beta = 0.2), # From Jung
                            group_n_vec = c(36, 21, 13), # For G groups, vector of sample sizes of first G-1 groups
                            R = 1000, # number of simulated datasets to estimate power for 1-way ANOVA with G groups of unequal size
                            seed = 37)
  )
  min_eff_sizes[i] = effect_size_vector[min(which(tmp_power >= 0.8))]
}

min_eff_sizes
# 0.30 0.37 0.41 0.45