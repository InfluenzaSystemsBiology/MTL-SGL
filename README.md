# Multi-Task Learning Sparse Group Lasso Model
The project developed a Multi-Task Learning Sparse Group Lasso (MTL-SGL) model that uses multisourced serologic data (e.g. HI assay) to learn antigenicity-associated mutations and glycosylation sites. This model is also able to infer antigenic variant by quantifying antigenic distance. By applying MTL-SGL to influenza H1 hemagglutinin sequences, we showed the method enables rapid characterization of antigenic profiles and identification of antigenic variants on a large scale. 

# File structure
This repository contains three folders
1. TrainingData
    - Serological assay data (HI.xlsx), HA1 sequences (ha1.fasta) and N-linked glycosylation sites (n.txt) for viruses in 5 individual datasets (Task 1- 5). Serological data was collected from literatures, HA1 seuqences were collected from public databases (see below) and N-linked glycosylation sites were predicted by NetNGlyc 1.0 Server (http://www.cbs.dtu.dk/services/NetNGlyc/)
2. TestingData
    - HA1 sequences used as testing data to build sequence-baed antigenic map. Collected from NCBI(https://www.ncbi.nlm.nih.gov/genomes/FLU/), GISAID (https://www.gisaid.org/) and Influenza Research Database (https://www.fludb.org/)
3. Learning
    - Run the MTL-SGL model using pre-processed human H1N1 IAVs data by Main_training.m
    - Pre-processed human H1N1 IAVs data is located at Data/Data.mat
    - Kernal function og MTL-SGL model is located at Fun/MTL_SGL.m
    - Run Bootstrap analysis (100 runs) for a roubust feature selection using Bootstrap/Bootstrap.m 
# Usage  
1. Matlab enviroment required. No extra toolbox requirment. 
2. Run the MTL-SGL model using pre-processed human H1N1 IAVs data by Main_training.m
3. Run Bootstrap analysis (100 runs) for a roubust feature selection using Bootstrap/Bootstrap.m 

## Feedback
Let me know if you have any questions or comments at ll1118@msstate.edu or wan@cvm.msstate.edu
