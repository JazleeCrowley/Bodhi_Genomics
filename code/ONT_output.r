#make a table with basic ONT output for each sample
install.packages(c("tidyverse", "gt"))
# ONT Adaptive Sampling
# Read Length Distribution QC Table
# ==========================================

library(tidyverse)
library(gt)

# 1. Enter sequencing data
qc_data <- tibble(
  Sample = c("K1", "K20", "K68", "FL70", "FL88", "FL168", "BG1A", "O15"),

  Total_Reads = c(3951, 429, 3103, 2023, 1231, 1108, 1429, 3450),

  Reads_500bp = c(297, 26, 242, 111, 88, 55, 77, 257),
  Percent_500bp = c(7.52, 6.06, 7.80, 5.49, 7.15, 4.96, 5.39, 7.45),

  Reads_1kb = c(68, 9, 82, 30, 22, 10, 18, 54),
  Percent_1kb = c(1.72, 2.10, 2.64, 1.48, 1.79, 0.90, 1.26, 1.57),

  Reads_5kb = c(0, 1, 2, 0, 1, 0, 0, 1),
  Percent_5kb = c(0.00, 0.23, 0.06, 0.00, 0.08, 0.00, 0.00, 0.03),

  Reads_10kb = c(0, 0, 0, 0, 0, 0, 0, 0),
  Percent_10kb = c(0, 0, 0, 0, 0, 0, 0, 0)
)

# 2. Create publication-style table
qc_table <- qc_data %>%
  gt() %>%

  tab_header(
    title = md("**ONT Adaptive Sampling – Read Length Distribution**"),
    subtitle = "Sequencing quality control across eight barcodes"
  ) %>%

  cols_label(
    Sample = "Sample",
    Total_Reads = "Total reads",
    Reads_500bp = "Reads",
    Percent_500bp = "Percent",
    Reads_1kb = "Reads",
    Percent_1kb = "Percent",
    Reads_5kb = "Reads",
    Percent_5kb = "Percent",
    Reads_10kb = "Reads",
    Percent_10kb = "Percent"
  ) %>%

  tab_spanner(
    label = "≥500 bp",
    columns = c(Reads_500bp, Percent_500bp)
  ) %>%

  tab_spanner(
    label = "≥1 kb",
    columns = c(Reads_1kb, Percent_1kb)
  ) %>%

  tab_spanner(
    label = "≥5 kb",
    columns = c(Reads_5kb, Percent_5kb)
  ) %>%

  tab_spanner(
    label = "≥10 kb",
    columns = c(Reads_10kb, Percent_10kb)
  ) %>%

  fmt_number(
    columns = c(Total_Reads, Reads_500bp, Reads_1kb,
                Reads_5kb, Reads_10kb),
    decimals = 0,
    use_seps = TRUE
  ) %>%

  fmt_number(
    columns = c(Percent_500bp, Percent_1kb,
                Percent_5kb, Percent_10kb),
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

# 3. Display table
qc_table

# 4. Export table
gtsave(qc_table, "ONT_read_length_distribution.html")
gtsave(qc_table, "ONT_read_length_distribution.png")
