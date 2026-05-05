-- Prefiro usar um CamelCase para escrever as linhas
-- Ja para as FKs, prefiro usar snake_case, pois fica mais facil de saber qual eh
-- Falando em FKs, elas tem uma estrutura legal, seria algo como fk_{tabela referenciada}_{tabela com a FK}_{espeficicacao}

CREATE DATABASE Alexandria_2;
USE Alexandria_2;

CREATE TABLE Pessoa (
	Cpf VARCHAR(15) NOT NULL,
		PRIMARY KEY(Cpf),
        
    NomeCompleto VARCHAR(60),
    DataDeNascimento DATE,
    Endereco VARCHAR(50) NOT NULL,
    Complemento VARCHAR(16) NOT NULL,
    Sexo VARCHAR(16),
    NumeroDeTelefone VARCHAR(11),
    Email VARCHAR(40),
    Deficiência VARCHAR(20)
);

CREATE TABLE Biblioteca (
	IdBiblioteca INT AUTO_INCREMENT NOT NULL,
		PRIMARY KEY(IdBiblioteca),
        
	Endereco VARCHAR(50) NOT NULL,
    CNPJ VARCHAR(14) NOT NULL,
    Nome VARCHAR(40),
    Tipo VARCHAR(20),
    Telefone VARCHAR(11),
	Email VARCHAR(30),
    Ano DATE,
    Observações VARCHAR(128)
);

CREATE TABLE Livro (
	Isbn VARCHAR(14) NOT NULL,
		PRIMARY KEY(Isbn),
        
    Titulo VARCHAR(30),
    Autores VARCHAR(50),
    Editora VARCHAR(30),
    AnoDePublicacao DATE,
    Paginas INT,
    Idioma VARCHAR(3),
    FaixaEtaria VARCHAR(2),
    Genero VARCHAR(20),
    Preco DECIMAL(8, 2),
    Sinopse VARCHAR(512),
    Detalhes VARCHAR(128)
);

CREATE TABLE Exemplar(
	IdExemplar INT AUTO_INCREMENT NOT NULL,
		PRIMARY KEY(IdExemplar),
	
    IdBiblioteca INT NOT NULL,
		CONSTRAINT fk_biblioteca_exemplar
			FOREIGN KEY(IdBiblioteca)
            REFERENCES Biblioteca(IdBiblioteca)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
	
	Isbn VARCHAR(14) NOT NULL,
		CONSTRAINT fk_livro_exemplar
			FOREIGN KEY(Isbn)
            REFERENCES Livro(Isbn),
            
	Quantidade INT,
    Condicao VARCHAR(20) NOT NULL
);

CREATE TABLE Funcionario(
	IdFuncionario INT AUTO_INCREMENT NOT NULL,
		PRIMARY KEY(IdFuncionario),
	
    IdBiblioteca INT NOT NULL,
		CONSTRAINT fk_biblioteca_funcionario
			FOREIGN KEY(IdBiblioteca)
            REFERENCES Biblioteca(IdBiblioteca)
            ON DELETE CASCADE
            ON UPDATE CASCADE,

	Cpf VARCHAR(15) NOT NULL,
		CONSTRAINT fk_pessoa_funcionario
        FOREIGN KEY(Cpf)
        REFERENCES Pessoa(Cpf)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
        
	DataDeAdmissao DATE NOT NULL,
    Cargo VARCHAR(20) NOT NULL
);

CREATE TABLE Leitor(
	Cpf VARCHAR(15) NOT NULL,
		CONSTRAINT fk_pessoa_leitor
        FOREIGN KEY(Cpf)
        REFERENCES Pessoa(Cpf)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    PRIMARY KEY(Cpf),

	NomeResponsavel VARCHAR(64)
);

CREATE TABLE CadastroDoLeitor(
	IdCadastro INT AUTO_INCREMENT NOT NULL,
		PRIMARY KEY(IdCadastro),
        
    IdBiblioteca INT NOT NULL,
		CONSTRAINT fk_biblioteca_cadastro
			FOREIGN KEY(IdBiblioteca)
            REFERENCES Biblioteca(IdBiblioteca)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
            
	Cpf VARCHAR(15) NOT NULL,
		CONSTRAINT fk_leitor_cadastro
        FOREIGN KEY(Cpf)
        REFERENCES Leitor(Cpf)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
        
	DataCadastro DATE,
    Comprovante VARCHAR(20),
    Aprovado VARCHAR(20)
);

CREATE TABLE Emprestimo(
	IdEmprestimo INT AUTO_INCREMENT NOT NULL,
		PRIMARY KEY(IdEmprestimo),
        
    IdCadastro INT NOT NULL,
		CONSTRAINT fk_cadastro_emprestimo
			FOREIGN KEY(IdCadastro)
            REFERENCES CadastroDoLeitor(IdCadastro),

	
    IdExemplar INT NOT NULL,
		CONSTRAINT fk_exemplar_emprestimo
        FOREIGN KEY(IdExemplar)
        REFERENCES Exemplar(IdExemplar)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
        
	DataDoAluguel DATE,
    DataDaDevolucao DATE,
    Categoria VARCHAR(30),
    
    IdUnidadeRetirada INT NOT NULL,
		CONSTRAINT fk_biblioteca_emprestimo_retirada
			FOREIGN KEY(IdUnidadeRetirada)
            REFERENCES Biblioteca(IdBiblioteca)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
            
    IdUnidadeDevolvida INT NOT NULL,
		CONSTRAINT fk_biblioteca_emprestimo_devolvida
			FOREIGN KEY(IdUnidadeDevolvida)
            REFERENCES Biblioteca(IdBiblioteca)
            ON DELETE CASCADE
            ON UPDATE CASCADE
);