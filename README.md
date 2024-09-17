# Power_ANOVA_FDR
Sample size and power calculations for 1-way ANOVA rolling in FDR

<!-- ABOUT THE PROJECT -->
## Background and setup

* 3-group exposure (n1 = 200, n2 = 20, n3 = 20) - can be generalized to more than 3 groups. 
* Continuous outcome (can assumed to be normally distributed and standardized)
* Comparisons via ANOVA
    + Assume group 1 has mean $\delta$ and groups 2 and 3 have mean 0. See below section on defining the \it{effect size} relative to Cohen's definition (1988) in the standard ANOVA with equal group sizes.
* 3000-4000 protein (outcomes) so want to control FDR
* Ideally, assumed N, 80% and produce minimal detectable effect sizes

## Approach

* Write a function to calculate power (via simulations) for 1-way ANOVA with unequal group sizes
* Use R project 'FDRsampsize' that takes in fdr, n, power function (above), eff.size (effect size vector), null.effect.

## Defining \it{effect size} in these ANOVA power calculations