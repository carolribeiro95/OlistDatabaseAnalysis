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
      - Exclusão de colunas irrelevantes
      - Criação de tabelas .sql e indexação no banco de dados
  
     
## 2) Business Intelligence em SQL

     - Quais são os clientes responsáveis por 80% do faturamento da empresa? (query_01)
     - Taxa de conversão de pagamento (query_02)
     - Taxa de aprovação de pedidos (query_03)
     - Ticket médio (query_04)
     - Quais as categorias de produtos mais venderam por ano? (query_05)
     - Recência, frequência e monetização por cliente (query_06)

## Resultados
O ano de 2017 foi escolhido para a análise visto que os dados mensais desse ano estão completos.

- Podemos observar que há uma concentração de mercado com o estado de São Paulo dominando mais de 50% do faturamento total.
  
- O negócio operou acima da média de faturamento à partir do segundo semestre de 2017 com um pico de faturamento no mês de Novembro, demonstrando eficiência da semana de "Black Friday".
  
-  A cateogoria de "Relógios e Presentes" apresentam o maior ticket médio (R$231.79), porém estão em segundo lugar no ranking de faturamento total, perdendo para a categoria "Cama Mesa e Banho", que apresentou maior faturamento, maior volume de vendas e um ticket médio baixo de R$110.69.

-  As 3 categorias com maior com maior volume de vendas, representaram mais de 36% do faturamento total com um ticket médio abaixo da média geral, o que oferece uma oportunidade para o time de marketing reforçar a fidelidade dos clientes que compram nessas categorias.

-  48% dos clientes são responsáveis por 80% do faturamento total em 2017.

<img width="776" height="88" alt="Image" src="https://github.com/user-attachments/assets/3e896315-9353-4b46-b681-152f031598e5" />

<img width="1145" height="632" alt="Image" src="https://github.com/user-attachments/assets/ac21df58-b2ef-4aea-9b87-825259661abf" />
