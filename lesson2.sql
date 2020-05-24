-- список бд
SHOW DATABASES;
-- создание базы данных
CREATE DATABASE IF NOT EXISTS mysql_lessons;

-- удаление бд
-- DROP DATABASE IF EXISTS mysql_lessons;

-- выбор бд для дальнейшего использования
USE mysql_lessons;

CREATE TABLE IF NOT EXISTS course(
	id_course INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(50) NOT NULL,
    duration TINYINT UNSIGNED NOT NULL,
    pic VARCHAR(250) DEFAULT 'course.png',
    date_start DATE NOT NULL
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

SHOW TABLES; -- список таблиц
DESC course;

-- добавление записей в таблицу
INSERT INTO course 
(title, duration, pic, date_start)
VALUES 
('WEB Developer', 4, 'web.png', '2020-10-04'),
('Puthon', 2, 'python.png', '2020-05-25');

INSERT INTO course
(title, duration, date_start)
VALUES
('Node JS', 4, '2020-11-15');

INSERT INTO course
(title, duration, date_start)
VALUES
('JAVA',3, '2020-11-10');

-- обновление данных в таблице
UPDATE course SET pic='java.png' WHERE id_course=4;

-- удаление записи
DELETE FROM course WHERE id_course=2;

-- получение всех записей из таблицы
SELECT * FROM course;

-- получение по определенным столбцам
SELECT title, duration FROM course;

-- = != <  > <= >=
SELECT * FROM course WHERE id_course=1;
SELECT * FROM course WHERE title='WEB Developer';
SELECT * FROM course WHERE duration > 3;

USE mysql_lessons;

-- операторы
-- AND OR NOT
	
SELECT * FROM course WHERE duration > 3 AND title = 'JAVA';

SELECT * FROM course WHERE duration > 3  AND duration < 6;

-- BETWEEN AND - диапазоны 
SELECT * FROM course WHERE date_start BETWEEN NOW() AND '2020-11-10';

-- IN(value1, value2, value3)
SELECT * FROM course WHERE duration IN(3, 6, 10);

-- LIKE
-- JA%
-- %er
-- %o%

SELECT * FROM course WHERE title LIKE '%o%';

-- ORDER BY DESC - отсортированный вывод по убыванию 
-- ORDER BY ASC - отсортированный вывод по возрастанию 

SELECT * FROM course ORDER BY title DESC;
SELECT * FROM course ORDER BY date_start;

-- по нескольким столбцам 
SELECT * FROM course ORDER BY duration ASC, title DESC; 

-- индексы 
CREATE INDEX title -- имя индекса
ON course(title); -- название столбца в таблице

CREATE UNIQUE INDEX duration -- имя индекса
ON course(duration); -- название столбца в таблице

-- составные индексы
-- CREATE INDEX duration_date ON course(date_start, date_end);

-- справочная информация по индексам 

SHOW INDEX FROM course;

EXPLAIN SELECT * FROM course WHERE title='JAVA';

-- удаление индекса 
DROP INDEX title ON course; -- title название индекса 

-- Домашняя работа 
-- выбрать первые 10 записей из таблицы

SELECT * FROM course LIMIT 2;

-- выбрать с 10 по 20 записи из таблицы

SELECT * FROM course LIMIT 3, 6;

-- функция: перевод в верхний регистр 
-- SELECT UCASE(поле) FROM имя_таблицы WHERE условие
-- SELECT UPPER(поле) FROM имя_таблицы WHERE условие

SELECT *, UCASE(title) as title FROM course;
-- или 
SELECT *, UPPER(title) as title FROM course;

-- перевод в нижний регистр
-- SELECT LCASE(поле) FROM имя_таблицы WHERE условие
-- SELECT LOWER(поле) FROM имя_таблицы WHERE условие

SELECT *, LCASE(title) as title FROM course;
-- или
SELECT *, LOWER(title) as title FROM course;

-- получение всех записей из таблицы
SELECT * FROM course;




