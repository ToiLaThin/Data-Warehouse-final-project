import numpy as np
import pandas as pd
import matplotlib.pyplot as plt


def get_dim_table(src_path: str, dst_path: str, columns_label: list):
    '''đọc file txt gồm key value và convert ra file csv
        convert data txt => dict => datafram => csv
        các item thuộc columns label phải là string
        item đầu sẽ là index
    '''
    a_dictionary = {}
    a_file = open(src_path)
    for line in a_file:
        key, value = line.split(sep=' ', maxsplit=1)
        a_dictionary[key] = value.replace('\n', '').replace("\"","")

    #print(a_dictionary)
    occu_df = pd.DataFrame.from_dict(a_dictionary, orient='index')
    occu_df.reset_index(inplace=True)
    #print(occu_df) 

    occu_df.columns = columns_label
    occu_df[columns_label[0]] = occu_df[columns_label[0]].astype(str).astype(int)
    occu_df[columns_label[1]] = occu_df[columns_label[1]].astype(str)
    #print(occu_df[columns_label[1]].dtype)
    #print(occu_df[columns_label[0]].dtype)
    occu_df.to_csv(dst_path, index=False)

def get_dim_table_wForeign(src_path: str,
                            dst_path: str,
                            columns_label: list,
                            principle_df: pd.DataFrame) -> pd.DataFrame:
    key_arr = []
    value_arr = []
    foreign_name_arr = []
    foreign_key_arr = []

    a_file = open(src_path)
    for line in a_file:
        key, value = line.split(sep=' ', maxsplit=1)
        key_arr.append(key)
        value, foreign_name = value.lstrip().rstrip().rsplit(sep=', ',maxsplit= 1)
        value_arr.append(value)
        foreign_name = foreign_name.replace('\n', '').replace("\"","").split(sep='-',maxsplit=1)[0]
        foreign_name_arr.append(foreign_name)

    for foreign_name in foreign_name_arr:
        foreign_key = principle_df[principle_df['state_value'] == foreign_name].index.values[0]
        foreign_key_arr.append(foreign_key)
    
    df = pd.concat([pd.Series(key_arr), pd.Series(value_arr), pd.Series(foreign_key_arr)], axis=1)
    df.reset_index(drop=True, inplace=True)
    df.columns = columns_label
    df[columns_label[0]] = df[columns_label[0]].astype(str).astype(int)
    df[columns_label[1]] = df[columns_label[1]].astype(str)
    df[columns_label[2]] = df[columns_label[2]].astype(str).astype(int)
    df.to_csv(dst_path, index=False)
    #print(df)

#industry 
get_dim_table('./industry_data/detail_occupation.txt','./industry_dims/detail_occupation.csv',['detail_occupation_id','detail_occupation_value'])
get_dim_table('./industry_data/detail_industry.txt','./industry_dims/detail_industry.csv',['detail_industry_id','detail_industry_value'])

#demography
get_dim_table('./demography_data/education.txt','./demography_dims/education.csv',['education_id','education_value'])
get_dim_table('./demography_data/marital_status.txt','./demography_dims/marital_status.csv',['marital_status_id','marital_status_value'])
get_dim_table('./demography_data/race.txt','./demography_dims/race.csv',['race_id','race_value'])

#household
get_dim_table('./household_data/household_type.txt','./household_dims/household_type.csv',['household_type_id','household_type_value'])
get_dim_table('./household_data/household_unit.txt','./household_dims/household_unit.csv',['household_unit_id','household_unit_value'])
get_dim_table('./household_data/household_income.txt','./household_dims/household_income.csv',['household_income_id','household_income_value'])

#geography
get_dim_table('./geography_data/state.txt','./geography_dims/state.csv',['state_id','state_value'])
principle_df = pd.read_csv('./geography_dims/state.csv', encoding='ISO-8859-1')
get_dim_table_wForeign('./geography_data/metropolitan.txt','./geography_dims/metropolitan.csv',['metropolitan_id','metropolitan_value','foreign_state_id'],principle_df)

#job_seeking_method
get_dim_table('./job_seeking_method_data/job_seeking_method.txt','./job_seeking_method_dims/job_seeking_method.csv',['job_seeking_method_id','job_seeking_method_value'])

#unemployment_reason
get_dim_table('./unemployment_reason_data/unemployment_reason.txt','./unemployment_reason_dims/unemployment_reason.csv',['unemployment_reason_id','unemployment_reason_value'])