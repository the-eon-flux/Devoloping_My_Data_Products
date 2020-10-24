
mpgSp <- ifelse(mtcars$mpg - 20 > 0, mtcars$mpg - 20, 0 )
# Beakpoint at 20


fit <- lm(hp ~ mpg, mtcars)
fit1 <- lm(hp ~ mpgSp + mpg, mtcars)

anova(fit, fit1)

plot(mtcars$mpg, mtcars$hp)
abline(fit, col = "Red", lwd = 2)

fit1lines <- predict(fit1, newdata = data.frame(
      mpg = 10:35, mpgSp = ifelse(10:35 -20 > 0, 10:35 - 20, 0 )
))

lines(10:35, fit1lines, col = "dodgerblue", lwd = 2)

summary(fit1)

