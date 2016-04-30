use master
go
drop database livrariadigital
----------Query Estrutura das Tabelas--------------
create database livrariadigital
go
use livrariadigital

create table autor(
id int not null identity,
nome varchar(100) not null,
datanasc date not null,
datafale date,
localmorte varchar(100),
--biografia
primary key(id)
)

create table editora(

id int not null identity,
nome varchar(100) not null,
tel varchar(14) not null,
cnpj varchar(18) not null,
cep varchar(9) not null,
uf varchar(2) not null,
cidade varchar(100) not null,
bairro varchar(100) not null,
rua varchar(100) not null,
numero int not null,
compl varchar(10),

--primary key(cnpj), --verificar
primary key(id)
)


create table categoria(
id int not null identity,
nome varchar(30),
descricao varchar(max),
primary key(id)
)


create table livro(
id int not null identity,
idautor int not null,
ideditora int not null,
titulo varchar(30),
isbn varchar (14),
paginas int,
edicao int,
tipocapa varchar(10),
--info editora
ano decimal (4),
assunto varchar(40),
idioma varchar(40),
imagem varchar(max),
preco decimal(7,2),
--resumo
--sumario
foreign key (idautor) references autor(id),
foreign key (ideditora) references editora(id),
primary key(id)
)

create table livrocategoria(
idlivro int not null,
idcategoria int not null,
foreign key (idlivro) references livro(id),
foreign key (idcategoria) references categoria(id) on delete cascade,
)


--------------Inserts de Teste--------------------

INSERT INTO autor VALUES ('George Orwell', '25/06/1903', '21/01/1950', 'Londres, Reino Unido')
INSERT INTO autor VALUES ('J. K Rowling', '25/06/1903', '21/01/1950', 'Nova York')

INSERT INTO editora VALUES ('Companhia das Letras e contos','1137073500', '55789390000112', '04532002' ,'SP','São Paulo','bairro', 'R. Bandeira Paulista', 702 ,'complement')
INSERT INTO editora VALUES ('Companhia das Letras','1137073500', '55789390000112', '04532002' ,'SP','São Paulo','bairro', 'R. Bandeira Paulista', 702 ,'complement')
INSERT INTO editora VALUES ('Brasil inc','1137073500', '55789390000112', '04532002' ,'SP','São Paulo','bairro', 'R. Bandeira Paulista', 702 ,'complement')

INSERT INTO livro VALUES (1,1,'1984','9780141182957',414,1,'brochura',1949,'fic��o cient�fica ','Portugu�s','1984.jpg', 129.00),
(1,1,'Cha de minhapi ca','9780141182957',414,1,'brochura',1949,'fic��o cient�fica ','Portugu�s','1984.jpg', 50.00),
(2,2,'Paula tejando','9780141182957',414,1,'brochura',1949,'fic��o cient�fica ','Portugu�s','1984.jpg', 60.00),
(2,3,'Harry potter','9780141182957',414,1,'brochura',1949,'fic��o cient�fica ','Portugu�s','1984.jpg', 100.00)

insert into categoria values ('acao', 'muito tiro')
insert into categoria values ('comedia', 'muita risada')
insert into categoria values ('romance', 'muito amor')

insert into livrocategoria values (1,1), (2,2), (3,2), (4,3)

select* from livro
select * from autor
select * from editora

truncate table editora
truncate table autor
truncate
-------------------------
Pesquisa de livros a partir de autor
--------------------------
create view v_livrocategoria
as
select liv.id, liv.titulo
from livro liv
inner join autor aut
on liv.idautor = aut.id
where aut.id = 1
group by liv.id, liv.titulo
-------------------------
Pesquisa de livros a partir da editora
-------------------------
select liv.id, liv.titulo
from livro liv
inner join editora ed
on liv.ideditora = ed.id
where ed.id = 1
order by ed.id
-------------------------
Pesquisa de livros a partir da categoria
-------------------------
select liv.id, liv.titulo
from livro liv
inner join livrocategoria lc
on liv.id = lc.idlivro
inner join categoria cat
on cat.id = lc.idcategoria
group by liv.id, liv.titulo
order by liv.id
-------------------------
Pesquisa de livros a partir do título
-------------------------
select * from livros where titulo like %''%
-------------------------
select id, nome, CONVERT(CHAR(10),datanasc,103) AS datanasc, CONVERT(CHAR(10),datafale,103) AS datafale, localmorte FROM autor




--VIEW RESPONSAVEL PELA PESQUISA DE LIVRO ATRAVEZ DE UM AUTOR
create view v_pesquisaPorAutor
as
	select aut.nome, liv.id, liv.titulo, liv.isbn, liv.paginas, liv.edicao, liv.tipocapa, liv.ano, liv.assunto, liv.idioma, liv.preco, liv.imagem
	from livro liv
	inner join autor aut
	on liv.idautor = aut.id
	group by liv.id, liv.titulo, liv.isbn, liv.paginas, liv.edicao, liv.tipocapa, liv.ano, liv.assunto, liv.idioma, liv.preco, liv.imagem, aut.nome

select * from v_pesquisaPorAutor where nome like '%r%'
drop view v_pesquisaPorAutor

--VIEW RESPONSAVEL PRLA PESQUISA DE LIVRO ATRAVES DA EDITORA
create view v_pesquisaPorEditora
as
	select ed.nome, liv.id, liv.titulo, liv.isbn, liv.paginas, liv.edicao, liv.tipocapa, liv.ano, liv.assunto, liv.idioma, liv.preco, liv.imagem
	from livro liv
	inner join editora ed
	on liv.ideditora = ed.id
	group by liv.id, liv.titulo, liv.isbn, liv.paginas, liv.edicao, liv.tipocapa, liv.ano, liv.assunto, liv.idioma, liv.preco, liv.imagem, ed.nome
	
select * from v_pesquisaPorEditora where nome like '%contos%'
drop view v_pesquisaPorEditora

--VIEW RESPONSAVEL PELA PESQUISA DE LIVRO ATRAVES DA CATEGORIA
create view v_pesquisaPorCategoria
as
	select cat.nome, liv.id, liv.titulo, liv.isbn, liv.paginas, liv.edicao, liv.tipocapa, liv.ano, liv.assunto, liv.idioma, liv.preco, liv.imagem
	from livro liv
	inner join livrocategoria lc
	on liv.id = lc.idlivro
	inner join categoria cat
	on cat.id = lc.idcategoria
	group by liv.id, liv.titulo, liv.isbn, liv.paginas, liv.edicao, liv.tipocapa, liv.ano, liv.assunto, liv.idioma, liv.preco, liv.imagem, cat.nome
	
select * from v_pesquisaPorCategoria where nome like '%comedia%'
drop view v_pesquisaPorCategoria