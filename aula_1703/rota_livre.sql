CREATE DATABASE Rota_Livre;
USE Rota_Livre;

CREATE TABLE Manutencao (
	ID_manutencao INT AUTO_INCREMENT PRIMARY KEY,
	horario DATETIME,
	local_mecanico VARCHAR(64),
	preco DECIMAL(10, 2),
	procedimento VARCHAR(255) NOT NULL
);

DESCRIBE Historico;

CREATE TABLE Carro_Manutencao (
	condicao_carro VARCHAR(255)
);

ALTER TABLE Carro_Manutencao ADD COLUMN fk_ID_manutencao INT;

ALTER TABLE Carro_Manutencao ADD FOREIGN KEY (fk_ID_carro) REFERENCES Carro(ID_carro);
ALTER TABLE Carro_Manutencao ADD FOREIGN KEY (fk_ID_manutencao) REFERENCES Manutencao(ID_manutencao);

CREATE TABLE Carro (
	ID_carro INT AUTO_INCREMENT PRIMARY KEY,
	placa_carro VARCHAR(7) NOT NULL,
	categoria VARCHAR(32),
	modelo VARCHAR(32),
	ano YEAR,
	status VARCHAR(16) NOT NULL,
	quilometragem INT
);

CREATE TABLE Contrato (
	ID_contrato INT AUTO_INCREMENT PRIMARY KEY,
	data DATE,
	devolucao DATETIME,
	preco DECIMAL(10, 2),
	pagamento VARCHAR(16),
	locadora VARCHAR(64)
);

ALTER TABLE Contrato ADD COLUMN fk_ID_carro INT;
ALTER TABLE Contrato ADD FOREIGN KEY (fk_ID_carro) REFERENCES Carro(ID_carro);

ALTER TABLE Contrato ADD COLUMN fk_ID_cliente INT;
ALTER TABLE Contrato ADD FOREIGN KEY (fk_ID_cliente) REFERENCES Cliente(ID_cliente);

CREATE TABLE Multa (
	ID_multa INT AUTO_INCREMENT PRIMARY KEY,
	fk_ID_contrato INT,
	data_hota DATETIME,
	orgao_emissor VARCHAR(64) NOT NULL,
	cidade VARCHAR(64)
);

ALTER TABLE Multa ADD COLUMN descricao VARCHAR(256);
ALTER TABLE Multa ADD FOREIGN KEY (fk_ID_contrato) REFERENCES Contrato(ID_contrato);

CREATE TABLE Cliente (
	ID_cliente INT AUTO_INCREMENT PRIMARY KEY,
	nome VARCHAR(64),
	numero_telefone VARCHAR(11),
	CHN VARCHAR(9) NOT NULL,
	CPF VARCHAR(11),
	data_nascimento DATE
);

ALTER TABLE Cliente MODIFY CPF VARCHAR(11) NOT NULL;

CREATE TABLE Historico (
	ID_historico INT AUTO_INCREMENT PRIMARY KEY,
	fk_ID_contrato INT,
	data_criacao DATETIME,
	descricao VARCHAR(255),
	condicao_inicial VARCHAR(64),
	condicao_final VARCHAR(64)
);

ALTER TABLE Historico ADD FOREIGN KEY (fk_ID_contrato) REFERENCES Contrato(ID_contrato);



