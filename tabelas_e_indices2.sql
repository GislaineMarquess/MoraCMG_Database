CREATE TABLE PESSOA (
	ra int NOT NULL,
	nome char(50) NOT NULL,
	curso char(30) NOT NULL,

	PRIMARY KEY (ra)
)

CREATE TABLE USUARIO (
	ra int NOT NULL,
	mudanca_imediata int NOT NULL, -- 1=sim / 0=não

	PRIMARY KEY (ra),
	FOREIGN KEY (ra) REFERENCES PESSOA
)

CREATE TABLE ADMINISTRADOR ( --Usuário administrador da moradia
	ra int NOT NULL,
	cod_moradia int NOT NULL,
	email char(30),

	PRIMARY KEY (ra),
	FOREIGN KEY (ra) REFERENCES PESSOA
	-- FOREIGN KEY (cod_moradia) REFERENCES MORADIA	
)

CREATE TABLE MORADIA(
	cod_moradia int IDENTITY,
	nome_moradia char(30) NOT NULL,
	qtd_moradores int,
	bio char(50),
	ra_adm int NOT NULL UNIQUE, -- FK
	vagas_disponiveis int NULL

	PRIMARY KEY (cod_moradia)
	FOREIGN KEY (ra_adm) REFERENCES ADMINISTRADOR
)

CREATE TABLE VAGAS(
	cod_moradia int NOT NULL,
	cod_vaga int IDENTITY, 
	tipo_vaga int NOT NULL, -- 0 = temporaria / 1 = permanente
	dt_criacao datetime, 
	dt_inicio date,

	PRIMARY KEY (cod_vaga),
	FOREIGN KEY (cod_moradia) REFERENCES MORADIA
)

CREATE TABLE VAGA_TEMPORARIA (
	cod_vaga int NOT NULL,
	data_final date, 
	valor_diaria money NULL,

	PRIMARY KEY (cod_vaga),
	FOREIGN KEY (cod_vaga) REFERENCES VAGAS
)

CREATE TABLE VAGA_PERMANENTE (
	cod_vaga int NOT NULL,
	aluguel money,
	contas money,
	valor_total money,
	pessoas_no_quarto int, -- campo para indicar se é vaga individual ou para dividir quarto

	PRIMARY KEY (cod_vaga),
	FOREIGN KEY (cod_vaga) REFERENCES VAGAS
)


CREATE TABLE APLICACOES (
	cod_aplicacao int NOT NULL,
	cod_vaga int NOT NULL,
	ra int NOT NULL,
	data_aplicacao DATETIME,

	PRIMARY KEY (cod_aplicacao),
	FOREIGN KEY (cod_vaga) references VAGAS,
	FOREIGN KEY (ra) references USUARIO
)

-- ÍNDICES (é bom revisar pq eu não sei direito o que to fazendo aqui)

CREATE UNIQUE INDEX index_ra_pessoa ON PESSOA (ra)
CREATE UNIQUE INDEX index_cod_aplicacao ON APLICACOES (cod_aplicacao)
CREATE UNIQUE INDEX index_cod_moradia ON MORADIA (cod_moradia)
CREATE INDEX ind_usuario_pessoa on USUARIO (ra)
CREATE INDEX ind_administrador_pessoa on ADMINISTRADOR (ra)
CREATE INDEX ind_moradia_administrador on MORADIA (ra_adm)
CREATE INDEX ind_vagatemporaria_vagas on VAGA_TEMPORARIA (cod_vaga)
CREATE INDEX ind_vagapermanente_vagas on VAGA_PERMANENTE (cod_vaga)
CREATE INDEX ind_aplicacoes_vagas on APLICACOES (cod_vaga)
CREATE INDEX ind_aplicacoes_usuario on APLICACOES (ra)
