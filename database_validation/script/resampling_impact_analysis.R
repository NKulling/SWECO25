library(ggplot2)

# Local variables 

datafold<-"./data"

# Files to compare
files<-list.files(datafold, full.names = T, pattern = "*.rds")

# Create an empty data frame to store the results

result_table <- data.frame()

# Loop through each file in "files"

for (file in files) {
  # Load data
  df <- readRDS(file)
  
  # Calculate delta
  df$delta <- df$original - df$sweco
  
  # Descriptive stats
  mn <- mean(df$delta, na.rm = TRUE)
  md <- median(df$delta, na.rm = TRUE)
  std <- sd(df$delta, na.rm = TRUE)
  complete_range <- max(df$original) - min(df$original)
  
  # Calculate RMSD
  
  rmsd <- sqrt(mean((df$original - df$sweco)^2, na.rm=T))

  normalized_rmsd <- rmsd / (max(df$original) - min(df$original))
  
  # Calculate the R-squared 
  dt <- na.omit(df)
  correlation <- cor(dt$original, dt$sweco)
  rsquared <- correlation^2 
  
  # Extract layer name
  nm <- basename(file)
  
  # Create a row with the calculated values
  row <- data.frame(
    layername = nm,
    mean = mn,
    median = md,
    standardDeviation = std,
    RSquared = rsquared,
    RMSD = rmsd,
    NRMSD = normalized_rmsd
  )
  
  # Append the row to the result table
  result_table <- rbind(result_table, row)
}

##Descriptive stats: 

mean(result_table$NRMSD)      #0.009903105
median(result_table$NRMSD)    #0.005793996
sd(result_table$NRMSD)        #0.0092
range(result_table$NRMSD)     #min 0.003558642  max 0.041301552
nrow(result_table)            # 28 Layers

mean(result_table$RSquared)   #0.9651068
median(result_table$RSquared) #0.9896692
sd(result_table$RSquared)     #0.04316473
range(result_table$RSquared)  # min 0.8551718 max 0.9994933

#- visualisation

#- NRMSD
ggplot(result_table, aes(x = NRMSD, y = reorder(layername, NRMSD))) +
  geom_point(shape = 16, size = 3, position = "identity") +
  labs(x = "NRMSD", y = "") +
  theme_bw() +
  scale_x_continuous(limits = c(0, 1))

setwd(figures)
ggsave("scatterplot_NRMSD.jpg", plot=last_plot(), height= 5, width= 6)

#- R-squared
ggplot(result_table, aes(x = RSquared, y = reorder(layername, RSquared))) +
  geom_point(shape = 16, size = 3, position = "identity") +
  labs(x = "R-squared", y = "") +
  theme_bw() +
  scale_x_continuous(limits = c(0, 1))

setwd(figures)
ggsave("scatterplot_RSq.jpg", plot=last_plot(), height= 5, width= 6)

