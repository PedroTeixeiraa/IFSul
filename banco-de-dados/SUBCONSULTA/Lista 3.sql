USE compubras;

-- 1) Exiba o nome, endereço, cidade e o CEP dos clientes que moram em Santa Catarina e que
-- tenham pelo menos um pedido feito onde o prazo de entrega é entre 16 e 20 dias. Linhas: 59

SELECT
	c.Nome,
	c.Endereco,
	c.Cidade,
	c.Cep
FROM
	cliente c
WHERE
	c.Uf = 'SC'
	AND c.CodCliente IN (
		SELECT
			p.CodCliente
		FROM
			pedido p
		WHERE
			datediff(p.PrazoEntrega, p.DataPedido) >= 16
			AND datediff(p.PrazoEntrega, p.DataPedido) <= 20
	);

-- 2) Exiba o nome, endereço, cidade e o CEP dos clientes que moram no Rio Grande do Sul e tenham pedidos 
-- realizados por algum vendedor que tenha o nome iniciando com a letra A. Além disso deve ser exibido 
-- apenas os clientes que tiveram pedidos no ano de 2015. A lista deve estar ordenada em ordem alfabética
-- e sem clientes repetidos. Linhas: 9

SELECT
	c.Nome,
	c.Endereco,
	c.Cidade,
	c.Cep
FROM
	cliente c
WHERE
	c.Uf = 'RS'
	AND c.CodCliente IN (
		SELECT
			p.CodCliente
		FROM
			pedido p
		INNER JOIN vendedor v ON
			v.CodVendedor = p.CodVendedor
		WHERE
			v.Nome LIKE 'A%'
			AND YEAR(p.DataPedido) = 2015
	)
ORDER BY
	c.Nome;


-- 3) Exiba o nome, salário e a faixa de comissão dos vendedores que recebem mais que R$ 1800,00 que tenham realizado
-- algum pedido em Dezembro de 2014 para clientes que moram ou em Santa Catarina ou no Rio Grande do Sul. (2 sub-consultas). 
-- Linhas: 7

SELECT
	v.Nome,
	v.SalarioFixo,
	v.FaixaComissao
FROM
	vendedor v
WHERE
	v.CodVendedor IN (
		SELECT
			p.CodVendedor
		FROM
			pedido p
		WHERE
			p.CodCliente IN (
				SELECT
					c.CodCliente
				FROM
					cliente c
				WHERE
					c.Uf IN (
						'RS', 'SC'
					)
			)
			AND YEAR(p.DataPedido) = 2014
			AND MONTH(p.DataPedido) = 12
	)
	AND v.FaixaComissao IN (
		'A', 'B'
	);

-- 4) Exiba um ranking contendo o nome e o total de vendas efetuadas por vendedor durante o ano de 2015. 
-- Note que não devem aparecer vendedores que efetuaram nenhuma venda no ano. Linhas: 244

SELECT
	v.Nome,
	p.total_vendas
FROM
	vendedor v
INNER JOIN (
		SELECT
			p.CodVendedor,
			COUNT(p.CodPedido) AS total_vendas
		FROM
			pedido p
		WHERE
			YEAR(p.DataPedido) = 2015
		GROUP BY
			p.CodVendedor
	) p ON
	p.CodVendedor = v.CodVendedor
ORDER BY
	p.total_vendas DESC;

-- 5) Anulada

-- 6) Exiba o nome e a comissão dos vendedores. A consulta externa deverá ser na tabela vendedor e existem 
-- duas sub-consultas (uma dentro da outra). A lista deve ser ordenada pelo valor das comissões. Além disso,
-- as comissões devem ter o valor exibido arredondado (2 números depois da vírgula), a comissão para todos 
-- os vendedores é 10% do total vendido. Linhas: 246

SELECT
	v.Nome,
	COALESCE(pippr.comissao, ROUND(0.00, 2)) AS comissao_dos_vendedores
FROM
	vendedor v
LEFT JOIN (
		SELECT
			p.CodVendedor,
			ROUND(COALESCE(SUM(ip.Quantidade * pr.ValorUnitario * 0.1), 0), 2) AS comissao
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
GROUP BY
	v.CodVendedor
ORDER BY
	comissao_dos_vendedores;

-- 7) Exiba um ranking com o nome do cliente e o total comprado por este cliente no ano de 2015. Os clientes que 
-- devem integrar o ranking devem morar no Rio Grande do Sul ou em Santa Catarina. Além disso, o total devem 
-- ter o valor exibido arredondado (2 números depois da vírgula). A consulta externa é em cliente. Linhas: 117

SELECT
	c.Nome,
	COALESCE(SUM(pippr.totalVendido), ROUND(0.00, 2)) AS total
FROM
	cliente c
LEFT JOIN (
		SELECT
			p.CodCliente,
			SUM(ip.Quantidade * pr.ValorUnitario) AS totalVendido
		FROM
			pedido p
		INNER JOIN itempedido ip ON
			ip.CodPedido = p.CodPedido
		INNER JOIN produto pr ON
			pr.CodProduto = ip.CodProduto
		WHERE
			YEAR(p.DataPedido) = 2015
		GROUP BY
			p.CodCliente
	) pippr ON
	pippr.CodCliente = c.CodCliente
WHERE
	c.Uf IN (
		'RS', 'SC'
	)
GROUP BY
	c.CodCliente
ORDER BY
	pippr.totalVendido;

-- 8) Exiba um ranking com o nome do vendedor e o total vendido por ele no ano de 2014. Além disso, o total devem 
-- ter o valor exibido arredondado (2 números depois da vírgula). A consulta externa é em vendedor. Linhas: 246

SELECT
	v.Nome,
	COALESCE(SUM(pippr.totalVendido), ROUND(0.00, 2)) AS total
FROM
	vendedor v
LEFT JOIN (
		SELECT
			p.CodVendedor,
			SUM(ip.Quantidade * pr.ValorUnitario) AS totalVendido
		FROM
			pedido p
		INNER JOIN itempedido ip ON
			ip.CodPedido = p.CodPedido
		INNER JOIN produto pr ON
			pr.CodProduto = ip.CodProduto
		WHERE
			YEAR(p.DataPedido) = 2014
		GROUP BY
			p.CodVendedor
	) pippr ON
	pippr.CodVendedor = v.CodVendedor
GROUP BY
	v.CodVendedor
ORDER BY
	v.Nome;


-- 9) Exiba o código do produto, nome e a quantidade vendida dos produtos que tiveram pedidos entre os dias 12/08/2014 e
-- 27/10/2014. Os resultados devem ser ordenados pela quantidade e a consulta externa é na tabela produto. Linhas: 770

SELECT
	pr.CodProduto,
	pr.Descricao,
	ip.quantidadeVendida
FROM
	produto pr
INNER JOIN (
		SELECT
			i.CodProduto,
			SUM(i.Quantidade) AS quantidadeVendida
		FROM
			itempedido i
		INNER JOIN pedido p ON
			p.CodPedido = i.CodPedido
		WHERE
			p.DataPedido BETWEEN '2014-08-12' AND '2014-10-27'
		GROUP BY
			i.CodProduto
	) ip ON
	ip.CodProduto = pr.CodProduto
ORDER BY
	ip.QuantidadeVendida DESC;

-- 10) Crie uma consulta que retorne o nome do cliente e o total comprado por este no ano de 2014 e no ano de 2015. 
-- A consulta também deve retornar o saldo da diferença entre o total comprado no ano de 2015 e o total de 2014,
-- ordenada por este saldo. Não preocupe-se com os saldos que por eventualidade possuam o valor null. 
-- DICA: a sub-consulta será no lugar de uma tabela, ademais podem haver várias sub-consultas para as colunas desta tabela. 
-- Linhas: 1576

SELECT
	c.Nome,
	COALESCE(p2014.totalComprado, 0) AS total_2014,
	COALESCE(p2015.totalComprado, 0) AS total_2015,
	SUM(COALESCE(p2015.totalComprado, 0) - COALESCE(p2014.totalComprado, 0)) AS saldo
FROM
	cliente c
LEFT JOIN (
		SELECT
			p.CodCliente,
			SUM(i.Quantidade * pr.ValorUnitario) AS totalComprado
		FROM
			pedido p
		INNER JOIN itempedido i ON
			i.CodPedido = p.CodPedido
		INNER JOIN produto pr ON
			pr.CodProduto = i.CodProduto
		WHERE
			YEAR(p.DataPedido) IN (2014)
		GROUP BY
			p.CodCliente
	) p2014 ON
	p2014.CodCliente = c.CodCliente
LEFT JOIN (
		SELECT
			p.CodCliente,
			SUM(i.Quantidade * pr.ValorUnitario) AS totalComprado
		FROM
			pedido p
		INNER JOIN itempedido i ON
			i.CodPedido = p.CodPedido
		INNER JOIN produto pr ON
			pr.CodProduto = i.CodProduto
		WHERE
			YEAR(p.DataPedido) IN (2015)
		GROUP BY
			p.CodCliente
	) p2015 ON
	p2015.CodCliente = c.CodCliente
GROUP BY
	c.CodCliente
ORDER BY
	saldo DESC;


