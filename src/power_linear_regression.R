
# This is power for simple linear regression
# y = beta0 + beta1*x + e
# If e are normally distributed, can use t-test
# According to Neter et al "Applied Linear Regression" page 72, 
# Under the alternative beta1 = b1 (non-zero)
# Power = P(|t*|>t_{1-alpha/2, n-2, ncp}, where
# ncp = |b1|/s(b1) = sqrt(N) * |b1| * sigma_X / sigma_e

power_linreg <- function(n = n, 
                         alpha = alpha, 
                         b1 = b1,
                         sigma_X = sigma_X, 
                         sigma_e = sigma_e){
  
  t_H0_crit_value_positive = abs(qt(alpha/2, n-2, lower.tail = TRUE))
  lambda = sqrt(n) * b1 * sigma_X / sigma_e
  return(pt(t_H0_crit_value_positive, df = n-2, ncp = lambda, lower.tail = FALSE) +
           pt(-t_H0_crit_value_positive, df = n-2, ncp = lambda, lower.tail = TRUE))
}

# test code not run
## Cross-checking with PASS 
# Example 2
# power_linreg(n = 10, alpha = 0.05, b1 = 0.25, sigma_X = sqrt(3400/10), sigma_e = sqrt(10)) 
# 
# # Example 3
# power_linreg(n = 100, alpha = 0.05, b1 = -.0667, sigma_X = 7.5, sigma_e = 4) # 0.2359684

