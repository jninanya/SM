SM
=====

[SOLANUM](https://doi.org/10.21223/P3/E71OS6) potato growth model as an R function. This model simulates the daily assimilation of biomass as a function of the efficiency in radiation interception, conversion of intercepted radiation into biomass, and translocation of biomass to tubers. 

Usage
-----
```{r eval=F}
SM <- function(weather, 
               crop_parameters, 
               dates, 
               plant_density = 3.7,
               env_parameters = list(TN=4, TO=17, TX=28, Pc=12, w=0.5),
               potential_growth_module = TRUE,
               lateblight_limited_module = FALSE,
               water_limited_module = FALSE,
               frost_limited_module = FALSE,
               severity_data,
               umbral=0.5)
```
Arguments
-----
- **x:** A vector of the timing (in __*dap -*__ days after planting or __*tt -*__ thermal time) when biomass or canopy cover data were collected.
- **y:** A vector of temporal data of biomass (harvest index) or canopy cover (in %). 
- **xfun:** A character indicating if data will be fitted to a Beta or Gompertz function. Use __*"Beta"*__ for canopy cover and __*"Gompertz"*__ for biomass data.
- **xtime:** A character indicating if __*xtime*__ is days after planting (use __*"dap"*__) or thermal time (__*"tt"*__; by default).
- **init.par:** A vector indicating the 3 initial values of the parameters of the Beta or Gompertz function.
- **use.par.default:** A logical value. If __use.par.default=TRUE__, default values in __*init.par*__ will be used for the Beta or Gompertz function; otherwise, another initial value can be specified in __*init.par*__. Default __use.par.default=TRUE__.
- **graph:** A logical value.

Values
-----
- **$parameters:** A vector of the fitted parameters of the Beta or Gompertz function.
- **$fitted.data:** A data frame of the observed and estimated data.
- **$simulated.data:**  A data frame of simulated data for biomass or canopy cover.
- **$warning.message:** A character indicating any warning message in the model fitting.
- **$out.model:** A summary.nls of the fitted model.
