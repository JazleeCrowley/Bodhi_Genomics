#create chord diagram for barcode analysis

#load required libraries
install.packages("circlize", repos = "https://cloud.r-project.org")
install.packages("readxl", repos = "https://cloud.r-project.org")
library(circlize)
library(readxl)

#read in the data
df <- read_excel("~/Git/Bodhi_Genomics/data/raw/BarcodeMatrix.xlsx")
mat <- as.data.frame(df)
rownames(mat) <- mat[[1]]   # first column becomes row names
mat <- mat[,-1]             # remove first column
mat <- as.matrix(mat)       # convert to matrix

# create chord diagram
##save the chord diagram as a PNG file
png("chord_diagram.png", width = 1200, height = 1200, res = 150)
circos.clear()
circos.par(gap.degree = 8)

chordDiagram(
  mat,
  annotationTrack = "grid",
  preAllocateTracks = list(track.height = 0.08),
  transparency = 0.3
)



circos.trackPlotRegion(
  track.index = 1,
  panel.fun = function(x, y) {

    sector <- get.cell.meta.data("sector.index")
    xlim <- get.cell.meta.data("xlim")

    circos.text(
      x = mean(xlim),
      y = 1.15,
      labels = sector,
      facing = "bending.outside",
      niceFacing = TRUE,
      cex = 0.8
    )
  },
  bg.border = NA
)

pdf("chord_diagram.pdf", width = 8, height = 8)

dev.off()

