
# Relationship between Cohen's f (effect size) and mean of first group, denoted delta
f_from_delta <- function(delta, N, n1) delta*sqrt(n1*(N - n1))/N

delta_from_f <- function(f, N, n1) f*N / sqrt(n1*(N - n1))


# Formula from Jung 2005 Bioinformatics and Ni et al 2024 Genes to get
# assumes m tests, p0 = proportion of tests with true null
# p-value threshold for so that we are powered at (1-beta) to declare significance for 
# (1-p0)*m tests that have a signal, while controlling for the FDR (fdr) -- from Jung (2005 Bioinformatics)

alpha_threshold <- function(m, p0, fdr = 0.05, beta = 0.2) return(fdr*(1-p0)*(1-beta) / (p0 * (1 - fdr)))

# test code not run
# alpha_threshold(m = 3000, p0 = 0.8)
