/*
==============================================================================================================================================
==============================================================================================================================================
										              -- Medicare Provider Fraud Analysis --
==============================================================================================================================================
==============================================================================================================================================

*/


-- Problem Statement:
/*
Medicare fraud increases healthcare costs through deceptive billing practices, such as false claims and duplicate submissions. 
This project analyzes Medicare claims data to identify inconsistencies, detect anomalies in provider behavior, and uncover suspicious
patterns in high-cost procedures. The findings will support insurers and regulators in strengthening fraud detection and 
improving healthcare transparency. 
*/


-- Database: Medicare_claims_db

create database Medicare_claims_db;

use Medicare_claims_db;


-- -------------------------------------------------- CREATE TABLES -------------------------------------------------------------------------- 

create table beneficiary (
BeneID varchar(255) not null primary key,
DOB	date,
DOD	date,
Gender tinyint check (Gender = 0 or Gender = 1),
Race tinyint check (Race between 1 and 5),
RenalDiseaseIndicator varchar(40),
State int,
NoOfMonths_PartACov	tinyint check (NoOfMonths_PartACov between 0 and 12),
NoOfMonths_PartBCov	tinyint check (NoOfMonths_PartBCov between 0 and 12),
IPAnnualReimbursementAmt int,
IPAnnualDeductibleAmt int,
OPAnnualReimbursementAmt int,	
OPAnnualDeductibleAmt int
);

create table chronic_conditions (
BeneID varchar(255) not null,
ChronicCond_Alzheimer tinyint check (ChronicCond_Alzheimer in (0,1)),
ChronicCond_Heartfailure tinyint check (ChronicCond_Heartfailure in (0,1)),	
ChronicCond_KidneyDisease tinyint check (ChronicCond_KidneyDisease in (0,1)),
ChronicCond_Cancer tinyint check (ChronicCond_Cancer in (0,1)),
ChronicCond_ObstrPulmonary tinyint check (ChronicCond_ObstrPulmonary in (0,1)),
ChronicCond_Depression tinyint check (ChronicCond_Depression in (0,1)),
ChronicCond_Diabetes tinyint check (ChronicCond_Diabetes in (0,1)),
ChronicCond_IschemicHeart tinyint check (ChronicCond_IschemicHeart in (0,1)),
ChronicCond_Osteoporasis tinyint check (ChronicCond_Osteoporasis in (0,1)),
ChronicCond_rheumatoidarthritis	tinyint check (ChronicCond_rheumatoidarthritis in (0,1)),
ChronicCond_stroke tinyint check (ChronicCond_stroke in (0,1)),
foreign key (BeneID) references beneficiary (BeneID)
);

create table provider (
Provider varchar(255) not null primary key,
PotentialFraud varchar(3) check (PotentialFraud in ('Yes', 'No'))
);

create table outpatient (
BeneID varchar(255) not null,
ClaimID	varchar(255) not null primary key,
ClaimType varchar(50) not null check (ClaimType = 'Outpatient'),
ClaimStartDt date,
ClaimEndDt date,	
Provider varchar(255),	
InscClaimAmtReimbursed int,
AttendingPhysician varchar(255),
OperatingPhysician varchar(255),
OtherPhysician varchar(255),	
DeductibleAmtPaid int,
foreign key (BeneID) references beneficiary (BeneID),
foreign key (Provider) references provider(Provider)
);

create table outpatient_diagnosis (
ClaimID	varchar(255) not null,
ClmAdmitDiagnosisCode varchar(300),
ClmDiagnosisCode_1 varchar(300),
ClmDiagnosisCode_2 varchar(300),
ClmDiagnosisCode_3 varchar(300),
ClmDiagnosisCode_4 varchar(300),	
ClmDiagnosisCode_5 varchar(300),	
ClmDiagnosisCode_6 varchar(300),
ClmDiagnosisCode_7 varchar(300),
ClmDiagnosisCode_8 varchar(300),
ClmDiagnosisCode_9 varchar(300),
ClmDiagnosisCode_10 varchar(300),
foreign key (ClaimID) references outpatient(ClaimID)
);

create table outpatient_procedure (
ClaimID	varchar(255) not null,
ClmProcedureCode_1 varchar(300),
ClmProcedureCode_2 varchar(300),	
ClmProcedureCode_3 varchar(300),	
ClmProcedureCode_4 varchar(300),
ClmProcedureCode_5 varchar(300),
ClmProcedureCode_6 varchar(300),
foreign key (ClaimID) references outpatient(ClaimID)
);

create table inpatient (
BeneID varchar(255) not null,
ClaimID	varchar(255) not null primary key,
ClaimType varchar(50) not null,
ClaimStartDt date,
ClaimEndDt date,
Provider varchar(255),
InscClaimAmtReimbursed int,
AttendingPhysician varchar(255),
OperatingPhysician varchar(255),
OtherPhysician varchar(255),
AdmissionDt date,
DeductibleAmtPaid int,
DischargeDt date,
foreign key (BeneID) references beneficiary (BeneID),
foreign key (Provider) references provider(Provider)
);

create table inpatient_diagnosis (
ClaimID	varchar(255) not null,
ClmAdmitDiagnosisCode varchar(300),
DiagnosisGroupCode varchar(200),
ClmDiagnosisCode_1 varchar(300),
ClmDiagnosisCode_2 varchar(300),
ClmDiagnosisCode_3 varchar(300),
ClmDiagnosisCode_4 varchar(300),
ClmDiagnosisCode_5 varchar(300),
ClmDiagnosisCode_6 varchar(300),
ClmDiagnosisCode_7 varchar(300),
ClmDiagnosisCode_8 varchar(300),
ClmDiagnosisCode_9 varchar(300),
ClmDiagnosisCode_10 varchar(300),
foreign key (ClaimID) references inpatient(ClaimID)
);

create table inpatient_procedure (
ClaimID	varchar(255) not null,
ClmProcedureCode_1 varchar(300),
ClmProcedureCode_2 varchar(300),
ClmProcedureCode_3 varchar(300),
ClmProcedureCode_4 varchar(300),
ClmProcedureCode_5 varchar(300),
ClmProcedureCode_6 varchar(300),
foreign key (ClaimID) references inpatient(ClaimID)
);



-- ---------------------------------------------- Load data file into tables ------------------------------------------------------------------

load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/beneficiary.csv"
into table beneficiary
fields terminated by ','
optionally enclosed by '"'
lines terminated by '\r\n'
ignore 1 rows;

select * from beneficiary;

load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/chronic_condition.csv"
into table chronic_conditions
fields terminated by ','
optionally enclosed by '"'
lines terminated by '\r\n'
ignore 1 rows;

select * from chronic_conditions;

load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/provider.csv"
into table provider
fields terminated by ','
optionally enclosed by '"'
lines terminated by '\r\n'
ignore 1 rows;

select * from provider;

load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/outpatient.csv"
into table outpatient
fields terminated by ','
optionally enclosed by '"'
lines terminated by '\r\n'
ignore 1 rows;

select * from outpatient;

load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/outpatient_diagnosis.csv"
into table outpatient_diagnosis
fields terminated by ','
optionally enclosed by '"'
lines terminated by '\r\n'
ignore 1 rows;

select * from outpatient_diagnosis;

load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/outpatient_procedure.csv"
into table outpatient_procedure
fields terminated by ','
optionally enclosed by '"'
lines terminated by '\r\n'
ignore 1 rows;

select * from outpatient_procedure;

load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/inpatient.csv"
into table inpatient
fields terminated by ','
optionally enclosed by '"'
lines terminated by '\r\n'
ignore 1 rows;

select * from inpatient;

load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/inpatient_diagnosis.csv"
into table inpatient_diagnosis
fields terminated by ','
optionally enclosed by '"'
lines terminated by '\r\n'
ignore 1 rows;

select * from inpatient_diagnosis;

load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/inpatient_procedure.csv"
into table inpatient_procedure
fields terminated by ','
optionally enclosed by '"'
lines terminated by '\r\n'
ignore 1 rows;

select * from inpatient_procedure;
