CREATE DATABASE universidade;
USE universidade;

CREATE TABLE departamento (
    id_departamento INT NOT NULL,
    nome VARCHAR(45),
    campus VARCHAR(45),
    coordenador_id INT,
    PRIMARY KEY (id_departamento)
);

CREATE TABLE professor (
    id_professor INT NOT NULL,
    nome VARCHAR(45),
    titulacao VARCHAR(45),
    data_admissao DATE,
    regime_trabalho VARCHAR(45),
    departamento_id INT,
    PRIMARY KEY (id_professor),
    CONSTRAINT fk_professor_departamento
        FOREIGN KEY (departamento_id)
        REFERENCES departamento (id_departamento)
);

ALTER TABLE departamento
ADD CONSTRAINT fk_departamento_coordenador
FOREIGN KEY (coordenador_id)
REFERENCES professor (id_professor);

CREATE TABLE curso (
    id_curso INT NOT NULL,
    nome VARCHAR(45),
    tipo_graduacao VARCHAR(45),
    turno VARCHAR(45),
    departamento_id INT,
    PRIMARY KEY (id_curso),
    CONSTRAINT fk_curso_departamento
        FOREIGN KEY (departamento_id)
        REFERENCES departamento (id_departamento)
);

CREATE TABLE disciplina (
    id_disciplina INT NOT NULL,
    nome VARCHAR(45),
    carga_horaria INT,
    tipo_disciplina VARCHAR(45),
    professor_id INT,
    PRIMARY KEY (id_disciplina),
    CONSTRAINT fk_disciplina_professor
        FOREIGN KEY (professor_id)
        REFERENCES professor (id_professor)
);

CREATE TABLE aluno (
    id_aluno INT NOT NULL,
    nome VARCHAR(45),
    sobrenome VARCHAR(45),
    data_nascimento DATE,
    sexo VARCHAR(45),
    PRIMARY KEY (id_aluno)
);

CREATE TABLE pre_requisitos (
    id_pre_requisitos INT NOT NULL,
    descricao VARCHAR(45),
    PRIMARY KEY (id_pre_requisitos)
);

CREATE TABLE matriculado (
    aluno_id INT NOT NULL,
    disciplina_id INT NOT NULL,
    semestre INT NOT NULL,
    ano YEAR NOT NULL,
    nota_final DECIMAL(10,2),
    frequencia INT,
    situacao VARCHAR(45),
    PRIMARY KEY (aluno_id, disciplina_id, semestre, ano),
    CONSTRAINT fk_matricula_aluno
        FOREIGN KEY (aluno_id)
        REFERENCES aluno (id_aluno),
    CONSTRAINT fk_matricula_disciplina
        FOREIGN KEY (disciplina_id)
        REFERENCES disciplina (id_disciplina)
);

CREATE TABLE disciplina_curso (
    disciplina_id INT NOT NULL,
    curso_id INT NOT NULL,
    PRIMARY KEY (disciplina_id, curso_id),
    CONSTRAINT fk_disc_curso_disciplina
        FOREIGN KEY (disciplina_id)
        REFERENCES disciplina (id_disciplina),
    CONSTRAINT fk_disc_curso_curso
        FOREIGN KEY (curso_id)
        REFERENCES curso (id_curso)
);

CREATE TABLE disciplina_pre_requisito (
    disciplina_id INT NOT NULL,
    pre_requisito_id INT NOT NULL,
    PRIMARY KEY (disciplina_id, pre_requisito_id),
    CONSTRAINT fk_pre_req_disciplina
        FOREIGN KEY (disciplina_id)
        REFERENCES disciplina (id_disciplina),
    CONSTRAINT fk_pre_req_requisito
        FOREIGN KEY (pre_requisito_id)
        REFERENCES pre_requisitos (id_pre_requisitos)
);

INSERT INTO departamento (id_departamento, nome, campus, coordenador_id) VALUES
(1, 'Tecnologia da Informação', 'Campus Norte', NULL),
(2, 'Engenharia Civil', 'Campus Norte', NULL),
(3, 'Ciências Biológicas', 'Campus Sul', NULL),
(4, 'Administração e Negócios', 'Campus Sul', NULL);

INSERT INTO professor (id_professor, nome, titulacao, data_admissao, regime_trabalho, departamento_id) VALUES
(10, 'Ricardo Oliveira', 'Doutor', '2015-03-10', 'Dedicação Exclusiva', 1),
(11, 'Fernanda Costa', 'Mestre', '2018-08-15', '40h', 1),
(12, 'Marcos Silva', 'Doutor', '2010-02-01', 'Dedicação Exclusiva', 2),
(13, 'Ana Beatriz', 'Mestre', '2021-01-20', '20h', 3),
(14, 'Carlos Souza', 'Especialista', '2022-05-12', '20h', 4),
(15, 'Juliana Mendes', 'Doutor', '2017-11-30', '40h', 3),
(16, 'Flavia Silva', 'Doutor', '2015-03-10', 'Dedicação Exclusiva', 1),
(17, 'Roberto de Souza', 'Doutor', '2012-04-10', 'Dedicação Exclusiva', 2),
(18, 'Aline Meireles', 'Mestre', '2019-07-22', '40h', 4),
(19, 'Patrícia Antunes', 'Doutor', '2016-02-15', 'Dedicação Exclusiva', 3),
(20, 'Gustavo Lima', 'Mestre', '2020-09-01', '20h', 1);

UPDATE departamento SET coordenador_id = 10 WHERE id_departamento = 1;
UPDATE departamento SET coordenador_id = 12 WHERE id_departamento = 2;
UPDATE departamento SET coordenador_id = 15 WHERE id_departamento = 3;
UPDATE departamento SET coordenador_id = 14 WHERE id_departamento = 4;

INSERT INTO curso (id_curso, nome, tipo_graduacao, turno, departamento_id) VALUES
(100, 'Sistemas de Informação', 'Bacharelado', 'Noturno', 1),
(101, 'Ciência da Computação', 'Bacharelado', 'Integral', 1),
(102, 'Engenharia Civil', 'Bacharelado', 'Integral', 2),
(103, 'Biologia', 'Licenciatura', 'Matutino', 3),
(104, 'Gestão Comercial', 'Tecnólogo', 'Noturno', 4);

INSERT INTO disciplina (id_disciplina, nome, carga_horaria, tipo_disciplina, professor_id) VALUES
(501, 'Banco de Dados', 80, 'Teórica', 10),       
(502, 'Programação Web', 60, 'Prática', 11),       
(503, 'Cálculo Estrutural', 80, 'Teórica', 12),   
(504, 'Genética', 40, 'Teórica', 13),             
(505, 'Microbiologia', 60, 'Prática', 15),         
(506, 'Matemática Financeira', 40, 'Teórica', 14), 
(507, 'Estrutura de Dados', 60, 'Prática', 10),    
(508, 'Algoritmos Avançados', 80, 'Prática', 10), 
(509, 'Interface Humano-Computador', 40, 'Teórica', 11),
(510, 'Resistência dos Materiais', 80, 'Teórica', 12),   
(511, 'Estatística Aplicada', 60, 'Teórica', 14),
(512, 'Banco de Dados', 80, 'Prática consultas SQLs', 16),
(513, 'Inteligência Artificial', 80, 'Teórica/Prática', 10),
(514, 'Sistemas Operacionais', 60, 'Teórica', 20),
(515, 'Mecânica dos Solos', 80, 'Prática', 17),
(516, 'Introdução à Economia', 40, 'Teórica', 18),
(517, 'Bioquímica', 60, 'Prática', 19);

INSERT INTO aluno (id_aluno, nome, sobrenome, data_nascimento, sexo) VALUES
(1001, 'Lucas', 'Moraes', '2002-05-15', 'M'),
(1002, 'Bia', 'Ferreira', '2001-10-22', 'F'),
(1003, 'Pedro', 'Gomes', '2003-01-12', 'M'),
(1004, 'Carla', 'Dias', '2000-08-30', 'F'),
(1005, 'Igor', 'Santos', '2002-03-14', 'M'),
(1006, 'Fernanda', 'Lima', '2001-04-12', 'F'),
(1007, 'Rodrigo', 'Alves', '2003-09-18', 'M'),
(1008, 'Amanda', 'Rocha', '2002-11-05', 'F'),
(1009, 'Gabriel', 'Nunes', '2000-06-21', 'M'),
(1010, 'Larissa', 'Teixeira', '2004-02-14', 'F'),
(1011, 'Lucas', 'Ribeiro', '2001-07-19', 'M'),
(1012, 'Beatriz', 'Pinheiro', '2002-05-30', 'F'),
(1013, 'Matheus', 'Barbosa', '2003-12-01', 'M'),
(1014, 'Camila', 'Cardoso', '2000-01-25', 'F'),
(1015, 'Thiago', 'Araújo', '2002-08-11', 'M'),
(1016, 'Bruna', 'Carvalho', '2003-03-22', 'F'),
(1017, 'Felipe', 'Martins', '2001-10-09', 'M'),
(1018, 'Letícia', 'Vieira', '2004-05-04', 'F'),
(1019, 'Vinícius', 'Machado', '2002-07-15', 'M'),
(1020, 'Isabela', 'Freitas', '1999-12-12', 'F'),
(1021, 'Leonardo', 'Dias', '2003-04-02', 'M'),
(1022, 'Mariana', 'Castro', '2001-09-27', 'F'),
(1023, 'Daniel', 'Pinto', '2002-11-11', 'M'),
(1024, 'Gabriela', 'Melo', '2000-03-08', 'F'),
(1025, 'Eduardo', 'Santos', '2003-06-17', 'M');

INSERT INTO matriculado (aluno_id, disciplina_id, semestre, ano, nota_final, frequencia, situacao) VALUES
(1006, 501, 1, 2024, 7.5, 85, 'Aprovado'),
(1007, 501, 1, 2024, 4.2, 78, 'Reprovado'),
(1008, 503, 1, 2024, 8.0, 90, 'Aprovado'),
(1009, 504, 1, 2024, 9.5, 100, 'Aprovado'),
(1010, 506, 1, 2024, 5.5, 60, 'Reprovado'),
(1011, 502, 1, 2024, 6.8, 76, 'Aprovado'),
(1012, 502, 1, 2024, 3.0, 80, 'Reprovado'),
(1013, 503, 1, 2024, 7.2, 92, 'Aprovado'),
(1014, 504, 1, 2024, 8.7, 95, 'Aprovado'),
(1015, 506, 1, 2024, 6.0, 75, 'Aprovado'),
(1003, 501, 1, 2024, 0.0, 10, 'Desistente'),
(1004, 502, 1, 2024, 1.5, 25, 'Desistente'),
(1006, 502, 2, 2024, 8.2, 94, 'Aprovado'),
(1007, 501, 2, 2024, 7.0, 88, 'Aprovado'),
(1008, 510, 2, 2024, 9.0, 98, 'Aprovado'),
(1009, 505, 2, 2024, 4.5, 82, 'Reprovado'),
(1010, 506, 2, 2024, 7.5, 85, 'Aprovado'),
(1016, 511, 2, 2024, 8.0, 90, 'Aprovado'),
(1017, 511, 2, 2024, 5.0, 70, 'Reprovado'),
(1018, 507, 2, 2024, 6.5, 75, 'Aprovado'),
(1019, 507, 2, 2024, 2.1, 50, 'Reprovado'),
(1020, 516, 2, 2024, 9.8, 100, 'Aprovado'),
(1012, 507, 2, 2024, 0.0, 5,  'Desistente'),
(1015, 516, 2, 2024, 0.5, 12, 'Desistente'),
(1006, 507, 1, 2025, 7.9, 88, 'Aprovado'),
(1007, 502, 1, 2025, 6.2, 80, 'Aprovado'),
(1008, 515, 1, 2025, 8.5, 95, 'Aprovado'),
(1009, 505, 1, 2025, 7.3, 90, 'Aprovado'),
(1011, 508, 1, 2025, 4.0, 75, 'Reprovado'),
(1012, 501, 1, 2025, 8.0, 92, 'Aprovado'),
(1013, 510, 1, 2025, 5.8, 85, 'Reprovado'),
(1014, 517, 1, 2025, 9.1, 98, 'Aprovado'),
(1015, 516, 1, 2025, 7.0, 80, 'Aprovado'),
(1021, 501, 1, 2025, 6.7, 86, 'Aprovado'),
(1022, 504, 1, 2025, 8.3, 94, 'Aprovado'),
(1023, 506, 1, 2025, 3.5, 55, 'Reprovado'),
(1024, 516, 1, 2025, 10.0, 100, 'Aprovado'),
(1025, 503, 1, 2025, 7.0, 88, 'Aprovado'),
(1018, 515, 1, 2025, 0.5, 22, 'Desistente'), 
(1006, 513, 2, 2025, 9.2, 96, 'Aprovado'),
(1007, 508, 2, 2025, 7.1, 85, 'Aprovado'),
(1011, 508, 2, 2025, 6.5, 80, 'Aprovado'),
(1013, 510, 2, 2025, 7.5, 90, 'Aprovado'),
(1017, 511, 2, 2025, 7.0, 85, 'Aprovado'),
(1019, 507, 2, 2025, 6.0, 78, 'Aprovado'),
(1021, 509, 2, 2025, 8.5, 92, 'Aprovado'),
(1022, 517, 2, 2025, 5.4, 82, 'Reprovado'),
(1023, 506, 2, 2025, 6.2, 76, 'Aprovado'),
(1025, 515, 2, 2025, 8.0, 93, 'Aprovado'),
(1002, 509, 2, 2025, 0.0, 0,  'Desistente'),
(1005, 517, 2, 2025, 1.1, 18, 'Desistente'),
(1001, 503, 1, 2026, 10.0, 100, 'Aprovado'),
(1002, 505, 1, 2026, 8.0, 92, 'Aprovado'),
(1003, 508, 1, 2026, 6.5, 80, 'Aprovado'),
(1004, 505, 1, 2026, 9.5, 98, 'Aprovado'),
(1005, 511, 1, 2026, 8.2, 94, 'Aprovado'),
(1006, 514, 1, 2026, 8.8, 90, 'Aprovado'),
(1007, 513, 1, 2026, 6.9, 84, 'Aprovado'),
(1008, 511, 1, 2026, 9.5, 100, 'Aprovado'),
(1009, 517, 1, 2026, 7.4, 89, 'Aprovado'),
(1010, 516, 1, 2026, 8.1, 91, 'Aprovado'),
(1011, 513, 1, 2026, 5.2, 80, 'Reprovado'),
(1012, 509, 1, 2026, 7.7, 88, 'Aprovado'),
(1014, 505, 1, 2026, 9.0, 95, 'Aprovado'),
(1015, 511, 1, 2026, 6.3, 79, 'Aprovado'),
(1016, 506, 1, 2026, 4.0, 63, 'Reprovado'),
(1018, 511, 1, 2026, 8.2, 92, 'Aprovado'),
(1020, 511, 1, 2026, 9.6, 98, 'Aprovado'),
(1022, 517, 1, 2026, 7.0, 87, 'Aprovado'),
(1024, 511, 1, 2026, 8.9, 94, 'Aprovado'),
(1001, 508, 2, 2026, 9.5, 98, 'Aprovado'),
(1002, 511, 2, 2026, 3.5, 60, 'Reprovado'),
(1003, 501, 2, 2026, 8.0, 90, 'Aprovado'),
(1004, 506, 2, 2026, 7.8, 85, 'Aprovado'),
(1021, 508, 2, 2026, 0.0, 10, 'Desistente'),
(1023, 501, 2, 2026, 0.0, 0,  'Desistente');

INSERT INTO disciplina_curso (disciplina_id, curso_id) VALUES
(501, 100), 
(501, 101),
(502, 101),
(503, 102),
(504, 103),
(505, 103),
(506, 104),
(507, 100),
(508, 101),
(509, 100),
(510, 102),
(511, 100), 
(511, 104),
(513, 101),
(514, 100),
(515, 102),
(516, 104),
(517, 103);

INSERT INTO pre_requisitos (id_pre_requisitos, descricao) VALUES
(1, 'Lógica de Programação'),
(2, 'Cálculo Diferencial');

INSERT INTO disciplina_pre_requisito (disciplina_id, pre_requisito_id) VALUES
(502, 1),
(503, 2),
(508, 1);

