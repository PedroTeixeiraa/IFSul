USE compubras;

-- 1) Crie uma consulta que exiba o código do cliente, o nome do cliente e o número dos seus
-- pedidos ordenados pelo nome e posteriormente pelo código do pedido. Somente devem ser 
-- exibidos os pedidos dos vendedores que possuem a faixa de comissão “A”. Linhas: 1749

SELECT
	c.CodCliente,
	c.Nome,
	pv.CodPedido
FROM
	cliente c
INNER JOIN (
		SELECT
			p.CodCliente,
			p.CodPedido
		FROM
			pedido p
		INNER JOIN vendedor v ON
			v.CodVendedor = p.CodVendedor
		WHERE v.FaixaComissao = 'A'
	) pv ON
	pv.CodCliente = c.CodCliente
ORDER BY c.Nome, pv.CodPedido;

-- 2) Crie uma consulta que exiba o nome do cliente, endereço, cidade, UF, CEP, código do pedido
-- e prazo de entrega dos pedidos que NÃO sejam de vendedores que ganham menos de R$ 1500,00. 
-- Linhas: 5109

SELECT
	c.Nome,
	c.Endereco,
	c.Cidade,
	c.Uf,
	c.Cep,
	p.CodPedido,
	p.PrazoEntrega
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
			p.CodVendedor NOT IN (
				SELECT
					v.CodVendedor
				FROM
					vendedor v
				WHERE
					v.SalarioFixo < 1500
			)
	) p ON
	p.CodCliente = c.CodCliente;

-- 3) Crie uma consulta que exiba o nome do cliente, cidade e estado, dos clientes que fizeram algum 
-- pedido no ano de 2015. Ordene os resultados pelos nomes dos clientes em ordem alfabética. Linhas: 1291

SELECT
	c.Nome,
	c.Cidade,
	c.Uf
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

-- 4) Crie uma consulta que exiba o código do pedido e o somatório da quantidade de itens desse pedido. 
-- Devem ser exibidos somente os pedidos em que o somatório das quantidades de itens de um pedido seja
-- maior que a média da quantidade de itens de todos os pedidos. Linhas: 2508

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

-- 5) Anulada

-- 6) Crie uma consulta que exiba o nome do cliente, o nome do vendedor de seu primeiro pedido e o estado do cliente. 
-- Devem ser exibidos apenas os clientes de Santa Catarina e apenas o primeiro vendedor. Linhas: 59

SELECT
	c.Nome,
	pv.nome_vendedor,
	c.Uf
FROM
	cliente c
INNER JOIN (
		SELECT
			p.CodCliente,
			v.Nome AS nome_vendedor
		FROM
			pedido p
		INNER JOIN vendedor v ON
			v.CodVendedor = p.CodVendedor
		GROUP BY
			p.CodCliente
	) pv ON
	pv.CodCliente = c.CodCliente
WHERE
	c.Uf IN ('SC')
GROUP BY
	c.CodCliente
ORDER BY
	c.Nome;

-- 7) Selecione o nome do produto e o valor unitário dos produtos que possuem o valor unitário maior que todos os
-- produtos que comecem com a letra L. A lista deve ser ordenada em ordem alfabética. Linhas: 192

SELECT
	p.Descricao,
	p.ValorUnitario
FROM
	produto p
WHERE
	p.ValorUnitario > (
		SELECT
			MAX(p2.ValorUnitario)
		FROM
			produto p2
		WHERE
			p2.Descricao LIKE 'L%'
	)
ORDER BY p.Descricao;


-- 8) Selecione o código do produto, o nome do produto e o valor unitário dos produtos que possuam pelo menos um pedido 
-- com mais de 9 itens em sua quantidade. A lista deve ser ordenada pelo valor unitário em ordem decrescente. Linhas: 3063

SELECT
	p.*
FROM
	produto p
WHERE
	p.CodProduto IN (
		SELECT
			ip.CodProduto
		FROM
			itempedido ip
		WHERE
			ip.Quantidade > 9
	)
ORDER BY
	p.ValorUnitario DESC;

-- 9) Selecione o código do vendedor e o nome dos vendedores que não tenham vendido nenhum pedido com prazo de 
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
			YEAR(p.PrazoEntrega) = 2015
			AND MONTH(p.PrazoEntrega) = 8
	)
ORDER BY
	v.Nome;

-- 10) Selecione o código do cliente e o nome dos clientes que tenham feitos pedidos em Abril de 2014. 
-- A lista deve ser ordenada pelo nome dos clientes em ordem alfabética. Linhas: 208

SELECT
	c.CodCliente,
	c.Nome
FROM
	cliente c
WHERE
	c.CodCliente IN (
		SELECT
			p.CodCliente
		FROM
			pedido p
		WHERE
			YEAR(p.DataPedido) = 2014
			AND MONTH(p.DataPedido) = 4
	)
ORDER BY
	c.Nome;