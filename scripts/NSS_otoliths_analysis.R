
file_path = system.file("extdata",
                        "NSS_herring_otoliths.csv",
                        package = "ParametricAEM")
data_nss_otoliths = read.csv(file_path, sep = ",")
data_exp = data_nss_otoliths[data_nss_otoliths$expertise == 1, ] # Extract experts
data_exp = data_exp[data_exp$age > 0, ]
data_analysis = Compute_modes(data_exp)
data_analysis_capped = Cap_ages(data_analysis, min_age = 3, max_age = 12)

### Fit the different models ###


# Full model
fit1 = Estimate_model(data = data_analysis_capped,
                      min_age = 3,
                      max_age = 12,
                      start = c(2, 0, 0.5, 0, 0.2),
                      estimate = c(1, 1, 1, 1, 1))

AIC1 = 2 * 5 - 2 * fit1$loglik


# alpha1 = 0
fit2 = Estimate_model(data = data_analysis_capped,
                      min_age = 3,
                      max_age = 12,
                      start = c(2, 0, 0.5, 0, 0.2),
                      estimate = c(1, 1, 1, 0, 1))
AIC2 = 2 * 4 - 2 * fit2$loglik


# alpha1 = beta1 = 0
fit3 = Estimate_model(data = data_analysis_capped,
                      min_age = 3,
                      max_age = 12,
                      start = c(2, 0, 0, 0, 0.2),
                      estimate = c(1, 0, 1, 0, 1))
AIC3 = 2 * 3 - 2 * fit3$loglik


# alpha0 = alpha1 = 0
fit4 = Estimate_model(data = data_analysis_capped,
                      min_age = 3,
                      max_age = 12,
                      start = c(2, 0, 0, 0, 0.2),
                      estimate = c(1, 1, 0, 0, 1))
AIC4 = 2 * 3 - 2 * fit4$loglik


AICs = c(AIC1, AIC2, AIC3, AIC4) # fit2 best model

fitted_pars = fit2$estimate
all_pars = c(fitted_pars[1:3, "Estimate"], 0, fitted_pars[4, "Estimate"])
best_matrix = Calculate_matrix(all_pars, min_age = 3, max_age = 12)

