# Data-Warehouse-final-project
### Build a OLAP data warehouse for analytic population survey of America ###

> This include ETL pipeline, python for create csv data source and making report using mdx or power bi, excel pivot table and chart.  
> Feel free to clone for studying purposes. 

1. First run 2 sql file for creating db for ETL process
2. run python files filterd_cps.py -> get_all_dims.py -> get_all_facts.py -> transform_data.py for creating csv files
3. Run Visual Studio 2019 solution CPS_SSIS for ETL from csv -> cps_st database -> cps_dw database
4. Run SSAS_CPS solution for query the OLAP cube
5. Run Power BI for report(note that may require configuration for your own machine to get the data source)  
There is a detail word report on the project
 Here is the link to the datasets, which are not included in this repos due to their massive size(cannot push to git hub): 
 https://drive.google.com/drive/u/0/folders/1reTx6dvwRbDoJ-EKlxS2vDwXeq4hbEo7 
 Remember to put those two file at the root folder, and keep the same name
