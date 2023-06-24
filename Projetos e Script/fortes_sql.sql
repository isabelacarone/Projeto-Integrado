-- Criando tabela habilidades e fazendo os comentários pertinentes.
CREATE TABLE habilidades (
                id_habilidade NUMERIC(10) NOT NULL,
                hard_skills VARCHAR(252) NOT NULL,
                soft_skills VARCHAR(252) NOT NULL,
                CONSTRAINT habilidades_pk PRIMARY KEY (id_habilidade)
);
COMMENT ON TABLE habilidades IS 'Tabela referente as habilidades dos funcionários.';
COMMENT ON COLUMN habilidades.id_habilidade IS 'Id das habilidades';
COMMENT ON COLUMN habilidades.hard_skills IS 'Coluna referente as hard skills que um funcionário pode ter.';
COMMENT ON COLUMN habilidades.soft_skills IS 'Coluna referente as soft skills que um funcionário pode ter.';


-- Criando tabela funcionarios e fazendo os comentários pertinentes.


CREATE TABLE funcionarios (
                id_funcionario CHAR(12) NOT NULL,
                nome VARCHAR(252) NOT NULL,
                data_contratacao DATE NOT NULL,
                data_nascimento DATE NOT NULL,
                cargo VARCHAR(12) NOT NULL,
                departamento VARCHAR(12) NOT NULL,
                gestor_id CHAR(12),
                CONSTRAINT funcionarios_pk PRIMARY KEY (id_funcionario)
);
COMMENT ON TABLE funcionarios IS 'Tabela para registro dos funcionários.';
COMMENT ON COLUMN funcionarios.id_funcionario IS 'Coluna para identificação do funcionário.';
COMMENT ON COLUMN funcionarios.nome IS 'Nome completo do funcionário.';
COMMENT ON COLUMN funcionarios.data_contratacao IS 'Data de contratação do funcionário.';
COMMENT ON COLUMN funcionarios.data_nascimento IS 'Data de nascimento do funcionário.';
COMMENT ON COLUMN funcionarios.cargo IS 'Cargo do funcionário.';
COMMENT ON COLUMN funcionarios.departamento IS 'Departamento no qual o funcionário trabalha.';
COMMENT ON COLUMN funcionarios.gestor_id IS 'Coluna para identificação do funcionário que é gestor.';


-- Criando tabela habilidades_funcionarios e fazendo os comentários pertinentes.


CREATE TABLE habilidades_funcionarios (
                id_habilidade NUMERIC(10) NOT NULL,
                id_funcionario CHAR(12) NOT NULL,
                CONSTRAINT habilidades_funcionarios_pk PRIMARY KEY (id_habilidade, id_funcionario)
);
COMMENT ON TABLE habilidades_funcionarios IS 'Tabela referente as skills que um funcionário tem.';
COMMENT ON COLUMN habilidades_funcionarios.id_habilidade IS 'Id das habilidades';
COMMENT ON COLUMN habilidades_funcionarios.id_funcionario IS 'Coluna para identificação do funcionário.';


-- Criando tabela informacoes_adicionais e fazendo os comentários pertinentes.


CREATE TABLE informacoes_adicionais (
                id_funcionario CHAR(12) NOT NULL,
                informacoes_adicionais BYTEA NOT NULL,
                CONSTRAINT informacoes_adicionais_pk PRIMARY KEY (id_funcionario, informacoes_adicionais)
);
COMMENT ON TABLE informacoes_adicionais IS 'informacoes adicionais dos funcionarios';
COMMENT ON COLUMN informacoes_adicionais.id_funcionario IS 'Coluna para identificação do funcionário.';
COMMENT ON COLUMN informacoes_adicionais.informacoes_adicionais IS 'informações adicionais dos funcionários.';


-- Criando tabela enderecos e fazendo os comentários pertinentes.


CREATE TABLE enderecos (
                id_endereco NUMERIC(5) NOT NULL,
                id_funcionario CHAR(12) NOT NULL,
                cep NUMERIC(15) NOT NULL,
                numero VARCHAR(10) NOT NULL,
                complemento VARCHAR(252),
                CONSTRAINT enderecos_pk PRIMARY KEY (id_endereco, id_funcionario)
);
COMMENT ON TABLE enderecos IS 'enderecos dos funcionarios';
COMMENT ON COLUMN enderecos.id_endereco IS 'id dos endereços dos alunos';
COMMENT ON COLUMN enderecos.id_funcionario IS 'Coluna para identificação do funcionário.';
COMMENT ON COLUMN enderecos.cep IS 'cep dos endereços. Idealmente FK de uma tabela de validação dos correios.';
COMMENT ON COLUMN enderecos.numero IS 'número do endereço';
COMMENT ON COLUMN enderecos.complemento IS 'complemento do endereço';


-- Criando tabela telefones e fazendo os comentários pertinentes.


CREATE TABLE telefones (
                telefone NUMERIC(20) NOT NULL,
                id_funcionario CHAR(12) NOT NULL,
                CONSTRAINT telefones_pk PRIMARY KEY (telefone, id_funcionario)
);
COMMENT ON TABLE telefones IS 'tabela de telefones dos funcionarios';
COMMENT ON COLUMN telefones.telefone IS 'telefones dos funcionários';
COMMENT ON COLUMN telefones.id_funcionario IS 'Coluna para identificação do funcionário.';


-- Criando tabela atividades e fazendo os comentários pertinentes.


CREATE TABLE atividades (
                atividade_id VARCHAR(12) NOT NULL,
                tipo VARCHAR(252) NOT NULL,
                data_de_realizacao DATE NOT NULL,
                quantidade_participantes NUMERIC(4) NOT NULL,
                gestor_responsavel CHAR(12) NOT NULL,
                CONSTRAINT atividades_pk PRIMARY KEY (atividade_id)
);
COMMENT ON TABLE atividades IS 'Tabela para a organização dos dados das atividades realizadas.';
COMMENT ON COLUMN atividades.atividade_id IS 'ID da atividade.';
COMMENT ON COLUMN atividades.tipo IS 'Tipo de atividade que está sendo realizada.';
COMMENT ON COLUMN atividades.data_de_realizacao IS 'Data de realização da atividade.';
COMMENT ON COLUMN atividades.quantidade_participantes IS 'Quantidade de participantes para a atividade.';
COMMENT ON COLUMN atividades.gestor_responsavel IS 'Coluna para identificação do funcionário.';


-- Criando tabela banco_de_talentos e fazendo os comentários pertinentes.


CREATE TABLE banco_de_talentos (
                id_funcionario CHAR(12) NOT NULL,
                atividade_id VARCHAR(12) NOT NULL,
                dados_atividades BYTEA NOT NULL,
                estatisticas_pessoais BYTEA NOT NULL,
                obs_gestao BYTEA NOT NULL,
                CONSTRAINT banco_de_talentos_pk PRIMARY KEY (id_funcionario, atividade_id)
);
COMMENT ON TABLE banco_de_talentos IS 'Banco de talentos para os funcionários.';
COMMENT ON COLUMN banco_de_talentos.id_funcionario IS 'Coluna para identificação do funcionário.';
COMMENT ON COLUMN banco_de_talentos.atividade_id IS 'ID da atividade.';
COMMENT ON COLUMN banco_de_talentos.dados_atividades IS 'Arquivo com os dados coletados nas atividades.';
COMMENT ON COLUMN banco_de_talentos.estatisticas_pessoais IS 'Arquivo com as estatísticas pessoais de cada funcionário com base na atividade.';
COMMENT ON COLUMN banco_de_talentos.obs_gestao IS 'Observações que a gestão têm a adicionar ao funcionário em função da atividade.';


-- Criando as relações (PK, FK, PFK) para as tabelas relacionadas no projeto lógico.


ALTER TABLE habilidades_funcionarios ADD CONSTRAINT habilidades_habilidades_funcionarios_fk
FOREIGN KEY (id_habilidade)
REFERENCES habilidades (id_habilidade)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE funcionarios ADD CONSTRAINT funcionarios_funcionarios_fk
FOREIGN KEY (gestor_id)
REFERENCES funcionarios (id_funcionario)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE atividades ADD CONSTRAINT funcionarios_atividades_fk
FOREIGN KEY (gestor_responsavel)
REFERENCES funcionarios (id_funcionario)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE banco_de_talentos ADD CONSTRAINT funcionarios_banco_de_talentos_fk
FOREIGN KEY (id_funcionario)
REFERENCES funcionarios (id_funcionario)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE telefones ADD CONSTRAINT funcionarios_telefones_fk
FOREIGN KEY (id_funcionario)
REFERENCES funcionarios (id_funcionario)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE enderecos ADD CONSTRAINT funcionarios_enderecos_fk
FOREIGN KEY (id_funcionario)
REFERENCES funcionarios (id_funcionario)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE informacoes_adicionais ADD CONSTRAINT funcionarios_informacoes_adicionais_fk
FOREIGN KEY (id_funcionario)
REFERENCES funcionarios (id_funcionario)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE habilidades_funcionarios ADD CONSTRAINT funcionarios_habilidades_funcionarios_fk
FOREIGN KEY (id_funcionario)
REFERENCES funcionarios (id_funcionario)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE banco_de_talentos ADD CONSTRAINT atividades_banco_de_talentos_fk
FOREIGN KEY (atividade_id)
REFERENCES atividades (atividade_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;


-- Como os dados são específicos e não possuem fator de ambiguidade, não houve a necessidade de adicionar constraints.