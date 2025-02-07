## Goal :
 The goal of this analysis is to develop a robust regression model. This involves various steps, starting with
 exploratory data analysis to understand the dataset's characteristics, detecting multicollinearity,
 eliminating correlated predictor variables, and choosing an appropriate regression method for
 model selection. Subsequently, the process includes checking assumptions, considering variable
 transformations based on the results, addressing outliers, refining the model, and interpreting the
 least square estimators.
 <br/>
 <br/>
 The specific aim is to create a regression model that effectively explains the relationship between
 the predictor variables and the response variable in the provided dataset named "streamflow."
 This dataset contains real-time information about water flow in different areas, encompassing
 various factors such as drainage area, precipitation, temperature, humidity, runoff, and relative
 risk median. The response variable, "max90," signifies the 90th percentile of annual maximum
 streamflow, which is crucial in understanding water flow variability.
 <br/>
 <br/>
 By the conclusion of this project, the objective is to construct a reliable regression model that
 describes and predicts the relationship between the specified predictor variables and the response
 variable, providing insights into the variability of water flow in different areas based on the given
 dataset

 ##  Dataset Description:
 The given dataset is named streamflow, which is a real time dataset. This dataset contains
 information about flow or movement of water in different areas. There are nine columns in the
 dataset, among which one column, ‘STAID’ is the identity of the areas from where the
 information about the flow of water is collected. We will not include this in our analysis as it acts
 as an index of the dataset. Below is the description of our variables:
 ### Predictor Variables :
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

 
