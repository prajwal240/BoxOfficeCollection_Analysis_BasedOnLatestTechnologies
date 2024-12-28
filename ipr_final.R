library(ggplot2)
library(readxl)

data <- read_excel(file.choose())
print(data)

str(data)
head(data)

if (any(is.na(data))) {
  cat("Warning: There are missing values in the dataset. Removing rows with NA.\n")
  data <- na.omit(data)  
} else {
  cat("No missing values found in the dataset.\n")
}

data$Release_Format <- as.factor(data$Release_Format)

z_scores <- scale(data$box_office)
threshold <- 4  
data <- data[abs(z_scores) < threshold, ]

model <- lm(box_office ~ vfx_shots * Release_Format, data = data)

summary(model)

r_squared <- summary(model)$r.squared
cat("R^2 value for the model:", round(r_squared, 4), "\n")

data$predicted_box_office <- predict(model, newdata = data)

predict_box_office <- function(vfx_shots, Release_Format) {
  new_data <- data.frame(vfx_shots = vfx_shots, Release_Format = factor(Release_Format, levels = levels(data$Release_Format)))
  predicted_value <- predict(model, newdata = new_data)
  return(predicted_value)
}

vfx_input <- 2500  
Release_Format_input <- "IMAX"  
predicted_collection <- predict_box_office(vfx_input, Release_Format_input)
cat("Predicted Box Office Collection for", vfx_input, "VFX shots in", Release_Format_input, "format:", 
    format(predicted_collection, big.mark = ",", scientific = FALSE), "\n")

plot1 <- ggplot(data, aes(x = vfx_shots, y = box_office, color = Release_Format)) +
  geom_point() +  
  geom_smooth(method = "lm", aes(group = Release_Format), se = FALSE) +  
  labs(title = "Box Office Collection vs VFX Shots by Release Format",
       x = "Number of VFX Shots",
       y = "Box Office Collection") +
  theme_minimal()

print(plot1)
ggsave("box_office_vs_vfx_shots.png", plot = plot1, width = 10, height = 6)

plot2 <- ggplot(data, aes(x = box_office, y = predicted_box_office, color = Release_Format)) +
  geom_point() +
  geom_abline(intercept = 0, slope = 1, linetype = "dashed", color = "red") +
  labs(title = "Predicted vs Actual Box Office Collection",
       x = "Actual Box Office Collection",
       y = "Predicted Box Office Collection") +
  theme_minimal()

print(plot2)
ggsave("predicted_vs_actual_box_office.png", plot = plot2, width = 10, height = 6)

plot3 <- ggplot(data, aes(x = vfx_shots, y = box_office)) +
  geom_point(color = "blue") +  
  geom_smooth(method = "lm", se = FALSE, color = "red") +  
  labs(title = "VFX Shots vs Box Office Collection",
       x = "Number of VFX Shots",
       y = "Box Office Collection") +
  theme_minimal()

print(plot3)
ggsave("vfx_shots_vs_box_office.png", plot = plot3, width = 10, height = 6)

residuals_plot <- ggplot(data, aes(x = model$fitted.values, y = model$residuals)) +
  geom_point() +
  geom_hline(yintercept = 0, linetype = "dashed", color = "red") +
  labs(title = "Residuals vs Fitted",
       x = "Fitted Values",
       y = "Residuals") +
  theme_minimal()

print(residuals_plot)
ggsave("residuals_vs_fitted.png", plot = residuals_plot, width = 10, height = 6)

qqnorm(model$residuals)
qqline(model$residuals, col = "red")
ggsave("qq_plot.png", plot = last_plot(), width = 10, height = 6)  # Save QQ plot
