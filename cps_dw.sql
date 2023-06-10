-- CREATE DATABASE CPS_DW
----------------------------------------------------------------------------------------
-- script dw dims
CREATE DATABASE CPS_DW
USE CPS_DW

CREATE TABLE [DimDetailIndustry] (
    [detail_industry_id] int,
    [detail_industry_value] varchar(max),
    CONSTRAINT pkDimDetailIndustry PRIMARY KEY ( detail_industry_id )
);

CREATE TABLE [DimDetailOccupation] (
    [detail_occupation_id] int,
    [detail_occupation_value] varchar(max),
    CONSTRAINT pkDimDetailOccupation PRIMARY KEY ( detail_occupation_id )
);

CREATE TABLE [DimRace] (
    [race_id] int,
    [race_value] varchar(max),
    CONSTRAINT pkDimRace PRIMARY KEY ( race_id )
);

CREATE TABLE [DimEducation] (
    [education_id] int,
    [education_value] varchar(max),
    CONSTRAINT pkDimEducation PRIMARY KEY ( education_id )
);

CREATE TABLE [DimMaritalStatus] (
    [marital_status_id] int,
    [marital_status_value] varchar(max),
    CONSTRAINT pkDimMaritalStatus PRIMARY KEY ( marital_status_id )
);

CREATE TABLE [DimHouseHoldType] (
    [household_type_id] int,
    [household_type_value] varchar(max),
    CONSTRAINT pkDimHouseHoldType PRIMARY KEY ( household_type_id )
);

CREATE TABLE [DimHouseHoldUnit] (
    [household_unit_id] int,
    [household_unit_value] varchar(max),
    CONSTRAINT pkDimHouseHoldUnit PRIMARY KEY ( household_unit_id )
);

CREATE TABLE [DimHouseHoldIncome] (
    [household_income_id] int,
    [household_income_value] varchar(max),
    CONSTRAINT pkDimHouseHoldIncome PRIMARY KEY ( household_income_id )
);

CREATE TABLE [DimState] (
    [state_id] int,
    [state_value] varchar(max),
    CONSTRAINT pkDimState PRIMARY KEY ( state_id )
);

CREATE TABLE [DimMetropolitan] (
    [metropolitan_id] int,
    [metropolitan_value] varchar(max),
    [foreign_state_id] int,
    CONSTRAINT pkDimMetropolitan PRIMARY KEY ( metropolitan_id ),
    CONSTRAINT fkDimMetropolitan_DimState FOREIGN KEY ( foreign_state_id )
	REFERENCES DimState (state_id)
);


CREATE TABLE [DimJobSeekingMethod] (
    [job_seeking_method_id] int,
    [job_seeking_method_value] varchar(max),
    CONSTRAINT pkDimJobSeekingMethod PRIMARY KEY ( job_seeking_method_id )
);

CREATE TABLE [DimUnemploymentReason] (
    [unemployment_reason_id] int,
    [unemployment_reason_value] varchar(max),
    CONSTRAINT pkDimUnemploymentReason PRIMARY KEY ( unemployment_reason_id )
);

------------------------------------------------------------------------------------------------
-- script dw facts
CREATE TABLE [FactHouseHold] (    
    [household_id] real,
    [f_metropolitan_id] int,
    [f_household_unit_id] int,
    [f_household_type_id] int,
    [f_household_income_id] int,
    [n_persone_living] int,
    CONSTRAINT pkFactHouseHold PRIMARY KEY ( household_id ),
    CONSTRAINT fkFactHouseHold_DimMetropolitan FOREIGN KEY ( f_metropolitan_id )
	REFERENCES DimMetropolitan (metropolitan_id),
    CONSTRAINT fkFactHouseHold_DimHouseHoldType FOREIGN KEY ( f_household_type_id )
	REFERENCES DimHouseHoldType (household_type_id),
    CONSTRAINT fkFactHouseHold_DimHouseHoldUnit FOREIGN KEY ( f_household_unit_id )
	REFERENCES DimHouseHoldUnit (household_unit_id),
    CONSTRAINT fkFactHouseHold_DimHouseHoldIncome FOREIGN KEY ( f_household_income_id )
	REFERENCES DimHouseHoldIncome (household_income_id)
);

CREATE TABLE [FactEmployment] (
    [person_id] int,
    [f_metropolitan_id] int,
    [f_detail_industry_id] int,
    [f_detail_occupation_id] int,
    [n_age] int,
    [f_marital_status_id] int,
    [sex] varchar(max),
    [f_education_id] int,
    [f_race_id] int,
    [labor_force] varchar(max), --fulltime or partime
    [hours_aweek_mjob] int,
    [hours_aweek_jobs] int,    
    CONSTRAINT pkFactEmployment PRIMARY KEY ( person_id ),
    CONSTRAINT fkFactEmployment_DimMetropolitan FOREIGN KEY ( f_metropolitan_id )
	REFERENCES DimMetropolitan (metropolitan_id),
    CONSTRAINT fkFactEmployment_DimDetailIndustry FOREIGN KEY ( f_detail_industry_id )
	REFERENCES DimDetailIndustry (detail_industry_id),
    CONSTRAINT fkFactEmployment_DimDetailOccupation FOREIGN KEY ( f_detail_occupation_id )
	REFERENCES DimDetailOccupation (detail_occupation_id),
    CONSTRAINT fkFactEmployment_DimMaritalStatus FOREIGN KEY ( f_marital_status_id )
	REFERENCES DimMaritalStatus (marital_status_id),

    CONSTRAINT fkFactEmployment_DimEducation FOREIGN KEY ( f_education_id )
	REFERENCES DimEducation (education_id),
    CONSTRAINT fkFactEmployment_DimRace FOREIGN KEY ( f_race_id )
	REFERENCES DimRace (race_id)
);



CREATE TABLE [FactUnemployment] (
    [person_id] int,
    [f_metropolitan_id] int,
    [f_detail_industry_id] int,
    [f_detail_occupation_id] int,
    [n_age] int,
    [f_marital_status_id] int,
    [sex] varchar(max),
    [f_education_id] int,
    [f_race_id] int,
    [f_unemployment_reason_id] int,
    [labor_force] varchar(max),
    [n_unemployment_duration] int,
    CONSTRAINT pkFactUnemployment PRIMARY KEY ( person_id ),
    CONSTRAINT fkFactUnemployment_DimMetropolitan FOREIGN KEY ( f_metropolitan_id )
	REFERENCES DimMetropolitan (metropolitan_id),
    CONSTRAINT fkFactUnemployment_DimDetailIndustry FOREIGN KEY ( f_detail_industry_id )
	REFERENCES DimDetailIndustry (detail_industry_id),
    CONSTRAINT fkFactUnemployment_DimDetailOccupation FOREIGN KEY ( f_detail_occupation_id )
	REFERENCES DimDetailOccupation (detail_occupation_id),
    CONSTRAINT fkFactUnemployment_DimMaritalStatus FOREIGN KEY ( f_marital_status_id )
	REFERENCES DimMaritalStatus (marital_status_id),

    CONSTRAINT fkFactUnemployment_DimEducation FOREIGN KEY ( f_education_id )
	REFERENCES DimEducation (education_id),
    CONSTRAINT fkFactUnemployment_DimRace FOREIGN KEY ( f_race_id )
	REFERENCES DimRace (race_id),
    CONSTRAINT fkFactUnemployment_DimUnemploymentReason FOREIGN KEY ( f_unemployment_reason_id )
	REFERENCES DimUnemploymentReason (unemployment_reason_id)
);


CREATE TABLE [FactEmploymentPeriodicityHourly] (
    [person_id] int,
    [f_metropolitan_id] int,
    [f_detail_industry_id] int,
    [f_detail_occupation_id] int,
    [n_age] int,
    [f_marital_status_id] int,
    [sex] varchar(max),
    [f_education_id] int,
    [f_race_id] int,
    [labor_force] varchar(max),
    [n_hourly_rate] int, --lương theo giờ
    [n_usual_hours_aweek] int, -- giá trị -4 có nghĩa là vary
    CONSTRAINT pkFactEmploymentPeriodicityHourly PRIMARY KEY ( person_id ),
    CONSTRAINT fkFactEmploymentPeriodicityHourly_DimMetropolitan FOREIGN KEY ( f_metropolitan_id )
	REFERENCES DimMetropolitan (metropolitan_id),
    CONSTRAINT fkFactEmploymentPeriodicityHourly_DimDetailIndustry FOREIGN KEY ( f_detail_industry_id )
	REFERENCES DimDetailIndustry (detail_industry_id),
    CONSTRAINT fkFactEmploymentPeriodicityHourly_DimDetailOccupation FOREIGN KEY ( f_detail_occupation_id )
	REFERENCES DimDetailOccupation (detail_occupation_id),
    CONSTRAINT fkFactEmploymentPeriodicityHourly_DimMaritalStatus FOREIGN KEY ( f_marital_status_id )
	REFERENCES DimMaritalStatus (marital_status_id),

    CONSTRAINT fkFactEmploymentPeriodicityHourly_DimEducation FOREIGN KEY ( f_education_id )
	REFERENCES DimEducation (education_id),
    CONSTRAINT fkFactEmploymentPeriodicityHourly_DimRace FOREIGN KEY ( f_race_id )
	REFERENCES DimRace (race_id)
);


CREATE TABLE [FactEmploymentPeriodicityWeekly] (
    [person_id] int,
    [f_metropolitan_id] int,
    [f_detail_industry_id] int,
    [f_detail_occupation_id] int,
    [n_age] int,
    [f_marital_status_id] int,
    [sex] varchar(max),
    [f_education_id] int,
    [f_race_id] int,
    [labor_force] varchar(max),
    [n_weekly_earning] int, --lương theo tuần
    CONSTRAINT pkFactEmploymentPeriodicityWeekly PRIMARY KEY ( person_id ),
    CONSTRAINT fkFactEmploymentPeriodicityWeekly_DimMetropolitan FOREIGN KEY ( f_metropolitan_id )
	REFERENCES DimMetropolitan (metropolitan_id),
    CONSTRAINT fkFactEmploymentPeriodicityWeekly_DimDetailIndustry FOREIGN KEY ( f_detail_industry_id )
	REFERENCES DimDetailIndustry (detail_industry_id),
    CONSTRAINT fkFactEmploymentPeriodicityWeekly_DimDetailOccupation FOREIGN KEY ( f_detail_occupation_id )
	REFERENCES DimDetailOccupation (detail_occupation_id),
    CONSTRAINT fkFactEmploymentPeriodicityWeekly_DimMaritalStatus FOREIGN KEY ( f_marital_status_id )
	REFERENCES DimMaritalStatus (marital_status_id),

    CONSTRAINT fkFactEmploymentPeriodicityWeekly_DimEducation FOREIGN KEY ( f_education_id )
	REFERENCES DimEducation (education_id),
    CONSTRAINT fkFactEmploymentPeriodicityWeekly_DimRace FOREIGN KEY ( f_race_id )
	REFERENCES DimRace (race_id)
);


CREATE TABLE [FactJobSeeking] (
    [person_id] int,
    [f_metropolitan_id] int,
    [f_detail_industry_id] int,
    [f_detail_occupation_id] int,
    [n_age] int,
    [f_marital_status_id] int,
    [sex] varchar(max),
    [f_education_id] int,
    [f_race_id] int,
    [labor_force] varchar(max),
    [n_unemployment_duration] int,
    [f_unemployment_reason_id] int,
    [f_job_seeking_method1_id] int,
    [f_job_seeking_method2_id] int NULL,
    [f_job_seeking_method3_id] int NULL,
    [f_job_seeking_method4_id] int NULL,
    [f_job_seeking_method5_id] int NULL,
    [f_job_seeking_method6_id] int NULL,
    [n_job_seeking_methods_count] int,
    CONSTRAINT pkFactJobSeeking PRIMARY KEY ( person_id ),
    CONSTRAINT fkFactJobSeeking_DimMetropolitan FOREIGN KEY ( f_metropolitan_id )
	REFERENCES DimMetropolitan (metropolitan_id),
    CONSTRAINT fkFactJobSeeking_DimDetailIndustry FOREIGN KEY ( f_detail_industry_id )
	REFERENCES DimDetailIndustry (detail_industry_id),
    CONSTRAINT fkFactJobSeeking_DimDetailOccupation FOREIGN KEY ( f_detail_occupation_id )
	REFERENCES DimDetailOccupation (detail_occupation_id),
    CONSTRAINT fkFactJobSeeking_DimMaritalStatus FOREIGN KEY ( f_marital_status_id )
	REFERENCES DimMaritalStatus (marital_status_id),

    CONSTRAINT fkFactJobSeeking_DimEducation FOREIGN KEY ( f_education_id )
	REFERENCES DimEducation (education_id),
    CONSTRAINT fkFactJobSeeking_DimRace FOREIGN KEY ( f_race_id )
	REFERENCES DimRace (race_id),
    CONSTRAINT fkFactJobSeeking_DimUnemploymentReason FOREIGN KEY ( f_unemployment_reason_id )
	REFERENCES DimUnemploymentReason (unemployment_reason_id),

    CONSTRAINT fkFactJobSeeking_DimJobSeekingMethod1 FOREIGN KEY ( f_job_seeking_method1_id )
	REFERENCES DimJobSeekingMethod (job_seeking_method_id),
    CONSTRAINT fkFactJobSeeking_DimJobSeekingMethod2 FOREIGN KEY ( f_job_seeking_method2_id )
	REFERENCES DimJobSeekingMethod (job_seeking_method_id),
    CONSTRAINT fkFactJobSeeking_DimJobSeekingMethod3 FOREIGN KEY ( f_job_seeking_method3_id )
	REFERENCES DimJobSeekingMethod (job_seeking_method_id),
    CONSTRAINT fkFactJobSeeking_DimJobSeekingMethod4 FOREIGN KEY ( f_job_seeking_method4_id )
	REFERENCES DimJobSeekingMethod (job_seeking_method_id),
    CONSTRAINT fkFactJobSeeking_DimJobSeekingMethod5 FOREIGN KEY ( f_job_seeking_method5_id )
	REFERENCES DimJobSeekingMethod (job_seeking_method_id),
    CONSTRAINT fkFactJobSeeking_DimJobSeekingMethod6 FOREIGN KEY ( f_job_seeking_method6_id )
	REFERENCES DimJobSeekingMethod (job_seeking_method_id),
);