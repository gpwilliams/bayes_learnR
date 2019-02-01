set.seed(100)
library(tidyverse)

# https://github.com/tjmahr/MadR_RStanARM/blob/master/bayesian_updating.Rmd
# pesky priors: https://jimgrange.wordpress.com/2016/01/18/pesky-priors/
# also: http://rpubs.com/JimGrange/143989

# grid approximation

# set initial states of belief
dog <- tibble(
  mu = 70:130, # 2 * SD of 15
  prior = 1/length(mu), # prob
  posterior = NA # previous
)

# "gather" data, here we do it all at once but will introduce one by one
observed_data <- rnorm(n = 100, mean = 100, sd = 15)

# do Bayesian updating starting at 0 observations
# each posterior becomes a prior
dog$posterior <- dog$prior # update prior bayed on current findings

# update based on new data

# code to loop ----


likelihoods <- dnorm(observed_data[1], dog$mu, 15)
unstd_posterior <- likelihoods * dog$prior
dog$posterior <- unstd_posterior / sum(unstd_posterior)

plot(dog$posterior)

ggplot(dog, aes(x = mu)) +
  geom_line(y = posterior)


# loopy code ----

for(i in seq_along(likelihood)) {
  dog$unstd_posterior <- likelihood[i] * dog$unstd_posterior
  dog$posterior <- dog$unstd_posterior / sum(dog$unstd_posterior)
}



# MAYBE USE OTHER EXAMPLE



