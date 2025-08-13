test_that("Compute modes adds the relevant columns", {
    file_path = system.file("extdata",
                         "NSS_herring_scales.csv",
                          package = "ParametricAEM")
    data_nss_scales = read.csv(file_path, sep = ",")
    data_exp = data_nss_scales[data_nss_scales$expertise == 1, ] # Extract experts
    data_exp = data_exp[data_exp$age > 0, ]
    data_analysis = Compute_modes(data_exp)
    expect_true(!is.null(data_analysis$weight) & !is.null(data_analysis$modal_age_low) & !is.null(data_analysis$modal_age_closest))
})

test_that("Compute modes increases or maintains the number of rows", {
    file_path = system.file("extdata",
                            "NSS_herring_scales.csv",
                            package = "ParametricAEM")
    data_nss_scales = read.csv(file_path, sep = ",")
    data_exp = data_nss_scales[data_nss_scales$expertise == 1, ] # Extract experts
    data_exp = data_exp[data_exp$age > 0, ]
    data_analysis = Compute_modes(data_exp)
    expect_true(nrow(data_exp) <= nrow(data_analysis))
})

test_that("Compute modes returns numeric columns", {
    file_path = system.file("extdata",
                            "NSS_herring_scales.csv",
                            package = "ParametricAEM")
    data_nss_scales = read.csv(file_path, sep = ",")
    data_exp = data_nss_scales[data_nss_scales$expertise == 1, ] # Extract experts
    data_exp = data_exp[data_exp$age > 0, ]
    data_analysis = Compute_modes(data_exp)
    expect_true(is.numeric(data_analysis$weight) & is.numeric(data_analysis$modal_age_low) & is.numeric(data_analysis$modal_age_closest))
})

test_that("Compute modes' weights are correct", {
    FishID = rep(1, 6)
    age = c(1, 1, 1, 3, 3, 3)
    dummy = data.frame(FishID, age)
    dummy_ext = Compute_modes(dummy)
    expect_equal(dummy_ext$weight, rep(0.5, 12))
})

test_that("Compute modes' modal_age_low is correct", {
    FishID = rep(1, 6)
    age = c(1, 1, 1, 3, 3, 3)
    dummy = data.frame(FishID, age)
    dummy_ext = Compute_modes(dummy)
    expect_equal(dummy_ext$modal_age_low, rep(1, 12))
})

test_that("Compute modes' modal_age_closest is correct", {
    FishID = rep(1, 6)
    age = c(1, 1, 1, 3, 3, 3)
    dummy = data.frame(FishID, age)
    dummy_ext = Compute_modes(dummy)
    expect_equal(dummy_ext$modal_age_closest, c(rep(1, 6), rep(3, 6)))
})
