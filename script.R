# Install pacman if not already installed
if (!require(pacman, quietly = TRUE)) {
  install.packages("pacman")
}

# Load pacman
library(pacman)

# List of packages to check and install
packages <- c("openxlsx", "MASS")

# Use pacman to check and install packages
p_load(char = packages)


# Create a new Excel workbook
wb <- createWorkbook()

#load data
data(birthwt)

#Get data information
help("birthwt")

#Check variables/ Variables
colnames(birthwt)

# inspect data structure
str(birthwt)

#convert variables into their respective data types
#the variables ({low, Race, smoke and ht} check description "help("birthwt")") are labled in 
# in numbers but they are categorical variables and can be chacked below

is.factor(birthwt$low)
is.factor(birthwt$smoke)
is.factor(birthwt$race)
is.factor(birthwt$ht)

birthwt$low <- as.factor(birthwt$low)
birthwt$smoke <- as.factor(birthwt$smoke)
birthwt$race <- as.factor(birthwt$race)
birthwt$ht <- as.factor(birthwt$ht)

# assuming the data had multiple categories such species name if it was an entomological data set 
# then we could make contigency tables with the table commands

low<- table(birthwt$low)
smoke<- table(birthwt$smoke)
race<- table(birthwt$race)
ht<- table(birthwt$ht)


# Add sheets and write contingency tables
addWorksheet(wb, "birthwt")
writeData(wb, "birthwt", birthwt)

# Add sheets and write contingency tables
addWorksheet(wb, "low")
writeData(wb, "low", low)

# Add sheets and write contingency tables
addWorksheet(wb, "smoke")
writeData(wb, "smoke", smoke)

# Add sheets and write contingency tables
addWorksheet(wb, "race")
writeData(wb, "race", race)

# Add sheets and write contingency tables
addWorksheet(wb, "ht")
writeData(wb, "ht", ht)

# Save the workbook
saveWorkbook(wb, "contingency_tables.xlsx", overwrite = TRUE)