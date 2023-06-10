CREATE DATABASE CPS_ST
USE CPS_ST

--script stage dims
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


--script stage facts
CREATE TABLE [FactHouseHold] (
    [PERSONID] int,
    [GTCBSA] int,
    [HRHHID] real,
    [HEHOUSUT] int,
    [HRHTYPE] int,
    [HEFAMINC] int,
    [HRNUMHOU] int,
    CONSTRAINT pkFactHouseHold PRIMARY KEY ( HRHHID ),
    CONSTRAINT fkFactHouseHold_DimMetropolitan FOREIGN KEY ( GTCBSA )
	REFERENCES DimMetropolitan (metropolitan_id),
    CONSTRAINT fkFactHouseHold_DimHouseHoldType FOREIGN KEY ( HRHTYPE )
	REFERENCES DimHouseHoldType (household_type_id),
    CONSTRAINT fkFactHouseHold_DimHouseHoldUnit FOREIGN KEY ( HEHOUSUT )
	REFERENCES DimHouseHoldUnit (household_unit_id),
    CONSTRAINT fkFactHouseHold_DimHouseHoldIncome FOREIGN KEY ( HEFAMINC )
	REFERENCES DimHouseHoldIncome (household_income_id)
);

CREATE TABLE [FactEmployment] (
    [PERSONID] int,
    [GTCBSA] int,
    [PRDTIND1] int,
    [PRDTOCC1] int,
    [PRTAGE] int,
    [PEMARITL] int,
    [PESEX] int,
    [PEEDUCA] int,
    [PTDTRACE] int,
    [PRFTLF] int,
    [PEHRUSL1] int,
    [PEHRUSLT] int,    
    CONSTRAINT pkFactEmployment PRIMARY KEY ( PERSONID ),
    CONSTRAINT fkFactEmployment_DimMetropolitan FOREIGN KEY ( GTCBSA )
	REFERENCES DimMetropolitan (metropolitan_id),
    CONSTRAINT fkFactEmployment_DimDetailIndustry FOREIGN KEY ( PRDTIND1 )
	REFERENCES DimDetailIndustry (detail_industry_id),
    CONSTRAINT fkFactEmployment_DimDetailOccupation FOREIGN KEY ( PRDTOCC1 )
	REFERENCES DimDetailOccupation (detail_occupation_id),
    CONSTRAINT fkFactEmployment_DimMaritalStatus FOREIGN KEY ( PEMARITL )
	REFERENCES DimMaritalStatus (marital_status_id),

    CONSTRAINT fkFactEmployment_DimEducation FOREIGN KEY ( PEEDUCA )
	REFERENCES DimEducation (education_id),
    CONSTRAINT fkFactEmployment_DimRace FOREIGN KEY ( PTDTRACE )
	REFERENCES DimRace (race_id)
);



CREATE TABLE [FactUnemployment] (
    [PERSONID] int,
    [GTCBSA] int,
    [PRDTIND1] int,
    [PRDTOCC1] int,
    [PRTAGE] int,
    [PEMARITL] int,
    [PESEX] int,
    [PEEDUCA] int,
    [PTDTRACE] int,
    [PRFTLF] int,
    [PRUNEDUR] int,
    [PRUNTYPE] int,
    CONSTRAINT pkFactUnemployment PRIMARY KEY ( PERSONID ),
    CONSTRAINT fkFactUnemployment_DimMetropolitan FOREIGN KEY ( GTCBSA )
	REFERENCES DimMetropolitan (metropolitan_id),
    CONSTRAINT fkFactUnemployment_DimDetailIndustry FOREIGN KEY ( PRDTIND1 )
	REFERENCES DimDetailIndustry (detail_industry_id),
    CONSTRAINT fkFactUnemployment_DimDetailOccupation FOREIGN KEY ( PRDTOCC1 )
	REFERENCES DimDetailOccupation (detail_occupation_id),
    CONSTRAINT fkFactUnemployment_DimMaritalStatus FOREIGN KEY ( PEMARITL )
	REFERENCES DimMaritalStatus (marital_status_id),

    CONSTRAINT fkFactUnemployment_DimEducation FOREIGN KEY ( PEEDUCA )
	REFERENCES DimEducation (education_id),
    CONSTRAINT fkFactUnemployment_DimRace FOREIGN KEY ( PTDTRACE )
	REFERENCES DimRace (race_id),
    CONSTRAINT fkFactUnemployment_DimUnemploymentReason FOREIGN KEY ( PRUNTYPE )
	REFERENCES DimUnemploymentReason (unemployment_reason_id)
);


CREATE TABLE [FactEmploymentPeriodicityHourly] (
    [PERSONID] int,
    [GTCBSA] int,
    [PRDTIND1] int,
    [PRDTOCC1] int,
    [PRTAGE] int,
    [PEMARITL] int,
    [PESEX] int,
    [PEEDUCA] int,
    [PTDTRACE] int,
    [PRFTLF] int,
    [PEERNPER] int,
    [PRERNHLY] int,
    [PEERNHRO] int,
    CONSTRAINT pkFactEmploymentPeriodicityHourly PRIMARY KEY ( PERSONID ),
    CONSTRAINT fkFactEmploymentPeriodicityHourly_DimMetropolitan FOREIGN KEY ( GTCBSA )
	REFERENCES DimMetropolitan (metropolitan_id),
    CONSTRAINT fkFactEmploymentPeriodicityHourly_DimDetailIndustry FOREIGN KEY ( PRDTIND1 )
	REFERENCES DimDetailIndustry (detail_industry_id),
    CONSTRAINT fkFactEmploymentPeriodicityHourly_DimDetailOccupation FOREIGN KEY ( PRDTOCC1 )
	REFERENCES DimDetailOccupation (detail_occupation_id),
    CONSTRAINT fkFactEmploymentPeriodicityHourly_DimMaritalStatus FOREIGN KEY ( PEMARITL )
	REFERENCES DimMaritalStatus (marital_status_id),

    CONSTRAINT fkFactEmploymentPeriodicityHourly_DimEducation FOREIGN KEY ( PEEDUCA )
	REFERENCES DimEducation (education_id),
    CONSTRAINT fkFactEmploymentPeriodicityHourly_DimRace FOREIGN KEY ( PTDTRACE )
	REFERENCES DimRace (race_id)
);


CREATE TABLE [FactEmploymentPeriodicityWeekly] (
    [PERSONID] int,
    [GTCBSA] int,
    [PRDTIND1] int,
    [PRDTOCC1] int,
    [PRTAGE] int,
    [PEMARITL] int,
    [PESEX] int,
    [PEEDUCA] int,
    [PTDTRACE] int,
    [PRFTLF] int,
    [PEERNPER] int,
    [PRERNWA] int,
    CONSTRAINT pkFactEmploymentPeriodicityWeekly PRIMARY KEY ( PERSONID ),
    CONSTRAINT fkFactEmploymentPeriodicityWeekly_DimMetropolitan FOREIGN KEY ( GTCBSA )
	REFERENCES DimMetropolitan (metropolitan_id),
    CONSTRAINT fkFactEmploymentPeriodicityWeekly_DimDetailIndustry FOREIGN KEY ( PRDTIND1 )
	REFERENCES DimDetailIndustry (detail_industry_id),
    CONSTRAINT fkFactEmploymentPeriodicityWeekly_DimDetailOccupation FOREIGN KEY ( PRDTOCC1 )
	REFERENCES DimDetailOccupation (detail_occupation_id),
    CONSTRAINT fkFactEmploymentPeriodicityWeekly_DimMaritalStatus FOREIGN KEY ( PEMARITL )
	REFERENCES DimMaritalStatus (marital_status_id),

    CONSTRAINT fkFactEmploymentPeriodicityWeekly_DimEducation FOREIGN KEY ( PEEDUCA )
	REFERENCES DimEducation (education_id),
    CONSTRAINT fkFactEmploymentPeriodicityWeekly_DimRace FOREIGN KEY ( PTDTRACE )
	REFERENCES DimRace (race_id)
);


CREATE TABLE [FactJobSeeking] (
    [PERSONID] int,
    [GTCBSA] int,
    [PRDTIND1] int,
    [PRDTOCC1] int,
    [PRTAGE] int,
    [PEMARITL] int,
    [PESEX] int,
    [PEEDUCA] int,
    [PTDTRACE] int,
    [PRFTLF] int,
    [PRUNEDUR] int,
    [PRUNTYPE] int,
    [PELKM1] int,
    [PULKM2] int NULL,
    [PULKM3] int NULL,
    [PULKM4] int NULL,
    [PULKM5] int NULL,
    [PULKM6] int NULL,
    [JobSeekingMethodsCount] int,
    CONSTRAINT pkFactJobSeeking PRIMARY KEY ( PERSONID ),
    CONSTRAINT fkFactJobSeeking_DimMetropolitan FOREIGN KEY ( GTCBSA )
	REFERENCES DimMetropolitan (metropolitan_id),
    CONSTRAINT fkFactJobSeeking_DimDetailIndustry FOREIGN KEY ( PRDTIND1 )
	REFERENCES DimDetailIndustry (detail_industry_id),
    CONSTRAINT fkFactJobSeeking_DimDetailOccupation FOREIGN KEY ( PRDTOCC1 )
	REFERENCES DimDetailOccupation (detail_occupation_id),
    CONSTRAINT fkFactJobSeeking_DimMaritalStatus FOREIGN KEY ( PEMARITL )
	REFERENCES DimMaritalStatus (marital_status_id),

    CONSTRAINT fkFactJobSeeking_DimEducation FOREIGN KEY ( PEEDUCA )
	REFERENCES DimEducation (education_id),
    CONSTRAINT fkFactJobSeeking_DimRace FOREIGN KEY ( PTDTRACE )
	REFERENCES DimRace (race_id),
    CONSTRAINT fkFactJobSeeking_DimUnemploymentReason FOREIGN KEY ( PRUNTYPE )
	REFERENCES DimUnemploymentReason (unemployment_reason_id),

    CONSTRAINT fkFactJobSeeking_DimJobSeekingMethod1 FOREIGN KEY ( PELKM1 )
	REFERENCES DimJobSeekingMethod (job_seeking_method_id),
    CONSTRAINT fkFactJobSeeking_DimJobSeekingMethod2 FOREIGN KEY ( PULKM2 )
	REFERENCES DimJobSeekingMethod (job_seeking_method_id),
    CONSTRAINT fkFactJobSeeking_DimJobSeekingMethod3 FOREIGN KEY ( PULKM3 )
	REFERENCES DimJobSeekingMethod (job_seeking_method_id),
    CONSTRAINT fkFactJobSeeking_DimJobSeekingMethod4 FOREIGN KEY ( PULKM4 )
	REFERENCES DimJobSeekingMethod (job_seeking_method_id),
    CONSTRAINT fkFactJobSeeking_DimJobSeekingMethod5 FOREIGN KEY ( PULKM5 )
	REFERENCES DimJobSeekingMethod (job_seeking_method_id),
    CONSTRAINT fkFactJobSeeking_DimJobSeekingMethod6 FOREIGN KEY ( PULKM6 )
	REFERENCES DimJobSeekingMethod (job_seeking_method_id),
);