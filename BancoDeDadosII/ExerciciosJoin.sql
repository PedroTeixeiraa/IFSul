USE compubras;

/*1) Mostrar a quantidade pedida para um determinado produto com um determinado
código a partir da tabela item de pedido.*/

SELECT 
    pr.CodProduto,
    pr.descricao,
    COALESCE(SUM(ip.Quantidade), 0) AS TOTAL
FROM
    itempedido ip
        RIGHT JOIN
    produto pr ON ip.CodProduto = pr.CodProduto
GROUP BY CodProduto
ORDER BY TOTAL , pr.CodProduto;
 
/*2) Listar a quantidade de produtos que cada pedido contém.*/
	SELECT 
    p.codpedido,
    coalesce(SUM(ip.quantidade), 0) as total_produtos
FROM
    pedido p
        LEFT JOIN
    itempedido ip ON p.codpedido = ip.codpedido
	GROUP BY p.codpedido
    ORDER BY p.codpedido;
    
/*3) Ver os pedidos de cada cliente, listando nome do cliente e número do pedido.*/

SELECT 
    c.CodCliente, c.nome, p.CodPedido
FROM
    cliente c
        INNER JOIN
    pedido p ON p.CodCliente = c.CodCliente
ORDER BY p.CodPedido , c.CodCliente;

/*4) Listar todos os clientes com seus respectivos pedidos. Os clientes que não têm
pedidos também devem ser apresentados.*/

SELECT 
    c.CodCliente,
    c.nome,
    p.CodPedido
FROM
    cliente c
        LEFT JOIN
    pedido p ON c.CodCliente = p.CodCliente
    ORDER BY c.CodCliente, p.CodPedido;
    

/*5) Clientes com prazo de entrega superior a 10 dias e que pertençam aos estados do
Rio Grande do Sul ou Santa Catarina.*/

SELECT 
    c.codcliente,
    c.nome
FROM
    cliente c
        LEFT JOIN
    pedido p ON c.codcliente = p.codcliente
WHERE
    (c.uf = 'RS' OR c.uf = 'SC')
        AND TIMEDIFF(p.prazoentrega, p.datapedido) > 10
        GROUP BY c.codcliente;
/*6) Mostrar os clientes e seus respectivos prazos de entrega, ordenando do maior para
o menor.*/

SELECT 
    c.CodCliente, c.nome, p.PrazoEntrega
FROM
    cliente c
        RIGHT JOIN
    pedido p ON c.CodCliente = p.CodCliente
ORDER BY p.PrazoEntrega DESC , c.CodCliente;

/*7) Apresentar os vendedores, em ordem alfabética, que emitiram pedidos com prazos
de entrega superiores a 15 dias e que tenham salários fixos iguais ou superiores a
R$ 1.000,00*/

SELECT 
    MAX(v.CodVendedor) AS CodVendedor, v.Nome
FROM
    vendedor v
        LEFT JOIN
    pedido p ON v.CodVendedor = p.CodVendedor
WHERE
    TIMEDIFF(p.prazoEntrega, p.DataPedido) > 15
        AND v.SalarioFixo >= 1000
GROUP BY v.CodVendedor
ORDER BY v.nome , v.CodVendedor;
    
    
/*8) Os vendedores têm seu salário fixo acrescido de 20% da soma dos valores dos
pedidos. Faça uma consulta que retorne o nome dos funcionários e o total de
comissão, desses funcionários.*/

SELECT 
    v.codvendedor,
    v.nome,
    COALESCE(SUM(ip.quantidade * pr.valorunitario) * 0.2,
            0) AS comissao
FROM
    vendedor v
        LEFT JOIN
    pedido p ON p.codvendedor = v.codvendedor
        LEFT JOIN
    itempedido ip ON ip.codpedido = p.codpedido
        LEFT JOIN
    produto pr ON pr.codproduto = ip.codproduto
GROUP BY v.codvendedor
ORDER BY comissao, v.codvendedor;

/*9) Os clientes e os respectivos vendedores que fizeram algum pedido para esse
cliente, juntamente com a data do pedido.*/

SELECT 
    c.codcliente, c.nome, v.codvendedor, v.nome, p.datapedido
FROM
    cliente c
        INNER JOIN
    pedido p ON c.codcliente = p.codcliente
        INNER JOIN
    vendedor v ON p.codvendedor = v.codvendedor
ORDER BY c.codcliente , v.codvendedor;
    
/*10) Liste o nome do cliente e a quantidade de pedidos de cada cliente.*/
SELECT 
    c.CodCliente,
    c.nome,
    COUNT(p.CodCliente) AS QUANTIDADE_DE_PEDIDOS
FROM
    cliente c
        LEFT JOIN
    pedido p ON c.CodCliente = p.CodCliente
GROUP BY c.nome
ORDER BY QUANTIDADE_DE_PEDIDOS , c.CodCliente;


/*11) Liste o nome do cliente, o código do pedido e a quantidade total de produtos por
pedido.*/

SELECT 
    c.CodCliente, c.nome, p.CodPedido, ip.Quantidade AS total
FROM
    cliente c
        INNER JOIN
    pedido p ON p.CodCliente = c.CodCliente
        LEFT JOIN
    itempedido ip ON ip.CodPedido = p.CodPedido
GROUP BY c.CodCliente
ORDER BY p.CodPedido;

/*12) Liste o nome do cliente, o código do pedido e o valor total do pedido*/

SELECT 
    c.CodCliente,
    c.nome,
    p.CodPedido,
    SUM(pr.ValorUnitario * ip.Quantidade) AS TOTAL
FROM
    cliente c
        INNER JOIN
    pedido p ON p.CodCliente = c.CodCliente
        INNER JOIN
    itempedido ip ON ip.CodPedido = p.CodPedido
        INNER JOIN
    produto pr ON pr.CodProduto = ip.CodProduto
GROUP BY p.CodPedido , c.CodCliente
ORDER BY p.CodPedido;

/*13) Liste os produtos, a quantidade vendida e a data dos pedidos realizados no mês de
maio de 2015, começando pelos mais vendidos.*/

SELECT 
    pr.codproduto,
    pr.descricao,
    p.datapedido,
    SUM(ip.quantidade) as total
FROM
    produto pr 
LEFT JOIN itempedido ip ON pr.codproduto = ip.codproduto	
LEFT JOIN pedido p ON p.codpedido = ip.codpedido
    WHERE month(p.datapedido) = 5 and year(p.datapedido) = 2015
GROUP BY pr.codproduto, p.codpedido
ORDER BY total desc;
     
/*14) Liste os produtos, do mais caro para o mais barato, dos pedidos no mês de junho
(considerando todos os anos)*/

SELECT 
    pr.codproduto,
    pr.descricao,
    pr.valorunitario
FROM
    produto pr
        INNER JOIN
    itempedido ip ON pr.codproduto = ip.codproduto
        INNER JOIN
    pedido p ON p.codpedido = ip.codpedido
WHERE
    MONTH(p.datapedido) = 6
    GROUP BY pr.codproduto
ORDER BY pr.valorunitario desc;

/*15) Exiba a relação dos pedidos mais caros de todos os tempos. Esta relação deve
conter o nome do cliente, do vendedor, o código do pedido e o valor total do pedido.*/
	
SELECT 
    c.nome,
    v.nome,
    p.codpedido,
    SUM(pr.valorunitario * ip.quantidade) AS total
FROM
    pedido p
        LEFT JOIN
    vendedor v ON p.codvendedor = v.codvendedor
        LEFT JOIN
    cliente c ON p.codcliente = c.codcliente
        LEFT JOIN
    itempedido ip ON p.codpedido = ip.codpedido
        LEFT JOIN
    produto pr ON pr.codproduto = ip.codproduto
GROUP BY p.codpedido
ORDER BY total DESC;

/*16) Exiba a relação com os melhores vendedores (considerando apenas a quantidade
de pedidos) para o mês de setembro (incluindo todos os anos). Exiba o nome do
vendedor, o ano e o número total de pedidos daquele ano.*/

SELECT 
    v.nome as vendedor,
    year(p.datapedido) as ano,
    ip.quantidade as pedidos
FROM
    vendedor v
        LEFT JOIN
    pedido p ON v.codvendedor = p.codvendedor
        INNER JOIN
    itempedido ip ON ip.codpedido = p.codpedido
    WHERE month(p.datapedido) = 9
    GROUP BY v.nome, ip.quantidade
    ORDER BY ano desc, pedidos desc, v.nome;
    
/*17) Liste o nome dos clientes e o total de pedidos de cada cliente, em ordem crescente
de pedidos. Os clientes sem pedidos também devem ser listados.*/

SELECT 
    c.nome,
    count(p.codpedido) as pedidos
FROM
    cliente c
        LEFT JOIN
    pedido p ON c.codcliente = p.codcliente
    GROUP BY c.nome
    ORDER BY pedidos, c.nome;
    
/*18) Exiba uma relação em ordem alfabética do código do cliente e nome dos clientes
que nunca fizeram nenhum pedido*/

SELECT 
    c.nome, c.CodCliente
FROM
    cliente c
        LEFT JOIN
    pedido p ON c.CodCliente = p.CodCliente
WHERE
    p.CodPedido IS NULL
ORDER BY c.nome;

/*19) Mostre o código do produto, a descrição e o valor total obtido por cada produto ao
longo da história da loja. Ordene a lista pelo valor total dos produtos. Observe que
mesmo os produtos que nunca foram vendidos devem ser exibidos.*/

SELECT 
	pr.codproduto,
    pr.descricao,
    SUM(pr.valorunitario * ip.quantidade) as valor_total
FROM produto pr INNER JOIN itempedido ip ON pr.codproduto = ip.codproduto
GROUP BY pr.codproduto
ORDER BY valor_total desc;

/*20) Mostre todos os dados dos vendedores e a quantidade total de pedidos efetuados
por cada vendedor. A relação deve contar apenas os vendedores de faixa de
comissão “A” e ordenados pela quantidade total de pedidos. Mesmo os vendedores
sem pedidos devem ser listados.*/
\
SELECT 
    v.*,
    count(p.codpedido) as total_pedidos
FROM
    vendedor v
        LEFT JOIN
    pedido p ON v.codvendedor = p.codvendedor
    WHERE v.faixaComissao = 'A'
    GROUP BY v.codvendedor
    ORDER BY total_pedidos;