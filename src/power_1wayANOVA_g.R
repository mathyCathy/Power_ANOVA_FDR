
# power_1wayANOVA_G
#
# This function uses simulations to estimate power for 1-way ANOVA with G unequal groups
# Assumes outcomes in all groups are normal with SD 1. 
# Assumes group 1 has mean delta and all other groups have mean 0
# Simulates R datasets under the above setup, and fits an ANOVA assuming equal variance across groups
# eff_size is the one from Cohen (1998)
# group_n_vec: a vector of length (G-1) giving the size of the first (G-1) groups
power_1wayANOVA_G <- function(n = 278, alpha = 0.05, eff_size, group_n_vec = c(127, 74, 45), R = 500, seed = 37){
  
  # Based on assumptions about, the mean of the first group should be the following delta
  delta = eff_size * n / sqrt(group_n_vec[1] * (n - group_n_vec[1]))
  
  set.seed(seed)
  rejectVec = rep(NA, R)
  for (r in 1:R){
    y1 = rnorm(group_n_vec[1], mean = delta, sd = 1)
    y2 = rnorm(group_n_vec[2], mean = 0, sd = 1)
    y3 = rnorm(group_n_vec[3], mean = 0, sd = 1)
    y4 = rnorm(n - sum(group_n_vec), mean = 0, sd = 1)
    
    # setup data
    dat = data.frame(y = c(y1, y2, y3, y4), 
                     group = rep(paste0("Group", 1:4), c(group_n_vec, n - sum(group_n_vec))))
    fit.anova = aov(y ~ group, data = dat)
    
    # p-value
    rejectVec[r] = as.numeric(summary(fit.anova)[[1]]$`Pr(>F)`[1] < alpha)
  }
  return(mean(rejectVec))
}

# test code not run
# 
# power_1wayANOVA_4groups(n = 278, alpha = 0.05, eff_size = 0.3, group_n_vec = c(127, 74, 45), R = 500, seed = 37)
# unlist(lapply(seq(0.1, 0.5, by = 0.01), power_1wayANOVA_4groups, n = 278, alpha = 0.05, group_n_vec = c(127, 74, 45), R = 500, seed = 37))
