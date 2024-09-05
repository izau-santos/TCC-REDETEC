-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema New_TCC
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema New_TCC
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `New_TCC` DEFAULT CHARACTER SET utf8 ;
USE `New_TCC` ;

-- -----------------------------------------------------
-- Table `New_TCC`.`Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `New_TCC`.`Usuario` (
  `Id_Usuario` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `Nome_Usuario` VARCHAR(45) NOT NULL,
  `CPF_Usuario` CHAR(11) NOT NULL,
  `Data_Nascimento_Usuario` DATE NOT NULL,
  `Cidade_Usuario` VARCHAR(45),
  `Email_Usuario` VARCHAR(100) NOT NULL,
  `Senha_Usuario` VARCHAR(100) NOT NULL,
  `Sexo_Usuario` ENUM("F", "M"),
  `Nivel_acesso` INT NOT NULL DEFAULT 1
);


-- -----------------------------------------------------
-- Table `New_TCC`.`Curso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `New_TCC`.`Curso` (
  `id_Curso` INT NOT NULL AUTO_INCREMENT,
  `Nome_Curso` VARCHAR(45) NOT NULL,
  `Horario_Curso` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_Curso`));


-- -----------------------------------------------------
-- Table `New_TCC`.`Perfil`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `New_TCC`.`Perfil` (
  `Id_Perfil` INT NOT NULL AUTO_INCREMENT,
  `Id_Usuario` INT NOT NULL,
  `Foto_perfil` VARCHAR(256) NULL,
  `Biografia_Perfil` TEXT NULL,
  `Data_Atualizacao_Perfil` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id_Perfil`),
  INDEX `fk_Perfil_Usuario_idx` (`Id_Usuario` ASC),
  CONSTRAINT `fk_Perfil_Usuario`
    FOREIGN KEY (`Id_Usuario`)
    REFERENCES `New_TCC`.`Usuario` (`Id_Usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `New_TCC`.`Postagem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `New_TCC`.`Postagem` (
  `Id_Postagem` INT NOT NULL AUTO_INCREMENT,
  `Id_Usuario` INT NOT NULL,
  `Legenda_postagem` TEXT NULL,
  `Localizacao_midia_Postagem` VARCHAR(256) NULL,
  `Data_postagem` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id_Postagem`),
  INDEX `fk_Usuarios_Postagem_idx` (`Id_Usuario` ASC),
  CONSTRAINT `fk_Usuarios_Postagem`
    FOREIGN KEY (`Id_Usuario`)
    REFERENCES `New_TCC`.`Usuario` (`Id_Usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;


-- -----------------------------------------------------
-- Table `New_TCC`.`Curtida`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `New_TCC`.`Curtida` (
  `id_Curtida` INT NOT NULL AUTO_INCREMENT,
  `id_Usuario` INT NOT NULL,
  `id_Postagem` INT NOT NULL,
  `Data_curtida` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_Curtida`),
  INDEX `fk_Usuarios_Curtidas_idx` (`id_Usuario` ASC),
  INDEX `fk_Postagem_Curtidas_idx` (`id_Postagem` ASC),
  CONSTRAINT `fk_Usuarios_Curtidas`
    FOREIGN KEY (`id_Usuario`)
    REFERENCES `New_TCC`.`Usuario` (`Id_Usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Postagem_Curtidas`
    FOREIGN KEY (`id_Postagem`)
    REFERENCES `New_TCC`.`Postagem` (`Id_Postagem`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;


-- -----------------------------------------------------
-- Table `New_TCC`.`Comentario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `New_TCC`.`Comentario` (
  `Id_Comentario` INT NOT NULL AUTO_INCREMENT,
  `Id_Usuario` INT NOT NULL,
  `Id_Postagem` INT NOT NULL,
  `Comentario_Postado` VARCHAR(256) NULL,
  `Data_Comentario` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id_Comentario`),
  INDEX `fk_Usuarios_Comentarios_idx` (`Id_Usuario` ASC),
  INDEX `fk_Postagem_Comentarios_idx` (`Id_Postagem` ASC),
  CONSTRAINT `fk_Usuarios_Comentarios`
    FOREIGN KEY (`Id_Usuario`)
    REFERENCES `New_TCC`.`Usuario` (`Id_Usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Postagem_Comentarios`
    FOREIGN KEY (`Id_Postagem`)
    REFERENCES `New_TCC`.`Postagem` (`Id_Postagem`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;


-- -----------------------------------------------------
-- Table `New_TCC`.`Professor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `New_TCC`.`Professor` (
  `Id_Professor` INT NOT NULL AUTO_INCREMENT,
  `Nome_Professor` VARCHAR(45) NOT NULL,
  `Password_Professor` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`Id_Professor`),
  UNIQUE INDEX `Nome_Professor_UNIQUE` (`Nome_Professor` ASC))
;

-- -----------------------------------------------------
-- Table `New_TCC`.`Professor_Curso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `New_TCC`.`Professor_Curso` (
  `id_Professor_Curso` INT NOT NULL AUTO_INCREMENT,
  `id_Cursos` INT NOT NULL,
  `id_Professor` INT NOT NULL,
  PRIMARY KEY (`id_Professor_Curso`),
  INDEX `fk_Cursos_Prof_Cursos_idx` (`id_Cursos` ASC),
  INDEX `fk_Professores_Prof_Cursos_idx` (`id_Professor` ASC),
  CONSTRAINT `fk_Cursos_Prof_Cursos`
    FOREIGN KEY (`id_Cursos`)
    REFERENCES `New_TCC`.`Curso` (`id_Curso`)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Professores_Prof_Cursos`
    FOREIGN KEY (`id_Professor`)
    REFERENCES `New_TCC`.`Professor` (`Id_Professor`)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `New_TCC`.`Matricula`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `New_TCC`.`Matricula` (
  `Id_Matricula` INT NOT NULL AUTO_INCREMENT,
  `Id_Usuario` INT NOT NULL,
  `Id_Curso` INT NOT NULL,
  PRIMARY KEY (`Id_Matricula`),
  INDEX `fk_Usuario_Matricula_idx` (`Id_Usuario` ASC),
  INDEX `fk_Cursos_Matricula_idx` (`Id_Curso` ASC),
  CONSTRAINT `fk_Usuario_Matricula`
    FOREIGN KEY (`Id_Usuario`)
    REFERENCES `New_TCC`.`Usuario` (`Id_Usuario`)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cursos_Matricula`
    FOREIGN KEY (`Id_Curso`)
    REFERENCES `New_TCC`.`Curso` (`id_Curso`)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `New_TCC`.`Materia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `New_TCC`.`Materia` (
  `Id_Materia` INT NOT NULL AUTO_INCREMENT,
  `Id_Professor` INT NOT NULL,
  `Nome_Materia` VARCHAR(45) NOT NULL,
  `Modulo_Materia` INT NOT NULL,
  PRIMARY KEY (`Id_Materia`),
  UNIQUE INDEX `Nome_Materia_UNIQUE` (`Nome_Materia` ASC),
  INDEX `fk_Materia_Professor_idx` (`Id_Professor` ASC),
  CONSTRAINT `fk_Materia_Professor`
    FOREIGN KEY (`Id_Professor`)
    REFERENCES `New_TCC`.`Professor` (`Id_Professor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `New_TCC`.`Materia_Curso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `New_TCC`.`Materia_Curso` (
  `Id_Materia_Curso` INT NOT NULL AUTO_INCREMENT,
  `Id_Materia` INT NOT NULL,
  `Id_Curso` INT NOT NULL,
  PRIMARY KEY (`Id_Materia_Curso`),
  INDEX `fk_MateCursos_Materia_idx` (`Id_Materia` ASC),
  INDEX `fk_MateCursos_Cursos_idx` (`Id_Curso` ASC),
  CONSTRAINT `fk_MateCursos_Materia`
    FOREIGN KEY (`Id_Materia`)
    REFERENCES `New_TCC`.`Materia` (`Id_Materia`)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_MateCursos_Cursos`
    FOREIGN KEY (`Id_Curso`)
    REFERENCES `New_TCC`.`Curso` (`id_Curso`)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `New_TCC`.`Conexao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `New_TCC`.`Conexao` (
  `Id_Conexao` INT NOT NULL,
  `Solicitacao_Enviada` INT NOT NULL,
  `Solicitacao_Solicitada` INT NOT NULL,
  `Data_Conexao` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  INDEX `fk_Amizade_Usuarios_idx` (`Solicitacao_Solicitada` ASC),
  INDEX `fk_Amizade_Enviada_idx` (`Solicitacao_Enviada` ASC),
  PRIMARY KEY (`Id_Conexao`),
  CONSTRAINT `fk_Amizade_Solicitada`
    FOREIGN KEY (`Solicitacao_Solicitada`)
    REFERENCES `New_TCC`.`Usuario` (`Id_Usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Amizade_Enviada`
    FOREIGN KEY (`Solicitacao_Enviada`)
    REFERENCES `New_TCC`.`Usuario` (`Id_Usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `New_TCC`.`Mensagem_Privada`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `New_TCC`.`Mensagem_Privada` (
  `Id_Mensagem_Privada` INT NOT NULL AUTO_INCREMENT,
  `Id_Usuario_Emisssor` INT NOT NULL,
  `Id_Usuario_Receptor` INT NOT NULL,
  `Mensagem` TEXT NOT NULL,
  `Localizacao_Midia` TEXT NULL,
  `Data_Mensagem` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id_Mensagem_Privada`),
  INDEX `fk_Usuario_Emissor_idx` (`Id_Usuario_Emisssor` ASC),
  INDEX `fk_Usuario_Receptor_idx` (`Id_Usuario_Receptor` ASC),
  CONSTRAINT `fk_Usuario_Emissor`
    FOREIGN KEY (`Id_Usuario_Emisssor`)
    REFERENCES `New_TCC`.`Usuario` (`Id_Usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuario_Receptor`
    FOREIGN KEY (`Id_Usuario_Receptor`)
    REFERENCES `New_TCC`.`Usuario` (`Id_Usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `New_TCC`.`Notificacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `New_TCC`.`Notificacao` (
  `Id_Notificacao` INT NOT NULL AUTO_INCREMENT,
  `Id_Usuario` INT NOT NULL,
  `Tipo_Notificacao` VARCHAR(50) NOT NULL,
  `Mensagem_Notificacao` TEXT NOT NULL,
  `Data_Notificacao` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Lida_Notificacao` TINYINT NULL DEFAULT 0,
  PRIMARY KEY (`Id_Notificacao`),
  INDEX `fk_Usuario_Notificacao_idx` (`Id_Usuario` ASC),
  CONSTRAINT `fk_Usuario_Notificacao`
    FOREIGN KEY (`Id_Usuario`)
    REFERENCES `New_TCC`.`Usuario` (`Id_Usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `New_TCC`.`Grupo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `New_TCC`.`Grupo` (
  `Id_Grupo` INT NOT NULL AUTO_INCREMENT,
  `Id_Criador_Professor` INT NOT NULL,
  `Nome_Grupo` VARCHAR(50) NOT NULL,
  `Descricao_Grupo` VARCHAR(50) NULL,
  `localizacao_Foto` TEXT NULL,
  `Data_Criacao` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  INDEX `fk_Grupos_Professores_idx` (`Id_Criador_Professor` ASC),
  PRIMARY KEY (`Id_Grupo`),
  CONSTRAINT `fk_Grupos_Professores`
    FOREIGN KEY (`Id_Criador_Professor`)
    REFERENCES `New_TCC`.`Professor` (`Id_Professor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `New_TCC`.`Integrante_Grupo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `New_TCC`.`Integrante_Grupo` (
  `Id_Intregante_Grupo` INT NOT NULL AUTO_INCREMENT,
  `Id_Grupo` INT NOT NULL,
  `Id_Usuario` INT NULL,
  `Id_Professor` INT NULL,
  `Data_Entrada` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id_Intregante_Grupo`),
  INDEX `fk_Integrantes_Grupos_idx` (`Id_Grupo` ASC),
  INDEX `fk_Integrantes_Usuarios_idx` (`Id_Usuario` ASC),
  INDEX `fk_Integrantes_Professores_idx` (`Id_Professor` ASC),
  CONSTRAINT `fk_Integrantes_Grupos`
    FOREIGN KEY (`Id_Grupo`)
    REFERENCES `New_TCC`.`Grupo` (`Id_Grupo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Integrantes_Usuarios`
    FOREIGN KEY (`Id_Usuario`)
    REFERENCES `New_TCC`.`Usuario` (`Id_Usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Integrantes_Professores`
    FOREIGN KEY (`Id_Professor`)
    REFERENCES `New_TCC`.`Professor` (`Id_Professor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `New_TCC`.`Anexo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `New_TCC`.`Anexo` (
  `Id_Anexo` INT NOT NULL AUTO_INCREMENT,
  `Id_Postagem` INT NULL,
  `Id_Mensagens_Privada` INT NULL,
  `Nome_Arquivo` VARCHAR(255) NOT NULL,
  `Tipo_Anexo` VARCHAR(50) NOT NULL,
  `Caminho_Anexo` VARCHAR(255) NOT NULL,
  `Data_Anexo` TIMESTAMP NOT NULL,
  PRIMARY KEY (`Id_Anexo`),
  INDEX `fk_Anexos_Postagem_idx` (`Id_Postagem` ASC),
  INDEX `fk_Anexos_Mensagens_Privadas_idx` (`Id_Mensagens_Privada` ASC),
  CONSTRAINT `fk_Anexos_Postagem`
    FOREIGN KEY (`Id_Postagem`)
    REFERENCES `New_TCC`.`Postagem` (`Id_Postagem`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Anexos_Mensagens_Privadas`
    FOREIGN KEY (`Id_Mensagens_Privada`)
    REFERENCES `New_TCC`.`Mensagem_Privada` (`Id_Mensagem_Privada`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE Vagas(
	Id_Vagas INT PRIMARY KEY AUTO_INCREMENT,
    Id_Professor INT NOT NULL,
    Id_Curso INT NOT NULL,
    Nome_Vaga VARCHAR(50) NOT NULL,
    Descricao_Vaga VARCHAR(300) NOT NULL,
    Data_Vaga_Publicada TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_Vaga_Professor 
		FOREIGN KEY (Id_Professor) 
		REFERENCES professor (Id_Professor),
	CONSTRAINT fk_Vaga_Curso
		FOREIGN KEY (Id_Curso)
        REFERENCES curso (id_Curso)
);

ALTER TABLE professor CHANGE COLUMN Password_Professor Senha_Professor VARCHAR(50) NOT NULL;

ALTER TABLE `new_tcc`.`anexo` 
ADD COLUMN `Deletado_Anexo` TINYINT(4) NOT NULL DEFAULT 0 AFTER `Data_Anexo`;

ALTER TABLE `new_tcc`.`comentario` 
ADD COLUMN `Deletado_comentario` TINYINT(4) NOT NULL DEFAULT 0 AFTER `Data_Comentario`;

ALTER TABLE `new_tcc`.`conexao` 
ADD COLUMN `Deletada_Conexao` TINYINT(4) NOT NULL DEFAULT 0 AFTER `Data_Conexao`;

ALTER TABLE `new_tcc`.`curso` 
ADD COLUMN `Deletado_Curso` TINYINT(4) NOT NULL DEFAULT 0 AFTER `Horario_Curso`;

ALTER TABLE `new_tcc`.`curtida` 
ADD COLUMN `Deletada_Curtida` TINYINT(4) NOT NULL DEFAULT 0 AFTER `Data_curtida`;

ALTER TABLE `new_tcc`.`grupo` 
ADD COLUMN `Deletado_Grupo` TINYINT(4) NOT NULL DEFAULT 0 AFTER `Data_Criacao`;

ALTER TABLE `new_tcc`.`materia` 
ADD COLUMN `Deletado_Materia` TINYINT(4) NOT NULL DEFAULT 0 AFTER `Modulo_Materia`;

ALTER TABLE `new_tcc`.`matricula` 
ADD COLUMN `Deletado_Matricula` TINYINT(4) NOT NULL DEFAULT 0 AFTER `Id_Curso`;

ALTER TABLE `new_tcc`.`mensagem_privada` 
ADD COLUMN `Deletado_Mensagem` TINYINT(4) NOT NULL DEFAULT 0 AFTER `Data_Mensagem`;

ALTER TABLE `new_tcc`.`perfil` 
ADD COLUMN `Deletado_Perfil` TINYINT(4) NOT NULL DEFAULT 0 AFTER `Data_Atualizacao_Perfil`;

ALTER TABLE `new_tcc`.`postagem` 
ADD COLUMN `Deletado_Postagem` TINYINT(4) NOT NULL DEFAULT 0 AFTER `Data_postagem`;

ALTER TABLE `new_tcc`.`professor` 
ADD COLUMN `Deletado_Professor` TINYINT(4) NOT NULL DEFAULT 0 AFTER `Senha_Professor`;

ALTER TABLE `new_tcc`.`usuario` 
ADD COLUMN `Deletado_Usuario` TINYINT(4) NOT NULL DEFAULT 0 AFTER `Nivel_acesso`;

ALTER TABLE `new_tcc`.`vagas` 
ADD COLUMN `Deletado_Vagas` TINYINT(4) NOT NULL DEFAULT 0 AFTER `Data_Vaga_Publicada`;

ALTER TABLE `new_tcc`.`professor` 
DROP COLUMN `Senha_Professor`,
DROP COLUMN `Nome_Professor`,
ADD COLUMN `Id_Usuario` INT(11) NOT NULL AFTER `Id_Professor`,
ADD INDEX `fk_Professor_Usuario_idx` (`Id_Usuario` ASC),
DROP INDEX `Nome_Professor_UNIQUE` ;
;

ALTER TABLE `new_tcc`.`professor` 
ADD CONSTRAINT `fk_Professor_Usuario`
  FOREIGN KEY (`Id_Usuario`)
  REFERENCES `new_tcc`.`usuario` (`Id_Usuario`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;


ALTER TABLE `new_tcc`.`integrante_grupo` 
DROP FOREIGN KEY `fk_Integrantes_Professores`;

ALTER TABLE `new_tcc`.`integrante_grupo` 
DROP COLUMN `Id_Professor`,
DROP INDEX `fk_Integrantes_Professores_idx` ;
;



 
