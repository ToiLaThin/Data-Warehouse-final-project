import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

def remove_duplicate_rows(df: pd.DataFrame) -> pd.DataFrame:
    list_of_columns = df.columns.tolist()
    list_of_columns.remove('PERSONID') #personid is unique so we have to ignore it from the checking

    duplicates = df[df.duplicated(subset=list_of_columns,keep='first')] #print(df.duplicated(subset=list_of_columns,keep='first'))
    df.drop_duplicates(inplace=True, subset=df.columns.difference(['PERSONID']))
    # drop duplicate them 1 lan nua 
    # vi co 2 dong chung hrhhid ma khac gia dinh
    df.drop_duplicates(inplace=True, subset=['HRHHID'])
    return df

def pre_process_dataframe(df: pd.DataFrame) -> pd.DataFrame:
    return remove_duplicate_rows(df)

original_df = pd.read_csv('./facts/fact_household.csv')
processed_df = pre_process_dataframe(original_df)
processed_df.to_csv('./facts/fact_household.csv', index=False)