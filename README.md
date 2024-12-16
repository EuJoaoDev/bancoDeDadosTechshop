# Explorando o Banco de Dados da Loja TechShop

Este projeto contém a estrutura e algumas operações básicas para um banco de dados da loja fictícia TechShop. O objetivo é demonstrar como criar tabelas, inserir dados e realizar consultas SQL úteis para gerenciar informações sobre clientes, produtos, pedidos e itens de pedidos.

## Requisitos

- PostgreSQL instalado em sua máquina.
- Um cliente para executar comandos SQL, como:
  - pgAdmin
  - DBeaver
  - Linha de comando do PostgreSQL.

## Estrutura do Banco de Dados

O banco de dados da TechShop é composto pelas seguintes tabelas:

### 1. **Tabela: clientes**
Armazena informações sobre os clientes.

```sql
create table clientes (
	id serial primary key,
	nome varchar(120),
	cidade varchar(120),
	email varchar(120) unique
)
```

### 2. **Tabela: produtos**
Armazena informações sobre os produtos disponíveis na loja.

```sql
create table produtos (
	id serial primary key,
	nome varchar(120) not null,
	preco decimal(10, 2) not null
)
```

### 3. **Tabela: pedidos**
Armazena os pedidos realizados pelos clientes.

```sql
create table pedidos (
	id serial primary key,
	cliente_id int references clientes(id),
	data date
)
```

### 4. **Tabela: itens_pedido**
Armazena os itens de cada pedido, com informações sobre a quantidade e o valor total.

```sql
create table itens_pedido (
	id serial primary key,
	produto_id int references produtos(id),
	pedido_id int references pedidos(id),
	quantidade int,
	valor_total decimal(10, 2)
)
```

## Inserção de Dados

### Clientes
```sql
insert into clientes (nome, cidade, email)
values
('joao', 'florianopolis', 'joao@email.com'),
('maria', 'florianopolis', 'maria@email.com'),
('ana', 'florianopolis', 'ana@email.com'),
('bruno', 'florianopolis', 'bruno@email.com'),
('breno', 'florianopolis', 'breno@email.com');
```

### Produtos
```sql
insert into produtos (nome, preco)
values
('caneta bic azul', 2),
('caneta bic preta', 2),
('caderno 15 matérias', 25),
('lápis preto', 3),
('estojo rosa', 25);
```

### Pedidos
```sql
insert into pedidos (cliente_id, data)
values
(1, '2024-12-13'),
(2, '2024-11-08'),
(3, '2024-08-01'),
(4, '2024-01-15'),
(5, '2024-12-02');
```

### Itens do Pedido
```sql
insert into itens_pedido (produto_id, pedido_id, quantidade, valor_total)
values 
(1, 1, 10, 20),
(2, 1, 10, 20),
(3, 2, 2, 50),
(4, 2, 2, 6),
(4, 3, 3, 75);
```

## Consultas Importantes

### Listar todos os produtos
```sql
select * from produtos;
```

### Listar todos os pedidos
```sql
select * from pedidos;
```

### Total por pedido
```sql
select pedidos.id, sum(itens_pedido.valor_total) from pedidos
join itens_pedido on pedidos.id = itens_pedido.pedido_id
group by pedidos.id;
```

### Detalhes dos produtos em cada pedido
```sql
select pedidos.id, 
	produtos.nome, 
	produtos.preco, 
	sum(itens_pedido.quantidade) as quantidade, 
	sum(itens_pedido.valor_total) as valor_total
	from pedidos
join itens_pedido 
	on pedidos.id = itens_pedido.pedido_id
join produtos 
	on itens_pedido.produto_id = produtos.id
group by pedidos.id, produtos.nome, produtos.preco;
```

### Relatório de clientes e seus pedidos
```sql
select
	clientes.id as id_do_cliente,
	clientes.nome,
	clientes.email,
	pedidos.id as id_do_pedido,
	pedidos.data as data_do_pedido
	from clientes
left join pedidos
on pedidos.cliente_id = clientes.id;
```

## Como Usar

1. Copie e cole o código SQL em seu cliente SQL.
2. Execute os comandos para criar as tabelas.
3. Insira os dados fornecidos.
4. Realize as consultas para explorar os dados.

## Objetivo

O objetivo deste projeto é fornecer uma base para explorar as operações básicas de SQL em um banco de dados relacional, aplicável ao gerenciamento de uma loja fictícia.

## Autor
João Victor (EuJoaoDev)
