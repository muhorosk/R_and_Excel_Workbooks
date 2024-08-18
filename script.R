# Install pacman if not already installed
if (!require(pacman, quietly = TRUE)) {
  install.packages("pacman")
}






# Load pacman
library(pacman)

# List of packages to check and install
packages <- c("openxlsx", "dplyr", "lubridate")


# Use pacman to check and install packages
p_load(char = packages)



# Set seed for reproducibility
set.seed(123)

# Define parameters
species <- c("Ae. aegypti",
             "Ae. chausseri",
             "Ae. furcifer",
             "Ae. hirsutus",
             "Ae. mcintoshi",
             "Ae. mettallicus",
             "Ae. ochraecius",
             "Ae. simpsoni",
             "Ae. stegomyia spp",
             "Ae. sudanensis",
             "Ae. tarsalis",
             "Ae. tricholabis",
             "Ae. unilineatus",
             "Ae. vittatus",
             "Aedes spp",
             "An. coustani",
             "An. funestus",
             "An. gambiae",
             "An. maculpalpis",
             "An. Nili",
             "An. pharoensis",
             "An. squamosus",
             "Anopheles spp",
             "Culex spp",
             "Cx. annurlioris",
             "Cx. cinereus",
             "Cx. ethiopicus",
             "Cx. pipiens",
             "Cx. poicilipes",
             "Cx. theileri",
             "Cx. tigripes",
             "Cx. univittatus",
             "Cx. vansomereni",
             "Cx. watti",
             "Cx. zombaensis",
             "Eret. Chrysogaster",
             "Eretmophidite spp",
             "Filcabia medilioneata",
             "Mn. africana",
             "Ur. Nigromaculata")
collection_methods = c("CDC Light Trap", "Biogents Sentinel Trap","Prokopack Trap","Gravid Trap","Sweep Nets",
                       "Resting Boxes", "Larval Dippers", "Larval Traps", "Aspirators", "Sticky Traps", "Ovitraps")


dates <- seq.Date(from = as.Date("2021-01-01"), to = as.Date("2023-12-31"), by = "day")

# Generate dataset
mosquito_data <- data.frame(
  Date = sample(dates, 1000, replace = TRUE), 
  Species = sample(species, 1000, replace = TRUE),
  Method= sample(collection_methods, 1000, replace =TRUE),
  Count = sample(1:25, 1000, replace = TRUE)
)


# Preview the dataset
head(mosquito_data)


#Check variables/ Variables
colnames(mosquito_data)

# inspect data structure
str(mosquito_data)



# Define the function
add_month_year_column <- function(data, date_column) {
  data %>%
    mutate(
      month_year = format(as.Date(get(date_column)), "%b_%Y")
    )
}


# Add the 'month' column
mosquito_data <- add_month_year_column(mosquito_data, "Date")

# Print the updated data
print(mosquito_data)

# Create contingency table for Species and Date
contingency_table_1 <- table(mosquito_data$Species, mosquito_data$Date)
contingency_table_1 <- as.data.frame.matrix(contingency_table_1)

# as you can see it is worth grouping the data and representing the data 
#in month total counts than individual data


contingency_table_2 <- mosquito_data%>% group_by(Species,month_year)%>%
  summarize(total_pool_size = sum(Count, na.rm = TRUE))%>%
  arrange(desc(month_year))%>%
  ungroup()

contingency_table_2 <- xtabs(total_pool_size ~ Species + month_year, data = contingency_table_2)
contingency_table_2 <- as.data.frame.matrix(contingency_table_2)

# lets find out the count each trap collected and the species

contingency_table_3 <- mosquito_data%>% group_by(Species,Method)%>%
  summarize(total_pool_size = sum(Count, na.rm = TRUE))%>%
  ungroup()

contingency_table_3 <- xtabs(total_pool_size ~ Species + Method, data = contingency_table_3)
contingency_table_3 <- as.data.frame.matrix(contingency_table_3)


#lets find out what each trap collected with the month 

contingency_table_4 <- mosquito_data%>% group_by(Method,month_year)%>%
  summarize(total_pool_size = sum(Count, na.rm = TRUE))%>%
  arrange(desc(month_year))%>%
  ungroup()

contingency_table_4 <- xtabs(total_pool_size ~ Method + month_year, data = contingency_table_4)
contingency_table_4 <- as.data.frame.matrix(contingency_table_4)

#Lets transfer this data  into excel workbook

# Create a new Excel workbook
wb <- createWorkbook()


# Add sheets and write contingency tables
addWorksheet(wb, "contingency_table_1")
writeData(wb, "contingency_table_1", contingency_table_1)

# Add sheets and write contingency tables
addWorksheet(wb, "contingency_table_2")
writeData(wb, "contingency_table_2", contingency_table_2)

# Add sheets and write contingency tables
addWorksheet(wb, "contingency_table_3")
writeData(wb, "contingency_table_3", contingency_table_3)

# Add sheets and write contingency tables
addWorksheet(wb, "contingency_table_4")
writeData(wb, "contingency_table_4", contingency_table_4)

# Save the workbook
saveWorkbook(wb, "contingency_tables.xlsx", overwrite = TRUE)