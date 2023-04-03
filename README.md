SM
=====

[SOLANUM](https://doi.org/10.21223/P3/E71OS6) potato growth model as an R function. This model simulates the daily assimilation of biomass as a function of the efficiency in radiation interception, conversion of intercepted radiation into biomass, and translocation of biomass to tubers. 

Usage
-----
```{r eval=F}
SM(weather, crop_parameters, dates, plant_density = 3.7, env_parameters = list(TN=4, TO=17, TX=28, Pc=12, w=0.5))
```
Arguments
-----
- **weather:** A vector of the timing (in __*dap -*__ days after planting or __*tt -*__ thermal time) when biomass or canopy cover data were collected.
- **crop_parameters:** A vector of temporal data of biomass (harvest index) or canopy cover (in %). 
- **dates:** A character indicating if data will be fitted to a Beta or Gompertz function. Use __*"Beta"*__ for canopy cover and __*"Gompertz"*__ for biomass data.
- **plant_density:** A character indicating if __*xtime*__ is days after planting (use __*"dap"*__) or thermal time (__*"tt"*__; by default).
- **env_parameters:** A vector indicating the 3 initial values of the parameters of the Beta or Gompertz function.

Values
-----
- **$parameters:** A vector of the fitted parameters of the Beta or Gompertz function.
- **$fitted.data:** A data frame of the observed and estimated data.
- **$simulated.data:**  A data frame of simulated data for biomass or canopy cover.
- **$warning.message:** A character indicating any warning message in the model fitting.
- **$out.model:** A summary.nls of the fitted model.
