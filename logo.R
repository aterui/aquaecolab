
x <- rnorm(500)
y <- rnorm(500)

png(filename = "image/logo.png", width = 100, height = 100)
par(mar = c(0,0,0,0))
plot(y ~ x, ann = F, axes = F,
     ylim = c(-1, 1), xlim = c(-1, 1),
     pch = 21, bg = heat.colors(500, alpha = 0.5),
     cex = rnorm(500, sd = 5), col = NA)
dev.off()