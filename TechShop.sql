create table clientes (
	id serial primary key,
	nome varchar(120),
	cidade varchar(120),
	email varchar(120) unique
)

insert into clientes (nome, cidade, email)
values ('joao', 'florianopolis', 'joao@email.com'),
('maria', 'florianopolis', 'maria@email.com'),
('ana', 'florianopolis', 'ana@email.com'),
('bruno', 'florianopolis', 'bruno@email.com'),
('breno', 'florianopolis', 'breno@email.com')
  
create table produtos (
	id serial primary key,
	nome varchar(120) not null,
	preco decimal(10, 2) not null
)

insert into produtos (nome, preco)
values
('caneta bic azul', 2),
('caneta bic preta', 2),
('caderno 15 matérias', 25),
('lápis preto', 3),
('estojo rosa', 25)

select * from produtos

create table pedidos (
	id serial primary key,
	cliente_id int references clientes(id),
	data date
)

insert into pedidos (cliente_id, data)
values
(1, '2024-12-13'),
(2, '2024-11-08'),
(3, '2024-08-01'),
(4, '2024-01-15'),
(5, '2024-12-02')

select * from pedidos

  create table itens_pedido (
	id serial primary key,
	produto_id int references produtos(id),
	pedido_id int references pedidos(id),
	quantidade int,
	valor_total decimal(10, 2)
)

select * from produtos
	
insert into itens_pedido (produto_id, pedido_id, quantidade, valor_total)
values 
	(1, 1, 10, 20),
	(2, 1, 10, 20),
	(3, 2, 2, 50),
	(4, 2, 2, 6),
	(4, 3, 3, 75)

select * from itens_pedido

select pedidos.id, sum(itens_pedido.valor_total) from pedidos
join itens_pedido on pedidos.id = itens_pedido.pedido_id
group by pedidos.id
  
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
group by pedidos.id, produtos.nome, produtos.preco

select
	clientes.id as id_do_cliente,
	clientes.nome,
	clientes.email,
	pedidos.id as id_do_pedido,
	pedidos.data as data_do_pedido
	from clientes
left join pedidos
on pedidos.cliente_id = clientes.id