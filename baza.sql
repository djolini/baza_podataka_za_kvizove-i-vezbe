CREATE DATABASE IF NOT EXISTS `ltcode`;

-- -----------------------------------------------------
-- Table `ltcode`.`categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ltcode`.`categories` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `category` VARCHAR(70) NOT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ltcode`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ltcode`.`users` (
  `ID` INT NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  `email` VARCHAR(255) NULL,
  `password` VARCHAR(255) NOT NULL,
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`));


-- -----------------------------------------------------
-- Table `ltcode`.`subcategories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ltcode`.`subcategories` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `subcategory` VARCHAR(45) NOT NULL,
  `categories_ID` INT NOT NULL,
  PRIMARY KEY (`ID`, `categories_ID`),
  INDEX `fk_subcategories_categories_idx` (`categories_ID` ASC) ,
  CONSTRAINT `fk_subcategories_categories`
    FOREIGN KEY (`categories_ID`)
    REFERENCES `ltcode`.`categories` (`ID`)

    )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ltcode`.`quiz`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ltcode`.`quiz` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `question` VARCHAR(255) NOT NULL,
  `first_answer` VARCHAR(255) NOT NULL,
  `second_answer` VARCHAR(255) NOT NULL,
  `third_answer` VARCHAR(255) NULL,
  `fourth_answer` VARCHAR(255) NULL,
  `answer` VARCHAR(255) NOT NULL,
  `is_true` TINYTEXT NULL,
  `extra` VARCHAR(255) NULL,
  `subcategories_ID` INT,
  `subcategories_categories_ID` INT,
  PRIMARY KEY (`ID`, `subcategories_ID`, `subcategories_categories_ID`),
  INDEX `fk_quiz_subcategories1_idx` (`subcategories_ID` ASC, `subcategories_categories_ID` ASC) ,
  CONSTRAINT `fk_quiz_subcategories1`
    FOREIGN KEY (`subcategories_ID` , `subcategories_categories_ID`)
    REFERENCES `ltcode`.`subcategories` (`ID` , `categories_ID`)

    )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ltcode`.`exercises`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ltcode`.`exercises` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `question` VARCHAR(255) NOT NULL,
  `text_infront` VARCHAR(255) NULL,
  `text_behind` VARCHAR(255) NULL,
  `answer` VARCHAR(255) NOT NULL,
  `is_true` TINYTEXT NOT NULL,
  `extra` VARCHAR(255) NULL,
  `subcategories_ID` INT,
  `subcategories_categories_ID` INT,
  PRIMARY KEY (`ID`, `subcategories_ID`, `subcategories_categories_ID`),
  INDEX `fk_exercises_subcategories1_idx` (`subcategories_ID` ASC, `subcategories_categories_ID` ASC) ,
  CONSTRAINT `fk_exercises_subcategories1`
    FOREIGN KEY (`subcategories_ID` , `subcategories_categories_ID`)
    REFERENCES `ltcode`.`subcategories` (`ID` , `categories_ID`)

    )
ENGINE = InnoDB;

USE `ltcode` ;

-- -----------------------------------------------------
-- Placeholder table for view `ltcode`.`quiz_questions_and_answers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ltcode`.`quiz_questions_and_answers` (`question` INT, `answer` INT);

-- -----------------------------------------------------
-- Placeholder table for view `ltcode`.`exercises_questions_and_answers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ltcode`.`exercises_questions_and_answers` (`question` INT, `answer` INT);

-- -----------------------------------------------------
-- procedure GetOfficeByCountry
-- -----------------------------------------------------

DELIMITER $$
USE `ltcode`$$
CREATE PROCEDURE GetOfficeByCountry(
	IN category VARCHAR(255)
)
BEGIN
	SELECT *
 	FROM categories
	WHERE category = 'HTML';
END$$

DELIMITER ;

-- -----------------------------------------------------
-- View `ltcode`.`quiz_questions_and_answers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ltcode`.`quiz_questions_and_answers`;
USE `ltcode`;
CREATE  OR REPLACE VIEW `quiz_questions_and_answers` AS
SELECT question,answer
FROM quiz;

-- -----------------------------------------------------
-- View `ltcode`.`exercises_questions_and_answers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ltcode`.`exercises_questions_and_answers`;
USE `ltcode`;
CREATE  OR REPLACE VIEW `exercises_questions_and_answers` AS
SELECT question,answer
FROM exercises
WHERE ID<10;

CREATE TABLE IF NOT EXISTS `ltcode`.`blog` (
  `ID` INT PRIMARY KEY  NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `content` VARCHAR(255) NOT NULL);

  CREATE TABLE IF NOT EXISTS `ltcode`.`recommendations` (
    `ID` INT PRIMARY KEY  NOT NULL AUTO_INCREMENT,
    `title` VARCHAR(45) NOT NULL,
    `content` VARCHAR(255) NOT NULL);

    CREATE TRIGGER uppercase_insert BEFORE INSERT ON categories FOR EACH ROW
    SET NEW.category = UPPER(NEW.category);

    CREATE TRIGGER uppercase_update BEFORE UPDATE ON categories FOR EACH ROW
    SET NEW.category = UPPER(NEW.category);



    CREATE TRIGGER uppercase_insert BEFORE INSERT ON subcategories FOR EACH ROW
    SET NEW.subcategory = UPPER(NEW.subcategory);

    CREATE TRIGGER uppercase_update BEFORE UPDATE ON subcategories FOR EACH ROW
    SET NEW.subcategory = UPPER(NEW.subcategory);
