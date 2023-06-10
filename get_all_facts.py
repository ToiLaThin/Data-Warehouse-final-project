import numpy as np
import pandas as pd
import matplotlib.pyplot as plt



def get_fact_table(src_path: str, dst_path, column_labels: list, filter_dict: dict = None):
    '''
    Trích các cột cần trong dim job và đưa ra 1 file csv mới là tham số truyền vô
    Thêm jobid va`o
    Lấy các cột trong column_labels
    Lọc theo dict với mỗi key là array of not accepted value
    '''
    df = pd.read_csv(src_path, encoding='ISO-8859-1')

    for col, not_value in filter_dict.items():
        df = df[~df[col].isin(not_value)]

    df = df[column_labels]
    df.reset_index(drop=True, inplace=True)
    
    #df.rename(columns={'index': 'JOBID'}, inplace=True)
    #print(df.head())
    df.to_csv(dst_path, index=False)


#employment
#WHY PEHRUSLT HAVE 0 VALUE EVEN THAT PERSON IS EMPLOYED AT WORK IN MONTHLY
#'PEMJOT', 'PREMPNOT', 'PEMLR', 
columns_to_get = ['PERSONID', 'PRDTIND1', 'PRDTOCC1', 'PRTAGE', 'PEMARITL', 'PESEX', 'PEEDUCA', 'PTDTRACE', 'PRFTLF', 'GTCBSA',
                   'PEHRUSL1', 'PEHRUSLT']
dict_to_filter = {
    #'''Only currently at work Why not use this to subtitle PEMJOT since it is considered more general'''
    #'PEMLR': [2,3,4,5,6,7,-1],
    #'''Only employed'''
    'PREMPNOT': [-1,2,3,4],
    #'''Only have 1 job'''
	'PEMJOT': [-1,1], 
    #Only if they know which city they 're in => which metropolitan is not 0
    'GTINDVPC': [0]
}

get_fact_table('./filtered_cps.csv', './facts/fact_employment.csv', column_labels= columns_to_get, filter_dict=dict_to_filter)


#employment_periodicity_weekly
columns_to_get = ['PERSONID', 'PRDTIND1', 'PRDTOCC1', 'PRTAGE', 'PEMARITL', 'PESEX', 'PEEDUCA', 'PTDTRACE', 'PRFTLF', 'GTCBSA',
                   'PEERNPER', 'PRERNWA']
dict_to_filter = {
    #Only employed
    'PREMPNOT': [-1,2,3,4],
    #Only have 1 job
	'PEMJOT': [-1,1], 
    #Only work weekly
    'PEERNPER': [-1,1,3,4,5,6,7],
    'GTINDVPC': [0]
}

get_fact_table('./filtered_cps.csv', './facts/fact_employment_periodicity_weekly.csv', column_labels= columns_to_get, filter_dict=dict_to_filter)


#employment_periodicity_hourly
columns_to_get = ['PERSONID', 'PRDTIND1', 'PRDTOCC1', 'PRTAGE', 'PEMARITL', 'PESEX', 'PEEDUCA', 'PTDTRACE', 'PRFTLF', 'GTCBSA',
                   'PEERNPER', 'PRERNHLY', 'PEERNHRO']
dict_to_filter = {
    #Only employed
    'PREMPNOT': [-1,2,3,4],
    #Only have 1 job
	'PEMJOT': [-1,1], 
    #Only work hourly
    'PEERNPER': [-1,2,3,4,5,6,7],
    #Usual hours must be known
    'PEERNHRO': [-1],
    'GTINDVPC': [0]
}

get_fact_table('./filtered_cps.csv', './facts/fact_employment_periodicity_hourly.csv', column_labels= columns_to_get, filter_dict=dict_to_filter)


#unemployment
columns_to_get = ['PERSONID', 'PRDTIND1', 'PRDTOCC1', 'PRTAGE', 'PEMARITL', 'PESEX', 'PEEDUCA', 'PTDTRACE', 'PRFTLF', 'GTCBSA',
                  'PRUNEDUR', 'PRUNTYPE']
dict_to_filter = {
    #Only unemployed
    'PREMPNOT': [-1,1,3,4],
    #More genralized  of PREMNOT
    #UNEMPLOYED LOOKING HAVE SOME 0 VALUE IN DURATION SEEKING COLS => 0 có nghĩa là mới mất việc và mới lên kế hoạch tìm việc chứ chưa tìm
    #nếu bỏ unemployed looking = thêm 4 vào mảng dưới thì PERTYPE THÊM VÀO ko có ý nghĩa vì chỉ duy nhất 1 value là 1
    'PEMLR': [-1,1,2,5,6,7],
    'GTINDVPC': [0]
}

get_fact_table('./filtered_cps.csv', './facts/fact_unemployment.csv', column_labels= columns_to_get, filter_dict=dict_to_filter)


#job_seeking
columns_to_get = ['PERSONID', 'PRDTIND1', 'PRDTOCC1', 'PRTAGE', 'PEMARITL', 'PESEX', 'PEEDUCA', 'PTDTRACE', 'GTCBSA', 'PRFTLF',
                   'PRUNEDUR', 'PRUNTYPE', 'PELKM1', 'PULKM2', 'PULKM3', 'PULKM4', 'PULKM5', 'PULKM6']
dict_to_filter = {
    #PRDTOCC1 cho biết nghề mong muốn làm PRDTIND1 lĩnh vực mong muốn làm => xử lý -1
    #100% người chưa xđ được nghề và lĩnh vực muốn làm việc (PRDTOCC1 = -1 VÀ PRDTIND1 = -1) rease son for unemployment là new entrance => lần đầu đi làm hoặc tái xuất giang hồ sau nhiều năm hưu trí
    #BOTH unemployed and employed (have looking or not) => chỉ unemployed
    #PRFTLF xem cột này có full time part time ko -> tất cả là full time => bỏ
    #qua data explore 100% người tìm việc là thất nghiệp và label force là full time
    #100% người là unemployed bị layoff ko có mong muốn tìm việc => thêm 3 vào ds bỏ cột PEMLR
    'PEMLR': [-1,1,2,3,5,6,7],
    #chỉ sử dụng 1 pp tuyển dụng mà ko sử dụng hết => các cột còn lại -1 => xử lý sao
    'GTINDVPC': [0]
}

get_fact_table('./filtered_cps.csv', './facts/fact_job_seeking.csv', column_labels= columns_to_get, filter_dict=dict_to_filter)


#household
columns_to_get = ['PERSONID', 'GTCBSA', 'HRHHID', 'HEHOUSUT', 'HRHTYPE', 'HEFAMINC', 'HRNUMHOU']
dict_to_filter = {
    #chỉ lấy hộ có kq pv là 1: pv thành công
    'HRINTSTA': [-1,2,3,4],
    'GTINDVPC': [0]
}
#tập gốc là tập nào vì tập filter đã bị mất dữ liệu
#remove duplicate hay group hay s
get_fact_table('./filtered_cps.csv', './facts/fact_household.csv', column_labels= columns_to_get, filter_dict=dict_to_filter)