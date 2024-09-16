
# power_1wayANOVA
#
# This function uses simulations to estimate power for 1-way ANOVA with three unequal groups
# Assumes outcomes in all three groups are normal with SD 1. 
# Assumes groups 2 and 3 have mean zero and group 3 has mean eff_size
# Simulates R datasets under the above setup, and fits an ANOVA assuming equal variance across groups
power_1wayANOVA <- function(eff_size, n1 = 200, n2 = 20, n3 = 20, R = 500, seed = 37){
  
  set.seed(seed)
  rejectVec = rep(NA, R)
  for (r in 1:R){
    y1 = rnorm(n1, mean = eff_size, sd = 1)
    y2 = rnorm(n2, mean = 0, sd = 1)
    y3 = rnorm(n3, mean = 0, sd = 1)
    
    # setup data
    dat = data.frame(y = c(y1, y2, y3), 
                     group = c(rep("Group1", n1), rep("Group2", n2), rep("Group3", n3)))
    fit.anova = aov(y ~ group, data = dat)
    
    # p-value
    rejectVec[r] = as.numeric(summary(fit.anova)[[1]]$`Pr(>F)`[1] < 0.05)
  }
  return(mean(rejectVec))
  
}

# test code not run

# power_1wayANOVA(eff_size = 0.5)
# power_1wayANOVA(eff_size = 0.52)
# power_1wayANOVA(eff_size = 0.53)
# power_1wayANOVA(eff_size = 0.54)
# 
# unlist(lapply(seq(0.4, 0.7, by = 0.01), power_1wayANOVA))
