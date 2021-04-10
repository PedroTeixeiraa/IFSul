USE compubras;


-- 1) Mostre o nome dos Clientes e seu endereço completo, dos clientes que realizaram um pedido no ano de 2015.
-- ordene pela ordem alfabética. Linhas: 1291

 SELECT
	c.Nome,
	c.Endereco
FROM
	cliente c
WHERE
	c.CodCliente IN (
		SELECT
			p.CodCliente
		FROM
			pedido p
		WHERE
			YEAR(p.DataPedido) = 2015
	)
ORDER BY
	c.Nome;

-- 2) Mostre o nome do produto e seu valor unitário. Somente devem ser exibidos os produtos que tiveram pelo menos 5 e no 
-- máximo 7 itens em um único pedido. Ordene em ordem decrescente pelo valor unitário dos produtos. Linhas: 1928

SELECT
	p.Descricao,
	p.ValorUnitario
FROM
	produto p
WHERE
	p.CodProduto IN (
		SELECT
			ip.CodProduto 
		FROM
			itempedido ip
		WHERE
			ip.Quantidade >= 5
			AND ip.Quantidade <= 7
	) ORDER BY p.ValorUnitario DESC;

-- 3) Mostre a quantidade de pedidos dos clientes que moram no RS ou em SC. Linhas: 1

SELECT
	count(*) AS total
FROM
	pedido p2
WHERE
	p2.CodCliente IN (
		SELECT
			c2.CodCliente
		FROM
			cliente c2
		WHERE
			c2.Uf IN ('RS', 'SC')
	);

-- 4) Mostre o código do produto, o nome e o valor unitário dos produtos que possuam pedidos para serem 
-- entregues entre os dias 01/12/2014 e 31/01/2015. Ordene a lista pelo valor unitário decrescente
-- dos produtos. Linhas: 625

SELECT
	pr.*
FROM
	produto pr
WHERE
	pr.CodProduto IN (
		SELECT
			ip.CodProduto
		FROM
			itempedido ip
		WHERE
			ip.CodPedido IN (
				SELECT
					p.CodPedido 
				FROM
					pedido p
				WHERE
					p.PrazoEntrega BETWEEN '2014-12-01' AND '2015-01-31'
			)
	)
ORDER BY
	pr.ValorUnitario DESC;

-- 5) Exiba os dados dos clientes que fizeram pedidos com mais de 60 itens, observe que esta é a quantidade
-- total de itens, independentemente de serem produtos iguais ou diferentes. Linhas: 10

SELECT
	*
FROM
	cliente c
WHERE
	c.CodCliente IN (
		SELECT
			p.CodCliente
		FROM
			pedido p
		WHERE
			p.CodPedido IN (
				SELECT
					ip.CodPedido
				FROM
					itempedido ip
				GROUP BY
					ip.CodPedido
				HAVING
					SUM(ip.Quantidade) > 60
			)
	);

-- 6) Crie uma consulta que exiba o código do cliente, o nome do cliente e o número dos seus pedidos ordenados
-- pelo nome e posteriormente pelo código do pedido. Somente devem ser exibidos os pedidos dos vendedores que 
-- possuem a faixa de comissão “A”. Linhas: 1749

SELECT
	p.CodCliente,
	c.Nome,
	p.CodPedido
FROM
	pedido p
INNER JOIN cliente c ON
	p.CodCliente = c.CodCliente
WHERE
	p.CodVendedor IN (
		SELECT
			v.CodVendedor
		FROM
			vendedor v
		WHERE
			v.FaixaComissao = 'A'
	)
GROUP BY
	p.CodPedido
ORDER BY
	c.Nome,
	p.CodPedido;

-- 7) Crie uma consulta que exiba o nome do cliente, endereço, cidade, UF, CEP, código do pedido e prazo de 
-- entrega dos pedidos que NÃO sejam de vendedores que ganham menos de R$ 1500,00. Linhas: 5109

SELECT
	c.Nome,
	c.Endereco,
	c.Cidade,
	c.Uf,
	c.Cep,
	p.CodPedido,
	p.prazoEntrega
FROM
	cliente c
INNER JOIN (
		SELECT
			p.CodCliente,
			p.CodPedido,
			p.PrazoEntrega
		FROM
			pedido p
		WHERE
			p.CodVendedor IN (
				SELECT
					v.CodVendedor
				FROM
					vendedor v
				WHERE
					v.SalarioFixo >= 1500
			)
		GROUP BY
			p.CodPedido
	) p ON
	p.CodCliente = c.CodCliente;
			

-- 8) Crie uma consulta que exiba o nome do cliente, cidade e estado, dos clientes que fizeram 
-- algum pedido no ano de 2015. Ordene os resultados pelos nomes dos clientes em ordem alfabética.
-- Linhas: 1291

SELECT
	c.Nome,
	c.Cidade,
	c.Uf
FROM
	cliente c
WHERE
	c.CodCliente IN (
		SELECT
			p2.CodCliente
		FROM
			pedido p2
		WHERE
			YEAR(p2.DataPedido) = 2015
	)
ORDER BY
	c.Nome;

-- 9) Crie uma consulta que exiba o código do pedido e o somatório da quantidade de itens desse pedido.
-- Devem ser exibidos somente os pedidos em que o somatório das quantidades de itens de um pedido 
-- seja maior que a média da quantidade de itens de todos os pedidos. Linhas: 2508

SELECT
	p.CodPedido,
	p.soma AS soma
FROM
	(
	SELECT
		SUM(ip.Quantidade) AS soma,
		ip.CodPedido
	FROM
		itempedido ip
	GROUP BY
		ip.CodPedido) p
WHERE
	p.soma > (
	SELECT
		AVG(p.Soma) AS media
	FROM
		(
		SELECT
			COALESCE(SUM(ip.Quantidade), 0) AS Soma
		FROM
			itempedido ip
		GROUP BY
			ip.CodPedido) AS p)
ORDER BY
	p.CodPedido;

-- 10) Crie uma consulta que exiba o nome do cliente, o nome do vendedor de seu último pedido e o
-- estado do cliente. Devem ser exibidos apenas os clientes do Rio Grande do Sul e apenas o último vendedor.
-- Linhas: 55

SELECT
	c.Nome AS nome_cliente,
	p.Nome AS nome_vendedor,
	c.Uf
FROM
	cliente c
INNER JOIN (
		SELECT
			p.CodCliente,
			p.CodPedido,
			v.Nome
		FROM
			pedido p
		INNER JOIN vendedor v ON
			v.CodVendedor = p.CodVendedor
		GROUP BY
			p.CodPedido
	) p ON
	p.CodCliente = c.CodCliente
WHERE
	c.Uf = 'RS'
GROUP BY
	c.CodCliente
ORDER BY
	c.Nome;


-- 11) Selecione o nome do produto e o valor unitário dos produtos que possuem o valor unitário maior
-- que todos os produtos que comecem com a letra L. A lista deve ser ordenada em ordem alfabética.
-- Linhas: 192

SELECT
	p.Descricao,
	p.ValorUnitario
FROM
	produto p
WHERE
	p.ValorUnitario > ALL (
		SELECT
			p2.ValorUnitario
		FROM
			produto p2
		WHERE
			p2.Descricao LIKE 'L%'
	)
ORDER BY
	p.Descricao;

-- 12) Selecione o código do produto, o nome do produto e o valor unitário dos produtos que possuam 
-- pelo menos um pedido com mais de 9 itens em sua quantidade. A lista deve ser ordenada pelo valor
-- unitário em ordem decrescente. Linhas: 3063

SELECT
	p.CodProduto,
	p.Descricao,
	p.ValorUnitario
FROM
	produto p
WHERE
	p.CodProduto IN (
		SELECT
			i2.CodProduto
		FROM
			itempedido i2
		WHERE
			i2.Quantidade > 9
	)
ORDER BY
	p.ValorUnitario DESC;

-- 13) Selecione o código do vendedor e o nome dos vendedores que não tenham vendido nenhum pedido com prazo de 
-- entrega em Agosto de 2015. A lista deve ser ordenada pelo nome dos vendedores em ordem alfabética. Linhas: 101

SELECT
	v.CodVendedor,
	v.Nome
FROM
	vendedor v
WHERE
	v.CodVendedor NOT IN (
		SELECT
			p.CodVendedor
		FROM
			pedido p
		WHERE
			MONTH(p.PrazoEntrega) = 8
			AND YEAR(p.PrazoEntrega) = 2015
	)
ORDER BY
	v.Nome;

-- 14) Selecione o código do cliente e o nome dos clientes que tenham feitos pedidos em Abril de 2014. A lista 
-- deve ser ordenada pelo nome dos clientes em ordem alfabética. Linhas:  208

SELECT
	c.CodCliente,
	c.Nome
FROM
	cliente c
WHERE
	c.CodCliente IN (
		SELECT
			p.CodClientes
		FROM
			pedido p
		WHERE
			MONTH(p.DataPedido) = 4
			AND YEAR(p.DataPedido) = 2014
	)
ORDER BY
	c.Nome;