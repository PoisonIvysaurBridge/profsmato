-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema profsmato
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `profsmato` ;

-- -----------------------------------------------------
-- Schema profsmato
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `profsmato` DEFAULT CHARACTER SET utf8 ;
USE `profsmato` ;

-- -----------------------------------------------------
-- Table `profsmato`.`Colleges`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `profsmato`.`Colleges` ;

CREATE TABLE IF NOT EXISTS `profsmato`.`Colleges` (
  `collegeID` VARCHAR(10) NOT NULL,
  `collegeName` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`collegeID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `profsmato`.`Departments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `profsmato`.`Departments` ;

CREATE TABLE IF NOT EXISTS `profsmato`.`Departments` (
  `departmentId` VARCHAR(10) NOT NULL,
  `attachedCollege` VARCHAR(10) NOT NULL,
  `departmentName` VARCHAR(80) NOT NULL,
  PRIMARY KEY (`departmentId`, `attachedCollege`),
  INDEX `fk_Departments_College_idx` (`attachedCollege` ASC),
  CONSTRAINT `fk_Departments_College`
    FOREIGN KEY (`attachedCollege`)
    REFERENCES `profsmato`.`Colleges` (`collegeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `profsmato`.`Degrees`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `profsmato`.`Degrees` ;

CREATE TABLE IF NOT EXISTS `profsmato`.`Degrees` (
  `degreeCode` VARCHAR(10) NOT NULL,
  `attachedCollege` VARCHAR(10) NOT NULL,
  `programName` VARCHAR(130) NOT NULL,
  PRIMARY KEY (`degreeCode`, `attachedCollege`),
  INDEX `fk_courses_College1_idx` (`attachedCollege` ASC),
  CONSTRAINT `fk_courses_College1`
    FOREIGN KEY (`attachedCollege`)
    REFERENCES `profsmato`.`Colleges` (`collegeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `profsmato`.`ref_status`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `profsmato`.`ref_status` ;

CREATE TABLE IF NOT EXISTS `profsmato`.`ref_status` (
  `statusId` INT(2) NOT NULL AUTO_INCREMENT,
  `status` VARCHAR(45) NULL,
  PRIMARY KEY (`statusId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `profsmato`.`Students`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `profsmato`.`Students` ;

CREATE TABLE IF NOT EXISTS `profsmato`.`Students` (
  `studentEmail` VARCHAR(50) NOT NULL,
  `username` VARCHAR(60) NOT NULL,
  `password` VARCHAR(50) NOT NULL,
  `lastname` VARCHAR(45) NOT NULL,
  `firstname` VARCHAR(45) NOT NULL,
  `program` VARCHAR(10) NULL,
  `status` INT(2) NOT NULL,
  `about` VARCHAR(70) NULL,
  `profilepic` TEXT NULL,
  `userType` ENUM('student', 'admin') NOT NULL,
  PRIMARY KEY (`studentEmail`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC),
  INDEX `fk_Students_Courses2_idx` (`program` ASC),
  INDEX `fk_Students_ref_status1_idx` (`status` ASC),
  CONSTRAINT `fk_Students_Courses2`
    FOREIGN KEY (`program`)
    REFERENCES `profsmato`.`Degrees` (`degreeCode`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Students_ref_status1`
    FOREIGN KEY (`status`)
    REFERENCES `profsmato`.`ref_status` (`statusId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `profsmato`.`Professors`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `profsmato`.`Professors` ;

CREATE TABLE IF NOT EXISTS `profsmato`.`Professors` (
  `profEmail` VARCHAR(50) NOT NULL,
  `lastname` VARCHAR(45) NOT NULL,
  `firstname` VARCHAR(45) NOT NULL,
  `department` VARCHAR(10) NULL,
  `about` VARCHAR(70) NULL,
  `profPicture` TEXT NULL,
  `status` INT(2) NULL,
  INDEX `fk_Professors_Departments2_idx` (`department` ASC),
  INDEX `fk_Professors_ref_status1_idx` (`status` ASC),
  PRIMARY KEY (`profEmail`),
  CONSTRAINT `fk_Professors_Departments2`
    FOREIGN KEY (`department`)
    REFERENCES `profsmato`.`Departments` (`departmentId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Professors_ref_status1`
    FOREIGN KEY (`status`)
    REFERENCES `profsmato`.`ref_status` (`statusId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `profsmato`.`Courses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `profsmato`.`Courses` ;

CREATE TABLE IF NOT EXISTS `profsmato`.`Courses` (
  `courseCode` VARCHAR(7) NOT NULL,
  `courseName` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`courseCode`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `profsmato`.`ref_contact`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `profsmato`.`ref_contact` ;

CREATE TABLE IF NOT EXISTS `profsmato`.`ref_contact` (
  `ref_contactId` INT(2) NOT NULL AUTO_INCREMENT,
  `contactType` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ref_contactId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `profsmato`.`Contacts`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `profsmato`.`Contacts` ;

CREATE TABLE IF NOT EXISTS `profsmato`.`Contacts` (
  `personId` VARCHAR(50) NOT NULL,
  `contactType` INT(2) NOT NULL,
  `contactDetail` VARCHAR(60) NOT NULL,
  `persontType` ENUM('student', 'prof') NOT NULL,
  PRIMARY KEY (`personId`, `contactType`, `contactDetail`),
  INDEX `fk_Contacts_ref_contact1_idx` (`contactType` ASC),
  CONSTRAINT `fk_Contacts_ref_contact1`
    FOREIGN KEY (`contactType`)
    REFERENCES `profsmato`.`ref_contact` (`ref_contactId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Contacts_Students1`
    FOREIGN KEY (`personId`)
    REFERENCES `profsmato`.`Students` (`studentEmail`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Contacts_Professors1`
    FOREIGN KEY (`personId`)
    REFERENCES `profsmato`.`Professors` (`profEmail`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `profsmato`.`prof_courses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `profsmato`.`prof_courses` ;

CREATE TABLE IF NOT EXISTS `profsmato`.`prof_courses` (
  `profEmail` VARCHAR(50) NOT NULL,
  `coursesCode` VARCHAR(7) NOT NULL,
  PRIMARY KEY (`profEmail`, `coursesCode`),
  INDEX `fk_prof_subject_Subjects1_idx` (`coursesCode` ASC),
  CONSTRAINT `fk_prof_subject_Professors1`
    FOREIGN KEY (`profEmail`)
    REFERENCES `profsmato`.`Professors` (`profEmail`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_prof_subject_Subjects1`
    FOREIGN KEY (`coursesCode`)
    REFERENCES `profsmato`.`Courses` (`courseCode`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `profsmato`.`ref_reviewComment_status`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `profsmato`.`ref_reviewComment_status` ;

CREATE TABLE IF NOT EXISTS `profsmato`.`ref_reviewComment_status` (
  `statusId` INT(2) NOT NULL AUTO_INCREMENT,
  `status` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`statusId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `profsmato`.`Reviews`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `profsmato`.`Reviews` ;

CREATE TABLE IF NOT EXISTS `profsmato`.`Reviews` (
  `reviewId` INT(11) NOT NULL AUTO_INCREMENT,
  `studentEmail` VARCHAR(50) NOT NULL,
  `profEmail` VARCHAR(50) NOT NULL,
  `rating` INT(1) NOT NULL,
  `title` VARCHAR(60) NOT NULL,
  `body` VARCHAR(245) NOT NULL,
  `timestamp` DATETIME NOT NULL,
  `status` INT(2) NOT NULL,
  PRIMARY KEY (`reviewId`),
  INDEX `fk_Reviews_Students1_idx` (`studentEmail` ASC),
  INDEX `fk_Reviews_Professors1_idx` (`profEmail` ASC),
  UNIQUE INDEX `studentEmail_UNIQUE` (`studentEmail` ASC),
  UNIQUE INDEX `profEmail_UNIQUE` (`profEmail` ASC),
  INDEX `fk_Reviews_ref_reviewComment_status1_idx` (`status` ASC),
  CONSTRAINT `fk_Reviews_Students1`
    FOREIGN KEY (`studentEmail`)
    REFERENCES `profsmato`.`Students` (`studentEmail`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Reviews_Professors1`
    FOREIGN KEY (`profEmail`)
    REFERENCES `profsmato`.`Professors` (`profEmail`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Reviews_ref_reviewComment_status1`
    FOREIGN KEY (`status`)
    REFERENCES `profsmato`.`ref_reviewComment_status` (`statusId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `profsmato`.`review_reacts`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `profsmato`.`review_reacts` ;

CREATE TABLE IF NOT EXISTS `profsmato`.`review_reacts` (
  `reviewId` INT(11) NOT NULL,
  `student` VARCHAR(50) NOT NULL,
  `react` ENUM('Like', 'Dislike') NOT NULL,
  PRIMARY KEY (`reviewId`, `student`),
  INDEX `fk_review_reacts_Students1_idx` (`student` ASC),
  CONSTRAINT `fk_review_reacts_Reviews1`
    FOREIGN KEY (`reviewId`)
    REFERENCES `profsmato`.`Reviews` (`reviewId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_review_reacts_Students1`
    FOREIGN KEY (`student`)
    REFERENCES `profsmato`.`Students` (`studentEmail`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `profsmato`.`Comments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `profsmato`.`Comments` ;

CREATE TABLE IF NOT EXISTS `profsmato`.`Comments` (
  `commentId` INT(11) NOT NULL AUTO_INCREMENT,
  `reviewId` INT(11) NOT NULL,
  `studentEmail` VARCHAR(50) NOT NULL,
  `commentBody` VARCHAR(100) NOT NULL,
  `timestamp` DATETIME NOT NULL,
  `status` INT(2) NOT NULL,
  PRIMARY KEY (`commentId`, `reviewId`),
  INDEX `fk_Comments_Reviews1_idx` (`reviewId` ASC),
  INDEX `fk_Comments_ref_reviewComment_status1_idx` (`status` ASC),
  CONSTRAINT `fk_Comments_Reviews1`
    FOREIGN KEY (`reviewId`)
    REFERENCES `profsmato`.`Reviews` (`reviewId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Comments_ref_reviewComment_status1`
    FOREIGN KEY (`status`)
    REFERENCES `profsmato`.`ref_reviewComment_status` (`statusId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `profsmato`.`Reports`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `profsmato`.`Reports` ;

CREATE TABLE IF NOT EXISTS `profsmato`.`Reports` (
  `reportId` INT(11) NOT NULL AUTO_INCREMENT,
  `studentReported` VARCHAR(50) NOT NULL,
  `timestamp` DATETIME NOT NULL,
  `reason` VARCHAR(100) NOT NULL,
  `reviewId` INT(11) NULL,
  `commentId` INT(11) NULL,
  `isResolved` TINYINT(1) NOT NULL,
  `actionTaken` VARCHAR(100) NULL,
  PRIMARY KEY (`reportId`),
  INDEX `fk_Reports_Reviews1_idx` (`reviewId` ASC),
  INDEX `fk_Reports_Comments1_idx` (`commentId` ASC),
  CONSTRAINT `fk_Reports_Reviews1`
    FOREIGN KEY (`reviewId`)
    REFERENCES `profsmato`.`Reviews` (`reviewId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Reports_Comments1`
    FOREIGN KEY (`commentId`)
    REFERENCES `profsmato`.`Comments` (`reviewId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `profsmato`.`Colleges`
-- -----------------------------------------------------
START TRANSACTION;
USE `profsmato`;
INSERT INTO `profsmato`.`Colleges` (`collegeID`, `collegeName`) VALUES ('CCS', 'College of Computer Studies');
INSERT INTO `profsmato`.`Colleges` (`collegeID`, `collegeName`) VALUES ('BAGCED', 'College of Education');
INSERT INTO `profsmato`.`Colleges` (`collegeID`, `collegeName`) VALUES ('CLA', 'College of Liberal Arts');
INSERT INTO `profsmato`.`Colleges` (`collegeID`, `collegeName`) VALUES ('COS', 'College of Science');
INSERT INTO `profsmato`.`Colleges` (`collegeID`, `collegeName`) VALUES ('GCOE', 'Gokongwei College of Engineering');
INSERT INTO `profsmato`.`Colleges` (`collegeID`, `collegeName`) VALUES ('COB', 'College of Business');
INSERT INTO `profsmato`.`Colleges` (`collegeID`, `collegeName`) VALUES ('SOE', 'School of Economics');
INSERT INTO `profsmato`.`Colleges` (`collegeID`, `collegeName`) VALUES ('COL', 'College of Law');

COMMIT;


-- -----------------------------------------------------
-- Data for table `profsmato`.`Departments`
-- -----------------------------------------------------
START TRANSACTION;
USE `profsmato`;
INSERT INTO `profsmato`.`Departments` (`departmentId`, `attachedCollege`, `departmentName`) VALUES ('CT', 'CCS', 'Computer Technology');
INSERT INTO `profsmato`.`Departments` (`departmentId`, `attachedCollege`, `departmentName`) VALUES ('ST', 'CCS', 'Software Technology');
INSERT INTO `profsmato`.`Departments` (`departmentId`, `attachedCollege`, `departmentName`) VALUES ('IT', 'CCS', 'Information Technology');
INSERT INTO `profsmato`.`Departments` (`departmentId`, `attachedCollege`, `departmentName`) VALUES ('CEPD', 'BAGCED', 'Counseling and Educational Psychology Department');
INSERT INTO `profsmato`.`Departments` (`departmentId`, `attachedCollege`, `departmentName`) VALUES ('ELMD', 'BAGCED', 'Educational Leadership and Management Department');
INSERT INTO `profsmato`.`Departments` (`departmentId`, `attachedCollege`, `departmentName`) VALUES ('DEAL', 'BAGCED', 'Department of English and Applied Linguistics');
INSERT INTO `profsmato`.`Departments` (`departmentId`, `attachedCollege`, `departmentName`) VALUES ('PED', 'BAGCED', 'Physical Education Department');
INSERT INTO `profsmato`.`Departments` (`departmentId`, `attachedCollege`, `departmentName`) VALUES ('SED', 'BAGCED', 'Science Education Department');
INSERT INTO `profsmato`.`Departments` (`departmentId`, `attachedCollege`, `departmentName`) VALUES ('COL', 'COL', 'College of Law');
INSERT INTO `profsmato`.`Departments` (`departmentId`, `attachedCollege`, `departmentName`) VALUES ('BHS', 'CLA', 'Behavioral Sciences Department');
INSERT INTO `profsmato`.`Departments` (`departmentId`, `attachedCollege`, `departmentName`) VALUES ('COM', 'CLA', 'Department of Communication');
INSERT INTO `profsmato`.`Departments` (`departmentId`, `attachedCollege`, `departmentName`) VALUES ('FIL', 'CLA', 'Filipino Department');
INSERT INTO `profsmato`.`Departments` (`departmentId`, `attachedCollege`, `departmentName`) VALUES ('HIS', 'CLA', 'History Department');
INSERT INTO `profsmato`.`Departments` (`departmentId`, `attachedCollege`, `departmentName`) VALUES ('INT', 'CLA', 'International Studies Department');
INSERT INTO `profsmato`.`Departments` (`departmentId`, `attachedCollege`, `departmentName`) VALUES ('LIT', 'CLA', 'Literature Department');
INSERT INTO `profsmato`.`Departments` (`departmentId`, `attachedCollege`, `departmentName`) VALUES ('PHILO', 'CLA', 'Philosophy Department');
INSERT INTO `profsmato`.`Departments` (`departmentId`, `attachedCollege`, `departmentName`) VALUES ('POLISCI', 'CLA', 'Political Science Department');
INSERT INTO `profsmato`.`Departments` (`departmentId`, `attachedCollege`, `departmentName`) VALUES ('PSYC', 'CLA', 'Psychology Department');
INSERT INTO `profsmato`.`Departments` (`departmentId`, `attachedCollege`, `departmentName`) VALUES ('THEO', 'CLA', 'Theology and Religious Studies Department');
INSERT INTO `profsmato`.`Departments` (`departmentId`, `attachedCollege`, `departmentName`) VALUES ('BIO', 'COS', 'Biology Department');
INSERT INTO `profsmato`.`Departments` (`departmentId`, `attachedCollege`, `departmentName`) VALUES ('CHEM', 'COS', 'Chemistry Department');
INSERT INTO `profsmato`.`Departments` (`departmentId`, `attachedCollege`, `departmentName`) VALUES ('MATH', 'COS', 'Mathematics Department');
INSERT INTO `profsmato`.`Departments` (`departmentId`, `attachedCollege`, `departmentName`) VALUES ('PHY', 'COS', 'Physics Department');
INSERT INTO `profsmato`.`Departments` (`departmentId`, `attachedCollege`, `departmentName`) VALUES ('CHEME', 'GCOE', 'Chemical Engineering Department');
INSERT INTO `profsmato`.`Departments` (`departmentId`, `attachedCollege`, `departmentName`) VALUES ('CIVIL', 'GCOE', 'Civil Engineering Department');
INSERT INTO `profsmato`.`Departments` (`departmentId`, `attachedCollege`, `departmentName`) VALUES ('ECED', 'GCOE', 'Electronics and Communications Engineering Department');
INSERT INTO `profsmato`.`Departments` (`departmentId`, `attachedCollege`, `departmentName`) VALUES ('IED', 'GCOE', 'Industrial Engineering Department');
INSERT INTO `profsmato`.`Departments` (`departmentId`, `attachedCollege`, `departmentName`) VALUES ('MEMD', 'GCOE', 'Manufacturing Engineering and Management Department');
INSERT INTO `profsmato`.`Departments` (`departmentId`, `attachedCollege`, `departmentName`) VALUES ('MED', 'GCOE', 'Mechanical Engineering Department');
INSERT INTO `profsmato`.`Departments` (`departmentId`, `attachedCollege`, `departmentName`) VALUES ('ACCT', 'COB', 'Accountancy Department');
INSERT INTO `profsmato`.`Departments` (`departmentId`, `attachedCollege`, `departmentName`) VALUES ('CLD', 'COB', 'Commercial Law Department');
INSERT INTO `profsmato`.`Departments` (`departmentId`, `attachedCollege`, `departmentName`) VALUES ('DSID', 'COB', 'Decision Sciences and Innovation Department');
INSERT INTO `profsmato`.`Departments` (`departmentId`, `attachedCollege`, `departmentName`) VALUES ('FMD', 'COB', 'Financial Management Department');
INSERT INTO `profsmato`.`Departments` (`departmentId`, `attachedCollege`, `departmentName`) VALUES ('MOD', 'COB', 'Management and Organization Department');
INSERT INTO `profsmato`.`Departments` (`departmentId`, `attachedCollege`, `departmentName`) VALUES ('MMD', 'COB', 'Marketing Management Department');
INSERT INTO `profsmato`.`Departments` (`departmentId`, `attachedCollege`, `departmentName`) VALUES ('ECO', 'SOE', 'Economics Department');

COMMIT;


-- -----------------------------------------------------
-- Data for table `profsmato`.`Degrees`
-- -----------------------------------------------------
START TRANSACTION;
USE `profsmato`;
INSERT INTO `profsmato`.`Degrees` (`degreeCode`, `attachedCollege`, `programName`) VALUES ('CS-CSE', 'CCS', 'BS Computer Science Major in Computer Systems Engineering');
INSERT INTO `profsmato`.`Degrees` (`degreeCode`, `attachedCollege`, `programName`) VALUES ('CS-NE', 'CCS', 'BS Computer Science with Specialization in Network Engineering');
INSERT INTO `profsmato`.`Degrees` (`degreeCode`, `attachedCollege`, `programName`) VALUES ('CS-ST', 'CCS', 'BS Computer Science with Specialization in Software Technology');
INSERT INTO `profsmato`.`Degrees` (`degreeCode`, `attachedCollege`, `programName`) VALUES ('CS-IST', 'CCS', 'BS Computer Science with Specialization in Instructional Systems Technology');
INSERT INTO `profsmato`.`Degrees` (`degreeCode`, `attachedCollege`, `programName`) VALUES ('BS-INSYS', 'CCS', 'BS Information Systems');
INSERT INTO `profsmato`.`Degrees` (`degreeCode`, `attachedCollege`, `programName`) VALUES ('BSIT', 'CCS', 'BS Information Technology');
INSERT INTO `profsmato`.`Degrees` (`degreeCode`, `attachedCollege`, `programName`) VALUES ('JDCTR', 'COL', 'Juris Doctor');
INSERT INTO `profsmato`.`Degrees` (`degreeCode`, `attachedCollege`, `programName`) VALUES ('BSAEC', 'SOE', 'Bachelor of Science in Applied Economics major in Industrial Economics ');
INSERT INTO `profsmato`.`Degrees` (`degreeCode`, `attachedCollege`, `programName`) VALUES ('BSAE2', 'SOE', 'Bachelor of Science in Applied Economics major in Industrial Economics and Bachelor of Science in Accountancy');
INSERT INTO `profsmato`.`Degrees` (`degreeCode`, `attachedCollege`, `programName`) VALUES ('BSA', 'COB', 'Bachelor of Science in Accountancy');
INSERT INTO `profsmato`.`Degrees` (`degreeCode`, `attachedCollege`, `programName`) VALUES ('BSADV', 'COB', 'Bachelor of Science in Advertising Management');
INSERT INTO `profsmato`.`Degrees` (`degreeCode`, `attachedCollege`, `programName`) VALUES ('BSMGT', 'COB', 'Bachelor of Science in Business Management');
INSERT INTO `profsmato`.`Degrees` (`degreeCode`, `attachedCollege`, `programName`) VALUES ('BSAPC', 'COB', 'Bachelor of Science in Applied Corporate Management');
INSERT INTO `profsmato`.`Degrees` (`degreeCode`, `attachedCollege`, `programName`) VALUES ('BSMKT', 'COB', 'Bachelor of Science in Marketing Management');
INSERT INTO `profsmato`.`Degrees` (`degreeCode`, `attachedCollege`, `programName`) VALUES ('BSCHE', 'GCOE', 'Bachelor of Science in Chemical Engineering');
INSERT INTO `profsmato`.`Degrees` (`degreeCode`, `attachedCollege`, `programName`) VALUES ('BSCPE', 'GCOE', 'Bachelor of Science in Computer Engineering');
INSERT INTO `profsmato`.`Degrees` (`degreeCode`, `attachedCollege`, `programName`) VALUES ('BSECE', 'GCOE', 'Bachelor of Science in Electronics Engineering');
INSERT INTO `profsmato`.`Degrees` (`degreeCode`, `attachedCollege`, `programName`) VALUES ('BSIE', 'GCOE', 'Bachelor of Science in Industrial Engineering');
INSERT INTO `profsmato`.`Degrees` (`degreeCode`, `attachedCollege`, `programName`) VALUES ('BSBIO', 'COS', 'Bachelor of Science in Biology ');
INSERT INTO `profsmato`.`Degrees` (`degreeCode`, `attachedCollege`, `programName`) VALUES ('BSCHY', 'COS', 'Bachelor of Science in Chemistry');
INSERT INTO `profsmato`.`Degrees` (`degreeCode`, `attachedCollege`, `programName`) VALUES ('BHBIO', 'COS', 'Bachelor of Science in Human Biology ');
INSERT INTO `profsmato`.`Degrees` (`degreeCode`, `attachedCollege`, `programName`) VALUES ('BSMTH', 'COS', 'Bachelor of Science in Mathematics ');
INSERT INTO `profsmato`.`Degrees` (`degreeCode`, `attachedCollege`, `programName`) VALUES ('BSSTT', 'COS', 'Bachelor of Science in Statistics major in Actuarial Science');
INSERT INTO `profsmato`.`Degrees` (`degreeCode`, `attachedCollege`, `programName`) VALUES ('ABBHS', 'CLA', 'Bachelor of Arts in Behavioral Sciences major in Organizational and Social Systems Development ');
INSERT INTO `profsmato`.`Degrees` (`degreeCode`, `attachedCollege`, `programName`) VALUES ('AB-HIS', 'CLA', 'Bachelor of Arts in History');
INSERT INTO `profsmato`.`Degrees` (`degreeCode`, `attachedCollege`, `programName`) VALUES ('ABIS', 'CLA', 'Bachelor of Arts in International Studies');
INSERT INTO `profsmato`.`Degrees` (`degreeCode`, `attachedCollege`, `programName`) VALUES ('AB-LIT', 'CLA', 'Bachelor of Arts in Literature');
INSERT INTO `profsmato`.`Degrees` (`degreeCode`, `attachedCollege`, `programName`) VALUES ('BEED', 'BAGCED', 'Bachelor of Science, Major in Early Childhood Education');
INSERT INTO `profsmato`.`Degrees` (`degreeCode`, `attachedCollege`, `programName`) VALUES ('BSED-ENGL', 'BAGCED', 'Bachelor of Secondary Education, major in English');
INSERT INTO `profsmato`.`Degrees` (`degreeCode`, `attachedCollege`, `programName`) VALUES ('BSED-BIO', 'BAGCED', 'Bachelor of Secondary Education Major in Biology');
INSERT INTO `profsmato`.`Degrees` (`degreeCode`, `attachedCollege`, `programName`) VALUES ('BSED-CHY', 'BAGCED', 'Bachelor of Secondary Education Major in Chemistry');
INSERT INTO `profsmato`.`Degrees` (`degreeCode`, `attachedCollege`, `programName`) VALUES ('BSED-MTH', 'BAGCED', 'Bachelor of Secondary Education, major in Mathematics');

COMMIT;


-- -----------------------------------------------------
-- Data for table `profsmato`.`ref_status`
-- -----------------------------------------------------
START TRANSACTION;
USE `profsmato`;
INSERT INTO `profsmato`.`ref_status` (`statusId`, `status`) VALUES (1, 'active');
INSERT INTO `profsmato`.`ref_status` (`statusId`, `status`) VALUES (2, 'pending');
INSERT INTO `profsmato`.`ref_status` (`statusId`, `status`) VALUES (3, 'inactive');

COMMIT;


-- -----------------------------------------------------
-- Data for table `profsmato`.`Students`
-- -----------------------------------------------------
START TRANSACTION;
USE `profsmato`;
INSERT INTO `profsmato`.`Students` (`studentEmail`, `username`, `password`, `lastname`, `firstname`, `program`, `status`, `about`, `profilepic`, `userType`) VALUES ('yuta_inoue@dlsu.edu.ph', 'Tatachiblob', 'yutainoue', 'Inoue', 'Yuta', 'BSIT', 1, 'I am Yuta Inoue.', 'default.png', 'student');
INSERT INTO `profsmato`.`Students` (`studentEmail`, `username`, `password`, `lastname`, `firstname`, `program`, `status`, `about`, `profilepic`, `userType`) VALUES ('ivana_lim@dlsu.edu.ph', 'poisonivysaurbridge', 'ivylim', 'Lim', 'Ivy', 'BSIT', 1, 'I am Ivy Lim.', 'default.png', 'admin');
INSERT INTO `profsmato`.`Students` (`studentEmail`, `username`, `password`, `lastname`, `firstname`, `program`, `status`, `about`, `profilepic`, `userType`) VALUES ('nigel_tan@dlsu.edu.ph', 'nigeltan', 'nigeltan', 'Tan', 'Nigel', 'BSIT', 1, 'I am Nigel Tan.', 'default.png', 'student');
INSERT INTO `profsmato`.`Students` (`studentEmail`, `username`, `password`, `lastname`, `firstname`, `program`, `status`, `about`, `profilepic`, `userType`) VALUES ('john_andrew_santiago@dlsu.edu.ph', 'andrewsantiago', 'andrewsantiago', 'Santiago', 'John Andrew', 'BSIT', 1, 'I am Andrew Santiago.', 'default.png', 'student');

COMMIT;


-- -----------------------------------------------------
-- Data for table `profsmato`.`Professors`
-- -----------------------------------------------------
START TRANSACTION;
USE `profsmato`;
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('frederico_ang@dlsu.edu.ph', 'Ang', 'Frederico', 'CT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('judith_azcarraga@dlsu.edu.ph', 'Azcarraga', 'Judith', 'CT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('alexie_ballon@dlsu.edu.ph', 'Ballon', 'Alexie', 'CT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('macario_cordel@dlsu.edu.ph', 'Cordel II', 'Macario', 'CT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('fritz_flores@dlsu.edu.ph', 'Flores', 'Fritz Kevin', 'CT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('geanne_franco@dlsu.edu.ph', 'Franco', 'Geanne', 'CT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('joel_ilao@dlsu.edu.ph', 'Ilao', 'Joel', 'CT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('franchesca_laguna@dlsu.edu.ph', 'Laguna', 'Ann Franchesca', 'CT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('karen_nomorosa@dlsu.edu.ph', 'Nomorosa', 'Karen', 'CT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('arlyn_ong@dlsu.edu.ph', 'Ong', 'Arlyn', 'CT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('marnel_peradilla@dlsu.edu.ph', 'Peradilla', 'Marnel', 'CT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('katrina_solomon@dlsu.edu.ph', 'Solomon', 'Katrina Ysabel', 'CT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('roger_uy@dlsu.edu.ph', 'Uy', 'Roger Luis', 'CT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('pierre_abesamis@dlsu.edu.ph', 'Abesamis', 'Pierre', 'IT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('jane_arcilla@dlsu.edu.ph', 'Arcilla', 'Mary Jane', 'IT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('estefanie_bertumen@dlsu.edu.ph', 'Bertumen', 'Estefanie', 'IT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('danny_cheng@dlsu.edu.ph', 'Cheng', 'Danny', 'IT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('michelle_ching@dlsu.edu.ph', 'Ching', 'Michelle Renee', 'IT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('alain_encarnacion@dlsu.edu.ph', 'Encarnacion', 'Alain Lizardo', 'IT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('christine_lim@dlsu.edu.ph', 'Lim', 'Christine Diane', 'IT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('oliver_malabanan@dlsu.edu.ph', 'Malabanan', 'Oliver', 'IT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('renato_molano@dlsu.edu.ph', 'Molano', 'Renato Jose Maria', 'IT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('loreto_sibayan@dlsu.edu.ph', 'Sibayan', 'Loreto', 'IT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('glenn_sipin@dlsu.edu.ph', 'Sipin', 'Glenn', 'IT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('liandro_tabora@dlsu.edu.ph', 'Tabora', 'Liandro Antonio', 'IT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('marivic_tangkeko@dlsu.edu.ph', 'Tangkeko', 'Marivic', 'IT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('geneva_timonera@dlsu.edu.ph', 'Timonera', 'Geneva Mara', 'IT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('emerico_auilar@dlsu.edu.ph', 'Aguilar', 'Emerico', 'ST', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('arnulfo_azcarraga@dlsu.edu.ph', 'Arnulfo', 'Azcarraga', 'ST', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('juan_balbin@dlsu.edu.ph', 'Balbin', 'Juan Paolo', 'ST', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('allan_borra@dlsu.edu.ph', 'Borra', 'Allan', 'ST', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('remedios_bulos@dlsu.edu.ph', 'Bulos', 'Remedios de Dios', 'ST', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('refael_cabredo@dlsu.edu.ph', 'Carbredo', 'Rafael', 'ST', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('arturo_caronongan@dlsu.edu.ph', 'Caronongan', 'Arturo III', 'ST', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('natalie_cheng@dlsu.edu.ph', 'Cheng', 'Natalie Lim', 'ST', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('shirley_chu@dlsu.edu.ph', 'Chu', 'Shirley', 'ST', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('gregory_cu@dlsu.edu.ph', 'Cu', 'Gregory', 'ST', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('jordan_deja@dlsu.edu.ph', 'Deja', 'Jordan Aiko', 'ST', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('neil_delgallego@dlsu.edu.ph', 'Del Gallego', 'Neil Patrick', 'ST', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('ryan_dimaunahan@dlsu.edu.ph', 'Dimaunahan', 'Ryan Samuael', 'ST', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('christine_gendrano@dlsu.edu.ph', 'Gendrano', 'Christine', 'ST', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('nathalie_lim@dlsu.edu.ph', 'Lim-Cheng', 'Nathalie', 'ST', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('teresita_limoanco@dlsu.edu.ph', 'Limoanco', 'Tereita', 'ST', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('patrice_lu@dlsu.edu.ph', 'Lu', 'Louis Patrice', 'ST', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('nelson_marcos@dlsu.edu.ph', 'Marcos', 'Nelson', 'ST', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('emilio_moghareh@dlsu.edu.ph', 'Moghareh', 'Emilio Ramin', 'ST', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('courtney_ngo@dlsu.edu.ph', 'Ngo', 'Courtney Anne', 'ST', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('ethel_ong@dlsu.edu.ph', 'Ong', 'Ethel Joy Chua', 'ST', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('jemie_que@dlsu.edu.ph', 'Que', 'Jemie', 'ST', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('ralph_regalado@dlsu.edu.ph', 'Regalado', 'Ralph Vincent', 'ST', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('conrado_ruiz@dlsu.edu.ph', 'Ruiz', 'Conrado Jr.', 'ST', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('florante_salvador@dlsu.edu.ph', 'Salvador', 'Forante Rofule', 'ST', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('briannne_samson@dlsu.edu.ph', 'Samson', 'Brianne Paul', 'ST', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('john_santillana@dlsu.edu.ph', 'Santillana', 'John Alexander', 'ST', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('solomon_see@dlsu.edu.ph', 'See', 'Solomon', 'ST', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('raymund_sison@dlsu.edu.ph', 'Sison', 'Raymund', 'ST', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('daniel_tan@dlsu.edu.ph', 'Tan', 'Daniel Stanley', 'ST', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('thomas_tiamlee@dlsu.edu.ph', 'Tiam-Lee', 'Thomas James', 'ST', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('edward_tighe@dlsu.edu.ph', 'Tighe', 'Edward', 'ST', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('esperanza_agoo@dlsu.edu.ph', 'Agoo', 'Esperanza', 'BIO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('zeba_alam@dlsu.edu.ph', 'Alam', 'Zeba Farooqi', 'BIO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('noel_alfonso@dlsu.edu.ph', 'Alfonso', 'Noel', 'BIO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('divina_amalin@dlsu.edu.ph', 'Amalin', 'Divina', 'BIO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('doree_arzadon@dlsu.edu.ph', 'Arzadon', 'Doree Esmeralda', 'BIO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('esperanza_cabrera@dlsu.edu.ph', 'Cabrera', 'Esperanza', 'BIO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('pacifico_calderon@dlsu.edu.ph', 'Calderon', 'Pacifico Eric', 'BIO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('patricio_cantilier@dlsu.edu.ph', 'Cantilier', 'Patricio', 'BIO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('chona_cruz@dlsu.edu.ph', 'Cruz', 'Chona Camille', 'BIO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('deocaris_custer@dlsu.edu.ph', 'Custer', 'Deocaris', 'BIO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('elenita_decastro@dlsu.edu.ph', 'De Castro', 'Elenita', 'BIO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('marie_reyes@dlsu.edu.ph', 'De Los Reyes', 'Marie', 'BIO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('addah_deperalta@dlsu.edu.ph', 'De Peralta', 'Addah', 'BIO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('christian_delarosa@dlsu.edu.ph', 'Dela Rosa', 'Christian Jordan', 'BIO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('mariquit_delosreyes@dlsu.edu.ph', 'Delos Reyes', 'Mariquit', 'BIO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('joy_esperanza@dlsu.edu.ph', 'Esperanza', 'Joy', 'BIO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('mary_flores@dlsu.edu.ph', 'Flores', 'Mary Jane', 'BIO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('jose_janairo@dlsu.edu.ph', 'Janairo', 'Jose', 'BIO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('nadine_ledesma@dlsu.edu.ph', 'Ledesma', 'Nadine', 'BIO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('virgilio_linis@dlsu.edu.ph', 'Linis', 'Virgilio', 'BIO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('eligio_maghirang@dlsu.edu.ph', 'Maghirang', 'Eligio', 'BIO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('ederlina_ocon@dlsu.edu.ph', 'Ocon', 'Ederlina', 'BIO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('melissa_pecundo@dlsu.edu.ph', 'Pecundo', 'Melissa', 'BIO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('micheal_ples@dlsu.edu.ph', 'Ples', 'Micheal', 'BIO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('gliceria_ramos@dlsu.edu.ph', 'Ramos', 'Gliceria', 'BIO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('dennis_raga@dlsu.edu.ph', 'Raga', 'Dennis', 'BIO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('cecilia_reyes@dlsu.edu.ph', 'Reyes', 'Cecilia', 'BIO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('jesus_sevilleja@dlsu.edu.ph', 'Sevilleja', 'Jesus Emmanuel', 'BIO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('carlene_solidum@dlsu.edu.ph', 'Solidum', 'Carlene', 'BIO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('derickerl_sumalapao@dlsu.edu.ph', 'Sumalapao', 'Derick Erl', 'BIO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('chrisitan_supsup@dlsu.edu.ph', 'Supsup', 'Christian', 'BIO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('marigold_uba@dlsu.edu.ph', 'Uba', 'Marigold', 'BIO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('rodel_vitor@dlsu.edu.ph', 'Vitor II', 'Rodel Jonathan', 'BIO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('lawrence_vitug@dlsu.edu.ph', 'Vitug', 'Lawrence', 'BIO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('laurenzo_alba@dlsu.edu.ph', 'Alba', 'Laurenzo', 'CHEM', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('glenn_alea@dlsu.edu.ph', 'Alea', 'Glenn', 'CHEM', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('jonah_bondoc@dlsu.edu.ph', 'Jonah', 'Bondoc', 'CHEM', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('janmicheal_cayme@dlsu.edu.ph', 'Cayme', 'Jan-Micheal', 'CHEM', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('wilfred_chung@dlsu.edu.ph', 'Chung', 'Wilfred', 'CHEM', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('rafael_espiritu@dlsu.edu.ph', 'Espiritu', 'Rafael', 'CHEM', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('darcy_garza@dlsu.edu.ph', 'Garza', 'Darcy', 'CHEM', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('lourdes_guidote@dlsu.edu.ph', 'Guidote', 'Lourdes', 'CHEM', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('jaime_janairo@dlsu.edu.ph', 'Janairo', 'Jaime', 'CHEM', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('faith_lagua@dlsu.edu.ph', 'Lagua', 'Faith', 'CHEM', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('nancy_lazaro@dlsu.edu.ph', 'Lazaro-Llanos', 'Nancy', 'CHEM', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('carlo_ng@dlsu.edu.ph', 'Ng', 'Carlo Antonio', 'CHEM', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('vincent_ng@dlsu.edu.ph', 'Ng', 'Vincent Antonio', 'CHEM', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('julius_nunez@dlsu.edu.ph', 'Nunez', 'Julius Andrew', 'CHEM', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('candy_ondevilla@dlsu.edu.ph', 'Ondevilla', 'Candy', 'CHEM', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('sarah_ong@dlsu.edu.ph', 'Ong', 'Sarah Diane', 'CHEM', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('david_penaloza@dlsu.edu.ph', 'Penaloza', 'David', 'CHEM', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('eric_punzalan@dlsu.edu.ph', 'Punzalan', 'Eric Camilo', 'CHEM', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('nesse_ressureccion@dlsu.edu.ph', 'Resuureccion', 'Nesse', 'CHEM', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('therese_rosbero@dlsu.edu.ph', 'Rosbero', 'Therese', 'CHEM', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('regina_salmasan@dlsu.edu.ph', 'Salmasan', 'Regina', 'CHEM', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('rodolfo_simayao@dlsu.edu.ph', 'Simayao', 'Rodolfo', 'CHEM', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('ryan_sytu@dlsu.edu.ph', 'Sytu', 'Ryan', 'CHEM', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('everlyn_tamayo@dlsu.edu.ph', 'Tamayo', 'Everlyn', 'CHEM', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('roger_tan@dlsu.edu.ph', 'Tan', 'Roger', 'CHEM', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('peter_tenido@dlsu.edu.ph', 'Tenido', 'Peter', 'CHEM', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('phoebe_trio@dlsu.edu.ph', 'Trio', 'Phoebe Zapanta', 'CHEM', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('joey_valinton@dlsu.edu.ph', 'Valinton', 'Joey', 'CHEM', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('derrick_yu@dlsu.edu.ph', 'Yu', 'Derrick Ethelbhert', 'CHEM', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('maxima_acelajado@dlsu.edu.ph', 'Acelajado', 'Maxima', 'MATH', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('angelo_alberto@dlsu.edu.ph', 'Alberto', 'Angelo', 'MATH', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('john_alcantara@dlsu.edu.ph', 'Alcantara', 'John Harold', 'MATH', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('francis_campena@dlsu.edu.ph', 'Campena', 'Francis Joseph', 'MATH', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('luisette_candelaria@dlsu.edu.ph', 'Candelaria', 'Luisette', 'MATH', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('rafael_cantuba@dlsu.edu.ph', 'Cantuba', 'Rafael Reno', 'MATH', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('riza_carasig@dlsu.edu.ph', 'Carasig', 'Riza', 'MATH', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('avegail_carpio@dlsu.edu.ph', 'Carpio', 'Avegail', 'MATH', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('kristine_carpio@dlsu.edu.ph', 'Carpio', 'Kristine Joy', 'MATH', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('frumencio_co@dlsu.edu.ph', 'Co', 'Frumencio', 'MATH', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('harris_delacruz@dlsu.edu.ph', 'Dela Cruz', 'Harris', 'MATH', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('ronald_florendo@dlsu.edu.ph', 'Florendo', 'Ronald', 'MATH', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('mark_garcia@dlsu.edu.ph', 'Garcia', 'Mark Anthony', 'MATH', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('clarence_gatchalian@dlsu.edu.ph', 'Gatchalian', 'Clarence', 'MATH', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('alana_hernandez@dlsu.edu.ph', 'Hernandez', 'Alana Margarita', 'MATH', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('isagani_jos@dlsu.edu.ph', 'Jos', 'Isagani', 'MATH', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('angelyn_lao@dlsu.edu.ph', 'Lao', 'Angelyn', 'MATH', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('mong_llarenas@dlsu.edu.ph', 'Llarenas', 'Mong', 'MATH', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('brian_lopez@dlsu.edu.ph', 'Lopez', 'Brian', 'MATH', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('leah_martin@dlsu.edu.ph', 'Martin-Lundag', 'Leah', 'MATH', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('ederlina_nocon@dlsu.edu.ph', 'Nocon', 'Ederlina', 'MATH', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('shirlee_ocampo@dlsu.edu.ph', 'Ocampo', 'Shirlee', 'MATH', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('christine_octavo@dlsu.edu.ph', 'Octavo', 'Christine Joy', 'MATH', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('anita_ong@dlsu.edu.ph', 'Ong', 'Anita', 'MATH', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('arturo_pacificador@dlsu.edu.ph', 'Pacificador', 'Arturo', 'MATH', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('shera_pausang@dlsu.edu.ph', 'Pausang', 'Shera Marie', 'MATH', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('edmundo_perez@dlsu.edu.ph', 'Perez Jr', 'Edmundo', 'MATH', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('rigor_ponsones@dlsu.edu.ph', 'Ponsones', 'Rigor', 'MATH', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('jose_tristan_reyes@dlsu.edu.ph', 'Reyes', 'Jose Tristan', 'MATH', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('maria_reyes@dlsu.edu.ph', 'Reyes', 'Maria Angeli', 'MATH', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('leonor_ruividar@dlsu.edu.ph', 'Ruividar', 'Leonor', 'MATH', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('bernadette_santos@dlsu.edu.ph', 'Santos', 'Bernadette Louise', 'MATH', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('christopher_santos@dlsu.edu.ph', 'Santos', 'Christopher', 'MATH', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('diana_songsong@dlsu.edu.ph', 'Songsong', 'Diana Cerzo', 'MATH', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('derick_sumalapao@dlsu.edu.ph', 'Sumalapao', 'Derick Erl', 'MATH', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('michele_tan@dlsu.edu.ph', 'Tan', 'Michele', 'MATH', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('sonia_tan@dlsu.edu.ph', 'Tan', 'Sonia', 'MATH', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('deneisha_tieng@dlsu.edu.ph', 'Tieng', 'Deneisha Balictar', 'MATH', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('regina_tresvalles@dlsu.edu.ph', 'Tresvalles', 'Regina', 'MATH', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('melvin_vidar@dlsu.edu.ph', 'Vidar', 'Melvin', 'MATH', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('jasmine_albelda', 'Albelda', 'Jasmine Angelie', 'PHY', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('norberto_alcantara@dlsu.edu.ph', 'Alcantara', 'Norberto', 'PHY', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('ryan_arevalo@dlsu.edu.ph', 'Arevalo', 'Ryan', 'PHY', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('ermys_bornilla@dlsu.edu.ph', 'Bornilla', 'Ermys', 'PHY', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('melanie_david@dlsu.edu.ph', 'David', 'Melanie', 'PHY', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('micheal_delmo@dlsu.edu.ph', 'Delmo', 'Micheal', 'PHY', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('john_enriquez@dlsu.edu.ph', 'Enriquez', 'John Isaac', 'PHY', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('maria_galvez@dlsu.edu.ph', 'Galvez', 'Maria Cecilia', 'PHY', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('richard_hartmann@dlsu.edu.ph', 'Hartmann', 'Richard', 'PHY', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('klaud_haygood@dlsu.edu.ph', 'Haygood', 'Klaud', 'PHY', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('alfonso_jadie@dlsu.edu.ph', 'Jadie', 'Alfonso Vicente', 'PHY', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('kevin_kaw@dlsu.edu.ph', 'Kaw', 'Kevin Anthony', 'PHY', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('enrique_manzano@dlsu.edu.ph', 'Nazano', 'Enrique', 'PHY', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('maria_monzano@dlsu.edu.ph', 'Manzano', 'Maria Carla', 'PHY', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('joselito_muldera@dlsu.edu.ph', 'Muldera', 'Joselito', 'PHY', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('michelle_natividad@dlsu.edu.ph', 'Natividad', 'Michelle', 'PHY', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('shirley_palisoc@dlsu.edu.ph', 'Palisoc', 'Shirley', 'PHY', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('vanessa_perianes@dlsu.edu.ph', 'Perianes', 'Vanessa', 'PHY', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('romeric_pobre@dlsu.edu.ph', 'Pobre', 'Romeroc', 'PHY', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('christopher_que@dlsu.edu.ph', 'Que', 'Christopher', 'PHY', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('reuben_quiroga@dlsu.edu.ph', 'Quiroga', 'Reuben', 'PHY', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('ofelia_rempillo@dlsu.edu.ph', 'Rempillo', 'Ofelia', 'PHY', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('emmanuel_rodulfo@dlsu.edu.ph', 'Rodulfo', 'Emmanuel', 'PHY', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('joseph_scheiter@dlsu.edu.ph', 'Scheiter', 'Joseph', 'PHY', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('jade_trono@dlsu.edu.ph', 'Trono', 'Jade Dungao', 'PHY', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('edgar_vallar@dlsu.edu.ph', 'Vallar', 'Edgar', 'PHY', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('enrico_villacorta@dlsu.edu.ph', 'Villacorta', 'Enrico', 'PHY', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('al_villagracia@dlsu.edu.ph', 'Villagracia', 'Al Rey', 'PHY', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('miel_abdon@dlsu.edu.ph', 'Abdon', 'Miel', 'BHS', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('roberto_abello@dlsu.edu.ph', 'Abello', 'Roberto Prudencio', 'BHS', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('james_aranet@dlsu.edu.ph', 'Araneta', 'James', 'BHS', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('myla_arcinas@dlsu.edu.ph', 'Arcinas', 'Myla', 'BHS', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('annabelle_bonje@dlsu.edu.ph', 'Bonje', 'Annabelle', 'BHS', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('bernardo_bonoan@dlsu.edu.ph', 'Bonoan', 'Bernardo', 'BHS', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('omega_danganan@dlsu.edu.ph', 'Danganan', 'Omega Diadem', 'BHS', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('kennith_dillena@dlsu.edu.ph', 'Dillena', 'Kennith', 'BHS', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('yellowbelle_duaqui@dlsu.edu.ph', 'Duaqui', 'Yellowbelle', 'BHS', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('marlon_era@dlsu.edu.ph', 'Era', 'Marlon', 'BHS', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('dennis_erasga@dlsu.edu.ph', 'Erasga', 'Dennis', 'BHS', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('melvin_jabar@dlsu.edu.ph', 'Jabar', 'Melvin', 'BHS', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('romeo_lee@dlsu.edu.ph', 'Lee', 'Romeo', 'BHS', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('alicia_manlagnit@dlsu.edu.ph', 'Malagnnit', 'Alicia', 'BHS', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('erlinda_natocyad@dlsu.edu.ph', 'Natocyad', 'Erlinda', 'BHS', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('cristina_rodriguez@dlsu.edu.ph', 'Rodriguez', 'Cristina', 'BHS', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('frances_sarmiento@dlsu.edu.ph', 'Sarmiento', 'Frances', 'BHS', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('erika_saturay@dlsu.edu.ph', 'Saturay', 'Erika', 'BHS', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('karen_so@dlsu.edu.ph', 'So', 'Karen', 'BHS', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('josefina_tondo@dlsu.edu.ph', 'Tondo', 'Josefina', 'BHS', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('diana_veloso@dlsu.edu.ph', 'Veloso', 'Diana', 'BHS', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('alphonsus_alfonso@dlsu.edu.ph', 'Alphonsus', 'Alfonso', 'COM', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('rica_arevalo@dlsu.edu.ph', 'Arevalo', 'Rica', 'COM', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('winston_baltasar@dlsu.edu.ph', 'Baltasar', 'Winston', 'COM', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('jan_bernadas@dlsu.edu.ph', 'Bernadas', 'Jan Micheal', 'COM', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('jacqueline_buenafe@dlsu.edu.ph', 'Buenafe', 'Jacqueline', 'COM', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('neil_burdeos@dlsu.edu.ph', 'Burdeos', 'Neil', 'COM', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('angeli_diaz@dlsu.edu.ph', 'Diaz', 'Angeli', 'COM', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('jimmy_domingo@dlsu.edu.ph', 'Domingo', 'Jimmy', 'COM', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('carlo_figueroa@dlsu.edu.ph', 'Figueroa', 'Carlo', 'COM', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('blaise_gacoscos@dlsu.edu.ph', 'Gacoscos', 'Blaise Rogel', 'COM', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('gerado_mariano@dlsu.edu.ph', 'Mariano', 'Gerardo', 'COM', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('clarissa_militante@dlsu.edu.ph', 'Militante', 'Clarissa', 'COM', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('miguel_paredes@dlsu.edu.ph', 'Paredes', 'Miguel Paolo', 'COM', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('joey_reyes@dlsu.edu.ph', 'Reyes', 'Joey', 'COM', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('joaquin_reuiz@dlsu.edu.ph', 'Reuiz', 'Joaquin', 'COM', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('eva_salvador@dlsu.edu.ph', 'Salvador', 'Eva', 'COM', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('ivory_sioson@dlsu.edu.ph', 'Sioson', 'Ivory', 'COM', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('norman_zafra@dlsu.edu.ph', 'Zafra', 'Norman', 'COM', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('remar_zamora@dlsu.edu.ph', 'Zamora', 'Remar', 'COM', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('myra_adoptante@dlsu.edu.ph', 'Adoptante', 'Myra', 'HIS', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('rita_agudon@dlsu.edu.ph', 'Agudon', 'Rita', 'HIS', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('cornelio_bascar@dlsu.edu.ph', 'Bascar', 'Cornelio', 'HIS', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('micheal_chua@dlsu.edu.ph', 'Chua', 'Micheal Charleston', 'HIS', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('lisandro_claudio@dlsu.edu.ph', 'Claudio', 'Lisandro Elias Estrada', 'HIS', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('easter_dabuet@dlsu.edu.ph', 'Dabuet', 'Easter Joy', 'HIS', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('arleigh_delacruz@dlsu.edu.ph', 'Dela Cruz', 'Arleigh', 'HIS', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('marlon_delupio@dlsu.edu.ph', 'Delupio', 'Marlon', 'HIS', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('luis_dery@dlsu.edu.ph', 'Dery', 'Luis', 'HIS', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('jose_duria@dlsu.edu.ph', 'Duria', 'Jose Lester', 'HIS', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('rene_escalante@dlsu.edu.ph', 'Escalante', 'Rene', 'HIS', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('rhommel_hernandez@dlsu.edu.ph', 'Hernandez', 'Rhommel', 'HIS', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('jose_jimenez@dlsu.edu.ph', 'Jimenez', 'Jose Victor', 'HIS', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('rose_lacuata@dlsu.edu.ph', 'Lacuata', 'Rose', 'HIS', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('roland_mactal@dlsu.edu.ph', 'Mactal', 'Roland', 'HIS', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('florina_orillos@dlsu.edu.ph', 'Orillos-Juan', 'Florina', 'HIS', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('fernando_santiago@dlsu.edu.ph', 'Santiago Jr', 'Fernando', 'HIS', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('jose_torres@dlsu.edu.ph', 'Torres', 'Jose Victor', 'HIS', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('lars_ubaldo@dlsu.edu.ph', 'Ubaldo', 'Lars', 'HIS', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('vicente_ybiernas@dlsu.edu.ph', 'Ybiernas', 'Vicente', 'HIS', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('ruby_alunen@dlsu.edu.ph', 'Alunen', 'Ruby', 'FIL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('ereberto_astorga@dlsu.edu.ph', 'Astorga', 'Ereberto', 'FIL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('emma_basco@dlsu.edu.ph', 'Basco', 'Emma', 'FIL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('mirylle_calindro@dlsu.edu.ph', 'Calindro', 'Mirylle', 'FIL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('dexter_cayanes@dlsu.edu.ph', 'Cayanes', 'Dexter', 'FIL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('ramil_correa@dlsu.edu.ph', 'Correa', 'Ramil', 'FIL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('arleigh_cruz@dlsu.edu.ph', 'Dela Cruz', 'Arleigh', 'FIL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('efren_domingo@dlsu.edu.ph', 'Domingo', 'Efren', 'FIL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('teresita_fortunato@dlsu.edu.ph', 'Fortunato', 'Teresita', 'FIL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('fanny_garcia@dlsu.edu.ph', 'Garcia', 'Fanny', 'FIL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('lakangiting_garcia@dlsu.edu.ph', 'Garcia', 'Lakangiting', 'FIL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('felicitas_herrera@dlsu.edu.ph', 'Herrera', 'Felicitas', 'FIL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('alona_jumaquio@dlsu.edu.ph', 'Jumaquio-Ardales', 'Alona', 'FIL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('danalyn_lubang@dlsu.edu.ph', 'Lubang', 'Danalyn', 'FIL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('rowell_madula@dlsu.edu.ph', 'Madula', 'Rowell', 'FIL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('josefina_mangahis@dlsu.edu.ph', 'Mangahis', 'Josefina', 'FIL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('lilbeth_quiore@dlsu.edu.ph', 'Quiore', 'Lilbeth', 'FIL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('joel_orellana@dlsu.edu.ph', 'Orellana', 'Joel', 'FIL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('marvin_reyes@dlsu.edu.ph', 'Reyes', 'Marvin', 'FIL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('maria_ricohermoso@dlsu.edu.ph', 'Ricohermoso', 'Maria Wevenia', 'FIL', NULL, 'default..png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('maria_roxas@dlsu.edu.ph', 'Roxas', 'Maria Lucille', 'FIL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('david_sanjuan@dlsu.edu.ph', 'San Juan', 'David', 'FIL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('racquel_sison@dlsu.edu.ph', 'Sison-Buban', 'Racquel', 'FIL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('emma_sison@dlsu.edu.ph', 'Sison', 'Emma', 'FIL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('grace_tabernero@dlsu.edu.ph', 'Tabernero', 'Grace', 'FIL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('dolores_taylan@dlsu.edu.ph', 'Taylan', 'Dolores', 'FIL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('myrna_torreliza@dlsu.edu.ph', 'Torreliza', 'Myrna', 'FIL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('john_binondo@dlsu.edu.ph', 'Binondo', 'John Phillip', 'INT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('renato_decastro@dlsu.edu.ph', 'De Castro', 'Renato', 'INT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('francisco_deguzman@dlsu.edu.ph', 'De Guzman', 'Francisco', 'INT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('lorenzo_delossantos@dlsu.edu.ph', 'Delos Santos', 'Lorenzo', 'INT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('robin_garcia@dlsu.edu.ph', 'Garcia', 'Robin Micheal', 'INT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('bernadette_hieida@dlsu.edu.ph', 'Hieida', 'Bernadette', 'INT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('severo_madrona@dlsu.edu.ph', 'Madrona', 'Severo', 'INT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('anastacio_marasigan@dlsu.edu.ph', 'Marasigan Jr', 'Anastacio', 'INT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('ann_pierre@dlsu.edu.ph', 'Peirre', 'Ann', 'INT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('karen_rodrigo@dlsu.edu.ph', 'Rodrigo', 'Karen', 'INT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('benjamin_sanjose@dlsu.edu.ph', 'San Jose', 'Benjamin', 'INT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('elaine_tolentino@dlsu.edu.ph', 'Tolentino', 'Elaine', 'INT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('ron_vilog@dlsu.edu.ph', 'Vilog', 'Ron Bridget', 'INT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('charmain_willoughby@dlsu.edu.ph', 'Willoughby', 'Charmaine', 'INT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('sylvelyn_almanzor@dlsu.edu.ph', 'Almonzor', 'Sylvelyn Jo', 'LIT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('vijae_alquisola@dlsu.edu.ph', 'Alquisola', 'Vijae Orquia', 'LIT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('mesandel_argulles@dlsu.edu.ph', 'Arguelles', 'Mesandel', 'LIT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('antonette_arogo@dlsu.edu.ph', 'Arogo', 'Antonette Talaue', 'LIT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('genevieve_asenjo@dlsu.edu.ph', 'Asenjo', 'Genevieve', 'LIT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('anne_balgos@dlsu.edu.ph', 'Balgos', 'Anne Richie', 'LIT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('josefina_baui@dlsu.edu.ph', 'Baui', 'Josefina', 'LIT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('ronald_baytan@dlsu.edu.ph', 'Baytan', 'Ronald', 'LIT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('ericka_carreon@dlsu.edu.ph', 'Carreon', 'Ericka', 'LIT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('calito_casaje@dlsu.edu.ph', 'Casaje', 'Carlito', 'LIT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('jeremy_chavez@dlsu.edu.ph', 'Chavez', 'Jeremy De', 'LIT', NULL, 'defaut.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('johann_espiritu@dlsu.edu.ph', 'Espiritu', 'Johann Vladimir', 'LIT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('genero_gojo@dlsu.edu.ph', 'Gojo-Cruz', 'Genaro', 'LIT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('kim_lira@dlsu.edu.ph', 'Lira', 'Kim', 'LIT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('jazmin_llana@dlsu.edu.ph', 'Llana', 'Jazmin', 'LIT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('shirley_lua@dlsu.edu.ph', 'Lua', 'Shirley', 'LIT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('randy_magdaluyo@dlsu.edu.ph', 'Magdaluyo', 'Randy', 'LIT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('mario_mendez@dlsu.edu.ph', 'Mendez Jr', 'Mario', 'LIT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('timothy_montes@dlsu.edu.ph', 'Montes', 'Timothy', 'LIT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('noel_moratilla@dlsu.edu.ph', 'Moratilla', 'Noel Christian', 'LIT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('cris_pe@dlsu.edu.ph', 'Pe', 'Cris Barba', 'LIT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('carlos_piocos@dlsu.edu.ph', 'Piocos III', 'Carlos', 'LIT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('dinah_roma@dlsu.edu.ph', 'Roma', 'Dinah', 'LIT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('anne_sangil@dlsu.edu.ph', 'Sangil', 'Anne Frances', 'LIT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('tanya_simoon@dlsu.edu.ph', 'Simon', 'Tanya', 'LIT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('oscar_solapco@dlsu.edu.ph', 'Solapco Jr', 'Oscar', 'LIT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('teresa_wright@dlsu.edu.ph', 'Wright', 'Ma Teresa', 'LIT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('miel_abadon@dlsu.edu.ph', 'Abadon', 'Miel', 'PHILO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('dennis_apolega@dlsu.edu.ph', 'Apolega', 'Dennis', 'PHILO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('hazel_biana@dlsu.edu.ph', 'Biana', 'Hazel', 'PHILO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('mark_dacela@dlsu.edu.ph', 'Dacela', 'Mark Anthony', 'PHILO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('ferdinand_dagmang@dlsu.edu.ph', 'Dagmang', 'Ferdinand', 'PHILO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('noelle_delacruz@dlsu.edu.ph', 'Dela Cruz', 'Noelle', 'PHILO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('rafael_dolor@dlsu.edu.ph', 'Dolor', 'Rafael', 'PHILO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('rosalia_domingo@dlsu.edu.ph', 'Domingo', 'Rosalia', 'PHILO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('martin_esteves@dlsu.edu.ph', 'Esteves', 'Martin Joseph', 'PHILO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('elenita_garcia@dlsu.edu.ph', 'Garcia', 'Elenita', 'PHILO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('victor_gojocco@dlsu.edu.ph', 'Gojocco', 'Victor', 'PHILO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('jeremiah_joaquin@dlsu.edu.ph', 'Joaquin', 'Jeremiah', 'PHILO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('dante_leoncini@dlsu.edu.ph', 'Leonicni', 'Dante Luis', 'PHILO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('victorino_lualhati@dlsu.edu.ph', 'Lualhati', 'Victorino Raymundo', 'PHILO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('jose_malbarosa@dlsu.edu.ph', 'Malbarosa', 'Jose', 'PHILO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('natividad_manauat@dlsu.edu.ph', 'Manauat', 'Natividad Dominique', 'PHILO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('gansham_mansukhani@dlsu.edu.ph', 'Mansukhani', 'Gansham', 'PHILO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('karen_montecillo@dlsu.edu.ph', 'Montecillo', 'Karen', 'PHILO', NULL, 'default.pnng', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('beverly_ms@dlsu.edu.ph', 'Ms', 'Beverly', 'PHILO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('krizna_palces@dlsu.edu.ph', 'Palces', 'Krizna Rei', 'PHILO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('gerald_penaranda@dlsu.edu.ph', 'Penaranda', 'Gerald', 'PHILO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('jeane_peracullo@dlsu.edu.ph', 'Peracullo', 'Jeane', 'PHILO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('cesar_unson@dlsu.edu.ph', 'Unson Jr', 'Cesar', 'PHILO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('mary_velasco@dlsu.edu.ph', 'Velasco', 'Mary Laureen', 'PHILO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('ignacio_ver@dlsu.edu.ph', 'Ver', 'Ignacio', 'PHILO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('ernest_villacorta@dlsu.edu.ph', 'Villacorta', 'Ernest Geir', 'PHILO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('monica_ang@dlsu.edu.ph', 'Ang', 'Monica', 'POLISCI', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('sebastian_asuncion@dlsu.edu.ph', 'Asuncion', 'Sebastian', 'POLISCI', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('cleo_calimbahin@dlsu.edu.ph', 'Calimbahin', 'Cleo', 'POLISCI', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('julien_carandang@dlsu.edu.ph', 'Carandang', 'Julien', 'POLISCI', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('lolita_chalkasra@dlsu.edu.ph', 'Chalkasra', 'Lolita Safaee', 'POLISCI', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('antonio_contreras@dlsu.edu.ph', 'Contreras', 'Antonio', 'POLISCI', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('danilo_delossantos@dlsu.edu.ph', 'Delos Santos', 'Danilo', 'POLISCI', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('gerardo_eusebio@dlsu.edu.ph', 'Eusebio', 'Gerardo', 'POLISCI', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('milagros_lomotan@dlsu.edu.ph', 'Lomotan', 'Marial Milagros Regina', 'POLISCI', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('vicente_groyon@dlsu.edu.ph', 'Groyon', 'Vicente Victor Emmanuel Garcia', 'POLISCI', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('sherwin_ona@dlsu.edu.ph', 'Ona', 'Sherwin', 'POLISCI', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('matthew_ordonez@dlsu.edu.ph', 'Ordonez', 'Matthew David', 'POLISCI', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('antonio_pedro@dlsu.edu.ph', 'Pedro Jr', 'Antonio', 'POLISCI', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('shiela_puruganan@dlsu.edu.ph', 'Puruganan', 'Shiela', 'POLISCI', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('joseph_reyes@dlsu.edu.ph', 'Reyes', 'Joseph Anthony', 'POLISCI', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('divina_roldan@dlsu.edu.ph', 'Roldan', 'Ma. Divina Garcia', 'POLISCI', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('edsel_sajor@dlsu.edu.ph', 'Sajor', 'Edsel', 'POLISCI', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('edwin_santiago@dlsu.edu.ph', 'Santiago', 'Edwin', 'POLISCI', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('allen_surla@dlsu.edu.ph', 'Surla', 'Allen', 'POLISCI', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('glenn_teh@dlsu.edu.ph', 'Teh', 'Glenn', 'POLISCI', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('rodolfo_tor@dlsu.edu.ph', 'Tor', 'Rodolfo', 'POLISCI', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('ador_torne@dlsu.edu.ph', 'Torneo', 'Ador', 'POLISCI', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('alessandra_arpon@dlsu.edu.ph', 'Arpon', 'Alessandra', 'PSYC', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('dinah_asiatico@dlsu.edu.ph', 'Asiatico', 'Ma. Dinah', 'PSYC', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('jim_baoloy@dlsu.edu.ph', 'Baoloy', 'Jim Rey', 'PSYC', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('reynaldo_canlas@dlsu.edu.ph', 'Canlas', 'Reynaldo Nuelito', 'PSYC', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('karina_crisostomo@dlsu.edu.ph', 'Crisostomo', 'Karina', 'PSYC', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('filemon_cruz@dlsu.edu.ph', 'Cruz', 'Filemon', 'PSYC', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('richthofen_dejesus@dlsu.edu.ph', 'De Jesus', 'Richthofen', 'PSYC', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('darren_dumaop@dlsu.edu.ph', 'Dumaop', 'Darren', 'PSYC', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('dinah_espartero@dlsu.edu.ph', 'Espartero-Asiatico', 'Dinah', 'PSYC', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('jose_espiritu@dlsu.edu.ph', 'Espiritu', 'Jose Lloyd', 'PSYC', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('zyra_evangelista@dlsu.edu.ph', 'Evangelista', 'Zyra', 'PSYC', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('adrianne_galang@dlsu.edu.ph', 'Galang', 'Adrianne John', 'PSYC', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('felize_garilao@dlsu.edu.ph', 'Garilao', 'Felize', 'PSYC', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('maria_garilao@dlsu.edu.ph', 'Garilao', 'Maria Ana Victoria', 'PSYC', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('roberto_javier@dlsu.edu.ph', 'Javier', 'Roberto', 'PSYC', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('chester_lee@dlsu.edu.ph', 'Lee', 'Chester Howard', 'PSYC', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('robert_leong@dlsu.edu.ph', 'Leong', 'Robert Neil', 'PSYC', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('eligio_maghirangjr@dlsu.edu.ph', 'Maghirang', 'Eligio', 'PSYC', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('hans_moran@dlsu.edu.ph', 'Moran', 'Hans', 'PSYC', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('janina_nalipay@dlsu.edu.ph', 'Nalipay', 'Ma. Janina', 'PSYC', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('grant_nelson@dlsu.edu.ph', 'Nelson', 'Grant', 'PSYC', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('anna_ocampo@dlsu.edu.ph', 'Ocampo', 'Anna', 'PSYC', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('karmia_pakingan@dlsu.edu.ph', 'Pakingan', 'Karmia', 'PSYC', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('jaymee_pantaleon@dlsu.edu.ph', 'Pantaleon', 'Jaymee', 'PSYC', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('rachel_parr@dlsu.edu.ph', 'Parr', 'Rachel Ann', 'PSYC', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('hector_perez@dlsu.edu.ph', 'Perez', 'Hetor', 'PSYC', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('monica_policarpio@dlsu.edu.ph', 'Policarpio', 'Monica Renee', 'PSYC', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('melissa_reyes@dlsu.edu.ph', 'Reyes', 'Melissa Lucia', 'PSYC', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('andrew_sagmit@dlsu.edu.ph', 'Sagmit', 'Johann Andrew', 'PSYC', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('maria_salanga@dlsu.edu.ph', 'Salanga', 'Maria Guadalupe', 'PSYC', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('mary_serranilla@dlsu.edu.ph', 'Serranilla-Orquiza', 'Mary Grace', 'PSYC', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('patricia_simon@dlsu.edu.ph', 'Simon', 'Patricia', 'PSYC', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('marie_maria@dlsu.edu.ph', 'Sta. Maria', 'Marie Magdalene', 'PSYC', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('monica_tongson@dlsu.edu.ph', 'Tongson', 'Monica Camille', 'PSYC', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('aliza_valeza@dlsu.edu.ph', 'Valeza', 'Aliza', 'PSYC', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('joanne_valle@dlsu.edu.ph', 'Valle', 'Joanne', 'PSYC', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('felicidad_villavicencio@dlsu.edu.ph', 'Villavicencio', 'Felicidad', 'PSYC', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('homer_yabut@dlsu.edu.ph', 'Yabut', 'Homer', 'PSYC', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('isabelle_yujuico@dlsu.edu.ph', 'Yujuico', 'Isabelle Regina', 'PSYC', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('gloria_antonio@dlsu.edu.ph', 'Antonio', 'Gloria', 'THEO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('auria_balang@dlsu.edu.ph', 'Balang', 'Auria', 'THEO', NULL, 'defualt.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('richard_balang@dlsu.edu.ph', 'Balang', 'Richard', 'THEO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('rito_baring@dlsu.edu.ph', 'Baring', 'Rito', 'THEO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('rosemarie_bautista@dlsu.edu.ph', 'Bautista', 'Rosemarie', 'THEO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('dominardor_bombongan@dlsu.edu.ph', 'Bombongan. Jr', 'Dominardor', 'THEO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('agnes_brazal@dlsu.edu.ph', 'Brazal', 'Agnes', 'THEO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('katherine_cabatbat@dlsu.edu.ph', 'Cabatbat', 'Katherine Pia', 'THEO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('edna_cadsawan@dlsu.edu.ph', 'Cadsawan', 'Eda', 'THEO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('teresa_camarines@dlsu.edu.ph', 'Camarines', 'Teresa', 'THEO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('delfo_canceran@dlsu.edu.ph', 'Canceran', 'Delfo', 'THEO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('fides_castillo@dlsu.edu.ph', 'Castillo', 'Fides Del', 'THEO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('lolita_castillo@dlsu.edu.ph', 'Castillo', 'Lolita', 'THEO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('ronaldo_celestial@dlsu.edu.ph', 'Celestial', 'Ronaldo', 'THEO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('roberto_conception@dlsu.edu.ph', 'Conception', 'Roberto', 'THEO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('dalmacito_cordero@dlsu.edu.ph', 'Cordero', 'Dalmacito', 'THEO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('jeff_corpuz@dlsu.edu.ph', 'Corpuz', 'Jeff Clyde', 'THEO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('dominic_deguzman@dlsu.edu.ph', 'De Guzman', 'Dominic', 'THEO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('melani_delmundo@dlsu.edu.ph', 'Delmundo', 'Melani', 'THEO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('arnold_donozo@dlsu.edu.ph', 'Donozo', 'Arnold', 'THEO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('mia_eballo@dlsu.edu.ph', 'Eballo', 'Mia', 'THEO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('melchor_gabe@dlsu.edu.ph', 'Gabe', 'Melchor Giovanni', 'THEO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('marvin_godo@dlsu.edu.ph', 'Godo', 'Marvin', 'THEO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('mylene_icamina@dlsu.edu.ph', 'Icamina', 'Mylene Silvestre', 'THEO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('dorothy_javier@dlsu.edu.ph', 'Jaiver', 'Dorothy', 'THEO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('jose_lacsa@dlsu.edu.ph', 'Lacsa', 'Jose Eric', 'THEO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('melanio_leal@dlsu.edu.ph', 'Leal', 'Melanio', 'THEO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('herminilito_luna@dlsu.edu.ph', 'Luna', 'Herminilito', 'THEO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('willard_macaraan@dlsu.edu.ph', 'Macaraan', 'Willard', 'THEO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('alvenio_mozol@dlsu.edu.ph', 'Mozol', 'Alvenio', 'THEO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('mirasol_navidad@dlsu.edu.ph', 'Navidad', 'Mirasol', 'THEO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('tessie_ponteras@dlsu.edu.ph', 'Ponteras', 'Tessie', 'THEO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('ricardo_puno@dlsu.edu.ph', 'Puno', 'Ricardo', 'THEO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('geran_ramos@dlsu.edu.ph', 'Ramos', 'Geran Ronace', 'THEO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('hernando_raymundo@dlsu.edu.ph', 'Raymundo', 'Hernando', 'THEO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('mark_reyes@dlsu.edu.ph', 'Reyes', 'Mark', 'THEO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('lysander_rivera@dlsu.edu.ph', 'Rivera', 'Lysander', 'THEO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('genaro_rondina@dlsu.edu.ph', 'Rondina', 'Genaro', 'THEO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('alma_sabulao@dlsu.edu.ph', 'Sabulao', 'Alma', 'THEO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('francis_salcedo@dlsu.edu.ph', 'Salcedo', 'Francis', 'THEO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('carolina_sayago@dlsu.edu.ph', 'Sayago', 'Carolina', 'THEO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('reuel_seno@dlsu.edu.ph', 'Seno', 'Reuel Rito', 'THEO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('niku_vicente@dlsu.edu.ph', 'Vicente', 'Niku', 'THEO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('feliciano_almazora@dlsu.edu.ph', 'Almazora', 'Feliciano', 'ACCT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('michelle_ang@dlsu.edu.ph', 'Ang', 'Michelle', 'ACCT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('nimpha_aquino@dlsu.edu.ph', 'Aquino', 'Nimpha', 'ACCT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('maria_baarde@dlsu.edu.ph', 'Baarde', 'Maria Victoria', 'ACCT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('violeta_baluran@dlsu.edu.ph', 'Baluran', 'Fe Violeta', 'ACCT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('brixen_barredo@dlsu.edu.ph', 'Barredo', 'Brixen', 'ACCT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('mark_bendo@dlsu.edu.ph', 'Bendo', 'Mark', 'ACCT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('jonathan_binaluyo@dlsu.edu.ph', 'Binaluyo', 'Jonathan', 'ACCT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('nancy_chua@dlsu.edu.ph', 'Chua', 'Nancy', 'ACCT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('carmelita_clerigo@dlsu.edu.ph', 'Clerigo', 'Carmelita', 'ACCT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('heindritz_conception@dlsu.edu.ph', 'Conception', 'Heindritz Yupico', 'ACCT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('cynthia_cudia@dlsu.edu.ph', 'Cudia', 'Cynthia', 'ACCT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('enrique_delossantos@dlsu.edu.ph', 'De Los Santos', 'Enrique', 'ACCT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('aeson_delacruz@dlsu.edu.ph', 'Dela Cruz', 'Aeson', 'ACCT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('jake_duran@dlsu.edu.ph', 'Duran', 'Jake', 'ACCT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('aaron_escartin@dlsu.edu.ph', 'Escartin', 'Aaron', 'ACCT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('nino_gonzales@dlsu.edu.ph', 'Gonzales', 'Nino Jose', 'ACCT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('mark_joven@dlsu.edu.ph', 'Joven', 'Mark Matthew', 'ACCT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('joy_legaspi@dlsu.edu.ph', 'Legaspi', 'Joy', 'ACCT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('perry_lim@dlsu.edu.ph', 'Lim', 'Perry', 'ACCT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('marivic_manolo@dlsu.edu.ph', 'Manolo', 'Marivic', 'ACCT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('placido_menaje@dlsu.edu.ph', 'Menaje Jr', 'Placido', 'ACCT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('allan_ocho@dlsu.edu.ph', 'Ocho', 'Allan', 'ACCT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('alloysius_paril@dlsu.edu.ph', 'Paril', 'Alloysius', 'ACCT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('ricarte_pinlac@dlsu.edu.ph', 'Pinlac', 'Ricarte', 'ACCT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('marilou_quibuyen@dlsu.edu.ph', 'Quibuyen', 'Marilou', 'ACCT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('mary_quitoriano@dlsu.edu.ph', 'Quitoriano', 'Mary Josephine', 'ACCT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('joy_rabo@dlsu.edu.ph', 'Rabo', 'Joy', 'ACCT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('fredrick_romero@dlsu.edu.ph', 'Romero', 'Fredericl Punzalan', 'ACCT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('marilou_sanagustin@dlsu.edu.ph', 'San Agustin', 'Marilou', 'ACCT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('alger_tang@dlsu.edu.ph', 'Tang', 'Alger', 'ACCT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('win_tubay@dlsu.edu.ph', 'Tubay', 'Win', 'ACCT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('florenz_tugas@dlsu.edu.ph', 'Tugas', 'Florenz', 'ACCT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('elsie_velasco@dlsu.edu.ph', 'Velasco', 'Elsie', 'ACCT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('francisco_villamin@dlsu.edu.ph', 'Villamin Jr', 'Francisco', 'ACCT', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('victor_ang@dlsu.edu.ph', 'Ang', 'Victor Reynaldo', 'CLD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('micheal_azucena@dlsu.edu.ph', 'Azucena', 'Micheal', 'CLD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('hilario_caraan@dlsu.edu.ph', 'Caraan', 'Hilario', 'CLD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('katrina_pearl_chua@dlsu.edu.ph', 'Chua', 'Katrina Pearl', 'CLD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('rex_cruz@dlsu.edu.ph', 'Cruz', 'Rex Enrico', 'CLD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('micheal_gerald_david@dlsu.edu.ph', 'David', 'Micheal Gerald', 'CLD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('andre_dejesus@dlsu.edu.ph', 'De Jesus', 'Andre', 'CLD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('darren_dejesus@dlsu.edu.ph', 'De Jesus', 'Darren', 'CLD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('roxanne_dimayuga@dlsu.edu.ph', 'Dimayuga', 'Roxanne', 'CLD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('araceli_habaradas@dlsu.edu.ph', 'Habaradas', 'Ma. Araceli', 'CLD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('raymund_habaradas@dlsu.edu.ph', 'Habaradas', 'Raymund', 'CLD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('james_heffron@dlsu.edu.ph', 'Heffron', 'James Keith', 'CLD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('larry_ignacio@dlsu.edu.ph', 'Ignacio', 'Larry', 'CLD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('arvin_jo@dlsu.edu.ph', 'Jo', 'Arvin', 'CLD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('lorna_lugod@dlsu.edu.ph', 'Lugod', 'Lorna', 'CLD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('zenaida_manalo@dlsu.edu.ph', 'Manalo', 'Zenaida', 'CLD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('patrick_perillo@dlsu.edu.ph', 'Perillo', 'Patrick', 'CLD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('ryan_quan@dlsu.edu.ph', 'Quan', 'Ryan', 'CLD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('jayson_ramos@dlsu.edu.ph', 'Ramos', 'Jayson', 'CLD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('jose_reyes@dlsu.edu.ph', 'Reyes', 'Jose', 'CLD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('reynaldo_ros@dlsu.edu.ph', 'Ros', 'Reynaldo', 'CLD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('jan_salud@dlsu.edu.ph', 'Salud', 'Jan Raphael Rivera', 'CLD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('voltaire_salud@dlsu.edu.ph', 'Salud', 'Voltaire Borja', 'CLD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('justin_sucgang@dlsu.edu.ph', 'Sucgang', 'Justin', 'CLD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('emily_salcedo@dlsu.edu.ph', 'Salcedo', 'Emily', 'CLD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('karen_torres@dlsu.edu.ph', 'Torres', 'Karen', 'CLD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('jan_uy@dlsu.edu.ph', 'Uy', 'Jan Reiner', 'CLD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('veronica_aguilos@dlsu.edu.ph', 'Aguilos', 'Veronica', 'DSID', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('jan_alcantara@dlsu.edu.ph', 'Alcantara', 'Jan', 'DSID', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('jerome_alvarez@dlsu.edu.ph', 'Alvarez', 'Jerome', 'DSID', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('rosairo_arzaga@dlsu.edu.ph', 'Arzaga', 'Rosairo', 'DSID', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('estafanie_bertumen@dlsu.edu.ph', 'Bertumen', 'Estafanie', 'DSID', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('ernesto_bilar@dlsu.edu.ph', 'Bilar', 'Ernesto Jose', 'DSID', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('blanche_flores@dlsu.edu.ph', 'Flores-Salvador', 'Blanche', 'DSID', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('mark_casanova@dlsu.edu.ph', 'Casanova', 'Mark Anthony', 'DSID', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('enrico_cordoba@dlsu.edu.ph', 'Cordoba', 'Enrico', 'DSID', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('racquel_cruz@dlsu.edu.ph', 'Cruz', 'Racquel', 'DSID', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('luis_desiderio@dlsu.edu.ph', 'Desiderio', 'Luis', 'DSID', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('rayr_dimaranan@dlsu.edu.ph', 'Dimaranan', 'Rayr', 'DSID', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('levi_esteban_elipane@dlsu.edu.ph', 'Elipane', 'Levi Esteban', 'DSID', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('maureen_felices@dlsu.edu.ph', 'Felices', 'Marueen', 'DSID', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('raymund_ganotice@dlsu.edu.ph', 'Ganotice', 'Raymund', 'DSID', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('theresa_gerial@dlsu.edu.ph', 'Gerial', 'Ma. Theresa Concepcion Alix', 'DSID', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('jake_go@dlsu.edu.ph', 'Go', 'Jake Ervin Jonathan Ching', 'DSID', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('brian_gozun@dlsu.edu.ph', 'Gozun', 'Brian', 'DSID', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('junnell_guia@dlsu.edu.ph', 'Guia', 'Junnell', 'DSID', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('jayme_ignacio@dlsu.edu.ph', 'Ignacio', 'Jayme', 'DSID', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('ravi_kumar@dlsu.edu.ph', 'Kumar', 'Ravi', 'DSID', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('cristina_lim@dlsu.edu.ph', 'Lim', 'Cristina', 'DSID', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('john_lim@dlsu.edu.ph', 'Lim', 'John', 'DSID', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('lutgardo_mendoza@dlsu.edu.ph', 'Mendoza', 'Lutgardo', 'DSID', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('monina_mercaldo@dlsu.edu.ph', 'Mercaldo', 'Monina', 'DSID', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('reynaldo_mones@dlsu.edu.ph', 'Mones', 'Reynaldo', 'DSID', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('melvin_moraga@dlsu.edu.ph', 'Moraga', 'melvin', 'DSID', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('marissa_noel@dlsu.edu.ph', 'Noel', 'Marissa', 'DSID', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('harvey_ong@dlsu.edu.ph', 'Ong', 'Harvey', 'DSID', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('rosario_ortegas@dlsu.edu.ph', 'Ortegas', 'Rosaro Corazon', 'DSID', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('raymond_paderna@dlsu.edu.ph', 'Paderna', 'Raymond', 'DSID', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('emilina_sarreal@dlsu.edu.ph', 'Sarreal', 'Emilina', 'DSID', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('salie_siao@dlsu.edu.ph', 'Siao', 'Salie', 'DSID', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('maricris_sim@dlsu.edu.ph', 'Sim', 'Maricris', 'DSID', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('dorelene_syjuico@dlsu.edu.ph', 'Syjuico', 'Dorelene Dimaunahan', 'DSID', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('april_valera@dlsu.edu.ph', 'Valera', 'April Andrea', 'DSID', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('aida_velasco@dlsu.edu.ph', 'Velasco', 'Aida', 'DSID', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('junius_yu@dlsu.edu.ph', 'Yu', 'Junius', 'DSID', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('maycris_albao@dlsu.edu.ph', 'Albao', 'Maycris', 'FMD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('catherine_almonte@dlsu.edu.ph', 'Almonte', 'Catherine Kalayaan Smith', 'FMD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('enrico_amat@dlsu.edu.ph', 'Amat', 'Enrico', 'FMD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('dioscoro_baylon@dlsu.edu.ph', 'Baylon', 'Dioscoro Palanas', 'FMD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('patricia_benito@dlsu.edu.ph', 'Benito', 'Patricia', 'FMD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('rene_betita@dlsu.edu.ph', 'Betita', 'Rene', 'FMD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('tyrone_chan@dlsu.edu.ph', 'Chan Pao', 'Tyrone', 'FMD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('ester_guerzon@dlsu.edu.ph', 'Guerzon', 'Ester', 'FMD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('kitin_lagdameo@dlsu.edu.ph', 'Lagdameo', 'Kitin', 'FMD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('edralin_lim@dlsu.edu.ph', 'Lim', 'Edralin', 'FMD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('earl_malvar@dlsu.edu.ph', 'Malvar', 'Earl', 'FMD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('liberty_patiu@dlsu.edu.ph', 'Patiu', 'Liberty', 'FMD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('junette_perez@dlsu.edu.ph', 'Perez', 'Junette', 'FMD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('alfredo_santoyo@dlsu.edu.ph', 'Santoyo', 'Alfredo', 'FMD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('mar_umali@dlsu.edu.ph', 'Umali', 'Mar Andriel', 'FMD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('kenneth_yumang@dlsu.edu.ph', 'Yumang', 'Kenneth', 'FMD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('karen_aquino@dlsu.edu.ph', 'Aquino', 'Karen Selina', 'MOD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('patrick_aure@dlsu.edu.ph', 'Aure', 'Patrick', 'MOD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('maricel_balabat@dlsu.edu.ph', 'Balabat', 'Maricel', 'MOD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('flellen_bautista@dlsu.edu.ph', 'Bautista', 'Ma. Flellen Fajardo', 'MOD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('geraldine_bernardo@dlsu.edu.ph', 'Bernardo', 'Geraldine', 'MOD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('azenith_castillo@dlsu.edu.ph', 'Castillo', 'Azenith Hababag', 'MOD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('jose_custodio@dlsu.edu.ph', 'Custodio', 'Jose Eduardo', 'MOD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('christine_dominado@dlsu.edu.ph', 'Dominado', 'Christine', 'MOD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('liza_fumar@dlsu.edu.ph', 'Fumar', 'Liza Mae', 'MOD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('artemio_gesmundo@dlsu.edu.ph', 'Gesmundo', 'Artemio', 'MOD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('caryl_jimenez@dlsu.edu.ph', 'Jimenez', 'Caryl Charlene', 'MOD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('shieradel_jimenez@dlsu.edu.ph', 'Jimenez', 'Shieradel', 'MOD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('josemari_lim@dlsu.edu.ph', 'Lim', 'Josemari', 'MOD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('julius_lunar@dlsu.edu.ph', 'Lunar', 'Julius', 'MOD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('davee_maligaya@dlsu.edu.ph', 'Maligaya', 'Davee Jean', 'MOD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('nestor_nisperos@dlsu.edu.ph', 'Nisperos Jr.', 'Nestor', 'MOD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('teodoro_ocampo@dlsu.edu.ph', 'Ocampo', 'Teodoro', 'MOD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('jeanne_sarmiento@dlsu.edu.ph', 'Sarmiento', 'Jeanne', 'MOD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('rafael_tesuan@dlsu.edu.ph', 'Tesuan', 'Rafael Gerardo', 'MOD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('maria_tibon@dlsu.edu.ph', 'Tibon', 'Maria Victoria', 'MOD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('alexander_trajano@dlsu.edu.ph', 'Trajano', 'Alexander', 'MOD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('adrian_yrigan@dlsu.edu.ph', 'Yrigan', 'Adrian Esposo', 'MOD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('julie_balarbar@dlsu.edu.ph', 'Balarbar', 'Julie', 'MMD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('jun_barrameda@dlsu.edu.ph', 'Barrameda', 'Jun', 'MMD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('shane_bellare@dlsu.edu.ph', 'Bellare', 'Shane Aldrin', 'MMD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('romeo_catap@dlsu.edu.ph', 'Catap Jr.', 'Romeo', 'MMD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('micheal_celis@dlsu.edu.ph', 'Celis', 'Micheal', 'MMD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('benison_cu@dlsu.edu.ph', 'Cu', 'Benison', 'MMD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('paula_deasis@dlsu.edu.ph', 'De Asis', 'Paula Nicola', 'MMD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('rayan_dui@dlsu.edu.ph', 'Dui', 'Rayan', 'MMD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('bienvenido_encarnacion@dlsu.edu.ph', 'Encarnacion', 'Bienvenido Lorenzo', 'MMD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('morieen_espinosa@dlsu.edu.ph', 'Espinosa', 'Morieen', 'MMD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('claro_ganac@dlsu.edu.ph', 'Ganac', 'Claro', 'MMD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('mark_gordon@dlsu.edu.ph', 'Gordon', 'Mark', 'MMD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('luz_jeong@dlsu.edu.ph', 'Jeong', 'Luz Suplico', 'MMD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('jose_luis_legaspi@dlsu.edu.ph', 'Legaspi', 'Jose Luis', 'MMD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('ireene_leoncio@dlsu.edu.ph', 'Leoncio', 'Ireene Cancio', 'MMD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('jose_luis_liongson@dlsu.edu.ph', 'Liongson', 'Jose Luis', 'MMD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('serge_marx@dlsu.edu.ph', 'Marx', 'Serge Lucien', 'MMD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('paz_poblador@dlsu.edu.ph', 'Poblador', 'Paz Esperanza', 'MMD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('ritchie_ramos@dlsu.edu.ph', 'Ramos', 'Ritchie', 'MMD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('billy_salcedo@dlsu.edu.ph', 'Salcedo', 'Billy Joe Guting', 'MMD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('nina_sales@dlsu.edu.ph', 'Sales', 'Nina Ana Marie Jocelyn', 'MMD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('gerard_sanluis@dlsu.edu.ph', 'San Luis', 'Gerard', 'MMD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('lysa_sanchez@dlsu.edu.ph', 'Sanchez', 'Lysa', 'MMD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('susan_santos@dlsu.edu.ph', 'Santos', 'Susan Dar', 'MMD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('raymund_veragara@dlsu.edu.ph', 'Vergara', 'Raymund', 'MMD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('luisito_abueg@dlsu.edu.ph', 'Abueg', 'Luisito', 'ECO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('carlo_anton_arguelles@dlsu.edu.ph', 'Arguelles', 'Carlo Anthon', 'ECO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('christopher_cabuay@dlsu.edu.ph', 'Cabuay', 'Christopher James', 'ECO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('neriza_casas@dlsu.edu.ph', 'Casas', 'Neriza', 'ECO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('marvin_castell@dlsu.edu.ph', 'Castell', 'Marvin Raymond', 'ECO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('paulynne_castillo@dlsu.edu.ph', 'Castillo', 'Paulynne', 'ECO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('maria_dabbay@dlsu.edu.ph', 'Dabbay', 'Maria Fe', 'ECO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('albert_lamberte@dlsu.edu.ph', 'Lamberte', 'Albert', 'ECO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('dickson_lim@dlsu.edu.ph', 'Lim', 'Dickson Aquino', 'ECO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('leigh_lim@dlsu.edu.ph', 'Lim', 'Leigh', 'ECO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('ella_oplas@dlsu.edu.ph', 'Oplas', 'Ma. Ella', 'ECO', NULL, 'defaut.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('zunally_rapada@dlsu.edu.ph', 'Rapada', 'Ma. Zunally', 'ECO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('roberto_raymundo@dlsu.edu.ph', 'Raymundo', 'Roberto', 'ECO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('cesar_rufino@dlsu.edu.ph', 'Rufino', 'Cesar', 'ECO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('mariel_sauler@dlsu.edu.ph', 'Sauler', 'Mariel Monica', 'ECO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('ailyn_shi@dlsu.edu.ph', 'Shi', 'Ailyn Ang', 'ECO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('deborah_sy@dlsu.edu.ph', 'Sy', 'Deborah Kim', 'ECO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('joel_tanchuco@dlsu.edu.ph', 'Tanchuco', 'Joel', 'ECO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('maria_tomaliwan@dlsu.edu.ph', 'Towaliwan', 'Maria', 'ECO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('tereso_tullao@dlsu.edu.ph', 'Tullao', 'Tereso', 'ECO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('winfred_villamil@dlsu.edu.ph', 'Villamil', 'Winfred', 'ECO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('krista_yu@dlsu.edu.ph', 'Yu', 'Krista Danielle Sy', 'ECO', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('nora_agpasa@dlsu.edu.ph', 'Agpasa', 'Nora', 'CEPD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('cabe_aquino@dlsu.edu.ph', 'Aquino', 'Cabe', 'CEPD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('john_aruta@dlsu.edu.ph', 'Aruta', 'John Jamir Benzon', 'CEPD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('chris_bernardo@dlsu.edu.ph', 'Bernardo', 'Chris', 'CEPD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('nenuica_canlas@dlsu.edu.ph', 'Canlas', 'Nenuca Fe ', 'CEPD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('maria_esperanza@dlsu.edu.ph', 'Esperanza', 'Maria Mikaela', 'CEPD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('macy_eusebio@dlsu.edu.ph', 'Eusebio', 'Macy', 'CEPD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('earl_ganuelas@dlsu.edu.ph', 'Ganuelas', 'Earl', 'CEPD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('anna_garcia@dlsu.edu.ph', 'Garcia-Manlulo', 'Anna Carina', 'CEPD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('anthony_mabanes@dlsu.edu.ph', 'Mabanes', 'Anthony Robert Jobert', 'CEPD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('blanche_mapile@dlsu.edu.ph', 'Mapile', 'Blanche', 'CEPD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('janet_s_mariano@dlsu.edu.ph', 'Mariano', 'Janet', 'CEPD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('lelinda_mugot@dlsu.edu.ph', 'Mugot', 'Lelinda', 'CEPD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('joel_obrador@dlsu.edu.ph', 'Obrador', 'Joel', 'CEPD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('aldwin_sanchez@dlsu.edu.ph', 'Sanchez', 'Aldwin', 'CEPD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('mayurkumar_agravat@dlsu.edu.ph', 'Agravat', 'Mayurkumar', 'DEAL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('kathleen_aquino@dlsu.edu.ph', 'Aquino-Riano', 'Kathleen Jane', 'DEAL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('shin_aracin@dlsu.edu.ph', 'Aracin', 'Shin', 'DEAL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('alice_arbond@dlsu.edu.ph', 'Arbon', 'Alice Mae', 'DEAL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('mila_arias@dlsu.edu.ph', 'Arias', 'Mila', 'DEAL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('aireen_arnuco@dlsu.edu.ph', 'Arnuco', 'Aireen', 'DEAL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('aileen_bautista@dlsu.edu.ph', 'Bautista', 'Aileen', 'DEAL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('edwina_bensal@dlsu.edu.ph', 'Bensal', 'Edwina', 'DEAL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('jose_catalan@dlsu.edu.ph', 'Catalan', 'Jose Antonio', 'DEAL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('cynthia_correo@dlsu.edu.ph', 'Correo', 'Cynthia', 'DEAL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('maria_cusipag@dlsu.edu.ph', 'Cusipag', 'Maria', 'DEAL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('leticia_dizon@dlsu.edu.ph', 'Dizon', 'Leticia', 'DEAL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('fernand_dumalay@dlsu.edu.ph', 'Dumalay', 'Fernand Kevin', 'DEAL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('trina_dusaban@dlsu.edu.ph', 'Dusaban', 'Trina Marie', 'DEAL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('lenard_espiritu@dlsu.edu.ph', 'Espiritu', 'Lenard', 'DEAL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('joahna_estacio@dlsu.edu.ph', 'Esacio', 'Ma. Joahna', 'DEAL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('jerico_esteron@dlsu.edu.ph', 'Esteron', 'Jerico', 'DEAL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('frederick_flores@dlsu.edu.ph', 'Flores', 'Frederick', 'DEAL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('marianne_gaerlan@dlsu.edu.ph', 'Gaerlan', 'Marianne Jennifer', 'DEAL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('michelly_galicia@dlsu.edu.ph', 'Galicia', 'Michelly', 'DEAL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('leif_garinto@dlsu.edu.ph', 'Garinto', 'Leif', 'DEAL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('cecilia_genuino@dlsu.edu.ph', 'Genuino', 'Cecilia', 'DEAL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('christian_albert_go@dlsu.edu.ph', 'Go', 'Christian Albert', 'DEAL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('joanna_go@dlsu.edu.ph', 'Go', 'Joanna', 'DEAL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('paulina_gocheco@dlsu.edu.ph', 'Gocheco', 'Paulina', 'DEAL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('guia_gonzales@dlsu.edu.ph', 'Gonzales', 'Guia', 'DEAL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('bernardita_gonzalo@dlsu.edu.ph', 'Gonzalo', 'Bernardita', 'DEAL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('leah_gustilo@dlsu.edu.ph', 'Gustilo', 'Leah', 'DEAL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('suzeth_latap@dlsu.edu.ph', 'Latap', 'Suzeth', 'DEAL', NULL, 'deafult.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('mylene_manalansan@dlsu.edu.ph', 'Manalansan', 'Mylene', 'DEAL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('kimberley_migallos@dlsu.edu.ph', 'Migallos', 'Kimberely', 'DEAL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('edna_miraflores@dlsu.edu.ph', 'Miraflores', 'Edna', 'DEAL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('alen_munoz@dlsu.edu.ph', 'Munoz', 'Alen Mateo', 'DEAL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('jocelyn_navera@dlsu.edu.ph', 'Navera', 'Jocelyn', 'DEAL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('jose_parina@dlsu.edu.ph', 'Parina', 'Jose', 'DEAL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('marietta_parungao@dlsu.edu.ph', 'Parungao', 'Marietta', 'DEAL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('rachele_pili@dlsu.edu.ph', 'Pili', 'Rachele', 'DEAL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('jeanne_purpura@dlsu.edu.ph', 'Purpura', 'Jeanne', 'DEAL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('anna_ramos@dlsu.edu.ph', 'Ramos', 'Anna Marie', 'DEAL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('philip_rentillo@dlsu.edu.ph', 'Rentillo', 'Philip', 'DEAL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('corazon_rodriguez@dlsu.edu.ph', 'Rodriguez', 'Corazon', 'DEAL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('rubie_sajise@dlsu.edu.ph', 'Sajise', 'Rubie', 'DEAL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('jennider_tan_ramos@dlsu.edu.ph', 'Ramos', 'Jennifer Tan-De', 'DEAL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('angelrita_sale@dlsu.edu.ph', 'Sale', 'Angelrita', 'DEAL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('nino_sandi@dlsu.edu.ph', 'Sandi', 'Nino', 'DEAL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('shelley_saracin@dlsu.edu.ph', 'Saracin', 'Shelley Jo', 'DEAL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('emil_sarmago@dlsu.edu.ph', 'Sarmago', 'Emil', 'DEAL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('ivory_siosonjr@dlsu.edu.ph', 'Sioson', 'Ivory', 'DEAL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('jose_tamayo@dlsu.edu.ph', 'Tamayo', 'Jose Antonio Lorenzo', 'DEAL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('lindsey_tan@dlsu.edu.ph', 'Tan', 'Lindsey', 'DEAL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('ingdrid_uba@dlsu.edu.ph', 'Uba', 'Ingrid', 'DEAL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('gina_ugalingan@dlsu.edu.ph', 'Ugalingan', 'Gina', 'DEAL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('paolo_valdez@dlsu.edu.ph', 'Valdez', 'Paolo Nino', 'DEAL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('dennis_villacorta@dlsu.edu.ph', 'Villacorta', 'Dennis', 'DEAL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('allan_villaverde@dlsu.edu.ph', 'Villaverde', 'Allan Rey', 'DEAL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('tomas_villegas@dlsu.edu.ph', 'Villegas', 'Tomas Macabenta', 'DEAL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('miel_o_abdon@dlsu.edu.ph', 'Abdon', 'Miel', 'ELMD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('jasper_alontaga@dlsu.edu.ph', 'Alontaga', 'Jasper Vincent', 'ELMD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('arvie_andal@dlsu.edu.ph', 'Andal', 'Arvie Sandoval', 'ELMD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('lilia_bautista@dlsu.edu.ph', 'Bautista', 'Lilia', 'ELMD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('frances_canon@dlsu.edu.ph', 'Canon', 'Frances Kristine', 'ELMD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('abdul_celendrino@dlsu.edu.ph', 'Celendrino', 'Abdul Jhariel', 'ELMD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('maria_celendrino@dlsu.edu.ph', 'Celendrino', 'Maria Corazon', 'ELMD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('marikita_evangelista@dlsu.edu.ph', 'Evangelista', 'Marikita', 'ELMD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('kristine_hernandez@dlsu.edu.ph', 'Hernandez', 'Kristine', 'ELMD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('gabriel_lazaro@dlsu.edu.ph', 'Lazaro', 'Gabriel John', 'ELMD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('thelma_mingoa@dlsu.edu.ph', 'Mingoa', 'Thelma', 'ELMD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('abdul_osman@dlsu.edu.ph', 'Osman', 'Abdul', 'ELMD', NULL, 'defualt.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('carmelea_see@dlsu.edu.ph', 'See', 'Carmelea Ang', 'ELMD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('maria_tapales@dlsu.edu.ph', 'Tapales', 'Maria Rita', 'ELMD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('maria_tee@dlsu.edu.ph', 'Tee', 'Maria', 'ELMD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('merile_acibar@dlsu.edu.ph', 'Acibar', 'Merlie', 'PED', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('jerwinn_aguinaldo@dlsu.edu.ph', 'Aguinaldo', 'Jerwinn', 'PED', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('elaine_andres@dlsu.edu.ph', 'Andres', 'Elaine Carie', 'PED', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('joanna_ayo@dlsu.edu.ph', 'Ayo', 'Joanna', 'PED', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('jacklyn_delosreyes@dlsu.edu.ph', 'Delos Reyes', 'Jacklyn', 'PED', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('heildenberg_dimarucot@dlsu.edu.ph', 'Dumarucot', 'Heildenberg', 'PED', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('louise_eballa@dlsu.edu.ph', 'Eballa', 'Louise Mark', 'PED', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('comille_gonzales@dlsu.edu.ph', 'Gonzales', 'Camille', 'PED', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('janet_mariano@dlsu.edu.ph', 'Mariano', 'Janet', 'PED', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('bengie_mendizabal@dlsu.edu.ph', 'Mendizabal', 'Bengie', 'PED', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('rachel_mercines@dlsu.edu.ph', 'Merinces', 'Rachel', 'PED', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('christopher_olarte@dlsu.edu.ph', 'Olarte', 'Christopher', 'PED', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('rolando_panlilio@dlsu.edu.ph', 'Panlilio', 'Rolando', 'PED', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('rosalinda_santiago@dlsu.edu.ph', 'Santiago', 'Rosalinda Barandino', 'PED', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('marga_tapang@dlsu.edu.ph', 'Tapang', 'Marga', 'PED', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('jacklyn_toldoya@dlsu.edu.ph', 'Toldoya', 'Jacklyn Anne', 'PED', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('maxima_acelajado_dr@dlsu.edu.ph', 'Acelajado', 'Maxima', 'SED', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('levi_elipane@dlsu.edu.ph', 'Elipane', 'Levi', 'SED', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('minie_lapinid@dlsu.edu.ph', 'Lapinid', 'Minie', 'SED', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('leonila_abella@dlsu.edu.ph', 'Abella', 'Leonila', 'CHEME', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('kathleen_aviso@dlsu.edu.ph', 'Aviso', 'Kathleen', 'CHEME', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('wilheliza_baraoidan@dlsu.edu.ph', 'Baraoidan', 'Wilheliza', 'CHEME', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('lawrence_belo@dlsu.edu.ph', 'Belo', 'Lawrence', 'CHEME', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('arnel_beltran@dlsu.edu.ph', 'Beltran', 'Arnel', 'CHEME', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('yolanda_brondial@dlsu.edu.ph', 'Brondial', 'Yolanda', 'CHEME', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('vergel_bungay@dlsu.edu.ph', 'Bungay', 'Vergel', 'CHEME', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('roberto_caguingin@dlsu.edu.ph', 'Caguinginn', 'Roberto', 'CHEME', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('king_co@dlsu.edu.ph', 'Co', 'Kind', 'CHEME', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('romel_marquez@dlsu.edu.ph', 'Marquez', 'Romel', 'CHEME', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('aileen_orbecido@dlsu.edu.ph', 'Orbecido', 'Aileen', 'CHEME', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('bryan_rappal@dlsu.edu.ph', 'Rappal', 'Bryan', 'CHEME', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('susan_roces@dlsu.edu.ph', 'Roces', 'Susan', 'CHEME', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('marylou_uy@dlsu.edu.ph', 'Uy', 'Marylou', 'CHEME', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('dennis_yu@dlsu.edu.ph', 'Yu', 'Dennis', 'CHEME', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('miguel_adraha@dlsu.edu.ph', 'Adraha', 'Miguel', 'CIVIL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('marcus_baron@dlsu.edu.ph', 'Baron', 'Marcus', 'CIVIL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('manny_belino@dlsu.edu.ph', 'Belino', 'Manny', 'CIVIL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('richard_dejesus@dlsu.edu.ph', 'De Jesus', 'Richard', 'CIVIL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('benjie_dimaculangan@dlsu.edu.ph', 'Dimaculangan', 'Benjie', 'CIVIL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('alexis_fillone@dlsu.edu.ph', 'Fillone', 'Alexis', 'CIVIL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('lessandro_garciano@dlsu.edu.ph', 'Garciano', 'Lessandro', 'CIVIL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('jem_jayme@dlsu.edu.ph', 'Jayme', 'Jem', 'CIVIL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('bernardo_lejano@dlsu.edu.ph', 'Lejano', 'Bernardo', 'CIVIL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('sam_lim@dlsu.edu.ph', 'Lim', 'Sam Jovinson', 'CIVIL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('maria_paringit@dlsu.edu.ph', 'Paringit', 'Maria Cecilia', 'CIVIL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('cheryl_roxas@dlsu.edu.ph', 'Roxas', 'Cheryl', 'CIVIL', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('melvin_cabatuan@dlsu.edu.ph', 'Cabatuan', 'Melvin', 'ECED', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('marvil_graza@dlsu.edu.ph', 'Graza', 'Marvil', 'ECED', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('john_jose@dlsu.edu.ph', 'Jose', 'John Anthony', 'ECED', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('enrique_m_manzano@dlsu.edu.ph', 'Manzano', 'Enrique', 'ECED', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('gerino_mappatao@dlsu.edu.ph', 'Mappatao', 'Gerino', 'ECED', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('john_orillo@dlsu.edu.ph', 'Orillo', 'John William', 'ECED', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('oswald_sapang@dlsu.edu.ph', 'Sapang', 'Oswald', 'ECED', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('dennis_cruz@dlsu.edu.ph', 'Cruz', 'Dennis', 'IED', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('nathaniel_felix@dlsu.edu.ph', 'Felix', 'Nathaniel Isidore', 'IED', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('emil_fernandez@dlsu.edu.ph', 'Fernandez', 'Emil Adrian', 'IED', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('bryan_gobaco@dlsu.edu.ph', 'Gobaco', 'Bryan', 'IED', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('alma_gutierrez@dlsu.edu.ph', 'Gutierrez', 'Alma Maria Jennifer', 'IED', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('richard_li@dlsu.edu.ph', 'Li', 'Richard', 'IED', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('anna_manalang@dlsu.edu.ph', 'Manalang', 'Anna Bella', 'IED', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('jose_mutuc@dlsu.edu.ph', 'Mutuc', 'Jose Edgar', 'IED', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('ronaldo_polancos@dlsu.edu.ph', 'Polancos', 'Ronaldo', 'IED', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('rosemary_seva@dlsu.edu.ph', 'Seva', 'Rosemary', 'IED', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('eric_siy@dlsu.edu.ph', 'Siy', 'Eric', 'IED', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('jazmin_tangsoc@dlsu.edu.ph', 'Tangsoc', 'Jazmin', 'IED', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('willy_zalatar@dlsu.edu.ph', 'Zalatar', 'Willy', 'IED', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('chrissete_agusting@dlsu.edu.ph', 'Agustin', 'Chrissete', 'MEMD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('nicanor_roxas@dlsu.edu.ph', 'Roxas', 'Nicanor', 'MEMD', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('anthony_escolar@dlsu.edu.ph', 'Escolar', 'Anthony', 'MED', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('byron_omboy@dlsu.edu.ph', 'Omboy', 'Byron Micheal', 'MED', NULL, 'default.png', 1);
INSERT INTO `profsmato`.`Professors` (`profEmail`, `lastname`, `firstname`, `department`, `about`, `profPicture`, `status`) VALUES ('conrad_pantua@dlsu.edu.ph', 'Pantua', 'Conrad Allan Jay', 'MED', NULL, 'default.png', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `profsmato`.`ref_contact`
-- -----------------------------------------------------
START TRANSACTION;
USE `profsmato`;
INSERT INTO `profsmato`.`ref_contact` (`ref_contactId`, `contactType`) VALUES (1, 'facebook');
INSERT INTO `profsmato`.`ref_contact` (`ref_contactId`, `contactType`) VALUES (2, 'youtube');
INSERT INTO `profsmato`.`ref_contact` (`ref_contactId`, `contactType`) VALUES (3, 'twitter');
INSERT INTO `profsmato`.`ref_contact` (`ref_contactId`, `contactType`) VALUES (4, 'instagram');

COMMIT;


-- -----------------------------------------------------
-- Data for table `profsmato`.`ref_reviewComment_status`
-- -----------------------------------------------------
START TRANSACTION;
USE `profsmato`;
INSERT INTO `profsmato`.`ref_reviewComment_status` (`statusId`, `status`) VALUES (1, 'active');
INSERT INTO `profsmato`.`ref_reviewComment_status` (`statusId`, `status`) VALUES (2, 'reported');
INSERT INTO `profsmato`.`ref_reviewComment_status` (`statusId`, `status`) VALUES (3, 'deleted');

COMMIT;

