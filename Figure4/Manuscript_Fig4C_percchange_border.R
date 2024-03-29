#Use ctrl +Shift +Enter to run whole script
# Install following packages if not installed yet
# install.packages("tidyverse")
# install.packages("RColorBrewer")
# install.packages("gridExtra")

library(tidyverse)
#library(RColorBrewer)
library(gridExtra)

#getwd()


# Import percentage change data where parameter was increased
chgpos= read.table("chgpos1.txt", header = T)
# Import percentage change data where parameter was decreased
chgneg = read.table("chgneg1.txt",  header = T)
# Import parameter names
parnames = read.csv("parnames.txt",  header = F)

# View imported data
head(chgpos)

# Add column with parameter names
chgpos$Parameters = parnames$V1[1:22]   # Make sure to use V1 since parnames is dataframe
chgneg$Parameters = parnames$V1[1:22]


##############
#Create dataframe to plot YAP/TAZ-LATS1/2 data
YLpos =c(chgpos$SN1[1:10], chgpos$SN2[1:10],chgpos$SN3[1:10], chgpos$SN4[1:10])
YLneg =c(chgneg$SN1[1:10], chgneg$SN2[1:10],chgneg$SN3[1:10], chgneg$SN4[1:10])
YLnames = rep(chgpos$Parameters[1:10], 4)
YLSNs = c(rep("SN1", 10), rep("SN2", 10), rep("SN3", 10), rep("SN4", 10))

YL = data.frame("Plus 15" = YLpos, "Minus 15" = YLneg, "Parameters" = YLnames, "SNs" = YLSNs)
YL$plussign = c(rep("+"), 40)
YL$minusssign = c(rep("-"), 40)

lev1 = c("kL1", "kL2", "JL", "kL3", "kYTup3", "JYTup3", "kYTup4", "JYTup4", "kYTup5", "kYTp1")

# Plot for YAP/TAZ-LATS1/2 negative feedback loop in Fig 4C
YLplot<- ggplot(YL)+
  #plot the percentage change when parameter is increased by 15%
  geom_col(aes(x = SNs, y = Plus.15, fill = factor(Parameters, levels = lev1)), position = "dodge", colour = "red")+
  #plot the percentage change when parameter is decreased by 15%
  geom_col(aes(x = SNs, y = Minus.15, fill = factor(Parameters, levels = lev1)), position = "dodge", colour = "blue")+
  geom_segment(aes(x = .5, y = 0, xend =4.5, yend = 0), colour = "black", size=0.01 , inherit.aes = FALSE ) +
  scale_fill_brewer(palette = "Spectral")+
  labs(fill="Parameters")+
  geom_text(aes(x = SNs, y = 1, label = SNs))+
  # Make bar plot circular
  coord_polar()+
  theme_void()+
  # Set limits to y-axis
  ylim(min(c(YL$Plus.15, YL$Minus.15))-.15, 2)+
  # Add title
  labs(title="YAP/TAZ-LATS1/2 Feedback Loop") + theme(plot.title = element_text(vjust=-30))+
  theme(plot.title = element_text(hjust = 0.5))+
  # Draw dotted lines to show increase or decrease by another 25% change
  geom_abline(slope=0, intercept=-0.25,  col = "black",lty=2)+
  geom_abline(slope=0, intercept=-0.5,  col = "black",lty=2)+
  geom_abline(slope=0, intercept=0.25,  col = "black",lty=2)+
  geom_abline(slope=0, intercept=0.5,  col = "black",lty=2)

################
#Create dataframe to plot YAP/TAZ-SIRT1 data
YSpos =c(chgpos$SN1[11:16], chgpos$SN2[11:16],chgpos$SN3[11:16], chgpos$SN4[11:16])
YSneg =c(chgneg$SN1[11:16], chgneg$SN2[11:16],chgneg$SN3[11:16], chgneg$SN4[11:16])
YSnames = rep(chgpos$Parameters[11:16], 4)
YSSNs = c(rep("SN1", 6), rep("SN2", 6), rep("SN3", 6), rep("SN4", 6))

YS = data.frame("Plus 15" = YSpos, "Minus 15" = YSneg, "Parameters" = YSnames, "SNs" = YSSNs)
YS$plussign = c(rep("+"), 24)
YS$minusssign = c(rep("-"), 24)

lev2 = c("kS1", "kS2", "JS", "kS3", "kYTup1", "JYTup1")

# Plot for YAP/TAZ-SIRT1 positive feedback loop in Fig 4C
YSplot<- ggplot(YS)+
  #plot the percentage change when parameter is increased by 15%
  geom_col(aes(x = SNs, y = Plus.15, fill = factor(Parameters, levels = lev2)), position = "dodge", colour = "red")+
  #plot the percentage change when parameter is decreased by 15%
  geom_col(aes(x = SNs, y = Minus.15, fill = factor(Parameters, levels = lev2)), position = "dodge", colour = "blue")+
  geom_segment(aes(x = .5, y = 0, xend =4.5, yend = 0), colour = "black", size=0.01 , inherit.aes = FALSE ) +
  scale_fill_brewer(palette = "Spectral")+
  labs(fill="Parameters")+
  geom_text(aes(x = SNs, y = .7, label = SNs))+
  # Make bar plot circular
  coord_polar()+
  theme_void()+
  # Set limits to y-axis
  ylim(min(c(YS$Plus.15, YS$Minus.15))-.15, 2)+
  # Add title
  labs(title="YAP/TAZ-SIRT1 Feedback Loop") + theme(plot.title = element_text(vjust=-30))+
  # Draw dotted lines to show increase or decrease by another 25% change
  theme(plot.title = element_text(hjust = 0.5))+
  geom_abline(slope=0, intercept=-0.25,  col = "black",lty=2)+
  geom_abline(slope=0, intercept=-0.5,  col = "black",lty=2)+
  geom_abline(slope=0, intercept=0.25,  col = "black",lty=2)+
  geom_abline(slope=0, intercept=0.5,  col = "black",lty=2)

#############################
#Create dataframe to plot YAP/TAZ-NOTCH data
YNpos =c(chgpos$SN1[17:22], chgpos$SN2[17:22],chgpos$SN3[17:22], chgpos$SN4[17:22])
YNneg =c(chgneg$SN1[17:22], chgneg$SN2[17:22],chgneg$SN3[17:22], chgneg$SN4[17:22])
YNnames = rep(chgpos$Parameters[17:22], 4)
YNSNs = c(rep("SN1", 6), rep("SN2", 6), rep("SN3", 6), rep("SN4", 6))

YN = data.frame("Plus 15" = YNpos, "Minus 15" = YNneg, "Parameters" = YNnames, "SNs" = YNSNs)
YN$plussign = c(rep("+"), 24)
YN$minusssign = c(rep("-"), 24)

lev3 = c("kN1", "kN2", "JN", "kN3", "kYTup2", "JYTup2")

# Plot for YAP/TAZ-NOTCH positive feedback loop in Fig 4C
YNplot<-ggplot(YN)+
  #plot the percentage change when parameter is increased by 15%
  geom_col(aes(x = SNs, y = Plus.15, fill = factor(Parameters, levels = lev3)), position = "dodge", colour = "red")+
  #plot the percentage change when parameter is decreased by 15%
  geom_col(aes(x = SNs, y = Minus.15, fill = factor(Parameters, levels = lev3)), position = "dodge", colour = "blue")+
  geom_segment(aes(x = .5, y = 0, xend =4.5, yend = 0), colour = "black", size=.01 , inherit.aes = FALSE) +
  scale_fill_brewer(palette = "Spectral")+
  labs(fill="Parameters")+
  geom_text(aes(x = SNs, y = 1.35, label = SNs))+
  # Make bar plot circular
  coord_polar()+
  theme_void()+
  # Set limits to y-axis
  ylim(min(c(YN$Plus.15, YN$Minus.15))-.15, 2.5)+
  # Add title
  labs(title="YAP/TAZ-NOTCH Feedback Loop") + theme(plot.title = element_text(vjust=-30))+
  # Draw dotted lines to show increase or decrease by another 25% change
  theme(plot.title = element_text(hjust = 0.5))+
  geom_abline(slope=0, intercept=-0.25,  col = "black",lty=2)+
  geom_abline(slope=0, intercept=-0.5,  col = "black",lty=2)+
  geom_abline(slope=0, intercept=0.25,  col = "black",lty=2)+
  geom_abline(slope=0, intercept=0.5,  col = "black",lty=2)
  

# Place plots in one figure in single row
grid.arrange(YLplot, YSplot, YNplot, ncol = 3)
