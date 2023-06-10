import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

df = pd.read_csv('./facts/fact_job_seeking.csv')
print(df.head())
print(df.info())
print(df.columns.dtype)
#string column dtype is object

