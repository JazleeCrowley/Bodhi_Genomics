#build a table of read lengths and qc for ONT data
read.csv("/Users/jazleecrowley/Git/Bodhi_Genomics/code/ONT_FirstAS_N50.csv", nrows = 3)

rm(list = ls())
# ==========================================
# ONT Adaptive Sampling - N50 and Read QC
# Colour theme: Teal / Sage
# ==========================================

library(tidyverse)
library(gt)

# 1. Import CSV
qc_data <- read.csv(
  "/Users/jazleecrowley/Git/Bodhi_Genomics/code/ONT_FirstAS_N50.csv",
  check.names = FALSE
)


# 2. Remove empty columns
qc_data <- qc_data[, names(qc_data) != "", drop = FALSE]

# 3. Rename columns
qc_data <- qc_data %>%
  rename(
    Mean_Length = `Mean_Length(bp)`,
    Median_Length = `Median_Length(bp)`,
    Max_Length = `Max_Length(bp)`
  ) %>%
  arrange(as.numeric(Barcode))

# 4. Create table
n50_table <- qc_data %>%
  gt() %>%

  tab_header(
    title = md("**ONT Adaptive Sampling – Sequencing QC**"),
    subtitle = "Read length, N50 and basecalling quality across samples"
  ) %>%

  cols_label(
    Sample = "Sample",
    Barcode = "Barcode",
    Mean_Length = "Mean (bp)",
    Median_Length = "Median (bp)",
    Max_Length = "Maximum (bp)",
    N50 = "N50 (bp)",
    N50_Num = "N50 reads",
    Q20_Percent = "Q20 (%)",
    Q30_Percent = "Q30 (%)",
    Avg_Quality = "Mean quality",
    GC_Percent = "GC (%)",
    Q1 = "Q1 (bp)",
    Q3 = "Q3 (bp)"
  ) %>%

  fmt_number(
    columns = c(Mean_Length, Median_Length,
                Max_Length, N50, N50_Num, Q1, Q3),
    decimals = 0,
    use_seps = TRUE
  ) %>%

  fmt_number(
    columns = c(Q20_Percent, Q30_Percent, GC_Percent),
    decimals = 2,
    pattern = "{x}%"
  ) %>%

  fmt_number(
    columns = Avg_Quality,
    decimals = 2
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
    table.font.size = 12,
    heading.title.font.size = 19,
    heading.subtitle.font.size = 12,
    column_labels.background.color = "#245B58",
    table.border.top.color = "#245B58",
    table.border.bottom.color = "#245B58",
    data_row.padding = px(8)
  ) %>%

  opt_row_striping()

# 5. Display table
n50_table

# 6. Export files
gtsave(n50_table, "ONT_N50_QC.html")
gtsave(n50_table, "ONT_N50_QC.png")


