SHOW DATABASES; 
USE mysql_lessons;
-- категории (id, name)
-- животные (id, name, age, passport, id_category)
-- коментарии (id, text, added, id_animal, id_parent_comment)

-- создаём таблицу категории
-- `id` обратные ковычки помогают не получить ошибку из за использования зарезервированных слов, полезно в использованием PHP
CREATE TABLE IF NOT EXISTS category(
 `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
 `name` VARCHAR(50) NOT NULL 
 )ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
 
 -- создаём табличку животные 
 CREATE TABLE IF NOT EXISTS animal(
 `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
 `name`  VARCHAR(50) NOT NULL,
 `age` FLOAT NOT NULL,
 `passport` BOOLEAN DEFAULT false, -- при дефолтном значение не указываем NOT NULL
 `id_category` INT NOT NULL,
 -- ДОБАВЛЯЕМ СВЗЯЬ МЕЖДУ ТАБЛИЦАМИ 
 CONSTRAINT categoty_fk -- название связи для дальнейшей работы с ней 
 FOREIGN KEY (id_category) --  внешний ключ
 REFERENCES category(id) -- певичный ключ в связанной таблице
-- действия на удаление 
 ON DELETE NO ACTION  -- SET NULL / CASCADE (удалние связных саписей)
 -- ON UPDATE NO ACTION  -- SET NULL / CASCADE (удалние связных саписей)
 )ENGINE=InnoDB DEFAULT CHARSET=utf8;
 
 -- создаём таблицу с коментариями и связываем её с живоными 
 CREATE TABLE IF NOT EXISTS `comment`(
 `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
 `text` MEDIUMTEXT NOT NULL,
 `added` DATETIME DEFAULT CURRENT_TIMESTAMP,
 `id_animal` INT NOT NULL,
 `id_parent_comment` INT ,
CONSTRAINT animal_fk -- название связи для дальнейшей работы с ней 
FOREIGN KEY (`id_animal`) --  внешний ключ
REFERENCES animal(`id`) -- певичный ключ в связанной таблице
ON DELETE CASCADE, -- CASCADE (удалние связных саписей)
CONSTRAINT comment_fk -- название связи для дальнейшей работы с ней 
FOREIGN KEY (`id_parent_comment`) --  внешний ключ
REFERENCES `comment`(`id`) -- певичный ключ в связанной таблице
ON DELETE NO ACTION
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
 
 -- Заполняем первичные ключи ( таблицу категории) 
--  INSERT INTO `category` (`name`) 
--  VALUES ('Кошка'), ('Собака'), ('Лошадь'); 

 INSERT INTO `animal` (`name`, `age`, `passport`, `id_category`) -- названия столбцов
 VALUE ('Васька', 1, true, 1); -- id_category - 1 - Кошка -- значения столбцов
 -- НУЖНО СОБЛЮДАТЬ ПОРЯДОК НАЗВАНИЯ И ЗНАЧЕНИЯ СТОЛБЦА
 INSERT INTO `animal` (`name`, `age`, `id_category`) -- названия столбцов
 VALUE ('Мурка', 2, 1); -- id_category - 1 - Кошка -- значения столбцов
 
INSERT INTO `animal` (`name`, `age`, `id_category`) -- названия столбцов
VALUE ('Граф', 3, 2); -- id_category - 1 - Кошка -- значения столбцов

-- Добавляем коментарий
INSERT INTO `comment` (`text`, `added`, `id_animal`)
VALUE
('Комментарий про Ваську', '2019-03-25 12:35', 1);
-- Добавляем ответ на коментарий
INSERT INTO `comment` (`text`, `id_animal`, `id_parent_comment`)
VALUE
('Ответ на коментарий про Ваську',1, 1);

-- ЗАПРОСЫ SELECT

-- название категории имя животного
SELECT concat(`category`.`name`,' ', `animal`.`name`)
AS animal_name -- название столбца в который будут выводиться данные
FROM `animal`, `category`
WHERE `animal`.`id_category` = `category`.`id`;

SELECT count(`animal`.`name`) AS animals_count, `category`.`name`
FROM `animal`,`category`
WHERE `animal`.`id_category` = `category`.`id`
GROUP BY `category`.`name`;

-- JOIN ЗАПРОСЫ
-- INNER JOIN 
-- везде где есть слово JOIN таблицам надо добавлять псевданимы и работать через псевданимы
-- псевданим сохраняеться только для запроса 

-- SELECT a.name, c.name 
-- FROM animal a  
-- INNER JOIN category c
-- ON a.id_category = c.id;

SELECT a.`name`, c.`name` -- выбираем названия (a.name - вместо а по факту подставиться animal) 
FROM `animal` a -- из таблицы animal (а-псевданим таблицы animal) 
INNER JOIN `category` c -- присоеденяем таблицу с категориями ( псевданим "с")
ON a.`id_category` = c.`id`; -- вместо можно написать USING(id_category "название столбца") толлько если a.`id_category` = c.`id_category`; значения id одинаковы

-- LEFT JOIN -- где не нашлось соотвествия проставит  NULL
SELECT a.`name`, c.`name` 
FROM `category` c
LEFT JOIN `animal` a
ON a.`id_category` = c.`id`;

-- категории без животных
-- типичное использование LEFT JOIN проверка на IS NULL, например ( пользователи которыые не оставляли коментарии) и тд.
SELECT c.`name`
FROM `category` c
LEFT JOIN `animal` a
ON a.`id_category` = c.`id`
WHERE a.`name` IS NULL;

-- RIGHT JOIN
SELECT a.`name`, c.`name` 
FROM `category` c
RIGHT JOIN `animal` a
ON a.`id_category` = c.`id`;

-- 1) выбрать животных, которым не добавили комментарии
-- 2) количество комментариев к животному Васька
-- 3) выбрать текст комментария, дату написания,
-- имя животного ( из категории Кошка)