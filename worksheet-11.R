# Documenting and Publishing your Data Worksheet

# Preparing Data for Publication
library(tidyverse)

stm_dat <- read_csv("data/StormEvents.csv")

head(stm_dat)
tail(stm_dat)

unique(stm_dat$EVENT_NARRATIVE)
str(stm_dat)  

...(stm_dat$EVENT_NARRATIVE) 

#outputting

dir.create('storm_project', showWarnings = FALSE)
write_csv(stm_dat, "storm_project/StormEvents_d2006.csv")

# Creating metadata
library(dataspice) #you can download at Github outside of sandbox
library(here)

create_spice(dir = "storm_project") #creat empty template

range(stm_dat$YEAR)
range(stm_dat$BEGIN_LAT, na.rm=TRUE)
range(stm_dat$BEGIN_LON, na.rm=TRUE)

edit_biblio(metadata_dir = here("storm_project", "metadata"))

edit_creators(metadata_dir = here("storm_project", "metadata"))

prep_access(data_path = here("storm_project"),
            access_path = here("storm_project", "metadata", "access.csv")) #discover metadata for you

edit_access(metadata_dir = here("storm_project", "metadata")) #access/edit file

prep_attributes(data_path = here("storm_project"),
                attributes_path = here("storm_project", "metadata", "attributes.csv"))   #get information for us

edit_attributes(metadata_dir = here("storm_project", "metadata"))

write_spice(path = here("storm_project", "metadata"))

library(emld) 
library(EML) 
library(jsonlite)

json <- read_json("storm_project/metadata/dataspice.json")
eml <- as_emld(json)
write_eml(eml, "storm_project/metadata/dataspice.xml")

# Creating a data package
library(datapack) 
library(uuid)

dp <- ...("DataPackage") # create empty data package

emlFile <- "storm_project/metadata/dataspice.xml"
emlId <- paste("urn:uuid:", UUIDgenerate(), sep = "")

mdObj <- new("DataObject", id = emlId, format = "eml://ecoinformatics.org/eml-2.1.1", file = emlFile)

dp <- addMember(dp, mdObj)  # add metadata file to data package


datafile <- "storm_project/StormEvents_d2006.csv"
dataId <- paste("urn:uuid:", UUIDgenerate(), sep = "")

dataObj <- new("DataObject", id = dataId, format = "text/csv", filename = datafile) 

dp <- addMember(dp, dataObj) # add data file to data package

dp <- insertRelationship(dp, subjectID = emlId, objectIDs = dataId)

serializationId <- paste("resourceMap", UUIDgenerate(), sep = "")
filePath <- file.path(sprintf("%s/%s.rdf", tempdir(), serializationId))
status <- serializePackage(dp, filePath, id=serializationId, resolveURI = "")

#Save the data package to a file, using the BagIt packaging format.
dp_bagit <- serializeToBagIt(dp) # right now this creates a zipped file in the tmp directory
file.copy(dp_bagit, "storm_project/Storm_dp.zip") # now we have to move the file out of the tmp directory


# this is a static copy of the DataONE member nodes as of July, 2019
read.csv("data/Nodes.csv")






