
source("src/power_linear_regression.R")
library(FDRsampsize)


m = 8 # num tests
n_hct = 40
n_control = 20
n = (n_hct + n_control)
p = n_hct / n
sd_X_binom = sqrt(p*(1-p)) # sd X based on bernoulli, 0.4714

power_linreg(n = 60, alpha = 0.05, b1 = 0.78, sigma_e = 1, sigma_X = sd_X_binom)

beta_vector = seq(0.25, 1, by = 0.01) # linear regression slopes
p0_vector = seq(1/4, 3/4, by = 1/8) # prop of tests that are truly null
min_eff_sizes = rep(NA, length(p0_vector))
for (i in 1:length(p0_vector)){
  print(i)
  n_null_tests = m * p0_vector[i]
  
  tmp_beta_power = rep(NA, length(beta_vector))
  for (j in 1:length(beta_vector)){
  tmp_beta_power[j] = fdr.power(fdr = 0.05, 
                        n = 60, 
                        pow.func = power_linreg,
                        eff.size = c(rep(0, n_null_tests), rep(beta_vector[j], m - n_null_tests)), # 8 tests, 50% with min detect slope of 0.8
                        null.effect=0, 
                        sigma_X = sd_X_binom, sigma_e = 1) 
  }
  min_eff_sizes[i] = beta_vector[min(which(tmp_beta_power >= 0.8))]
}

# 0.68 0.75 0.81 0.87 0.93
