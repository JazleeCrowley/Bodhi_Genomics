
# ==========================================
# ONT Adaptive Sampling
# Read Length Distribution QC Table
# ==========================================

library(tidyverse)
library(gt)

# 1. OLD MANUAL DATA ENTRY (KEPT FOR REFERENCE)
# qc_data <- tibble(
#   Sample = c("K1", "K20", "K68", "FL70", "FL88", "FL168", "BG1A", "O15"),
#   Total_Reads = c(3951, 429, 3103, 2023, 1231, 1108, 1429, 3450),
#   Reads_500bp = c(297, 26, 242, 111, 88, 55, 77, 257),
#   Percent_500bp = c(7.52, 6.06, 7.80, 5.49, 7.15, 4.96, 5.39, 7.45),
#   Reads_1kb = c(68, 9, 82, 30, 22, 10, 18, 54),
#   Percent_1kb = c(1.72, 2.10, 2.64, 1.48, 1.79, 0.90, 1.26, 1.57),
#   Reads_5kb = c(0, 1, 2, 0, 1, 0, 0, 1),
#   Percent_5kb = c(0.00, 0.23, 0.06, 0.00, 0.08, 0.00, 0.00, 0.03)
# )

# 2. IMPORT CSV
qc_data <- read.csv(
  "/Users/jazleecrowley/Git/Bodhi_Genomics/code/ONT_First_Second_readlengths.csv",
  check.names = FALSE
)

# 3. CREATE PUBLICATION-STYLE TABLE
qc_table <- qc_data %>%
  gt() %>%

  tab_header(
    title = md("**ONT Adaptive Sampling – Read Length Distribution**"),
    subtitle = "Sequencing quality control across samples"
  ) %>%

  cols_label(
    Sample = "Sample",
    Total_Reads = "Total reads",
    `Reads ≥500 bp` = "Reads",
    `Percent≥500 bp` = "Percent",
    `Reads≥1 kb` = "Reads",
    `Percent≥1 kb` = "Percent",
    `Reads≥5 kb` = "Reads",
    `Percent≥5 kb` = "Percent"
  ) %>%

  tab_spanner(
    label = "≥500 bp",
    columns = c(`Reads ≥500 bp`, `Percent≥500 bp`)
  ) %>%

  tab_spanner(
    label = "≥1 kb",
    columns = c(`Reads≥1 kb`, `Percent≥1 kb`)
  ) %>%

  tab_spanner(
    label = "≥5 kb",
    columns = c(`Reads≥5 kb`, `Percent≥5 kb`)
  ) %>%

  fmt_number(
    columns = c(Total_Reads, `Reads ≥500 bp`,
                `Reads≥1 kb`, `Reads≥5 kb`),
    decimals = 0,
    use_seps = TRUE
  ) %>%

  fmt_number(
    columns = c(`Percent≥500 bp`, `Percent≥1 kb`,
                `Percent≥5 kb`),
    decimals = 2,
    pattern = "{x}%"
  ) %>%

  cols_align(
    align = "center",
    columns = everything()
  ) %>%

  tab_options(
    table.font.names = "Arial",
    table.font.size = 13,
    heading.title.font.size = 18,
    heading.subtitle.font.size = 12,
    column_labels.background.color = "#24476B",
    column_labels.font.weight = "bold",
    table.border.top.color = "#24476B",
    table.border.bottom.color = "#24476B",
    data_row.padding = px(8)
  ) %>%

  opt_row_striping()

# 4. DISPLAY TABLE
qc_table

# 5. EXPORT TABLE
gtsave(qc_table, "ONT_read_length_distribution.html")
gtsave(qc_table, "ONT_read_length_distribution.png")
