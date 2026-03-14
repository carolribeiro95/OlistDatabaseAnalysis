Esse projeto consiste na criação de um banco de dados relacional da base de dados Olist do Kaggle
(fonte:https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) e manipulação dos dados para responder algumas perguntas e 
calcular alguns KPI's de vendas.

# Organização dos Dados

<img width="2486" height="1496" alt="Image" src="https://github.com/user-attachments/assets/db2520ed-8cf8-47f0-9425-41faacadfe94" />
Fonte: Brazilian E-Commerce Public Dataset by Olis from Kaggle


# Etapas:

## 1) ETL com a biblioteca Pandas do Python:
      
      - Leitura dos múltiplos arquivos em .csv
      - Conversão de tipos de dados
      - Exclusão de colunas irrelvantes
      - Criação de tabelas .sql e indexação no banco de dados
  
     
## 2) Business Intelligence em SQL

     - Quais são os clientes responsáveis por 80% do faturamento da empresa?
     - Recência, frequência e monetização por cliente
     - Taxa de conversão de pagamento
     - Taxa de aprovação de pedidos
     - Ticket médio
     - Lifetime value - LVT
     -Quais as categorias de produtos mais venderam por ano?
