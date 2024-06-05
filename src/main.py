#!/usr/bin/env python
# coding: utf-8

# In[1]:


import pandas as pd
import numpy as np


# In[2]:


employment_data = pd.read_csv(r'your path')


# In[3]:


employment_data


# In[4]:


education_data = pd.read_csv('your path')


# In[5]:


education_data


# In[6]:


socio_economic_data = pd.read_csv('your path')


# In[7]:


socio_economic_data


# In[8]:


european_countries = []

for ind in socio_economic_data.index:
    x = "europe" in socio_economic_data["regionUN"][ind].lower()
    if x:
        if socio_economic_data["country"][ind].lower() in european_countries:
            continue
        else:
            european_countries.append(socio_economic_data["country"][ind].lower())


# In[9]:


european_countries


# In[16]:


socio_economic_data['Country Name Lower'] = socio_economic_data['country'].str.lower()
europe_df_socio = socio_economic_data[socio_economic_data['Country Name Lower'].isin(european_countries)]

europe_df_socio.drop(columns=['Country Name Lower'], inplace=True)

print(europe_df_socio)


# In[17]:


europe_df_socio.to_csv(r'your path')


# In[10]:


education_data['Country Name Lower'] = education_data['Country Name'].str.lower()
europe_df = education_data[education_data['Country Name Lower'].isin(european_countries)]

europe_df.drop(columns=['Country Name Lower'], inplace=True)

print(europe_df)


# In[12]:


europe_df.to_csv(r'your path')


# In[13]:


employment_data


# In[14]:


employment_data['Country Name Lower'] = employment_data['Country Name'].str.lower()
europe_df_employment = employment_data[employment_data['Country Name Lower'].isin(european_countries)]

europe_df_employment.drop(columns=['Country Name Lower'], inplace=True)

print(europe_df_employment)


# In[15]:


europe_df_employment.to_csv(r'your path')


# In[ ]:




