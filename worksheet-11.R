# Documenting and Publishing your Data Worksheet

# Preparing Data for Publication
library(...)

stm_dat <- ...("data/StormEvents.csv")

...(stm_dat)
...(stm_dat)

...(stm_dat$EVENT_NARRATIVE) 

...('data_package', showWarnings = FALSE)
...(stm_dat, "data_package/StormEvents_d2006.csv")

# Creating metadata
library(...) ; library(...)

...(dir = "data_package")

...(stm_dat$YEAR)
...(stm_dat$BEGIN_LAT, na.rm=TRUE)
...(stm_dat$BEGIN_LON, na.rm=TRUE)

...(metadata_dir = here("data_package", "metadata"))

...(metadata_dir = here("data_package", "metadata"))

...(data_path = here("data_package"),
            access_path = here("data_package", "metadata", "..."))
...(metadata_dir = here("data_package", "metadata"))

...(data_path = here("data_package"),
                attributes_path = here("data_package", "metadata", "..."))
...(metadata_dir = here("data_package", "metadata"))

...(path = here("data_package", "metadata"))

library(...) ; library(...) ; library(...)

json <- ...("data_package/metadata/dataspice.json")
eml <- ...(json)
...(eml, "data_package/metadata/dataspice.xml")

# Creating a data package
library(...) ; library(...)

dp <- ...("DataPackage") # create empty data package

... <- "data_package/metadata/dataspice.xml"
... <- paste("urn:uuid:", UUIDgenerate(), sep = "")

... <- new("DataObject", id = ..., format = "eml://ecoinformatics.org/eml-2.1.1", file = ...)

dp <- ...(dp, ...)  # add metadata file to data package

... <- "data_package/StormEvents_d2006.csv"
... <- paste("urn:uuid:", UUIDgenerate(), sep = "")

... <- new("DataObject", id = ..., format = "text/csv", filename = ...) 

dp <- ...(dp, ...) # add data file to data package

dp <- ...(dp, subjectID = ..., objectIDs = ...)

serializationId <- paste("resourceMap", UUIDgenerate(), sep = "")
filePath <- file.path(sprintf("%s/%s.rdf", tempdir(), serializationId))
status <- serializePackage(..., filePath, id=serializationId, resolveURI = "")

... <- serializeToBagIt(...) # right now this creates a zipped file in the tmp directory
file.copy(..., "data_package/Storm_dp.zip") # now we have to move the file out of the tmp directory

# this is a static copy of the DataONE member nodes as of July, 2019
read.csv("data/Nodes.csv")






