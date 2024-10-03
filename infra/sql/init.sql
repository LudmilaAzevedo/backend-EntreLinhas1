CREATE SEQUENCE seq_ra START 1;

CREATE TABLE Aluno (
    id_aluno SERIAL PRIMARY KEY,
    ra VARCHAR (7) UNIQUE NOT NULL,
    nome VARCHAR (80) NOT NULL,
    sobrenome VARCHAR (80) NOT NULL,
    data_nascimento DATE,
    endereco VARCHAR (200),
    email VARCHAR (80),
    celular VARCHAR (20) NOT NULL
);

CREATE OR REPLACE FUNCTION gerar_ra() RETURNS TRIGGER AS $$
BEGIN
    NEW.ra := 'AAA' || TO_CHAR(nextval('seq_ra'), 'FM0000');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_gerar_ra
BEFORE INSERT ON Aluno
FOR EACH ROW EXECUTE FUNCTION gerar_ra();

CREATE TABLE Livro (
    id_livro SERIAL PRIMARY KEY,
    titulo VARCHAR (200) NOT NULL,
    autor VARCHAR (150) NOT NULL,
    editora VARCHAR (100) NOT NULL,
    ano_publicacao VARCHAR (5),
    isbn VARCHAR (20),
    quant_total INTEGER NOT NULL,
    quant_disponivel INTEGER NOT NULL,
    valor_aquisicao DECIMAL (10,2),
    status_livro_emprestado VARCHAR (20)
);


CREATE TABLE Emprestimo (
    id_emprestimo SERIAL PRIMARY KEY,
    id_aluno INT REFERENCES Aluno(id_aluno),
    id_livro INT REFERENCES Livro(id_livro),
    data_emprestimo DATE NOT NULL,
    data_devolucao DATE,
    status_emprestimo VARCHAR (20)
);

INSERT INTO Aluno (nome, sobrenome, data_nascimento, endereco, email, celular) 
VALUES 
('Conor', 'McGregor', '2005-01-15', 'Rua UFC, 123', 'mcgregor@ufc.com', '16998959876'),
('Amanda', 'Nunes', '2004-03-22', 'Rua UFC, 456', 'amanda.nunes@ufc.com', '16995992305'),
('Angelina', 'Jolie', '2003-07-10', 'Rua Hollywood, 789', 'jolie@cinema.com', '16991915502'),
('Natalie', 'Portman', '2002-11-05', 'Rua Hollywood, 101', 'natalie.portman@cinema.com', '16993930703'),
('Shaquille', 'ONeal', '2004-09-18', 'Rua NBA, 202', 'shaquille@gmail.com', '16993937030'),
('Harry', 'Kane', '2000-05-18', 'Rua Futebol, 2024', 'kane@futi.com', '16998951983'),
('Jaqueline', 'Carvalho', '2001-12-10', 'Rua Volei, 456', 'jack@volei.com', '16991993575'),
('Sheilla', 'Castro', '2003-04-25', 'Rua Volei, 2028', 'sheilla.castro@volei.com', '16981974547'),
('Gabriela', 'Guimarães', '2007-08-19', 'Rua Volei, 2028', 'gaby@volei.com', '16983932215'),
('Magic', 'Johnson', '2003-07-08', 'Rua NBA, 1999', 'magic@gmail.com', '16993932020');



INSERT INTO Aluno (nome, sobrenome, data_nascimento, endereco, email, celular) 
VALUES 
('Oconor', 'Gregor', '2006-02-11', 'Rua Flor, 123', 'oconord@ufc.com', '16998950876'),
('Rebeca', 'Nunes', '2007-05-21', 'Rua Lis, 456', 'rebeca.nunes@ufc.com', '16995904305'),
('Maria', 'Alves', '2008-07-10', 'Rua Terra, 789', 'mariaa@cinema.com', '16991987502'),
('Natalie', 'Silva', '2004-12-09', 'Rua Hollywood, 101', 'natalie.silva@cinema.com', '16991480703'),
('Shakti', 'ONeal', '2004-09-18', 'Rua NBA, 202', 'shakye@gmail.com', '16993937030'),
('Jean', 'Alves', '2007-05-01', 'Rua Flor, 230', 'alves@futi.com', '16998952424'),
('Janaina', 'Silva', '2001-11-11', 'Rua Volei, 456', 'jana@volei.com', '16990983910'),
('Sheila', 'Almeida', '2003-04-25', 'Rua Volei, 228', 'sheila.almeida@volei.com', '16989074098'),
('Isabela', 'Pereira', '2007-08-19', 'Rua Volei, 288', 'Isa@volei.com', '16983932098'),
('Alec', 'Johnson', '2003-07-08', 'Rua NBA, 1989', 'mas@gmail.com', '16993909820');

INSERT INTO Livro (titulo, autor, editora, ano_publicacao, isbn, quant_total, quant_disponivel, valor_aquisicao, status_livro_emprestado) 
VALUES 
('O Senhor dos Anéis', 'J.R.R. Tolkien', 'HarperCollins', '1954', '978-0007525546', 10, 10, 150.00, 'Disponível'),
('1984', 'George Orwell', 'Companhia das Letras', '1949', '978-8535906770', 8, 8, 90.00, 'Disponível'),
('Dom Quixote', 'Miguel de Cervantes', 'Penguin Classics', '1605', '978-0142437230', 6, 6, 120.00, 'Disponível'),
('O Pequeno Príncipe', 'Antoine de Saint-Exupéry', 'Agir', '1943', '978-8522008731', 12, 12, 50.00, 'Disponível'),
('A Revolução dos Bichos', 'George Orwell', 'Penguin', '1945', '978-0141036137', 7, 7, 80.00, 'Disponível'),
('O Hobbit', 'J.R.R. Tolkien', 'HarperCollins', '1937', '978-0007458424', 9, 9, 140.00, 'Disponível'),
('O Conde de Monte Cristo', 'Alexandre Dumas', 'Penguin Classics', '1844', '978-0140449266', 5, 5, 110.00, 'Disponível'),
('Orgulho e Preconceito', 'Jane Austen', 'Penguin Classics', '1813', '978-0141439518', 7, 7, 90.00, 'Disponível'),
('Moby Dick', 'Herman Melville', 'Penguin Classics', '1851', '978-0142437247', 4, 4, 100.00, 'Disponível'),
('Guerra e Paz', 'Liev Tolstói', 'Companhia das Letras', '1869', '978-8535922343', 3, 3, 130.00, 'Disponível');


INSERT INTO Livro (titulo, autor, editora, ano_publicacao, isbn, quant_total, quant_disponivel, valor_aquisicao, status_livro_emprestado) 
VALUES 
('Sapiens: Uma Breve História da Humanidade', 'Yuval Noah Harari', 'Companhia das Letras', '2011', '978-8535920424', 15, 15, 89.90, 'Disponível'),
('O Gene: Uma História Íntima', 'Siddhartha Mukherjee', 'Companhia das Letras', '2016', '978-8535927447', 10, 10, 99.90, 'Disponível'),
('A Origem das Espécies', 'Charles Darwin', 'Penguin Classics', '1859', '978-0140439120', 5, 5, 79.90, 'Disponível'),
('Breves Respostas para Grandes Questões', 'Stephen Hawking', 'Intrínseca', '2018', '978-6555602357', 12, 12, 59.90, 'Disponível'),
('O Poder do Hábito', 'Charles Duhigg', 'Objetiva', '2012', '978-8539004113', 20, 20, 49.90, 'Disponível'),
('A Revolta de Atlas', 'Ayn Rand', 'Arqueiro', '1957', '978-8599296493', 8, 8, 119.90, 'Disponível'),
('O Capital no Século XXI', 'Thomas Piketty', 'Intrínseca', '2013', '978-8580575070', 6, 6, 149.90, 'Disponível'),
('21 Lições para o Século 21', 'Yuval Noah Harari', 'Companhia das Letras', '2018', '978-8535930812', 14, 14, 79.90, 'Disponível'),
('O Andar do Bêbado', 'Leonard Mlodinow', 'Zahar', '2008', '978-8537808058', 10, 10, 54.90, 'Disponível'),
('Freakonomics', 'Steven D. Levitt, Stephen J. Dubner', 'Elsevier', '2005', '978-8535215261', 12, 12, 69.90, 'Disponível');

INSERT INTO Emprestimo (id_aluno, id_livro, data_emprestimo, data_devolucao, status_emprestimo) 
VALUES 
(1, 2, '2024-09-01', '2024-09-15', 'Em andamento'),
(2, 1, '2024-09-02', '2024-09-16', 'Em andamento'),
(3, 5, '2024-09-03', '2024-09-17', 'Em andamento'),
(5, 3, '2024-09-04', '2024-09-18', 'Em andamento'),
(4, 6, '2024-09-05', '2024-09-19', 'Em andamento'),
(6, 4, '2024-09-06', '2024-09-20', 'Em andamento'),
(7, 8, '2024-09-07', '2024-09-21', 'Em andamento'),
(8, 7, '2024-09-08', '2024-09-22', 'Em andamento'),
(10, 9, '2024-09-09', '2024-09-23', 'Em andamento'),
(9, 10, '2024-09-10', '2024-09-24', 'Em andamento'),
(1, 10, '2024-09-11', '2024-09-25', 'Em andamento'),
(2, 3, '2024-09-11', '2024-09-25', 'Em andamento'),
(4, 5, '2024-09-11', '2024-09-25', 'Em andamento'),
(6, 2, '2024-09-11', '2024-09-25', 'Em andamento');

INSERT INTO Emprestimo (id_aluno, id_livro, data_emprestimo, data_devolucao, status_emprestimo) 
VALUES 
(1, 2, '2024-09-01', '2024-09-15', 'Em andamento'),
(3, 4, '2024-09-02', '2024-09-16', 'Em andamento'),
(5, 6, '2024-09-03', '2024-09-17', 'Em andamento'),
(7, 8, '2024-09-04', '2024-09-18', 'Em andamento'),
(9, 10, '2024-09-05', '2024-09-19', 'Em andamento'),
(2, 3, '2024-09-06', '2024-09-20', 'Em andamento'),
(4, 5, '2024-09-07', '2024-09-21', 'Em andamento'),
(6, 7, '2024-09-08', '2024-09-22', 'Em andamento'),
(8, 9, '2024-09-09', '2024-09-23', 'Em andamento'),
(10, 1, '2024-09-10', '2024-09-24', 'Em andamento');

SELECT 
    a.ra, 
    a.nome, 
    a.sobrenome, 
    a.celular, 
    l.titulo, 
    l.autor, 
    l.editora, 
    e.data_emprestimo, 
    e.data_devolucao, 
    e.status_emprestimo
FROM 
    Emprestimo e
JOIN 
    Aluno a ON e.id_aluno = a.id_aluno
JOIN 
    Livro l ON e.id_livro = l.id_livro;

