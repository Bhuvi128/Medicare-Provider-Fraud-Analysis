/*
===============================================================================================================================================================================
===============================================================================================================================================================================
								-- Medicare Provider Fraud Analysis --
===============================================================================================================================================================================
===============================================================================================================================================================================

*/


-- Problem Statement:
/*
Medicare fraud increases healthcare costs through deceptive billing practices, such as false claims and duplicate submissions. 
This project analyzes Medicare claims data to identify inconsistencies, detect anomalies in provider behavior, and uncover suspicious
patterns in high-cost procedures. The findings will support insurers and regulators in strengthening fraud detection and 
improving healthcare transparency. 
*/


use Medicare_claims_db;


-- --------------------------------------------------------------------- Exploratory Data Analysis ---------------------------------------------------------------------------------------------

-- Check what are the tables are there

show tables;

-- Verify the tables

desc beneficiary;
desc chronic_conditions;
desc inpatient;
desc inpatient_diagnosis;
desc inpatient_procedure;
desc outpatient;
desc outpatient_diagnosis;
desc outpatient_procedure;
desc provider;



