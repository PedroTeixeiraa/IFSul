USE compubras;

-- 1. Crie uma função para calcular um aumento de 10% no salário dos vendedores de faixa de comissão
-- 'A’. Considere o valor do salário fixo para calcular este aumento. Faça uma consulta select
-- utilizando essa função.

DELIMITER $$
CREATE FUNCTION aumentoSalarioVendedorA(salarioFixo DOUBLE, faixaComissao VARCHAR(1)) RETURNS DOUBLE
DETERMINISTIC
BEGIN 
	IF faixaComissao = 'A' THEN
		RETURN TRUNCATE(salarioFixo * 1.10, 2);
	ELSE 
		RETURN TRUNCATE(salarioFixo, 2);
    END IF;    
END $$
DELIMITER ;

SELECT 
    v.Nome,
    AUMENTOSALARIOVENDEDORA(v.SalarioFixo, v.FaixaComissao) AS salarioTotal,
	v.SalarioFixo,
    v.FaixaComissao
FROM
    vendedor v
WHERE
    v.FaixaComissao = 'A';
    
-- 2. Crie uma função que retorne o código do produto com maior valor unitário   

DELIMITER $$
CREATE FUNCTION codigoProdutoMaisCaro() RETURNS INTEGER
DETERMINISTIC
BEGIN 
	DECLARE codigoProdutoMaisCaro INTEGER;
    
    SELECT p.CodProduto INTO codigoProdutoMaisCaro FROM produto p ORDER BY p.ValorUnitario DESC LIMIT 1;
    
    RETURN codigoProdutoMaisCaro;
END $$
DELIMITER ;

SELECT codigoProdutoMaisCaro() AS CODIGO_PRODUTO_MAIS_CARO;

-- 3. Crie uma função que retorne o código, a descrição e o valor do produto com maior valor unitário. Os
-- valores devem ser retornados em uma expressão: “O produto com código XXX – XXXXXXXXX
-- (descrição) possui o maior valor unitário R$XXXX,XX”. Crie um select que utiliza esta função

DELIMITER $$
CREATE FUNCTION detalhesProdutoMaisCaro() RETURNS VARCHAR(200)
DETERMINISTIC
BEGIN 
	DECLARE codigoProduto INTEGER;
    DECLARE valorUnitario DOUBLE;
    DECLARE descricaoProduto VARCHAR(100);
    
		SELECT 
			p.CodProduto, 
            p.ValorUnitario,
            p.Descricao 
            INTO 
            codigoProduto, 
            valorUnitario, 
            descricaoProduto
		FROM
			produto p
		ORDER BY p.ValorUnitario DESC
		LIMIT 1;
    
    RETURN CONCAT("O produto com código ", codigoProduto, " - ", descricaoProduto, " possui o maior valor unitário R$", TRUNCATE(valorUnitario, 2)) ;
END $$
DELIMITER ;

SELECT detalhesProdutoMaisCaro() AS DETALHES_PRODUTO_MAIS_CARO;
    
-- 4. Crie uma função que receba como parâmetros o código do produto com maior valor unitário e o
-- código do produto com menor valor unitário. Utilize as funções dos exercícios 2 e 3. Retorne a
-- soma dos dois.   

-- 5. Crie uma função que retorne a média do valor unitário dos produtos. Crie uma consulta que utilize
-- esta função. 
    
DELIMITER $$
CREATE FUNCTION mediaValorProdutos() RETURNS DOUBLE
DETERMINISTIC
BEGIN 
	DECLARE mediaValorProdutos DOUBLE;
    
     SELECT avg(p.ValorUnitario) INTO mediaValorProdutos FROM produto p;
    
    RETURN TRUNCATE(mediaValorProdutos, 2);
END $$
DELIMITER ;

SELECT mediaValorProdutos() AS MEDIA_VALOR_PRODUTOS;    

-- 6. Faça uma função que retorna o código do cliente com a maior quantidade de pedidos um ano/mês.
-- Observe que a função deverá receber como parâmetros um ano e um mês. Deve ser exibido a
-- seguinte expressão: “O cliente XXXXXXX (cód) – XXXXXXX (nome) foi o cliente que fez a maior
-- quantidade de pedidos no ano XXXX mês XX com um total de XXX pedidos”

DELIMITER $$
CREATE FUNCTION clienteMaisPedidos(ano INT, mes INT) RETURNS VARCHAR(200)
NOT DETERMINISTIC
BEGIN 
	DECLARE codigoCliente INTEGER;
    DECLARE nomeCliente VARCHAR(40);
    DECLARE totalPedidos INTEGER;
    
   SELECT 
		COUNT(p.CodPedido) AS TOTAL_PEDIDOS,
        c.CodCliente,
        c.Nome
		INTO 
        totalPedidos, 
        codigoCliente,
        nomeCliente 
	FROM cliente c 
		INNER JOIN pedido p 
        ON p.CodCliente = c.CodCliente
    WHERE YEAR(p.DataPedido) = ano 
		AND MONTH(p.dataPedido) = mes
	GROUP BY c.CodCliente
	ORDER BY TOTAL_PEDIDOS DESC
	LIMIT 1; 

    RETURN CONCAT("O cliente ", codigoCliente, " – ", nomeCliente,
    " foi o cliente que fez a maior quantidade de pedidos no ano ", 
    ano, " mês, " , mes, " com um total de ", totalPedidos, " pedidos");
END $$
DELIMITER ;

DROP FUNCTION clienteMaisPedidos;
SELECT clienteMaisPedidos(2013, 8) AS DETALHES_CLIENTE_MAIS_PEDIDO;

-- 7. Faça uma função que retorna a soma dos valores dos pedidos feitos por um determinado cliente.
-- Note que a função recebe por parâmetro o código de uma cliente e retorna o valor total dos pedidos
-- deste cliente. Faça a consulta utilizando Joins.

DELIMITER $$
CREATE FUNCTION valorTotalPedidosCliente(codigoCliente INT) RETURNS DOUBLE
NOT DETERMINISTIC
BEGIN 
    DECLARE valorTotalPedido DOUBLE;
    
	SELECT 
		SUM(ip.Quantidade * pr.ValorUnitario) INTO valorTotalPedido
	FROM pedido p
        INNER JOIN
    itempedido ip ON ip.CodPedido = p.CodPedido
        INNER JOIN
    produto pr ON pr.CodProduto = ip.CodProduto
	WHERE p.CodCliente = codigoCliente
	GROUP BY p.CodCliente;

    RETURN valorTotalPedido;
END $$
DELIMITER ;
    
SELECT valorTotalPedidosCliente(1) AS TOTAL_GASTO_CLIENTE;  

-- 8. Crie 3 funções. A primeira deve retornar a soma da quantidade de produtos de todos os pedidos. A
-- segunda, deve retornar o número total de pedidos e a terceira a média dos dois valores. Por fim,
-- crie uma quarta função que chama as outras três e exibe todos os resultados concatenados.

DELIMITER $$
CREATE FUNCTION somaQuantidadeProdutosTodosPedidos() RETURNS INT
DETERMINISTIC
BEGIN 
    DECLARE quantidadeProdutos INT;
    
	SELECT 
		SUM(ip.Quantidade) INTO quantidadeProdutos
	FROM pedido p
        INNER JOIN
    itempedido ip ON ip.CodPedido = p.CodPedido
        INNER JOIN
    produto pr ON pr.CodProduto = ip.CodProduto;

    RETURN quantidadeProdutos;
END $$
DELIMITER ;

DELIMITER $$
CREATE FUNCTION quantidadePedidosRealizados() RETURNS INT
DETERMINISTIC
BEGIN 
    DECLARE quantidadePedidos INT;
    
	SELECT 
		COUNT(p.CodPedido) INTO quantidadePedidos
	FROM pedido p;

    RETURN quantidadePedidos;
END $$
DELIMITER ;

DELIMITER $$
CREATE FUNCTION mediaQuantidadeProdutosPorPedido() RETURNS DOUBLE
DETERMINISTIC
BEGIN 
    DECLARE quantidadeTotalProdutos INT;
    DECLARE quantidadePedidos INT;
    
	SELECT somaQuantidadeProdutosTodosPedidos(), quantidadePedidosRealizados() INTO quantidadeTotalProdutos, quantidadePedidos;

    RETURN TRUNCATE(quantidadeTotalProdutos / quantidadePedidos, 2);
END $$
DELIMITER ;

DELIMITER $$
CREATE FUNCTION resultado() RETURNS VARCHAR(200)
DETERMINISTIC
BEGIN 
    DECLARE quantidadePedidosRealizados INT;
	DECLARE somaQuantidadeTodosProdutos INT;
    DECLARE mediaQuantidadeProduto DOUBLE;
    
	SELECT 
		somaQuantidadeProdutosTodosPedidos(),
        quantidadePedidosRealizados(),
        mediaQuantidadeProdutosPorPedido()
        INTO 
        somaQuantidadeTodosProdutos,
        quantidadePedidosRealizados,
        mediaQuantidadeProduto;
        
	RETURN CONCAT("Total Pedidos Realizados: ", quantidadePedidosRealizados,
    "\r\n Soma quantidade de produtos de todos os pedidos: ", somaQuantidadeTodosProdutos,
    "\r\n Media de produtos por pedido: ", mediaQuantidadeProduto);
END $$
DELIMITER ;

SELECT resultado() AS RESULTADO_PEDIDOS;

-- 9. Crie uma função que retorna o código do vendedor com maior número de pedidos para um
-- determinado ano/mês. Observe que a função deverá receber como parâmetros um ano e um mês.
-- Deve ser exibido a seguinte expressão: “O vendedor XXXXXXX (cód) – XXXXXXX (nome) foi o
-- vendedor que efetuou a maior quantidade de vendas no ano XXXX mês XX com um total de XXX
-- pedidos”.

DELIMITER $$
CREATE FUNCTION vendedorComMaiorNumeroPedidos(ano INT, mes INT) RETURNS VARCHAR(200)
DETERMINISTIC
BEGIN 
    DECLARE codigoVendedor INT;
	DECLARE nomeVendedor VARCHAR(30);
    DECLARE totalPedidos INT;
    DECLARE descricaoVendedor VARCHAR(50);
    
	SELECT 
		v.CodVendedor,
        v.Nome,
		COUNT(p.CodVendedor) as PEDIDOS_VENDEDOR
        INTO 
        codigoVendedor,
        nomeVendedor,
        totalPedidos
	FROM
		vendedor v
			INNER JOIN
		pedido p ON p.CodVendedor = v.CodVendedor
	WHERE
		YEAR(p.DataPedido) = ano
			AND MONTH(p.DataPedido) = mes
	GROUP BY p.CodVendedor
    ORDER BY PEDIDOS_VENDEDOR desc
    LIMIT 1;
    
    IF codigoVendedor IS NULL THEN 
		RETURN "Nenhum vendedor possui vendas neste período";
    ELSE 
		SET descricaoVendedor = CONCAT(codigoVendedor, " - ", nomeVendedor);
		
		RETURN CONCAT("O vendedor ",  descricaoVendedor, " foi o vendedor que efetuou a maior 
		quantidade de vendas no ano ", ano, " mês ", mes, " com um total de ", totalPedidos, " pedidos");
    END IF;
END $$
DELIMITER ;

SELECT vendedorComMaiorNumeroPedidos(2015, 7) AS DETALHES_VENDEDOR_MAIS_PEDIDOS;

-- 10. Crie uma função que retorne o nome e o endereço completo do cliente que fez o último
-- pedido na loja. (Pedido com a data mais recente).

DELIMITER $$
CREATE FUNCTION ultimoClienteAComprarLoja() RETURNS VARCHAR(200)
DETERMINISTIC
BEGIN 
		
	DECLARE nomeCliente VARCHAR(30);
    DECLARE endereco VARCHAR(30);
    DECLARE cidade VARCHAR(20);
    DECLARE uf VARCHAR(2);
    
	SELECT 
		c.Nome,
        c.Endereco,
        c.Cidade,
        c.Uf
        INTO
        nomeCliente,
        endereco,
        cidade,
        uf
	FROM
		cliente c
			INNER JOIN
		pedido p ON p.CodCliente = c.CodCliente
	ORDER BY p.DataPedido DESC
	LIMIT 1;
    
    RETURN CONCAT(nomeCliente, " | ", endereco, " | ", cidade, "/", uf);
    
END $$
DELIMITER ;

SELECT ultimoClienteAComprarLoja() AS DETALHES_ULTIMO_CLIENTE_COMPRAR;

-- 11. Crie uma função que retorne a quantidade de pedidos realizados para clientes do Estado informado
-- (receber o estado como parâmetro).

DELIMITER $$
CREATE FUNCTION totalPedidosUf(uf VARCHAR(2)) RETURNS INT 
DETERMINISTIC
BEGIN 
	DECLARE totalPedidos INT;
    
	SELECT 
		COUNT(p.CodPedido) INTO totalPedidos
	FROM
		pedido p
	WHERE
		p.CodCliente IN (SELECT 
				c.CodCliente
			FROM
				cliente c
			WHERE
				c.Uf = uf);
    
    RETURN totalPedidos;
    
END $$
DELIMITER ;

SELECT totalPedidosUf('SC') AS PEDIDOS_POR_UF;

-- 12. Crie uma função que retorne o valor total que é gasto com os salários dos vendedores de certa faixa
-- de comissão. (Receber a faixa de comissão por parâmetro). Note que deve ser considerado o valor
-- total dos salários, incluindo a comissão.

DELIMITER $$
CREATE FUNCTION percentualComissaoVendedor(faixaComissao VARCHAR(1)) RETURNS DOUBLE 
DETERMINISTIC
BEGIN 
    DECLARE percentualComissao DOUBLE;
    
    IF faixaComissao = 'A' THEN
		SET percentualComissao = 0.20;
    ELSEIF faixaComissao = 'B' THEN 
		SET percentualComissao = 0.15;
    ELSEIF faixaComissao = 'C' THEN 
		SET percentualComissao = 0.10;
    ELSEIF faixaComissao = 'D' THEN 
		SET percentualComissao = 0.05;
    END IF;
    
    RETURN percentualComissao;
END $$
DELIMITER ;

DELIMITER $$
CREATE FUNCTION totalGastoSalariosVendedoresPorFaixa(faixaComissao VARCHAR(1)) RETURNS DOUBLE 
DETERMINISTIC
BEGIN 
	DECLARE salarioVendedores DOUBLE;
    DECLARE comissaoVendedores DOUBLE;
    
	SELECT 
		SUM(v.SalarioFixo)
	INTO salarioVendedores FROM
		vendedor v
	WHERE
		v.FaixaComissao = faixaComissao;
    
    SELECT percentualComissaoVendedor(faixaComissao) INTO comissaoVendedores;
    
    RETURN salarioVendedores + (salarioVendedores * comissaoVendedores);
    
END $$
DELIMITER ;

SELECT totalGastoSalariosVendedoresPorFaixa('C') AS TOTAL_GASTO_SALARIOS_VENDEDORES;

-- 13. Crie uma função que mostre o cliente que fez o pedido mais caro da loja. O retorno da função
-- deverá ser: “O cliente XXXXXX efetuou o pedido XXXX (cód) em XXXX (data), o qual é o mais caro
-- registrado até o momento no valor total de R$XXXX,XX”.

DELIMITER $$
CREATE FUNCTION pedidoMaisCaroCliente() RETURNS VARCHAR(300)
DETERMINISTIC
BEGIN 
		
	DECLARE nomeCliente VARCHAR(30);
    DECLARE dataPedido DATE;
    DECLARE codigoPedido INT;
    DECLARE valorPedidoMaisCaro DOUBLE;
    
	SELECT 
		SUM(pr.ValorUnitario * ip.Quantidade) AS VALOR_PEDIDO,
		p.CodPedido,
		p.DataPedido
	INTO valorPedidoMaisCaro , codigoPedido , dataPedido FROM
		pedido p
			INNER JOIN
		itempedido ip ON ip.CodPedido = p.CodPedido
			INNER JOIN
		produto pr ON pr.CodProduto = ip.CodProduto
	GROUP BY p.CodPedido
	ORDER BY VALOR_PEDIDO DESC
	LIMIT 1;
    
	SELECT 
		c.Nome INTO nomeCliente
	FROM
		cliente c
	WHERE
		c.CodCliente IN (SELECT 
				p.CodCliente
			FROM
				pedido p
			WHERE
				p.CodPedido = codigoPedido);
    
    
    RETURN CONCAT("O cliente ", nomeCliente, " efetuou o pedido ", codigoPedido, " em ", dataPedido,
    " , o qual é o mais caro registrado até o momento no valor total de R$", valorPedidoMaisCaro);
    
END $$
DELIMITER ;

SELECT pedidoMaisCaroCliente() AS PEDIDO_MAIS_CARO_CLIENTE;

-- 14. Crie uma função que mostre o valor total arrecadado com apenas um determinado produto em toda
-- a história da loja. Esta função deverá receber como parâmetro o código do produto e retornar a
-- seguinte expressão: “O valor total arrecadado com o produto XXXXXX (descrição) foi de
-- R$XXXX,XX”.

DELIMITER $$
CREATE FUNCTION valorArrecadadoProduto(codigoProduto INT) RETURNS VARCHAR(200)
DETERMINISTIC
BEGIN 
		
	DECLARE descricaoProduto VARCHAR(30);
    DECLARE valorTotalArrecadoProduto DOUBLE;
    
   SELECT 
		SUM(pr.ValorUnitario * ip.Quantidade),
        pr.Descricao
        INTO 
        valorTotalArrecadoProduto,
        descricaoProduto
	FROM
		produto pr
			INNER JOIN
		itempedido ip ON ip.CodProduto = pr.CodProduto
	WHERE
		pr.CodProduto = codigoProduto;
    
    RETURN CONCAT("O valor total arrecadado com o produto ", descricaoProduto, 
    " foi de R$", valorTotalArrecadoProduto);
    
END $$
DELIMITER ;

SELECT valorArrecadadoProduto(1) AS VALOR_ARRECADADO_PRODUTO;


-- 15. Crie uma função que mostre a quantidade total vendida para um determinado produto. A função
-- deverá receber como parâmetro o código do produto e retornar a quantidade total de itens que
-- foram vendidos para este produto.    
    
DELIMITER $$
CREATE FUNCTION quantidadeVendidaProduto(codigoProduto INT) RETURNS INT
DETERMINISTIC
BEGIN 
		
    DECLARE quantidadeProduto DOUBLE;
    
    SELECT 
		SUM(ip.Quantidade) INTO quantidadeProduto
	FROM
		produto pr
			INNER JOIN
		itempedido ip ON ip.CodProduto = pr.CodProduto
	WHERE
		pr.CodProduto = codigoProduto;
    
    RETURN quantidadeProduto;
    
END $$
DELIMITER ;

SELECT quantidadeVendidaProduto(2) AS QUANTIDADE_VENDIDA_PRODUTO;
    
    
    