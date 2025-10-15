
-- Banco de Dados: academico
-- Compatível com MySQL 8+

CREATE DATABASE IF NOT EXISTS academico
  DEFAULT CHARACTER SET utf8mb4
  COLLATE utf8mb4_0900_ai_ci;

USE academico;

-- =======================
-- Tabela: alunos
-- =======================
DROP TABLE IF EXISTS matriculas;
DROP TABLE IF EXISTS alunos;
DROP TABLE IF EXISTS cursos;

CREATE TABLE alunos (
  aluno_id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  email VARCHAR(120) UNIQUE,
  data_nascimento DATE,
  cidade VARCHAR(80),
  nota_media DECIMAL(4,2) DEFAULT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX idx_alunos_cidade (cidade)
);

-- =======================
-- Tabela: cursos
-- =======================
CREATE TABLE cursos (
  curso_id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(120) NOT NULL,
  area VARCHAR(60) NOT NULL,
  carga_horaria INT NOT NULL,
  preco DECIMAL(10,2) NOT NULL,
  ativo TINYINT(1) DEFAULT 1
);

-- =======================
-- Tabela: matriculas
-- =======================
CREATE TABLE matriculas (
  matricula_id INT AUTO_INCREMENT PRIMARY KEY,
  aluno_id INT NOT NULL,
  curso_id INT NOT NULL,
  data_matricula DATE NOT NULL,
  status ENUM('Ativa','Concluída','Trancada','Cancelada') NOT NULL DEFAULT 'Ativa',
  nota_final DECIMAL(4,2) DEFAULT NULL,
  CONSTRAINT fk_matriculas_alunos FOREIGN KEY (aluno_id) REFERENCES alunos(aluno_id),
  CONSTRAINT fk_matriculas_cursos FOREIGN KEY (curso_id) REFERENCES cursos(curso_id),
  INDEX idx_matriculas_status (status)
);

-- =======================
-- Inserts: alunos
-- =======================
INSERT INTO alunos (nome, email, data_nascimento, cidade, nota_media) VALUES
('Alice Souza', 'alice.souza@example.com', '2005-03-14', 'Natal', 8.75),
('Bruno Lima', 'bruno.lima@example.com', '2004-07-22', 'Fortaleza', 7.20),
('Carla Mendes', 'carla.mendes@example.com', '2003-11-05', 'Recife', 9.10),
('Diego Alves', 'diego.alves@example.com', '2002-01-28', 'João Pessoa', 6.80),
('Eduarda Nunes', 'eduarda.nunes@example.com', '2005-09-12', 'Mossoró', 8.10),
('Felipe Araújo', 'felipe.araujo@example.com', '2004-02-17', 'Natal', 7.95),
('Gabriela Teixeira', 'gabriela.teixeira@example.com', '2003-05-03', 'Fortaleza', 9.40),
('Heitor Barros', 'heitor.barros@example.com', '2002-08-29', 'Natal', 5.90),
('Isabela Freitas', 'isabela.freitas@example.com', '2005-12-10', 'Recife', 8.30),
('João Victor', 'joao.victor@example.com', '2004-10-01', 'Mossoró', 6.50),
('Karen Ribeiro', 'karen.ribeiro@example.com', '2003-06-20', 'João Pessoa', 7.60),
('Lucas Martins', 'lucas.martins@example.com', '2002-04-11', 'Fortaleza', 8.95);

-- =======================
-- Inserts: cursos
-- =======================
INSERT INTO cursos (nome, area, carga_horaria, preco, ativo) VALUES
('Banco de Dados I', 'Tecnologia', 60, 650.00, 1),
('Autoria Web', 'Tecnologia', 80, 720.00, 1),
('Programação em Python', 'Tecnologia', 100, 900.00, 1),
('Redes de Computadores', 'Infraestrutura', 60, 550.00, 1),
('Segurança da Informação', 'Tecnologia', 60, 800.00, 1),
('Matemática Aplicada', 'Exatas', 40, 300.00, 1);

-- =======================
-- Inserts: matriculas
-- =======================
INSERT INTO matriculas (aluno_id, curso_id, data_matricula, status, nota_final) VALUES
(1, 1, '2025-02-15', 'Concluída', 9.10),
(1, 2, '2025-08-01', 'Ativa', NULL),
(2, 1, '2025-03-10', 'Ativa', NULL),
(2, 4, '2025-04-05', 'Trancada', NULL),
(3, 3, '2025-01-20', 'Concluída', 9.50),
(3, 5, '2025-05-12', 'Ativa', NULL),
(4, 6, '2025-02-02', 'Cancelada', NULL),
(5, 2, '2025-03-21', 'Concluída', 8.70),
(6, 1, '2025-01-18', 'Concluída', 8.20),
(6, 3, '2025-06-25', 'Ativa', NULL),
(7, 5, '2025-07-14', 'Ativa', NULL),
(8, 4, '2025-02-28', 'Concluída', 6.80),
(9, 1, '2025-03-02', 'Ativa', NULL),
(10, 2, '2025-07-07', 'Ativa', NULL),
(11, 6, '2025-04-30', 'Concluída', 7.10),
(12, 3, '2025-03-15', 'Concluída', 9.20),
(12, 1, '2025-09-01', 'Ativa', NULL);

-- Índices úteis adicionais
CREATE INDEX idx_cursos_area ON cursos(area);
CREATE INDEX idx_cursos_preco ON cursos(preco);
CREATE INDEX idx_matriculas_aluno ON matriculas(aluno_id);
CREATE INDEX idx_matriculas_curso ON matriculas(curso_id);

-- Fim do script
