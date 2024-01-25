
install.packages('ggplot2')
install.packages('corrplot')
install.packages('car')
install.packages('lmtest')
install.packages('EnvStats')
install.packages('sandwich')
# Load necessary libraries
library(ggplot2)
library(corrplot)
library(car)
library(lmtest)
library(EnvStats)
library(sandwich)
# Read the data
streamflow_data <- read.csv("C:/Users/aishw/Downloads/streamflow.csv")
# 1. Histograms
par(mfrow=c(3, 3)) # Set up a 3x3 grid for plots
for (i in 2:ncol(streamflow_data)) {
hist(streamflow_data[, i], main=colnames(streamflow_data)[i], xlab="",
col="lightblue", border="black")
}
# 2. Boxplots
par(mfrow=c(3, 3))
for (i in 2:ncol(streamflow_data)) {
boxplot(streamflow_data[, i], main=colnames(streamflow_data)[i],
col="lightgreen", border="black")
}
# 3. Scatterplot Matrix
pairs(streamflow_data[, c("max90", "DRAIN_SQKM", "PPTAVG_BASIN",
"T_AVG_BASIN", "T_AVG_SITE", "RH_BASIN", "MAR_PPT7100_CM", "RRMEDIAN")])
# 4. Added-Variable Plots
# Convert data to a data frame if it's not already

model <- lm(max90 ~ DRAIN_SQKM + PPTAVG_BASIN + T_AVG_BASIN + T_AVG_SITE
+ RH_BASIN + MAR_PPT7100_CM + RRMEDIAN, data=streamflow_data)
avPlots(model, col="violet", col.lines="black", pch=14, lwd=2)
# 5. Correlation Matrix Heatmap
cor_matrix <- cor(streamflow_data[, c("max90", "DRAIN_SQKM",
"PPTAVG_BASIN", "T_AVG_BASIN", "T_AVG_SITE", "RH_BASIN", "MAR_PPT7100_CM",
"RRMEDIAN")])
corrplot(cor_matrix, method="number")
# check the summary of the model
summary(model)
# Standardize the predictor variables
streamflow_data_scaled <- scale(streamflow_data[, c("DRAIN_SQKM",
"PPTAVG_BASIN", "T_AVG_BASIN", "T_AVG_SITE", "RH_BASIN", "MAR_PPT7100_CM",
"RRMEDIAN")])
# Convert the scaled data to a data frame
streamflow_data_scaled_df <- as.data.frame(streamflow_data_scaled)
# Add non-scaled columns to the new data frame
streamflow_data_scaled_df$max90 <- streamflow_data$max90
model <- lm(max90 ~ DRAIN_SQKM + PPTAVG_BASIN + T_AVG_BASIN + T_AVG_SITE
+ RH_BASIN + MAR_PPT7100_CM + RRMEDIAN, data=streamflow_data_scaled_df)
# check the summary of the model
summary(model)
reduced_model1 <- lm(max90 ~ RRMEDIAN + PPTAVG_BASIN + DRAIN_SQKM +
T_AVG_BASIN + T_AVG_SITE + RH_BASIN, data=streamflow_data_scaled_df)
summary(reduced_model1)
reduced_model2 <- lm(max90 ~ RRMEDIAN + PPTAVG_BASIN + DRAIN_SQKM +
T_AVG_BASIN + RH_BASIN, data=streamflow_data_scaled_df)
summary(reduced_model2)
reduced_predictor_vars <- c('DRAIN_SQKM', 'PPTAVG_BASIN', 'T_AVG_BASIN',
'RH_BASIN', 'RRMEDIAN')
red_X <- as.matrix(streamflow_data_scaled[, reduced_predictor_vars])
red_X <- cbind(Intercept = 1, red_X)

cor(red_X)
lmfit <- lm(max90 ~ RRMEDIAN + PPTAVG_BASIN + DRAIN_SQKM + T_AVG_BASIN +
RH_BASIN, data=streamflow_data_scaled_df)
lmfit
library(olsrr)
par(mfrow=c(1,1))
b<-ols_step_all_possible(lmfit)
plot(b)
#R2 Adjusted
b.adjr=data.frame(n=b$n, predictors=b$predictors, adjr=b$adjr)
print(b.adjr)
#Cp
b.cp=data.frame(n=b$n, predictors=b$predictors,adjr=b$cp)
print(b.cp)
#AIC
b.aic= data.frame(n=b$n,predictors=b$predictors, aic=b$aic)
print(b.aic)
#BIC
b.bic=data.frame(n=b$n,predictors=b$predictors,bic=b$sbic)
print(b.bic)
model_select<-lm(max90~PPTAVG_BASIN+DRAIN_SQKM +T_AVG_BASIN,
data=streamflow_data_scaled_df)
#Assumption Checking
jresid <- rstudent(model_select)
# Linearity Check
# Scatter plot: jresid vs fitted_values
plot(jresid ~ streamflow_data_scaled_df$max90, col = "black", xlab =
"Fitted_Values", ylab = "JK_Residual", main = "JK_Residual vs
Fitted_Values")
# Scatter plot: jresid vs PPTAVG_BASIN
plot(jresid~streamflow_data_scaled_df$PPTAVG_BASIN, col = "black", xlab =
"PPTAVG_BASIN", ylab = "JK_Residual", main = "JK_Residual vs

PPTAVG_BASIN")
# Scatter plot: jresid vs DRAIN_SQKM
plot(jresid~streamflow_data_scaled_df$DRAIN_SQKM, col = "black", xlab =
"DRAIN_SQKM", ylab = "JK_Residual", main = "JK_Residual vs DRAIN_SQKM")
# Scatter plot: jresid vs T_AVG_BASIN
plot(jresid~streamflow_data_scaled_df$T_AVG_BASIN, col = "black", xlab =
"T_AVG_BASIN", ylab = "JK_Residual", main = "JK_Residual vs T_AVG_BASIN")
# Set up a layout for two plots side by side
par(mfrow = c(1, 2))
# Calculate studentized residuals
rstudent_values <- rstudent(model)
# Plot 1: Studentized Residuals vs. Index
plot(seq_along(rstudent_values), rstudent_values, main = "Residuals vs.
Index", xlab = "Index", ylab = "Residuals")
# Plot 2: Studentized Residuals vs. Fitted Values
plot(model$fitted.values, rstudent_values, main = "Residuals vs. Fitted
Values", xlab = "Fitted Values", ylab = "Residuals")
# Constant Variance Checking
bptest(model_select)
jresid<-rstudent(model_select)
# Normality Checking
ks.test(jresid,'pnorm')
# Outlier Detection
ols_plot_dffits(model)
ols_plot_cooksd_chart(model)
ols_plot_dfbetas(model)
# Transformation of Model
# Removing Outlier
rows_to_remove <- c(179)
modified_data <- streamflow_data_scaled_df[-rows_to_remove, ]
model_select2 = lm(max90 ~ PPTAVG_BASIN + DRAIN_SQKM + T_AVG_BASIN,
data=modified_data)
summary(model_select2)
jresid<-rstudent(model_select2)

# Applying log transformation on model
log.Y<-log(modified_data$max90)
log_model <- lm(log.Y~modified_data$PPTAVG_BASIN+
modified_data$DRAIN_SQKM+ modified_data$T_AVG_BASIN)
summary(log_model)
log_jresid<-rstudent(log_model)
anova(log_model)
##Assumption Checking##
#Linearity Check
# Scatter plot: jresid vs fitted_values
plot(jresid ~ streamflow_data_scaled_df$max90, col = "black", xlab =
"Fitted_Values", ylab = "JK_Residual", main = "JK_Residual vs
Fitted_Values")
# Scatter plot: jresid vs PPTAVG_BASIN
plot(jresid~modified_data$PPTAVG_BASIN, col = "black", xlab =
"PPTAVG_BASIN", ylab = "JK_Residual", main = "JK_Residual vs
PPTAVG_BASIN")
# Scatter plot: jresid vs DRAIN_SQKM
plot(jresid~modified_data$DRAIN_SQKM, col = "black", xlab = "DRAIN_SQKM",
ylab = "JK_Residual", main = "JK_Residual vs DRAIN_SQKM")
# Scatter plot: jresid vs T_AVG_BASIN
plot(jresid~modified_data$T_AVG_BASIN, col = "black", xlab =
"T_AVG_BASIN", ylab = "JK_Residual", main = "JK_Residual vs T_AVG_BASIN")
#Independence Check
# Set up a layout for two plots side by side
par(mfrow = c(1, 2))
# Plot 1: Studentized Residuals vs. Index
plot(seq_along(rstudent_values), rstudent_values, main = "Studentized
Residuals vs. Index", xlab = "Index", ylab = "JK_Residuals")
# Plot 2: Studentized Residuals vs. Fitted Values
plot(model$fitted.values, rstudent_values, main = "Studentized Residuals
vs. Fitted Values", xlab = "Fitted Values", ylab = "JK_Residuals")
# Constant Variance Check
bptest(log_model)
#Normality Check
ks.test(log_jresid,'pnorm',0,1)
