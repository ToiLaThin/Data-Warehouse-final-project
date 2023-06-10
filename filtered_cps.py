#import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

# Importing the dataset
# data_dict = pd.read_csv('./data_dic.csv', encoding='ISO-8859-1')
# data_dict.columns = ['Name', 'Description']
# start_del_idx = data_dict[data_dict['Name'] == 'PXPDEMP1'].index.values[0]
# end_del_idx = data_dict[data_dict['Name'] == 'PXSCHLVL'].index.values[0]

# new_data_dict = data_dict.drop(data_dict.index[start_del_idx:end_del_idx+1])
# new_data_dict = new_data_dict.reset_index(drop=True)
# new_data_dict.to_csv('./new_data_dic.csv', index=False)
# print(new_data_dict)


# # Importing the dataset
# new_ds = pd.read_csv('./cps_2016-08.csv', encoding='ISO-8859-1')
# # print(new_ds)
# # print(new_ds.columns)
# print(new_ds.select_dtypes(include=['object']).columns.tolist)
# # new_ds = new_ds[new_ds['HRINTSTA'] == 1]
# # new_ds.to_csv('./new_ds.csv', index=False)
# print(new_ds.columns)


# import new dataset
# df = pd.read_csv('./new_ds.csv', encoding='ISO-8859-1')
# df = df[['PRDTCOW1', 'PRDTCOW2', 'PRDTIND1', 'PRDTIND2', 'PRDTOCC1',
#          'PRDTOCC2', 'PRMJIND1', 'PRMJIND2', 'PRMJOCC1', 'PRMJOCC2', 'PRMJOCGR']]
# print(df.head())
# df.to_csv('./dim_job.csv', index=False)


def get_ds_success_interview_adult():
    '''lấy cột có kq phỏng vấn và là adult
        thêm personid va`o data set
       '''
    stage_ds = pd.read_csv('./cps_2016-08.csv', encoding='ISO-8859-1')
    stage_ds = stage_ds[stage_ds['HRINTSTA'] == 1]
    stage_ds = stage_ds[stage_ds['PRPERTYP'] == 2]
    #TODO THEM CHI NAM TRONG LABEL FORCE HOAC KO
    stage_ds.reset_index(drop=False, inplace=True)
    stage_ds.rename(columns={'index': 'PERSONID'}, inplace=True)
    #print(stage_ds.columns)
    stage_ds.to_csv('./filtered_cps.csv', index=False)


# def get_ds_dim_job(src_path: str, dst_path):
#     '''trích các cột cần trong dim job và đưa ra 1 file csv mới là tham số truyền vô
#     thêm jobid va`o'''
#     df = pd.read_csv(src_path, encoding='ISO-8859-1')
#     df = df[['PERSONID', 'PRDTCOW1', 'PRDTCOW2', 'PRDTIND1', 'PRDTIND2', 'PRDTOCC1',
#             'PRDTOCC2', 'PRMJIND1', 'PRMJIND2', 'PRMJOCC1', 'PRMJOCC2', 'PRMJOCGR']]
#     df.reset_index(drop=False, inplace=True)
#     df.rename(columns={'index': 'JOBID'}, inplace=True)
#     print(df.head())
#     df.to_csv(dst_path, index=False)


# def get_principle_table(src_path: str, dst_path: str, columns_label: list):
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

    print(a_dictionary)
    occu_df = pd.DataFrame.from_dict(a_dictionary, orient='index')
    occu_df.reset_index(inplace=True)
    print(occu_df) 

    occu_df.columns = columns_label
    occu_df[columns_label[0]] = occu_df[columns_label[0]].astype(str).astype(int)
    #print(occu_df[columns_label[1]].dtype)
    #print(occu_df[columns_label[0]].dtype)
    occu_df.to_csv(dst_path, index=False)

get_ds_success_interview_adult()
# get_ds_dim_job('./new_ds.csv', './dim_job.csv')
# get_principle_table("./occupation.txt",'./occu_table.csv',['occu_id', 'occu_name'])
# get_principle_table('./industry_data/detail_class_of_worker.txt','./industry_principle/detail_class_of_worker.csv',['detail_class_of_worker_id','detail_class_of_worker_value'])
# get_principle_table('./industry_data/detail_occupation.txt','./industry_principle/detail_occupation.csv',['detail_occupation_id','detail_occupation_value'])
# get_principle_table('./industry_data/major_industry.txt','./industry_principle/major_industry.csv',['major_industry_id','major_industry_value'])
# get_principle_table('./industry_data/major_occupation.txt','./industry_principle/major_occupation.csv',['major_occupation_id','major_occupation_value'])
# get_principle_table('./industry_data/major_occupation_category.txt','./industry_principle/major_occupation_category.csv',['major_occupation_category_id','major_occupation_category_value'])
# get_principle_table('./industry_data/detail_industry.txt','./industry_principle/detail_industry.csv',['detail_industry_id','detail_industry_value'])

