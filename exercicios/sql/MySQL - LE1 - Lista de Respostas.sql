/* 1.	Qual o produto com o maior preço de custo */
select produto.id, produto.nome, produto.precocusto from produto order by produto.precoCusto desc limit 1;

/* 2.	Qual o produto com o maior preço de venda */
select produto.id, produto.nome, produto.precovenda from produto order by produto.precovenda desc limit 1;

/* 3.	Qual produto com o menor preço de custo */
select produto.id, produto.nome, produto.precocusto from produto order by produto.precocusto asc limit 1;

/* 4.	Qual produto com o menor preço de venda */
select produto.id, produto.nome, produto.precovenda from produto order by produto.precovenda asc limit 1;

/* 5.	A comanda mais recente */
select comanda.codigo, comanda.criadoEm from comanda order by comanda.criadoEm desc limit 1;

/* 6.	A comanda mais velha */
select comanda.codigo, comanda.criadoEm from comanda order by comanda.criadoEm asc limit 1;

/* 7.	A comanda com maior valor (baseado campo valor da tabela “comanda”) */
select comanda.codigo, comanda.valor from comanda order by comanda.valor desc limit 1;

/* 8.	As 3 comandas com maior valor (baseado campo valor da tabela “comanda”) ordenadas em ordem crescente */
select comanda.codigo, comanda.valor from comanda order by comanda.valor desc limit 0, 3;

/* 9.	Os clientes que são aniversariantes do mês */
select  * from pessoa where Month(pessoa.dataNascimento) = Month(Now());  

/* 10.	O código das mesas que onde não possuem atendentes alocados */
select mesa.codigo from mesa where mesa.atendenteId is null;

/* 11.	A quantidade de atendentes que existem cadastrados */
select count(1) from pessoa where pessoa.tipoPessoa = 'F';

/* 12.	A quantidade de comandas dos dois últimos anos (baseados na data e hoje) */
select count(1) 'Total de comandas do último ano' from comanda where comanda.alteradoEm between '2020-01-01' and '2022-12-31';

/* 13.	O maior valor de comanda (baseado campo valor da tabela “comanda”) dia a dia do mês atual */
select comanda.alteradoEm, comanda.codigo, max(comanda.valor) from comanda where comanda.alteradoEm between '2022-11-01' and '2022-11-30' group by comanda.alteradoEm order by comanda.alteradoEm;

/* 14.	O valor de cada comanda (baseado na soma dos valores dos produtos da comanda) juntamente com valor do item mais caro que compõe a comanda */
select comanda.id 'Comanda Id', sum(comandaProduto.valorTotal) 'Total', max(comandaProduto.valorTotal) 'Item mais caro' from comanda
join comandaProduto on comandaProduto.comandaId = comanda.Id
group by comandaProduto.comandaId order by comandaProduto.valorTotal desc;

/* 15.	O valor que cada cliente já gastou no restaurante */
select pessoa.id, pessoa.nome, sum(comanda.valor) from comanda
join pessoa on comanda.clienteId = pessoa.id group by pessoa.id;

/** 16.	A lista de códigos das mesas juntamente com o nome dos atendentes responsáveis por cada mesa (apenas as mesas que contém atendente) **/
select mesa.codigo, pessoa.nome from mesa inner join pessoa on mesa.atendenteId = pessoa.id;

/** 17.	A lista das comandas com seus produtos mostrando o código da comanda e o nome do produto **/
select comanda.codigo 'Codigo', produto.nome 'Produto' from comanda join comandaProduto on comandaProduto.comandaId = comanda.id join produto on comandaProduto.produtoId = produto.id order by comanda.codigo;

/** 18.	Os valores totais de cada comanda (baseado na soma dos itens da tabela “comandaProduto”) **/
select comanda.codigo, sum(comandaProduto.valorTotal) from comanda join comandaProduto on comandaProduto.comandaId = comanda.id group by comanda.codigo;

/** 19.	A comanda que teve a maior valor, mostrando o código da comanda, o valor da comanda e o nome do atendente responsável por aquela comanda **/
select comanda.codigo as 'Código da Comanda', pessoa.nome as 'Nome do atendente', mesa.nome 'Mesa', max(comanda.valor) as 'Valor' from comanda join mesa on comanda.mesaId = mesa.id join pessoa on mesa.atendenteId = pessoa.id

/** 20.	A quantidade de clientes em cada dia **/
select comanda.alteradoEm "Dia", count(comanda.Id) "Quantidade de clientes" from comanda
group by comanda.alteradoEm;

/** 21.	O funcionário mais velho que já fez algum atendimento **/
select pessoa.nome, min(pessoa.dataNascimento) from pessoa 
inner join mesa on mesa.atendenteId = pessoa.id
inner join comanda on comanda.mesaId = mesa.id
group by pessoa.dataNascimento
order by pessoa.dataNascimento asc limit 1;

/** 22.	A comanda com maior valor (baseado na soma dos itens da tabela “comandaProduto”) e que não está paga **/
select comanda.id, comanda.codigo, sum(comandaProduto.valorTotal) 'Valor total' from comanda
inner join comandaproduto on comandaProduto.comandaId = comanda.id
join statusComanda on comanda.statusComandaId = statusComanda.id
where statusComanda.nome like 'Em aberto' group by comanda.codigo order by sum(comandaProduto.valorTotal) desc limit 1;

/** 23.	A comanda com menor valor (baseado na soma dos itens da tabela “comandaProduto”) e que já está paga **/
select comanda.id, comanda.codigo, sum(comandaProduto.valorTotal) 'Valor total' from comanda
inner join comandaproduto on comandaProduto.comandaId = comanda.id
join statusComanda on comanda.statusComandaId = statusComanda.id
where statusComanda.nome like 'Fechada' group by comanda.codigo order by sum(comandaProduto.valorTotal) asc limit 1;

/** 24.	A quantidade de clientes que tem comandas em aberto **/
select *  from pessoa 
inner join comanda on comanda.clienteId = pessoa.id
inner join statuscomanda on comanda.statuscomandaid = statuscomanda.id
where statuscomanda.nome = 'Em aberto' group by comanda.clienteId;

select * from comanda
join statuscomanda on comanda.statuscomandaid = statuscomanda.id
where comanda.statuscomandaid = 1 group by clienteId;

/** 25.	O valor arrecadado por cada mesa (baseado campo valor da tabela “comanda”) **/
select mesa.nome, sum(comanda.valor) 'Valor Total' from mesa
left join comanda on comanda.mesaid = mesa.id
group by mesa.id order by 'Valor Total';

/** 26.	A quantidade de clientes que nunca consumiram no restaurante **/
select count(1) 'Quantidade de pessoas que nunca consumiram nada' from pessoa
where pessoa.id not in (select comanda.clienteid from comanda);

/** 27.	Os clientes que nunca consumiram no restaurante **/
select pessoa.nome from pessoa
where pessoa.id not in (select comanda.clienteid from comanda);

/** 28.	As comandas que estão em mesas ocupadas juntamente com seu valor (baseado campo valor da tabela “comanda”) **/
select comanda.codigo, comanda.valor from comanda
inner join mesa on comanda.mesaid = mesa.id
inner join statusmesa on mesa.statusmesaid = statusmesa.id
where statusmesa.nome like 'Ocupada';

/** 29.	Os 10 produtos mais vendidos (último mês) **/
select produto.nome, count(comandaproduto.id) 'Quantidade de vendas' from produto
inner join comandaproduto on comandaproduto.produtoId = produto.id
inner join comanda on comandaproduto.comandaid= comanda.id
where comanda.alteradoEm between '2022-11-01' and '2022-12-31'
group by produto.nome
order by count(comandaproduto.id) desc
limit 10;

/** 30.	O valor da comanda com maior valor e com menor valor (baseado campo valor da tabela “comanda”) **/
select max(comanda.valor) from comanda
union
select min(comanda.valor) from comanda

/** 31.	Os produtos que nunca saíram em nenhuma comanda **/

/** 32.	A quantidade de vezes que um produto saiu em cada comanda **/





