test_that("Cap_ages caps age and modal age at minimum and maximum age", {
    FishID = rep(1, 6)
    age = c(1, 1, 1, 12, 12, 12)
    dummy = data.frame(FishID, age)
    dummy_ext = Compute_modes(dummy)
    dummy_ext_cap = Cap_ages(dummy_ext, min_age = 2, max_age = 10)
    expect_true(max(dummy_ext_cap$age) <= 10 & min(dummy_ext_cap$age) >= 2 &
                max(dummy_ext_cap$modal_age_low) <= 10 & min(dummy_ext_cap$modal_age_low) >= 2 &
                max(dummy_ext_cap$modal_age_closest) <= 10 & min(dummy_ext_cap$modal_age_closest) >= 2)
})
