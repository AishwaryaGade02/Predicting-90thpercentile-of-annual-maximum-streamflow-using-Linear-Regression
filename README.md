## Regression Analysis: Predicting Streamflow Variability

### Project Overview :
This project focuses on developing a robust regression model using Applied Linear Regression methodologies. The goal is to analyze streamflow variability by identifying relationships between predictor variables and the 90th percentile of annual maximum streamflow (max90).

 ###  Dataset Description:
 The given dataset is named streamflow, which is a real time dataset. This dataset contains
 information about flow or movement of water in different areas. There are nine columns in the
 dataset, among which one column, ‘STAID’ is the identity of the areas from where the
 information about the flow of water is collected. We will not include this in our analysis as it acts
 as an index of the dataset. Below is the description of our variables:
 #### Predictor Variables :
   #### i. DRAIN_SQKM(X1): <br/>
   It refers to drainage area measured in square kilometers in each
 station in the dataset. It is a total surface area to which water from precipitation, snow and
 irrigation which is not absorbed into ground, reaches.
   #### ii. PPTAVG_BASIN (X2) :<br/>
   It stands for average precipitation observed in a specific basin
 area. It is a measure of the amount of rainfall, snowfall over a certain period of time. Basin is
 referred to depression in the surface of land.
 #### iii. T_AVG_BASIN (X3) :<br/> 
 It stands for average temperature in a specific basin area.
 #### iv. T_AVG_SITE (X4) :<br/> 
 It stands for average temperature in a specific site area
 #### v. RH_BASIN (X5): <br/>
 It stands for relative humidity of a specific basin area. It refers to the
 amount of moisture present in the air compared to the maximum amount of moisture that the air
 could hold at a given temperature.
 #### vi. MAR_PPT100_CM (X6): <br/>
 It stands for Mean Annual Runoff from Precipitation in the 100-year return period. It refers to metrics essentially quantifies the average amount of water
 runoff that occurs from precipitation over the course of a years
 #### vii. RRMEDIAN (X7):<br/>
 It stands for Relative Risk Median

 ### Response Variable :
 #### max90(Y) :<br/>
 It represents the 90th percentile of annual maximum streamflow. Streamflow
 indicates the volume of water flowing through a river or stream at a particular location, and the
 90th percentile of annual maximum streamflow is a significant metric in understanding and
 quantifying water flow variability

 ### Methodology
 #### 1. Exploratory Data Analysis (EDA)
- Histograms & Boxplots: Examined variable distributions & outliers.

- Correlation Matrix & Heatmap: Identified multicollinearity.

- Scatter Plots & Added Variable Plots: Explored relationships between variables.

#### 2. Model Building and Selection
- Initial Regression Model:

  - Fitted max90 against all predictor variables.

  - Used Variance Inflation Factor (VIF) to detect multicollinearity.

  - Selected variables with VIF < 10.

- Stepwise Selection:

  - Adjusted R², Mallow’s Cp, AIC, BIC were used to refine model selection.

  - Best model: max90 ~ PPTAVG_BASIN + DRAIN_SQKM + T_AVG_BASIN

 #### 3. Assumption Checking
- **Linearity**: Residual vs. fitted plots confirm no pattern.

- **Independence**: Residual analysis shows no correlation.

- **Constant Variance (Homoscedasticity)**: Checked using Breusch-Pagan Test.

- **Normality**: Checked using Kolmogorov-Smirnov Test.

#### 4. Outlier Detection & Model Transformation
- DFFITS, Cook’s Distance, DFBETAS identified influential points.

- 179th observation was removed for improved model fit.

- Log Transformation of max90 applied to stabilize variance and meet normality assumptions

#### 5. Final Model Selection
- Best Regression Model:
   log(max90) = 8.505 + 0.549 * PPTAVG_BASIN + 0.841 * DRAIN_SQKM + 0.314 * T_AVG_BASIN

- Adjusted R²: 0.3642 (indicating 36.42% variance explanation)

- All predictor variables statistically significant (p-value < 0.05)

#### 6. Findings & Interpretations
- Precipitation (PPTAVG_BASIN) and Drainage Area (DRAIN_SQKM) are strong predictors of streamflow variability.

- Temperature (T_AVG_BASIN) has a moderate effect.

- Outlier removal & transformation significantly improved model assumptions.

- Further refinements (e.g., weighted regression) could improve accuracy

#### Conclusion

This project successfully developed a regression model that explains streamflow variability using key environmental factors. Although the model meets key assumptions, improvements in variable selection, outlier handling, and alternative regression techniques could enhance its predictive power
