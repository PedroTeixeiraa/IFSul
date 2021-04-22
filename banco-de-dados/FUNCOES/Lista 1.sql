USE compubras;

-- 1. Retorne o número mais o nome do mês em português (1 - Janeiro) de acordo com o parâmetro
-- informado que deve ser uma data. Para testar, crie uma consulta que retorne o cliente e mês de
-- venda (número e nome do mês).


DELIMITER $$
CREATE FUNCTION diames(d date) RETURNS VARCHAR(30)
DETERMINISTIC
BEGIN 
	CASE MONTH(d)
	WHEN 1 THEN RETURN "1 - Janeiro"; 
	WHEN 2 THEN RETURN "2 - Fevereiro"; 
	WHEN 3 THEN RETURN "3 - Março"; 
	WHEN 4 THEN RETURN "4 - Abril"; 
	WHEN 5 THEN RETURN "5 - Maio"; 
	WHEN 6 THEN RETURN "6 - Junho"; 
	WHEN 7 THEN RETURN "7 - Julho"; 
	WHEN 8 THEN RETURN "8 - Agosto"; 
	WHEN 9 THEN RETURN "9 - Setembro"; 
	WHEN 10 THEN RETURN "10 - Outubro"; 
	WHEN 11 THEN RETURN "11 - Novembro"; 
	WHEN 12 THEN RETURN "12 - Dezembro";
	ELSE RETURN "";
	END CASE;
END $$
DELIMITER ;

SELECT diames(now());

-- 2. Retorne o número mais o nome do dia da semana (0 - Segunda) em português, como parâmetro de
-- entrada receba uma data. Para testar, crie uma consulta que retorne o número do pedido, nome do
-- cliente e dia da semana para entrega (função criada).

DELIMITER $$
CREATE FUNCTION diasemana(d date) RETURNS VARCHAR(30)
DETERMINISTIC
BEGIN 
	CASE DAYOFWEEK(d)
	WHEN 1 THEN RETURN "0 - Segunda"; 
	WHEN 2 THEN RETURN "1 - Terça"; 
	WHEN 3 THEN RETURN "2 - Quarta"; 
	WHEN 4 THEN RETURN "3 - Quinta"; 
	WHEN 5 THEN RETURN "4 - Sexta"; 
	WHEN 6 THEN RETURN "5 - Sábado"; 
	WHEN 7 THEN RETURN "6 - Domingo"; 
	ELSE RETURN "";
	END CASE;
END $$
DELIMITER ;

SELECT
	p.CodPedido,
	c.Nome,
	diasemana(p.PrazoEntrega) AS DIA_DA_SEMANA_ENTREGA
FROM
	pedido p
INNER JOIN cliente c ON
	c.CodCliente = p.CodCliente;

-- 3. Crie uma função para retornar o gentílico dos clientes de acordo com o estado onde moram
-- (gaúcho, catarinense ou paranaense), o parâmetro de entrada deve ser a sigla do estado. Para
-- testar a função crie uma consulta que liste o nome do cliente e gentílico (função criada).

DELIMITER $$
CREATE FUNCTION gentilicoCliente(uf VARCHAR(2)) RETURNS VARCHAR(20)
BEGIN
	CASE uf
		WHEN 'RS' THEN RETURN "GAÚCHO";
        WHEN 'SC' THEN RETURN "CATARINENSE";
        WHEN 'PR' THEN RETURN "PARANAENSE";
        ELSE RETURN ""; 
    END CASE;
END $$
DELIMITER ;

SELECT 
    c.Nome, 
    gentilicoCliente(c.UF) AS GENTILICO_CLIENTE
FROM
    cliente c;
    
-- 4. Crie uma função que retorne a Inscrição Estadual no formato #######-##. Para testar a função
-- criada exiba os dados do cliente com a IE formatada corretamente utilizando a função criada.    
    
DELIMITER $$
CREATE FUNCTION inscricaoEstadualFormatada(ie VARCHAR(9)) RETURNS VARCHAR(20)
BEGIN
	RETURN CONCAT(SUBSTRING(ie, 1, 7), "-", SUBSTRING(Ie, 8));
END $$
DELIMITER ;    

SELECT 
    c.Nome,
    c.Endereco,
    c.Cep,
    c.Cidade,
    c.Uf,
    INSCRICAOESTADUALFORMATADA(c.Ie) AS INSCRICAO_ESTADUAL_FORMATADA
FROM
    cliente c;
    
-- 5. Crie uma função que retorne o tipo de envio do pedido, se for até 3 dias será enviado por SEDEX,
-- se for entre 3 e 7 dias deverá ser enviado como encomenda normal, caso seja maior que este prazo
-- deverá ser utilizado uma encomenda não prioritária. Como dados de entrada recebe a data do
-- pedido e o prazo de entrega e o retorno será um varchar. Note que para criar esta função você
-- deverá utilizar a cláusula IF.    
    
DELIMITER $$
CREATE FUNCTION tipoEnvioPedido(dataPedido date, prazoEntrega date) RETURNS VARCHAR(30)
BEGIN
	DECLARE prazoDiasEntrega INT;
	DECLARE tipoEnvio VARCHAR(30);
    SET prazoDiasEntrega = datediff(prazoEntrega, dataPedido);
    
    IF prazoDiasEntrega < 3 THEN 
		SET tipoEnvio = 'SEDEX';
	ELSEIF (prazoDiasEntrega >= 3 AND prazoDiasEntrega <= 7) THEN
		SET tipoEnvio = 'Encomenda Normal';
	ELSE
		SET tipoEnvio = 'Encomenda não prioritaria';
    END IF;
    RETURN tipoEnvio; 
END $$
DELIMITER ;    

SELECT 
	p.CodPedido,
    TIPOENVIOPEDIDO(p.DataPedido, p.PrazoEntrega) as TIPO_ENVIO_PEDIDO
FROM
    pedido p;

-- 6. Crie uma função que faça a comparação entre dois números inteiros. Caso os dois números sejam
-- iguais a saída deverá ser “x é igual a y”, no qual x é o primeiro parâmetro e y o segundo parâmetro.
-- Se x for maior, deverá ser exibido “x é maior que y”. Se x for menor, deverá ser exibido “x é menor
-- que y”.

DELIMITER $$
CREATE FUNCTION compararXY(x INT, y INT) RETURNS VARCHAR(20)
BEGIN
    IF x = y THEN 
		RETURN 'x é igual a y';
	ELSEIF x > y THEN
		RETURN 'x é maior que y';
	ELSE
		RETURN 'x é menor que y';
    END IF;
END $$
DELIMITER ; 

SELECT compararXY(3, 2);

-- 7. Crie uma função que calcule a fórmula de bhaskara. Como parâmetro de entrada devem ser
-- recebidos 3 valores (a, b e c). Ao final a função deve retornar “Os resultados calculados são x e y”,
-- no qual x e y são os valores calculados.

DELIMITER $$
CREATE FUNCTION bhaskara (a DOUBLE, b DOUBLE, c DOUBLE) RETURNS VARCHAR(50)
BEGIN
	DECLARE x DOUBLE DEFAULT 0;
	DECLARE y DOUBLE DEFAULT 0;
	DECLARE delta DOUBLE;
    
    SET delta = POWER(b, 2) - (4*a*c);
    IF delta < 0 THEN
		 RETURN CONCAT('Os resultados calculados são ', x, ' e ', y);
	ELSE 
		SET x = TRUNCATE((-b + SQRT(delta)) / (2*a), 2);
		SET y = TRUNCATE((-b - SQRT(delta)) / (2*a), 2);
        
        RETURN CONCAT('Os resultados calculados são ', x, ' e ', y);
    END IF;
END $$
DELIMITER ; 

SELECT bhaskara(2,4,1);

-- 8. Crie uma função que retorne o valor total do salário de um vendedor (salário fixo + comissão
-- calculada). Note que esta função deve receber 3 valores de entrada, salário fixo, faixa de comissão
-- e o valor total vendido. Para testar essa função crie uma consulta que exiba o nome do vendedor e
-- o salário total.

DELIMITER $$
CREATE FUNCTION salarioTotalVendedor(salarioFixo DOUBLE, faixaComissao VARCHAR(1), totalVendido DOUBLE) RETURNS DOUBLE
BEGIN
	DECLARE comissaoVendedor DOUBLE;
	IF totalVendido = 0 THEN 
		RETURN salarioFixo;
    END IF;
    
    CASE faixaComissao
		WHEN 'A' THEN
			SET comissaoVendedor = totalVendido * 0.20;
        WHEN 'B' THEN
			SET comissaoVendedor = totalVendido * 0.15;
        WHEN 'C' THEN
			SET comissaoVendedor = totalVendido * 0.10;
        WHEN 'D' THEN
			SET comissaoVendedor = totalVendido * 0.5;
    END CASE;
    
    RETURN TRUNCATE(salarioFixo + comissaoVendedor, 2);
END $$
DELIMITER ; 

SELECT 
    v.Nome,
    SALARIOTOTALVENDEDOR(v.SalarioFixo,
            v.faixaComissao,
            SUM(ip.Quantidade * pr.ValorUnitario)) AS SALARIO_TOTAL_VENDEDOR
FROM
    vendedor v
        LEFT JOIN
    pedido p ON p.CodVendedor = v.CodVendedor
        INNER JOIN
    itempedido ip ON ip.CodPedido = p.CodPedido
        INNER JOIN
    produto pr ON pr.CodProduto = ip.CodProduto
GROUP BY p.CodPedido;


