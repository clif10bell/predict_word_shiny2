library(here)
library(data.table)

# Read the files back into R using readRDS()
split1_loaded <- readRDS("split1.rds")
split2_loaded <- readRDS("split2.rds")
split3_loaded <- readRDS("split3.rds")

# Combine the loaded data.tables into a single data.table
combined_dt_reduced <- rbindlist(list(split1_loaded, split2_loaded, split3_loaded))

rm(split1_loaded)
rm(split2_loaded)
rm(split3_loaded)