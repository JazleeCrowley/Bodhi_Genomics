#create a nice table for my genetic diversity statistics

#read packages
install.packages("readxl")
install.packages("gt")
library(gt)
library(readxl)

#read in data
df <- read_excel("/Users/jazleecrowley/Git/Bodhi_Genomics/data/processed/Demultiplexed_data_readable/Barcode_GeneticDiversityStats.xlsx", sheet = 1)

#create table
table <- df |>
  gt() |>
  tab_header(
    title = "Genetic Diversity of Ficus religiosa Populations",
    subtitle = "Generated from Excel in R"
  ) |>
  fmt_number(columns = where(is.numeric), decimals = 2) |>
  tab_options(
    table.font.size = "small"
  )

print(table)

gtsave(table, "HaplotypeDiversity.png")
