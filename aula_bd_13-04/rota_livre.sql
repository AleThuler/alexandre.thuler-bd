CREATE DATABASE Rota_Livre; 
USE Rota_Livre;
DROP DATABASE Rota_Livre;

CREATE TABLE Manutencao (
	ID_manutencao INT AUTO_INCREMENT PRIMARY KEY,
	horario DATETIME,
	local_mecanico VARCHAR(64),
	preco DECIMAL(10, 2),
	procedimento VARCHAR(255) NOT NULL
);

CREATE TABLE Carro (
	ID_carro INT AUTO_INCREMENT PRIMARY KEY,
	placa_carro VARCHAR(8) NOT NULL,
	categoria VARCHAR(32),
	modelo VARCHAR(32),
	ano YEAR,
	status VARCHAR(16) NOT NULL,
	quilometragem INT
);

CREATE TABLE Carro_Manutencao (
	condicao_carro VARCHAR(255),
	fk_ID_manutencao INT NOT NULL,
	FOREIGN KEY (fk_ID_manutencao) REFERENCES Manutencao(ID_manutencao),
	fk_ID_carro INT NOT NULL,
	FOREIGN KEY (fk_ID_carro) REFERENCES Carro(ID_carro)
);


CREATE TABLE Cliente (
	ID_cliente INT AUTO_INCREMENT PRIMARY KEY,
	nome VARCHAR(64),
	numero_telefone VARCHAR(15),
	CNH VARCHAR(11) NOT NULL,
	CPF VARCHAR(16) NOT NULL,
	data_nascimento DATE
);

CREATE TABLE Contrato (
	ID_contrato INT AUTO_INCREMENT PRIMARY KEY,
	fk_ID_carro INT,
	FOREIGN KEY (fk_ID_carro) REFERENCES Carro(ID_carro),
	fk_ID_cliente INT,
	FOREIGN KEY (fk_ID_cliente) REFERENCES Cliente(ID_cliente),
	data DATE,
	devolucao DATETIME,
	preco DECIMAL(10, 2),
	pagamento VARCHAR(64),
	locadora VARCHAR(64)
);


CREATE TABLE Multa (
	ID_multa INT AUTO_INCREMENT PRIMARY KEY,
	fk_ID_contrato INT,
	FOREIGN KEY (fk_ID_contrato) REFERENCES Contrato(ID_contrato),
	data_hora DATETIME,
	orgao_emissor VARCHAR(64) NOT NULL,
	cidade VARCHAR(64),
	descricao VARCHAR(256)
);


CREATE TABLE Historico (
	ID_historico INT AUTO_INCREMENT PRIMARY KEY,
	fk_ID_contrato INT,
	FOREIGN KEY (fk_ID_contrato) REFERENCES Contrato(ID_contrato),
	data_criacao DATETIME,
	descricao VARCHAR(255),
	condicao_inicial VARCHAR(64),
	condicao_final VARCHAR(64)
);

INSERT INTO Cliente (nome, CPF, numero_telefone, CNH, data_nascimento) VALUES
('Ricardo Almeida Santos', '123.456.789-01', '(11) 98765-4321', '12345678901', '1985-05-15'),
('Beatriz Ferreira Lima', '234.567.890-12', '(21) 99888-7766', '23456789012', '1992-10-22'),
('Marcos Oliveira Souza', '345.678.901-23', '(31) 97777-6655', '34567890123', '1978-03-30'),
('Ana Julia Castro', '456.789.012-34', '(47) 99122-3344', '45678901234', '2000-07-12'),
('Thiago Mendes Rocha', '567.890.123-45', '(61) 98111-2233', '56789012345', '1988-12-05'),
('Carla Cavalcante', '678.901.234-56', '(85) 99444-5566', '67890123456', '1995-08-25');

INSERT INTO Manutencao (horario, local_mecanico, preco, procedimento) VALUES
('2026-01-10 09:00:00', 'Oficina do Zé', 450.00, 'Troca de óleo e filtros'),
('2026-01-15 14:30:00', 'Centro Automotivo Porto', 1200.00, 'Substituição de pastilhas e discos de freio'),
('2026-02-05 10:00:00', 'Pneus Online', 1800.00, 'Alinhamento, balanceamento e 2 pneus novos'),
('2026-02-20 08:00:00', 'Auto Elétrica Faísca', 350.00, 'Troca de bateria e revisão de alternador'),
('2026-03-02 11:00:00', 'Funilaria Express', 950.00, 'Martelinho de ouro na porta traseira'),
('2026-03-28 16:00:00', 'Concessionária Autorizada', 2500.00, 'Revisão completa de 40.000km');

INSERT INTO Carro (placa_carro, categoria, modelo, ano, status, quilometragem) VALUES
('ABC-1234', 'Hatch', 'Chevrolet Onix', 2023, 'Disponível', 15200),
('DEF-5678', 'Sedan', 'Toyota Corolla', 2022, 'Alugado', 42000),
('GHI-9012', 'SUV', 'Jeep Compass', 2024, 'Manutenção', 5000),
('JKL-3456', 'Hatch', 'Hyundai HB20', 2021, 'Disponível', 68000),
('MNO-7890', 'Sedan', 'Volkswagen Virtus', 2023, 'Disponível', 22500),
('PQR-1122', 'SUV', 'Fiat Fastback', 2024, 'Alugado', 8900);

INSERT INTO Contrato (fk_ID_cliente, fk_ID_carro, data, devolucao, preco, pagamento, locadora) VALUES
(1, 2, '2026-03-01', '2026-03-07', 1200.00, 'Cartão de Crédito', 'Rota Livre Matriz'),
(2, 6, '2026-03-10', '2026-03-15', 2500.00, 'Pix', 'Rota Livre Matriz'),
(3, 1, '2026-03-20', '2026-03-22', 450.00, 'Dinheiro', 'Filial Aeroporto'),
(4, 5, '2026-03-25', '2026-03-30', 1100.00, 'Cartão de Débito', 'Rota Livre Matriz'),
(5, 4, '2026-03-28', '2026-04-05', 1800.00, 'Cartão de Crédito', 'Filial Centro'),
(6, 2, '2026-04-10', '2026-04-15', 1350.00, 'Pix', 'Rota Livre Matriz');

INSERT INTO Multa (fk_ID_contrato, data_hora, descricao, orgao_emissor, cidade) VALUES
(1, '2026-03-03 14:20:00', 'Excesso de velocidade (até 20%)', 'PRF', 'Curitiba'),
(2, '2026-03-12 09:15:00', 'Avanço de sinal vermelho', 'CET', 'São Paulo'),
(4, '2026-03-27 18:45:00', 'Estacionar em local proibido', 'DSV', 'Rio de Janeiro'),
(2, '2026-03-14 22:10:00', 'Conduzir veículo utilizando celular', 'DETRAN', 'São Paulo'),
(6, '2026-04-12 11:30:00', 'Não uso do cinto de segurança', 'PRF', 'Barueri'),
(5, '2026-03-30 16:00:00', 'Transitar em faixa exclusiva de ônibus', 'SPTrans', 'São Paulo');


INSERT INTO Historico (fk_ID_contrato, data_criacao, descricao, condicao_inicial, condicao_final) VALUES
(1, '2026-03-01', 'Retirada para viagem a trabalho', 'Impecável', 'Sujeira interna leve'),
(2, '2026-03-10', 'Locação executiva', 'Novo', 'Risco pequeno no para-choque'),
(3, '2026-03-20', 'Uso urbano final de semana', 'Bom estado', 'Pneu reserva utilizado'),
(4, '2026-03-25', 'Viagem litoral', 'Limpíssimo', 'Vestígios de areia no carpete'),
(5, '2026-03-28', 'Substituição de veículo próprio', 'Excelente', 'Impecável'),
(6, '2026-04-10', 'Locação para evento', 'Excelente', 'Luz de injeção acesa no painel');

SELECT * FROM Multa;
SELECT * FROM Carro;
SELECT modelo FROM Carro WHERE categoria = 'SUV';
SELECT fk_ID_contrato, cidade FROM Multa WHERE data_hora < '2026-03-20';
SELECT fk_ID_cliente FROM Contrato WHERE ID_contrato =1 OR ID_contrato =2;
SELECT nome, CPF FROM Cliente WHERE ID_cliente = 1 OR ID_cliente = 2;
SELECT * FROM Carro WHERE quilometragem >30000;
SELECT * FROM Contrato WHERE preco < 1200;
SELECT placa_carro FROM Carro WHERE ano > 2023;
SELECT * FROM Contrato WHERE pagamento = 'Pix';
SELECT * FROM Manutencao WHERE local_mecanico LIKE 'c%';
SELECT * FROM Cliente WHERE nome BETWEEN 'A%' AND 'C%';
SELECT * FROM Contrato ORDER BY fk_ID_carro;
SELECT descricao FROM Multa WHERE cidade = 'São Paulo';
SELECT nome, data_nascimento FROM Cliente WHERE data_nascimento < '1995-01-01';
SELECT modelo, placa_carro FROM Carro WHERE status = 'Disponível';
SELECT local_mecanico, procedimento, preco FROM Manutencao WHERE preco > 1000;
SELECT * FROM Contrato WHERE locadora = 'Filial Aeroporto';
SELECT condicao_inicial, condicao_final FROM Historico WHERE fk_ID_contrato = 1;
SELECT * FROM Carro ORDER BY ano DESC;








