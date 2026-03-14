#%% Importando bibliotecas
import pandas as pd
import sqlite3
#%%
customers = pd.read_csv('olist_customers_dataset.csv')
customers.head()
customers.info()
customers.shape

# %%
geolocations = pd.read_csv('olist_geolocation_dataset.csv')
geolocations.head()
geolocations.info()
geolocations.shape


# %%
items = pd.read_csv('olist_order_items_dataset.csv')
items.head(5)
items.info()
items.shape
# Tranformar data de string para datetime
items['shipping_limit_date'] = pd.to_datetime(items['shipping_limit_date'])
items.info()

# %%
payments = pd.read_csv('olist_order_payments_dataset.csv')
payments.head()
payments.info()
payments.shape

# %%
reviews = pd.read_csv('olist_order_reviews_dataset.csv')
reviews.head()
reviews.info()
reviews['review_creation_date'] = pd.to_datetime(reviews['review_creation_date'])
reviews['review_answer_timestamp'] = pd.to_datetime(reviews['review_answer_timestamp'])
reviews.isna().sum()

# Retirar review_comment_title e review_comment_message do novo dataframe, pois tem muitos dados nulos
reviews_clean = reviews.drop(columns=['review_comment_title', 'review_comment_message'], axis=1)
reviews_clean
# %%
orders = pd.read_csv('olist_orders_dataset.csv')
orders.head()
orders.info()
orders.shape
orders.isna().sum()
# Ajustar formato de data em orders
datas = ['order_purchase_timestamp', 
         'order_approved_at', 
         'order_delivered_carrier_date', 
         'order_delivered_customer_date', 
         'order_estimated_delivery_date']
for data in datas:
    orders[data] = pd.to_datetime(orders[data])
orders.info()

# %%
products = pd.read_csv('olist_products_dataset.csv')
products.head()
products.info()
products.shape
products.isna().sum()
products.columns
products['product_category_name'] = products['product_category_name'].fillna('categoria desconhecida')
products_clean = products[['product_id', 'product_category_name']]
products_clean.head()
# %%
sellers = pd.read_csv('olist_sellers_dataset.csv')
sellers.head()
sellers.info()
sellers.shape
sellers.columns

# %%
products_translation = pd.read_csv('product_category_name_translation.csv')
products_translation.head()
products_translation.info()
products_translation.shape

# %%
# Criando um Banco de Dados com sqlite3

# Conectar ou criar o banco de dados
conecte = sqlite3.connect('Olist_database.db')
cursor = conecte.cursor()

# Inserindo os arquivos .csv no banco de dados
customers.to_sql('customers', conecte,if_exists='replace',index=False)
geolocations.to_sql('geolocations',conecte,if_exists='replace',index=False)
items.to_sql('items',conecte,if_exists='replace',index=False)
payments.to_sql('payments',conecte,if_exists='replace',index=False)
reviews.to_sql('reviews',conecte,if_exists='replace',index=False)
reviews_clean.to_sql('reviews_clean',conecte,if_exists='replace',index=False)
orders.to_sql('orders',conecte,if_exists='replace',index=False)
products.to_sql('products',conecte,if_exists='replace',index=False)
products_clean.to_sql('products_clean',conecte,if_exists='replace',index=False)
sellers.to_sql('sellers',conecte,if_exists='replace',index=False)