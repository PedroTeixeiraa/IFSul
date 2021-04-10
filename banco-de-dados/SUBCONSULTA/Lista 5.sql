USE compubras;

-- 1) Crie uma tabela temporária que contenha os dados de todos os pedidos e de seus
-- vendedores e exiba na consulta principal o código do pedido, data de entrega e o nome do
-- vendedor. LINHAS = 8432.

 SELECT
	pv.CodPedido,
	pv.PrazoEntrega,
	pv.Nome
FROM
	(
		SELECT
			p.CodCliente,
			p.CodPedido,
			p.CodVendedor,
			p.DataPedido,
			p.PrazoEntrega,
			v.FaixaComissao,
			v.Nome,
			v.SalarioFixo
		FROM
			pedido p
		INNER JOIN vendedor v ON
			p.CodVendedor = v.CodVendedor
	) pv;

-- 2) Crie uma tabela temporária que contenha todos os dados das tabelas pedido e cliente, após
-- exiba na consulta principal apenas o código do pedido, data do pedido e o nome do cliente. Por fim,
-- ordene a lista em ordem cronológica a data do pedido. LINHAS = 8432

 SELECT
	cp.CodPedido,
	cp.DataPedido,
	cp.Nome
FROM
	(
		SELECT
			c.*,
			p.CodPedido,
			p.CodVendedor,
			p.DataPedido,
			p.PrazoEntrega
		FROM
			cliente c
		INNER JOIN pedido p ON
			p.CodCliente = c.CodCliente
	) cp
ORDER BY
	cp.DataPedido,
	cp.CodPedido;

-- 3) Crie uma tabela temporária que contenha todos os dados das tabelas pedido, cliente e
-- vendedor. Além disso, na consulta principal exiba os estados cadastrados e a quantidade total de
-- pedidos por estado. LINHAS = 27.

 SELECT
	pcv.Uf,
	COUNT(pcv.Uf) AS TotalPedidosEstado
FROM
	(
		SELECT
			c.Cep,
			c.Cidade,
			c.Endereco,
			c.Ie,
			c.Uf,
			c.Nome AS nome_cliente,
			v.Nome AS nome_vendedor,
			v.FaixaComissao,
			v.SalarioFixo,
			p.*
		FROM
			pedido p
		INNER JOIN cliente c ON
			c.CodCliente = p.CodCliente
		INNER JOIN vendedor v ON
			v.CodVendedor = p.CodVendedor
	) pcv
GROUP BY
	pcv.Uf
ORDER BY
	TotalPedidosEstado DESC;

-- 4) Crie uma tabela temporária que contenha todos os dados das tabelas pedido, cliente e
-- vendedor. Exiba o ranking dos vendedores pela quantidade de pedidos e ordene em ordem
-- decrescente. LINHAS = 244.

SELECT
	pcv.nome_vendedor,
	count(pcv.CodPedido) AS quantidade
FROM
	(
		SELECT
			c.Cep,
			c.Cidade,
			c.Endereco,
			c.Ie,
			c.Uf,
			c.Nome AS nome_cliente,
			v.Nome AS nome_vendedor,
			v.FaixaComissao,
			v.SalarioFixo,
			p.*
		FROM
			pedido p
		INNER JOIN cliente c ON
			c.CodCliente = p.CodCliente
		INNER JOIN vendedor v ON
			v.CodVendedor = p.CodVendedor
	) pcv
GROUP BY
	pcv.CodVendedor
ORDER BY
	quantidade DESC;

-- 5) Crie uma tabela temporária que contenha todos os dados das tabelas pedido, cliente e
-- vendedor. Exiba o ranking dos clientes pela quantidade de pedidos e ordene em ordem decrescente.
-- LINHAS = 1569.

SELECT
	pcv.nome_cliente,
	count(pcv.CodPedido) AS ranking
FROM
	(
		SELECT
			c.Cep,
			c.Cidade,
			c.Endereco,
			c.Ie,
			c.Uf,
			c.Nome AS nome_cliente,
			v.Nome AS nome_vendedor,
			v.FaixaComissao,
			v.SalarioFixo,
			p.*
		FROM
			pedido p
		INNER JOIN cliente c ON
			c.CodCliente = p.CodCliente
		INNER JOIN vendedor v ON
			v.CodVendedor = p.CodVendedor
	) pcv
GROUP BY
	pcv.CodCliente
ORDER BY
	ranking DESC;

-- 6) Crie uma tabela temporária que contenha todos os dados das tabelas pedido, itempedido e
-- produto. Exiba o código do pedido e o valor total de cada pedido. LINHAS = 6507.

SELECT
	pippr.CodPedido,
	SUM(pippr.Quantidade * pippr.valorUnitario) AS total
FROM
	(
		SELECT
			ip.CodItemPedido,
			ip.Quantidade,
			pr.*,
			p.*
		FROM
			pedido p
		INNER JOIN itempedido ip ON
			ip.CodPedido = p.CodPedido
		INNER JOIN produto pr ON
			pr.CodProduto = ip.CodProduto
	) pippr
GROUP BY
	pippr.CodPedido;

-- 7) Crie uma tabela temporária que contenha todos os dados das tabelas pedido, itempedido e
-- produto. Exiba o código do vendedor, o nome do vendedor e o salário deste vendedor para o mês de
-- abril/2016, considerando salário + comissão de 20% sobre as vendas desse vendedor. Note que
-- devem ser exibidos apenas os vendedores pertencentes a faixa de comissão A. LINHAS = 22.

SELECT
	v.CodVendedor,
	v.Nome,
	ROUND(COALESCE(v.SalarioFixo + SUM((pippr.quantidade * pippr.valorUnitario) * 0.2 ), 0), 2) AS salario
FROM
	(
		SELECT
			ip.CodItemPedido,
			ip.Quantidade,
			pr.*,
			p.*
		FROM
			pedido p
		INNER JOIN itempedido ip ON
			ip.CodPedido = p.CodPedido
		INNER JOIN produto pr ON
			pr.CodProduto = ip.CodProduto
	) pippr
INNER JOIN vendedor v ON
	v.CodVendedor = pippr.CodVendedor
WHERE
	YEAR(pippr.DataPedido) = 2016
	AND MONTH(pippr.DataPedido) = 4
	AND v.FaixaComissao = 'A'
GROUP BY
	v.CodVendedor
ORDER BY v.CodVendedor;

-- 8) Crie uma tabela temporária que contenha todos os dados das tabelas pedido, itempedido e
-- produto. Exiba o código do cliente, o nome do cliente e o valor gasto por ele durante o ano de 2016.
-- Por fim, ordene a lista pelo total gasto pelo cliente no decorrer do ano (maior -> menor). LINHAS =
-- 621.

SELECT
	c.CodCliente,
	c.Nome,
	SUM(pippr.quantidade * pippr.valorUnitario) AS valorGasto
FROM
	(
		SELECT
			ip.CodItemPedido,
			ip.Quantidade,
			pr.*,
			p.*
		FROM
			pedido p
		INNER JOIN itempedido ip ON
			ip.CodPedido = p.CodPedido
		INNER JOIN produto pr ON
			pr.CodProduto = ip.CodProduto
	) pippr
INNER JOIN cliente c ON
	c.CodCliente = pippr.CodCliente
WHERE year(pippr.DataPedido) = 2016
GROUP BY
	pippr.CodCliente
ORDER BY
	valorGasto DESC;

-- 9) Crie uma tabela temporária que contenha todos os dados das tabelas pedido, itempedido e
-- produto. Exiba o código do produto, o seu nome e a quantidade total vendida no ano de 2015.
-- LINHAS = 2715.

SELECT
	pippr.CodProduto,
	pippr.Descricao,
	SUM(pippr.Quantidade) AS total
FROM
	(
		SELECT
			ip.CodItemPedido,
			ip.Quantidade,
			pr.*,
			p.*
		FROM
			pedido p
		INNER JOIN itempedido ip ON
			ip.CodPedido = p.CodPedido
		INNER JOIN produto pr ON
			pr.CodProduto = ip.CodProduto
	) pippr
WHERE
	YEAR(pippr.DataPedido) = 2015
GROUP BY
	pippr.CodProduto
ORDER BY
	CodProduto;

-- 10) Crie uma tabela temporária que contenha todos os dados das tabelas pedido, itempedido e
-- produto. Exiba o código do vendedor, o nome e o total de pedidos que contenham itens que iniciem
-- com ‘PS4’. LINHAS = 146.

SELECT
	v.CodVendedor,
	v.Nome,
	COUNT(pippr.CodPedido) AS total
FROM
	(
		SELECT
			ip.CodItemPedido,
			ip.Quantidade,
			pr.*,
			p.*
		FROM
			pedido p
		INNER JOIN itempedido ip ON
			ip.CodPedido = p.CodPedido
		INNER JOIN produto pr ON
			pr.CodProduto = ip.CodProduto
	) pippr
INNER JOIN vendedor v ON
	v.CodVendedor = pippr.CodVendedor
WHERE
	pippr.Descricao LIKE 'PS4%'
GROUP BY
	v.CodVendedor
ORDER BY
	v.CodVendedor;

-- 11) Crie uma tabela temporária que contenha todos os dados das tabelas pedido, itempedido e
-- produto. Exiba o código do pedido, o código do produto e o valor total (valor total = quantidade *
-- valor unitário) de cada produto em um pedido. Dica: deverão ser utilizados dois campos na clausula
-- group by. LINHAS = 12339.

SELECT
	pippr.CodPedido,
	pippr.CodProduto,
	sum(pippr.Quantidade * pippr.valorUnitario) AS valor_total
FROM
	(
		SELECT
			ip.CodItemPedido,
			ip.Quantidade,
			pr.*,
			p.*
		FROM
			pedido p
		INNER JOIN itempedido ip ON
			ip.CodPedido = p.CodPedido
		INNER JOIN produto pr ON
			pr.CodProduto = ip.CodProduto
	) pippr
GROUP BY
	pippr.CodPedido,
	pippr.CodProduto
ORDER BY
	pippr.CodPedido;

-- 12) Crie uma tabela temporária que contenha todos os dados das tabelas pedido, itempedido e
-- produto. Exiba o ano, o código do cliente, o nome do cliente e o total comprado por este cliente a
-- cada ano. Dica: deverão ser utilizados dois campos na clausula group by. LINHAS
-- = 3905.

SELECT
	YEAR(pippr.DataPedido) AS Ano,
	c.CodCliente,
	c.Nome AS NomeCliente,
	SUM(pippr.Quantidade * pippr.valorUnitario) AS ValorTotal
FROM
	(
		SELECT
			ip.CodItemPedido,
			ip.Quantidade,
			pr.*,
			p.*
		FROM
			pedido p
		INNER JOIN itempedido ip ON
			ip.CodPedido = p.CodPedido
		INNER JOIN produto pr ON
			pr.CodProduto = ip.CodProduto
	) pippr
INNER JOIN cliente c ON
	c.CodCliente = pippr.CodCliente
GROUP BY
	c.CodCliente,
	Ano
ORDER BY
	Ano,
	c.CodCliente;
	
-- 13) Crie uma tabela temporária que contenha todos os dados das tabelas pedido, itempedido e
-- produto. Exiba o ano, o código do vendedor, o nome do vendedor e o valor total das vendas a cada
-- ano. Dica: deverão ser utilizados dois campos na clausula group by. LINHAS = 968.

SELECT
	YEAR(pippr.DataPedido) AS Ano,
	v.CodVendedor,
	v.Nome,
	SUM(pippr.Quantidade * pippr.valorUnitario) AS ValorTotal
FROM
	(
		SELECT
			ip.CodItemPedido,
			ip.Quantidade,
			pr.*,
			p.*
		FROM
			pedido p
		INNER JOIN itempedido ip ON
			ip.CodPedido = p.CodPedido
		INNER JOIN produto pr ON
			pr.CodProduto = ip.CodProduto
	) pippr
INNER JOIN vendedor v ON
	v.CodVendedor = pippr.CodVendedor
GROUP BY
	v.CodVendedor,
	Ano
ORDER BY
	Ano,
	v.CodVendedor;
