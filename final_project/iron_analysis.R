library(tidyverse)

#Function to read the spectral data from the appropriate text file
read_spec <- function(txt_file) {
  #Read text into a vector by line
  my_spec <- readLines(txt_file)
  #Find the index range of the data and metadata
  index <- match(">>>>>Begin Spectral Data<<<<<", my_spec)+1
  end <- length(my_spec)
  spec_vals <- my_spec[c(index:end)]
  
  #Separate out wavelength and absorbance values and store them into a dataframe
  f <- data.frame(do.call(rbind, strsplit(spec_vals, "\t", fixed = TRUE)))
  colnames(f) <- c("wavelength","absorbance")
  
  #Convert character values into numeric values
  f$wavelength <- as.numeric(f$wavelength)
  f$absorbance <- as.numeric(f$absorbance)
  
  #Return the data frame
  f
}

find_abs <- function(txt_file){
  spectrum <- read_spec(txt_file)
  df <- spectrum[which.min(abs(562-spectrum$wavelength)),]
}

analyze_set <- function(df, col.num){
  B <- lapply(X = df[ , col.num], FUN = find_abs)
  B <- do.call("rbind", B)
  rownames(B) <- 1:nrow(B)
  df <- cbind(df, B)
  df
}

#Read in raw data from spreadsheet
setwd("C:/Users/jacob/Desktop/Geobiology/iron_analysis")
my_data <- read_csv("iron_raw_data.csv")

#Add .txt to spectral file names
my_data <- my_data %>%
  mutate(spectral_file = paste(spectral_file, ".txt", sep = ""))
my_data <- as.data.frame(my_data)

#Begin to parse out spectral information from text files
setwd("C:/Users/jacob/Desktop/Geobiology/iron_analysis/raw_fz_files/")


#Extract wavelength and absorbance values
df_standards <- analyze_set(df_standards, 2)
my_data <- analyze_set(my_data, 6)

#Get a linear model for the data
stand.lm = lm(absorbance~concentrations, data = df_standards)
summary(stand.lm)

#Plot to look at how well the calibration curve looks with linear fit
ggplot(df_standards, aes(x = concentrations, y = absorbance)) +
  geom_point() +
  geom_abline(slope = coef(stand.lm)[["concentrations"]],
              intercept = coef(stand.lm)[["(Intercept)"]])

#Remove suspected saturated point from calibration curve
stand2 <- subset(df_standards, df_standards$concentrations < 110)
stand2.lm = lm(absorbance~concentrations, data = stand2)
summary(stand2.lm)

ggplot(df_standards, aes(x = concentrations, y = absorbance)) +
  geom_point() +
  geom_abline(slope = coef(stand2.lm)[["concentrations"]],
              intercept = coef(stand2.lm)[["(Intercept)"]])

#Store calibration curve values into objects to call later
m <- coef(stand2.lm)[["concentrations"]]
b <- coef(stand2.lm)[["(Intercept)"]]

#Create a calculated column with concentration values
data_processed <- mutate(my_data,
       conc = (absorbance -b)/m)

ggplot(data_processed) +
  geom_point(aes(x = conc, y = absorbance)) + 
  geom_abline(slope = m,
              intercept = b) +
  geom_hline(yintercept = df_standards[5,4]) +
  geom_vline(xintercept = df_standards[5,1])

#Accept values at or below the absorbance of our highest standard
data_final <- subset(data_processed, data_processed$absorbance <= df_standards[5,4])

data_final <- mutate(data_final,
                     wt_percent = (conc*100)/(1000*1000*sample_mass))

#Reanalyze values above the absorbance of our highest standard
data_redo <- subset(data_processed, data_processed$absorbance > df_standards[5,4]) %>%
  subset(select = -c(wavelength, absorbance, conc))
rownames(data_redo) <- 1:nrow(data_redo)

concentrations2 <- c(23.39, 46.78, 93.56, 105.3, 117.0)
filename2 <- c("GB22-0601-Fz-CIT_Absorbance__1__13-44-24-549.txt",
               "GB22-0601-Fz-CIT_Absorbance__2__15-21-16-959.txt",
               "GB22-0601-Fz-CIT_Absorbance__3__15-25-27-035.txt",
               "GB22-0601-Fz-CIT_Absorbance__4__15-26-58-494.txt",
               "GB22-0601-Fz-CIT_Absorbance__5__15-27-38-835.txt")

df_standards2 <- data.frame(concentrations2, filename2)
setwd("C:/Users/jacob/Desktop/Geobiology/iron_analysis/raw_fz_CIT/")

spec_replace <- c("GB22-0601-Fz-CIT_Absorbance__6__15-28-45-472.txt",
                  "GB22-0601-Fz-CIT_Absorbance__7__15-29-23-439.txt",
                  "GB22-0601-Fz-CIT_Absorbance__8__15-29-55-770.txt",
                  "GB22-0601-Fz-CIT_Absorbance__9__15-30-39-537.txt",
                  "GB22-0601-Fz-CIT_Absorbance__10__15-31-20-904.txt",
                  "GB22-0601-Fz-CIT_Absorbance__11__15-32-46-345.txt",
                  "GB22-0601-Fz-CIT_Absorbance__13__15-35-01-043.txt",
                  "GB22-0601-Fz-CIT_Absorbance__14__15-35-31-324.txt",
                  "GB22-0601-Fz-CIT_Absorbance__12__15-34-06-905.txt")
data_redo$spectral_file <- spec_replace
data_redo <- as.data.frame(data_redo)

df_standards2 <- analyze_set(df_standards2, 2)
data_redo <- analyze_set(data_redo, 6)

#Get a linear model for the data
stand_new.lm = lm(absorbance~concentrations2, data = df_standards2)
summary(stand_new.lm)

#Plot to look at how well the calibration curve looks with linear fit
ggplot(df_standards2, aes(x = concentrations2, y = absorbance)) +
  geom_point() +
  geom_abline(slope = coef(stand_new.lm)[["concentrations2"]],
              intercept = coef(stand_new.lm)[["(Intercept)"]])

m2 <- coef(stand_new.lm)[["concentrations2"]]
b2 <- coef(stand_new.lm)[["(Intercept)"]]

data_redo_processed <- mutate(data_redo,
                         conc = (absorbance - b2)/m2)

ggplot(data_redo_processed, aes(x = conc, y = absorbance)) +
  geom_point() +
  geom_abline(slope = coef(stand_new.lm)[["concentrations2"]],
              intercept = coef(stand_new.lm)[["(Intercept)"]])

data_redo_processed <- mutate(data_redo_processed,
                     wt_percent = (conc*100*5)/(3*1000*1000*sample_mass))

data_final <- rbind(data_final, data_redo_processed)
rownames(data_final) <- 1:nrow(data_final)

write.csv(data_final, "C:/Users/jacob/Desktop/Geobiology/iron_analysis/iron_analysis_processed.csv")

