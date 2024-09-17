# Power_ANOVA_FDR
Sample size and power calculations for 1-way ANOVA rolling in FDR

<!-- ABOUT THE PROJECT -->
## Background and setup

* 4-group exposure ($n_1 = 127$, $n_2 = 74$, $n_3 = 45$, $n_4 = 32$) - can be generalized to $G$ groups. Let $N$ be the total sample size.
* Continuous outcome (can assumed to be normally distributed and standardized)
* Comparisons via ANOVA
    + Assume group 1 has mean $\delta$ and remaining groups have mean 0. See below section on defining the *effect size* relative to Cohen's definition (1988) in the standard ANOVA with equal group sizes.
* 3000 proteins (outcomes) so want to control FDR
* Ideally, assumed N, 80% and produce minimal detectable effect sizes

## Approach

* Write a function to calculate power (via simulations) for 1-way ANOVA with unequal group sizes
* Use R project 'FDRsampsize' that takes in fdr, n, power function (above), eff.size (effect size vector), null.effect.

## Defining *effect size* in these ANOVA power calculations

For ANOVA with equal group sizes $n_1=n_2=\dots=n_G$ and common variance $\sigma^2$. Let $\mu_W$ denoted the weighted mean of all groups. For the case of the 4 groups above, $$\mu_W=\displaystyle\frac{n_1}{N}\delta.$$ Additionally, define $\sigma_m^2$ as follows:

$$\sigma_m^2 = \displaystyle\sum_{i=1}^G \displaystyle\frac{n_i}{N}\left(\mu_i - \mu_W \right)^2,$$ 

which for the case of 4 groups is 

$$\sigma_m^2 = \displaystyle\frac{n_1}{N}\left(\delta - \mu_W\right)^2 +\displaystyle\frac{n_2}{N}\mu_W^2 + 
\displaystyle\frac{n_3}{N}\mu_W^2 + 
\displaystyle\frac{n_4}{N}\mu_W^2 = \displaystyle\frac{n_1}{N}\left(\delta - \mu_W\right)^2 +\displaystyle\frac{N - n_1}{N}\mu_W^2.$$

Cohen (1988) defined the effect size $f$ as 

$$f = \sqrt{\displaystyle\frac{\sigma_m^2}{\sigma^2}}.$$

In our case, we assume $\sigma=1$ and thus $f = \sigma_m$. Note: this differs from what I intuitively assumed was the effect size which was just the difference in means of the group with the largest mean vs. the smallest mean scaled by the variance, i.e., $\delta$. 