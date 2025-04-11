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

-- Database: Medicare_claims_db
use Medicare_claims_db;


/*
==============================================================================================================================================================================
---------------------------------------------------------------------  Data Validation ---------------------------------------------------------------------------------------
==============================================================================================================================================================================
*/


-- 1.1 Validate data types

desc beneficiary;
desc chronic_conditions;
desc inpatient;
desc inpatient_diagnosis;
desc inpatient_procedure;
desc outpatient;
desc outpatient_diagnosis;
desc outpatient_procedure;
desc provider;

-- 1.2 Check for duplicates
select * from 
(select *, count(*) over(partition by beneid) as dup_count
from beneficiary) dup_check
where dup_count > 1;

select * from 
(select *, count(*) over(partition by beneid) as dup_count
from chronic_conditions) dup_check
where dup_count > 1;

select * from 
(select *, count(*) over(partition by claimid) as dup_count
from inpatient) dup_check
where dup_count > 1;

select * from 
(select *, count(*) over(partition by claimid) as dup_count
from inpatient_diagnosis) dup_check
where dup_count > 1;

select * from 
(select *, count(*) over(partition by claimid) as dup_count
from inpatient_procedure) dup_check
where dup_count > 1;

select * from 
(select *, count(*) over(partition by claimid) as dup_count
from outpatient) dup_check
where dup_count > 1;

select * from 
(select *, count(*) over(partition by claimid) as dup_count
from outpatient_diagnosis) dup_check
where dup_count > 1;

select * from 
(select *, count(*) over(partition by claimid) as dup_count
from outpatient_procedure) dup_check
where dup_count > 1;


/*
==============================================================================================================================================================================
----------------------------------------------------------------------- Exploratory Data analysis ----------------------------------------------------------------------------
==============================================================================================================================================================================
*/

-- 2.1 Total claims in inpatient
select count(*) as total_claims 
from inpatient;

-- 2.2 Total claims in outpatient
select count(*) as total_claims
from outpatient;

-- 2.3 Potential fraud in inpatient
select pv.potentialfraud, count(ip.claimid) total_claims
from inpatient ip left join provider pv
on ip.provider = pv.provider
group by pv.potentialfraud
order by total_claims desc;

-- 2.4 Potential fraud in outpatient
select pv.potentialfraud, count(op.claimid) total_claims
from outpatient op left join provider pv
on op.provider = pv.provider
group by pv.potentialfraud
order by total_claims desc;









