USE compubras;

-- 1) Exiba o código, o nome e o valor unitário dos produtos que tiveram mais que 9 unidades
-- vendidas em apenas um pedido (note que não é o somatório total de unidades vendidas é apenas
-- em um único pedido). Linhas: 3063

 SELECT
	p.CodProduto,
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
			ip.Quantidade > 9
	)
ORDER BY
	p.CodProduto;

-- 2) Exiba o código, o nome do cliente, o endereço, a cidade, o cep, o estado e a IE dos clientes
-- que efetuaram pedidos entre 25/09/2014 e 05/10/2015. Linhas: 1312

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
			p.DataPedido BETWEEN '2014-09-25' AND '2015-10-05'
	)
ORDER BY
	c.CodCliente;

-- 3) Exiba o código, o nome do cliente, o endereço, a cidade, o estado e a quantidade de pedidos
-- de todos os clientes ao longo do histórico da loja. Ordene a lista pela quantidade de pedidos
-- efetuados pelos clientes. Linhas: 1576

 SELECT
	c.CodCliente,
	c.Nome,
	c.Endereco,
	c.Cidade,
	c.Uf,
	COALESCE(p.tpc, 0) AS total
FROM
	cliente c
LEFT JOIN (
		SELECT
			p.CodCliente,
			COUNT(p.CodPedido) AS tpc
		FROM
			pedido p
		GROUP BY
			p.CodCliente
	) p ON
	c.CodCliente = p.CodCliente;

-- 4) Mostre o código do pedido, a data de entrega, a data do pedido, o código do cliente, o código
-- do vendedor e a quantidade total de unidades em cada pedido. Note que não é necessário
-- diferenciar os produtos. Ordene a lista pela quantidade total de unidades nos pedidos. Linhas: 8432

 SELECT
	p.*,
	COALESCE(ip.Quantidade, 0) AS produtos
FROM
	pedido p
LEFT JOIN (
		SELECT
			SUM(ip.Quantidade) AS Quantidade,
			ip.CodPedido
		FROM
			itempedido ip
		GROUP BY
			ip.CodPedido
	) ip ON
	ip.CodPedido = p.CodPedido
ORDER BY
	produtos DESC;

-- 5) Mostre todos os dados (código, descrição e valor unitário) dos produtos que nunca foram
-- vendidos. Ordene pela ordem alfabética da descrição dos produtos. Linhas: 356

 SELECT
	*
FROM
	produto p
WHERE
	p.CodProduto NOT IN (
		SELECT
			ip.CodProduto
		FROM
			itempedido ip
	)
ORDER BY
	p.Descricao;

-- 6) Exiba o código, a descrição, o valor unitário e a quantidade de unidades vendidas de cada
-- produto desde que a loja abriu. Ordene pelo somatório total de unidades vendidas. Linhas: 4407

 SELECT
	p.*,
	COALESCE(ip.Quantidade, 0) AS total
FROM
	produto p
INNER JOIN (
		SELECT
			ip.CodProduto,
			SUM(ip.Quantidade) AS Quantidade
		FROM
			itempedido ip
		GROUP BY
			ip.CodProduto
	) ip ON
	ip.CodProduto = p.CodProduto
ORDER BY
	total DESC;

-- 7) Exiba o código, o nome do cliente, o endereço, a cidade, o cep, o estado e a IE dos clientes
-- que efetuaram pedidos que contenham pelo menos um produto que custe menos de R$ 10,00.
-- Linhas: 32

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
				WHERE
					ip.CodProduto IN (
						SELECT
							p.CodProduto
						FROM
							produto p
						WHERE
							p.ValorUnitario < 10
					)
			)
	);

-- 8) Mostre os dados (código, nome, salário e faixa de comissão) dos vendedores que venderam
-- algum produto que a descrição inicie com IPHONE 6 PLUS. Linhas: 22

 SELECT
	*
FROM
	vendedor v
WHERE
	v.CodVendedor IN (
		SELECT
			p.CodVendedor
		FROM
			pedido p
		WHERE
			p.CodPedido IN (
				SELECT
					ip.CodPedido
				FROM
					itempedido ip
				WHERE
					ip.CodProduto IN (
						SELECT
							p.CodProduto
						FROM
							produto p
						WHERE
							p.Descricao LIKE 'IPHONE 6 PLUS%'
					)
			)
	);

-- 9) Mostre os dados (código, descrição, valor unitário) dos produtos, bem como a quantidade de 
-- pedidos que solicitaram esses produtos. Ordene a lista pela quantidade de pedidos de cada 
-- produto (do maior para o menor). Linhas: 4763

 SELECT
	p.*,
	COALESCE(ip.total, 0) AS total
FROM
	produto p
LEFT JOIN (
		SELECT
			ip.CodProduto,
			COUNT(ip.codPedido) AS total
		FROM
			itempedido ip
		GROUP BY
			ip.CodProduto
	) ip ON
	ip.CodProduto = p.CodProduto
ORDER BY
	total DESC;

-- 10) Mostre o código, prazo de entrega, data do pedido, código do cliente, do vendedor e o valor total
-- (em reais) de todos os pedidos. Ordene a lista em ordem decrescente pelo valor total. Linhas: 8432

 SELECT
	p.*,
	ippr.total
FROM
	pedido p
LEFT JOIN (
		SELECT
			ip.CodPedido,
			SUM(ip.Quantidade * pr.ValorUnitario) AS total
		FROM
			itempedido ip
		INNER JOIN produto pr ON
			pr.CodProduto = ip.CodProduto
		GROUP BY
			ip.CodPedido
	) ippr ON
	ippr.CodPedido = p.CodPedido
ORDER BY
	ippr.total DESC;

-- 11) Crie um ranking contendo o nome dos vendedores e a quantidade total de vendas (total de pedidos) efetuados por 
-- cada um os vendedores. Ordene o ranking do vendedor com o maior número de vendas (pedidos vendidos aos clientes)
-- para o que possui o menor total. Linhas: 246

 SELECT
	v.Nome,
	p.total
FROM
	vendedor v
LEFT JOIN (
		SELECT
			p.CodVendedor,
			COUNT(p.CodVendedor) AS total
		FROM
			pedido p
		GROUP BY
			p.CodVendedor
	) p ON
	p.CodVendedor = v.CodVendedor
ORDER BY
	p.total DESC;

-- 12) Crie um ranking contendo o nome dos vendedores o valor total gasto por cada cliente na loja.
-- Note que o valor total não é por pedido e sim por cliente (se um cliente efetuou mais de um pedido
-- os valores devem ser somados). Ordene a lista pelo total gasto por cada cliente. Linhas: 6460

 SELECT
	v.Nome AS nome_vendedor,
	piprc.nome_cliente,
	piprc.valor_gasto
FROM
	vendedor v
INNER JOIN (
		SELECT
			p.CodVendedor,
			c.Nome AS nome_cliente,
			SUM(pr.ValorUnitario * i.Quantidade) AS valor_gasto
		FROM
			pedido p
		INNER JOIN itempedido i ON
			i.CodPedido = p.CodPedido
		INNER JOIN produto pr ON
			pr.CodProduto = i.CodProduto
		INNER JOIN cliente c ON
			c.CodCliente = p.CodCliente
		GROUP BY
			p.CodCliente,
			p.CodVendedor
	) piprc ON
	piprc.CodVendedor = v.CodVendedor
ORDER BY
	piprc.valor_gasto DESC;

-- 13) Mostre os dados dos produtos (código, descrição e valor unitário) bem como a quantidade
-- total de unidades vendidas em 2015 para cada um dos produtos. Ordene a lista pela quantidade total
-- de unidades vendidas. Linhas: 2715

 SELECT
	p.*,
	ippe.total
FROM
	produto p
INNER JOIN (
		SELECT
			ip.CodProduto,
			SUM(ip.Quantidade) AS total
		FROM
			itempedido ip
		INNER JOIN pedido pe ON
			ip.CodPedido = pe.CodPedido
		WHERE
			YEAR(pe.DataPedido) = 2015
		GROUP BY
			ip.CodProduto
	) ippe ON
	ippe.CodProduto = p.CodProduto
ORDER BY
	ippe.total DESC;

-- 14) Mostre os dados dos produtos (código, descrição e valor unitário), bem como a quantidade
-- de unidades vendidas e o valor total arrecadado com cada produto. A lista deve ser ordenada pelo
-- valor total arrecadado ao longo dos anos. Linhas: 4763

 SELECT
	p.*,
	COALESCE(ippe.unidades_vendidas, 0),
	COALESCE(SUM(ippe.unidades_vendidas * p.ValorUnitario), 0) AS total_vendido
FROM
	produto p
LEFT JOIN (
		SELECT
			ip.CodProduto,
			SUM(ip.Quantidade) AS unidades_vendidas
		FROM
			itempedido ip
		INNER JOIN pedido pe ON
			ip.CodPedido = pe.CodPedido
		GROUP BY
			ip.CodProduto
	) ippe ON
	ippe.CodProduto = p.CodProduto
GROUP BY
	p.CodProduto
ORDER BY
	total_vendido DESC;

-- 15) Mostre o nome do vendedor e o valor total vendido por cada um dos vendedores desde que a
-- loja abriu. Ordene a lista pelo valor total vendido (maior para o menor). Listas: 246

 SELECT
	v.Nome,
	COALESCE(pippr.total_vendido, 0) AS total_vendido
FROM
	vendedor v
LEFT JOIN (
		SELECT
			p.CodVendedor,
			SUM(ip.Quantidade * pr.ValorUnitario) AS total_vendido
		FROM
			pedido p
		INNER JOIN itempedido ip ON
			ip.CodPedido = p.CodPedido
		INNER JOIN produto pr ON
			pr.CodProduto = ip.CodProduto
		GROUP BY
			p.CodVendedor
	) pippr ON
	pippr.CodVendedor = v.CodVendedor
ORDER BY
	pippr.total_vendido DESC;