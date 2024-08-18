# Load necessary library
library(dplyr)

# Set seed for reproducibility
set.seed(123)

# Define parameters
species <- c(
  "Aedes abserratus",
  "Aedes albopictus",
  "Aedes atlanticus",
  "Aedes altropalpus",
  "Aedes aurifer",
  "Aedes canadensis",
  "Aedes cantator",
  "Aedes cinereus",
  "Aedes communis",
  "Aedes dorsalis",
  "Aedes excrucians",
  "Aedes fitchii",
  "Aedes flavescens",
  "Aedes grossbecki",
  "Aedes hendersoni",
  "Aedes infirmatus",
  "Aedes intrudens",
  "Aedes japonicus",
  "Aedes provocans",
  "Aedes sticticus",
  "Aedes stimulans",
  "Aedes thibaulti",
  "Aedes tormentor",
  "Aedes triseriatus",
  "Aedes trivittatus",
  "Aedes vexans",
  "Anopheles atropos",
  "Anopheles barberi",
  "Anopheles bradleyi",
  "Anopheles crucians",
  "Anopheles earlei",
  "Anopheles punctipennis",
  "Anopheles quadrimaculatus",
  "Anopheles walker",
  "Culex erraticus",
  "Culex pipiens",
  "Culex restuans",
  "Culex salinarius",
  "Culex territans",
  "Culiseta inornata",
  "Culiseta melanura",
  "Culiseta minnesotae",
  "Culiseta morsitans",
  "Coquillettidia perturbans",
  "Orthopodomyia signifera",
  "Psorophora ciliata",
  "Psorophora columbiae",
  "Psorophora ferox",
  "Psorophora howardii",
  "Toxorhynchites rutilus septentrionalis",
  "Uranotaenia sapphirina",
  "Wyeomyia smithii,"
)

methods <- c("sweep net", "light trap","oviposition trap", "larval sampling")
dates <- seq.Date(from = as.Date("2021-01-01"), to = as.Date("2023-12-31"), by = "day")

# Generate dataset
mosquito_data <- data.frame(
  date = sample(dates, 4000, replace = TRUE), 
  species = sample(species, 4000, replace = TRUE),
  collection_method =sample(methods, 4000, replace = TRUE),
  pool = sample(1:25, 4000, replace = TRUE)
  
)

# Preview the dataset
head(mosquito_data)
