--- VIEWS -----------------

--- View que mostra informações detalhadas sobre cada ocorrência, incluindo o tipo de ocorrência, o local e o funcionário responsável.
CREATE VIEW vw_ocorrencias_detalhadas AS
SELECT 
    o.idoco AS id_ocorrencia,
    o.datoco AS data_ocorrencia,
    o.lococo AS local_ocorrencia,
    t.desctipoco AS tipo_ocorrencia,
    f.carfun AS cargo_funcionario,
    p.nompes AS nome_funcionario
FROM ocorrencia o
JOIN tipo_ocorrencia t ON o.tipo_ocorrenciaidtipoco = t.idtipoco
JOIN funcionario f ON o.funcionariopessoaidpes = f.pessoaidpes
JOIN pessoa p ON f.pessoaidpes = p.idpes;
-----------------

-- 1. Pessoas com idades entre 20 e 30 anos e do sexo feminino, ordenadas pelo nome em ordem descendente.
CREATE VIEW vw_pessoas_20_30_feminino AS
SELECT
    idpes,
    nompes,
    EXTRACT(YEAR FROM AGE(datnaspes)) AS idade,
    genpes
FROM
    pessoa
WHERE
    genpes = 'Feminino'
    AND EXTRACT(YEAR FROM AGE(datnaspes)) BETWEEN 20 AND 30
ORDER BY
    nompes DESC;
-------------------------------------------
-- 2. Ocorrências registradas em meses pares de 2023 nas cidades de São Miguel do Oeste e Descanso, ordenadas pelo tipo de ocorrência.
CREATE VIEW vw_ocorrencias_meses_pares_2023 AS
SELECT
    o.idoco,
    o.descoco,
    o.datoco,
    o.lococo,
    o.staoco,
    t.desctipoco AS tipo_ocorrencia,
    c.nomcid AS cidade
FROM
    ocorrencia o
JOIN
    tipo_ocorrencia t ON o.tipo_ocorrenciaidtipoco = t.idtipoco
JOIN
    cidade c ON o.cidadeidcid = c.idcid
WHERE
    EXTRACT(YEAR FROM o.datoco) = 2023
    AND EXTRACT(MONTH FROM o.datoco) IN (2, 4, 6, 8, 10, 12)
    AND c.nomcid IN ('São Miguel do Oeste', 'Descanso')
ORDER BY
    t.desctipoco ASC;
   
-----------------------------------------------------------------------------------

-- 3. Departamentos de polícia que registraram casos de roubo em 2024 nas cidades especificadas, ordenados por número de ocorrências.
CREATE VIEW vw_departamentos_roubo_2024 AS
SELECT
    dp.iddep,
    dp.disdep AS distrito,
    c.nomcid AS cidade,
    COUNT(o.idoco) AS total_ocorrencias
FROM
    departamento_policial dp
JOIN
    ocorrencia o ON dp.iddep = o.funcionariopessoaidpes
JOIN
    tipo_ocorrencia t ON o.tipo_ocorrenciaidtipoco = t.idtipoco
JOIN
    cidade c ON dp.cidadeidcid = c.idcid
WHERE
    t.desctipoco = 'Roubo'
    AND EXTRACT(YEAR FROM o.datoco) = 2024
    AND c.nomcid IN ('Maravilha', 'Descanso', 'Itapiranga', 'Guaraciaba')
GROUP BY
    dp.iddep, dp.disdep, c.nomcid
ORDER BY
    total_ocorrencias DESC;
--------------------------------------------------------------------------------------------------
-- 4. Total de ocorrências por tipo e cidade, ordenado da cidade com mais para menos ocorrências.
CREATE VIEW vw_ocorrencias_por_tipo_cidade AS
SELECT
    t.desctipoco AS tipo_ocorrencia,
    c.nomcid AS cidade,
    COUNT(o.idoco) AS total_ocorrencias
FROM
    ocorrencia o
JOIN
    tipo_ocorrencia t ON o.tipo_ocorrenciaidtipoco = t.idtipoco
JOIN
    cidade c ON o.cidadeidcid = c.idcid
GROUP BY
    t.desctipoco, c.nomcid
ORDER BY
    total_ocorrencias DESC;
