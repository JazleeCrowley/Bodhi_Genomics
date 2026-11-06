#make mapped table for first AS ONT run
read.csv("/Users/jazleecrowley/Git/Bodhi_Genomics/code/ONT_FirstAS_mappedreads.csv", nrows = 3)

# ==========================================
# ONT Adaptive Sampling - Mapping QC
# Colour theme: Purple / Lavender
# ==========================================

library(tidyverse)
library(gt)

# 1. Import CSV
mapping_data <- read.csv(
  "/Users/jazleecrowley/Git/Bodhi_Genomics/code/ONT_FirstAS_mappedreads.csv",
  check.names = TRUE
)

# 2. Remove empty columns
mapping_data <- mapping_data[
  , names(mapping_data) != "",
  drop = FALSE
]

# 3. Rename columns
mapping_data <- mapping_data %>%
  rename(
    Mapped_Reads = Number.of.reads.that.mapped.chloroplast,
    Min_Length = Ungapped.lengths.min,
    Max_Length = Ungapped.lengths.max,
    Mean_Length = Ungapped.lengths.mean,
    SD_Length = Ungapped.lengths.Std.Dev
  )

# 4. Create mapping table
mapping_table <- mapping_data %>%
  gt() %>%

  tab_header(
    title = md("**ONT Adaptive Sampling – Mapping QC**"),
    subtitle = "Chloroplast mapping statistics across samples"
  ) %>%

  cols_label(
    Sample = "Sample",
    Mapped_Reads = "Mapped reads",
    Min_Length = "Minimum (bp)",
    Max_Length = "Maximum (bp)",
    Mean_Length = "Mean (bp)",
    SD_Length = "Std. deviation (bp)"
  ) %>%

  fmt_number(
    columns = Mapped_Reads,
    decimals = 0,
    use_seps = TRUE
  ) %>%

  fmt_number(
    columns = c(Min_Length, Max_Length,
                Mean_Length, SD_Length),
    decimals = 1,
    use_seps = TRUE
  ) %>%

  cols_align(
    align = "center",
    columns = everything()
  ) %>%

  tab_style(
    style = cell_text(color = "white", weight = "bold"),
    locations = cells_column_labels(columns = everything())
  ) %>%

  tab_options(
    table.font.names = "Arial",
    table.font.size = 13,
    heading.title.font.size = 19,
    heading.subtitle.font.size = 12,
    column_labels.background.color = "#594477",
    table.border.top.color = "#594477",
    table.border.bottom.color = "#594477",
    data_row.padding = px(9)
  ) %>%

  opt_row_striping()

# 5. Display table
mapping_table

# 6. Export files
gtsave(mapping_table, "ONT_Mapping_QC.html")
gtsave(mapping_table, "ONT_Mapping_QC.png")
