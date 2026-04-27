barcode18 <- barcode18_FR_cp.fasta.txt
View(barcode18)

# Collapse into a single string
barcode18 <- paste(barcode18, collapse = "")

# Total number of characters
total_chars <- nchar(barcode18)

# Count number of "N" (case-sensitive)
num_n <- sum(strsplit(barcode18, "")[[1]] == "N")

# Percentage
percent_n <- (num_N / total_chars) * 100

percent_n