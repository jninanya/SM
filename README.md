EcSM
=====

[SOLANUM](https://doi.org/10.21223/P3/E71OS6) potato growth model as an R function. This model simulates the daily assimilation of biomass as a function of the efficiency in radiation interception, conversion of intercepted radiation into biomass, and translocation of biomass to tubers. 

Usage
-----
```{r eval=F}
SM(weather, crop_parameters, dates, plant_density = 3.7, env_parameters = list(TN=4, TO=17, TX=28, Pc=12, w=0.5))
```
Arguments
-----
- **weather:** A data frame containing daily weather data from sowing to harvest. Required variables for runnig the model are minimum temperature (__*tmin*__, in C), maximum temperature (__*tmax*__, in C), and solar radiation (__*srad*__, in MJ m-2 day-1).
- **crop_parameters:** A list containing Beta and Gompertz parameters as well as dry matter concentration and radiation use efficiency. Example: __*crop_parameters*__ = list(__*"A"*__ = 0.77, __*"tu"*__ = 505, __*"b"*__ = 144, __*"wmax"*__ = 0.99, __*"te"*__ = 774, __*"tm"*__ = 298, __*"RUE"*__ = 2.4, __*"DMc"*__ = 0.21).
- **dates:** A list indicating __*sowing*__, __*harvest*__, and __*emergence*__ dates.
- **plant_density:** A numeric value.
- **env_parameters:** A list indicating the environmental parameters. Example: env_parameters = list(TN=4, TO=17, TX=28, Pc=12, w=0.5).
