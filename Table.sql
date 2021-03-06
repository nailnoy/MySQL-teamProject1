DROP DATABASE`registration`;
-- -----------------------------------------------------
-- Schema registration
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `registration` DEFAULT CHARACTER SET utf8 ;
USE `registration` ;

-- -----------------------------------------------------
-- Table `registration`.`DEPARTMENT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `registration`.`DEPARTMENT` (
  `id` INT(2) NOT NULL,
  `name` VARCHAR(20) NOT NULL,
  `field` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `registration`.`STUDENT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `registration`.`STUDENT` (
  `id` INT(14) NOT NULL,
  `dept_id` INT(2) NOT NULL,
  `name` CHAR(10) NOT NULL,
  `ename` VARCHAR(50) NULL DEFAULT NULL,
  `grade` INT(1) NOT NULL,
  `id_num` VARCHAR(14) NOT NULL,
  `address` VARCHAR(100) NULL DEFAULT NULL,
  `phone` VARCHAR(14) NULL DEFAULT NULL,
  `post_no` VARCHAR(6) NOT NULL,
  PRIMARY KEY (`id`, `dept_id`),
  UNIQUE INDEX `id_num_UNIQUE` (`id_num` ASC),
  UNIQUE INDEX `post_no_UNIQUE` (`post_no` ASC),
  INDEX `fk_STUDENT_dept_id_idx` (`dept_id` ASC),
  CONSTRAINT `fk_STUDENT_dept_id`
    FOREIGN KEY (`dept_id`)
    REFERENCES `registration`.`DEPARTMENT` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `registration`.`PROFESSOR`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `registration`.`PROFESSOR` (
  `id` INT(10) NOT NULL,
  `name` VARCHAR(20) NOT NULL,
  `dept_id` INT(2) NOT NULL,
  `email` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id`, `dept_id`),
  INDEX `fk_PROFESSOR_dept_id_idx` (`dept_id` ASC),
  CONSTRAINT `fk_PROFESSOR_dept_id`
    FOREIGN KEY (`dept_id`)
    REFERENCES `registration`.`DEPARTMENT` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `registration`.`SUBJECT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `registration`.`SUBJECT` (
  `id` INT(5) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `create_year` CHAR(5) NOT NULL,
  `prof_id` INT(10) NOT NULL,
  `isu` INT(1) NOT NULL,
  `spare` INT(2) NOT NULL,
  `point` INT(1) NOT NULL,
  PRIMARY KEY (`id`, `prof_id`),
  INDEX `fk_ SUBJECT_prof_id_idx` (`prof_id` ASC),
  CONSTRAINT `fk_ SUBJECT_prof_id`
    FOREIGN KEY (`prof_id`)
    REFERENCES `registration`.`PROFESSOR` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `registration`.`REGISTRATION`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `registration`.`REGISTRATION` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `stu_id` INT(14) NOT NULL,
  `year` INT(4) NOT NULL,
  `term` INT(1) NOT NULL,
  `sub_id` INT(5) NOT NULL,
  `grade` FLOAT NULL DEFAULT 0,
  `fixed` TINYINT(1) NOT NULL DEFAULT 0,
  `rereg` INT(1) NOT NULL DEFAULT 1,
  `date` DATETIME NOT NULL,
  PRIMARY KEY (`id`, `sub_id`, `stu_id`),
  INDEX `fk_REGISTRATION_student_idx` (`stu_id` ASC),
  INDEX `fk_SUBJECT_sub_code_idx` (`sub_id` ASC),
  CONSTRAINT `fk_REGISTRATION_stu_id`
    FOREIGN KEY (`stu_id`)
    REFERENCES `registration`.`STUDENT` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_REGISTRATION_sub_id`
    FOREIGN KEY (`sub_id`)
    REFERENCES `registration`.`SUBJECT` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

ALTER TABLE REGISTRATION ADD UNIQUE (stu_id, sub_id, rereg);


-- -----------------------------------------------------
-- Table `registration`.`SCORE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `registration`.`SCORE` (
  `stu_id` INT(10) NOT NULL,
  `exam_avg` FLOAT NULL DEFAULT NULL,
  `exam_total` INT NULL DEFAULT NULL,
  PRIMARY KEY (`stu_id`),
  CONSTRAINT `fk_SCORE_stu_id`
    FOREIGN KEY (`stu_id`)
    REFERENCES `registration`.`STUDENT` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- ????????? ??? INSERT 

INSERT INTO DEPARTMENT VALUES 
(10,'????????????','??????'),
(20,'????????????','??????'),
(30,'????????????','??????'),
(40,'?????????????????????','??????'),
(50,'??????????????????','??????');

SELECT * FROM  DEPARTMENT;


INSERT INTO STUDENT VALUES 
(20191001,10,'?????????','Lee Sung-min',4,'001010-4234567','??????','010-1234-5678','00152'),
(20191002,10,'?????????','Kim Min-soo',4,'990812-1478526','??????','010-1234-1234','00458'),
(20191003,10,'?????????','Jang Seong-hoon',4,'000515-3648956','??????','010-1111-1111','01786'),
(20201104,10,'?????????','Kim Tae-wook',3,'011218-3214587','??????','010-1111-2222','02645'),
(20201105,50,'?????????','Kim Hae-ju',3,'011105-4563210','??????','010-2222-3333','06450'),
(20201106,20,'?????????','Jang Yoo-in',3,'010605-4879052','??????',NULL,'05042'),
(20201107,30,'?????????','Lee jin-ho',3,'000509-3502011','??????','010-4561-4586','06807'),
(20211208,50,'?????????','Kim Hyun-ah',2,'020104-4560123','??????','010-7861-1256','02354'),
(20211209,20,'?????????','Lee Si-an',2,'020308-3890405','??????',NULL,'02356'),
(20211210,20,'?????????','Lee Min-jung',2,'021027-4052126','??????','010-5411-3698','03054'),
(20221311,40,'?????????','Yoo Seong-hoon',1,'031111-3050214','??????','010-3335-7788','03452'),
(20221312,40,'?????????','Kim Ga-eul',1,'031116-4010233','??????',NULL,'05456'),
(20221313,40,'?????????','Kim Soo-jung',1,'030928-4892311','??????',NULL,'08045'),
(20221314,30,'?????????','Choi Jin-soo',1,'030425-3012990','??????','010-4869-2222','08046');

SELECT * FROM  STUDENT;


INSERT INTO SCORE VALUES 
(20191001,4.5,100), (20191002,4,94),
(20191003,4.4,99),(20201104,3.5,89),
(20201105,3.5,89),(20201106,3.3,86),
(20201107,4.5,100),(20211208,4.4,99),
(20211209,4.1,95),(20211210,4,94),
(20221311,3,83),(20221312,3.3,86),
(20221313,4,94),(20221314,3,83);

SELECT * FROM  SCORE;

INSERT INTO PROFESSOR VALUES 
(4001,'?????????',10,'4001@gmail.com'),
(4002,'?????????',20,'4002@gmail.com'),
(4003,'?????????',30,'4003@gmail.com'),
(4004,'?????????',40,'4004@gmail.com'),
(4005,'?????????',50,'4005@gmail.com'),
(4006,'?????????',20,'4006@gmail.com'),
(4007,'?????????',50,'4007@gmail.com'),
(4008,'?????????',10,'4008@gmail.com'),
(4009,'?????????',20,'4009@gmail.com'),
(5010,'?????????',30,'5010@gmail.com'),
(5011,'?????????',40,'5011@gmail.com');

SELECT * FROM  PROFESSOR;

INSERT INTO SUBJECT VALUES 
(4001,'?????????????????? ??????','2012',4004,4,5,3),
(4002,'???????????? ??????','2013',4004,4,5,4),
(4003,'?????????????????????','2013',5011,4,6,3),
(4004,'??????????????????','2012',5011,3,5,2),
(4005,'???????????????','2011',4005,4,6,3),
(4006,'??????????????????','2011',4005,3,5,4),
(4007,'UML','2012',4007,4,6,4),
(4008,'????????????','2012',4007,3,5,3),
(4009,'????????????','2013',4001,3,6,4),
(4010,'??????????????????','2019',4006,4,5,2),
(4011,'???????????????','2009',4003,4,6,3),
(4012,'???????????????','2015',4009,4,5,2),
(4013,'?????????','2014',4008,4,6,4);

SELECT * FROM SUBJECT;


INSERT INTO REGISTRATION VALUES 
(1,20191002,2021,1,4001,4,1,1,'2021-03-05'),
(2,20191003,2021,1,4002,4.5,1,1,'2021-03-05'),
(3,20201104,2021,1,4003,3,1,1,'2021-03-05'),
(4,20201105,2021,1,4004,4.5,1,1,'2021-03-05'),
(5,20201106,2021,1,4005,2.5,1,1,'2021-03-05'),
(6,20201107,2021,1,4006,3,1,1,'2021-03-05'),
(7,20211208,2021,2,4007,4,1,1,'2021-09-03'),
(8,20211209,2021,2,4008,4.5,1,1,'2021-09-03'),
(9,20211210,2021,2,4009,2,1,1,'2021-09-03'),
(10,20211208,2021,2,4010,4.5,1,1,'2021-09-03'),
(11,20211209,2021,2,4011,4,1,1,'2021-09-03'),
(12,20201106,2021,2,4012,3,1,1,'2021-09-03'),
(13,20221311,2022,1,4001,3.5,1,1,'2022-03-06'),
(14,20221311,2022,1,4002,4.5,1,1,'2022-03-06'),
(15,20221312,2022,1,4003,3.5,1,1,'2022-03-06'),
(16,20221312,2022,1,4004,3.5,1,1,'2022-03-06'),
(17,20221313,2022,1,4005,3,1,1,'2022-03-06'),
(18,20221314,2022,1,4006,4,1,1,'2022-03-06');

SELECT * FROM REGISTRATION;


COMMIT;


