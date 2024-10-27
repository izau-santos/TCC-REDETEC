CREATE DATABASE `TCC`;
use `TCC`;

CREATE TABLE `Usuario` (
  `Id_Usuario` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `Nome_Usuario` VARCHAR(45) NOT NULL,
  `CPF_Usuario` CHAR(14) NOT NULL,
  `Localizacao_Foto` TEXT,
  `Id_Interesse` INT,
  `Data_Nascimento_Usuario` DATE NOT NULL,
  `Email_Usuario` VARCHAR(100) NOT NULL,
  `Senha_Usuario` VARCHAR(100) NOT NULL,
  `Nivel_acesso` INT NOT NULL DEFAULT 0,
  `Deletado_Usuario` TINYINT(4) NOT NULL DEFAULT 0
);

CREATE TABLE IF NOT EXISTS `Curso` (
  `Id_Curso` INT PRIMARY KEY  NOT NULL AUTO_INCREMENT,
  `Nome_Curso` VARCHAR(45) NOT NULL,
  `Horario_Curso` VARCHAR(45) NOT NULL,
  `Deletado_Curso` TINYINT(4) NOT NULL DEFAULT 0
);


CREATE TABLE `Perfil` (
  `Id_Perfil` INT  PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `Id_Usuario` INT NOT NULL,
  `Foto_perfil` VARCHAR(256) NULL,
  `Biografia_Perfil` TEXT NULL,
  `Data_Atualizacao_Perfil` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Deletado_Perfil` TINYINT(4) NOT NULL DEFAULT 0,
   FOREIGN KEY (`Id_Usuario`)
   REFERENCES `Usuario` (`Id_Usuario`)
);

CREATE TABLE `Postagem` (
  `Id_Postagem` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `Id_Usuario` INT,
  `Legenda_postagem` VARCHAR(256),
  `Localizacao_midia_Postagem` TEXT,
  `Data_postagem` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Deletado_Postagem` TINYINT(4) NOT NULL DEFAULT 0,
  FOREIGN KEY (`Id_Usuario`)
  REFERENCES `Usuario` (`Id_Usuario`)
);

CREATE TABLE `Curtida` (
  `id_Curtida` INT NOT NULL AUTO_INCREMENT,
  `id_Usuario` INT NOT NULL,
  `id_Postagem` INT NOT NULL,
  `Data_curtida` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `Deletada_Curtida` TINYINT(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_Curtida`),
    FOREIGN KEY (`id_Usuario`)
    REFERENCES `Usuario` (`Id_Usuario`),
    FOREIGN KEY (`id_Postagem`)
    REFERENCES `Postagem` (`Id_Postagem`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;

CREATE TABLE `Comentario` (
  `Id_Comentario` INT NOT NULL AUTO_INCREMENT,
  `Id_Usuario` INT NOT NULL,
  `Id_Postagem` INT NOT NULL,
  `Comentario_Postado` VARCHAR(256) NULL,
  `Data_Comentario` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `Deletado_comentario` TINYINT(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`Id_Comentario`),
    FOREIGN KEY (`Id_Usuario`)
    REFERENCES `Usuario` (`Id_Usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (`Id_Postagem`)
    REFERENCES `Postagem` (`Id_Postagem`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;

CREATE TABLE `Professor` (
  `Id_Professor` INT NOT NULL AUTO_INCREMENT,
  `Nome_Professor` VARCHAR(45) NOT NULL,
  `Senha_Professor` VARCHAR(50) NOT NULL,
  `Deletado_Professor` TINYINT(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`Id_Professor`),
  UNIQUE INDEX `Nome_Professor_UNIQUE` (`Nome_Professor` ASC))
;

CREATE TABLE `Professor_Curso` (
  `id_Professor_Curso` INT NOT NULL AUTO_INCREMENT,
  `id_Cursos` INT NOT NULL,
  `id_Professor` INT NOT NULL,
  `Deletado_Professor_Curso` TINYINT(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_Professor_Curso`),
    FOREIGN KEY (`id_Cursos`)
    REFERENCES `Curso` (`id_Curso`)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION,
    FOREIGN KEY (`id_Professor`)
    REFERENCES `Professor` (`Id_Professor`)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION);
    

CREATE TABLE `Matricula` (
  `Id_Matricula` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `Id_Usuario` INT,
  `Id_Curso` INT,
  `Deletado_Matricula` TINYINT(4) NOT NULL DEFAULT 0,
   FOREIGN KEY (`Id_Usuario`)
   REFERENCES `Usuario` (`Id_Usuario`)
   ON DELETE RESTRICT
   ON UPDATE NO ACTION,
   FOREIGN KEY (`Id_Curso`)
   REFERENCES `Curso` (`id_Curso`)
);

CREATE TABLE `Materia` (
  `Id_Materia` INT NOT NULL AUTO_INCREMENT,
  `Id_Professor` INT NOT NULL,
  `Nome_Materia` VARCHAR(45) NOT NULL,
  `Modulo_Materia` INT NOT NULL,
  `Deletado_Materia` TINYINT(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`Id_Materia`),
  UNIQUE INDEX `Nome_Materia_UNIQUE` (`Nome_Materia` ASC),
    FOREIGN KEY (`Id_Professor`)
    REFERENCES `Professor` (`Id_Professor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
CREATE TABLE `Materia_Curso` (
  `Id_Materia_Curso` INT NOT NULL AUTO_INCREMENT,
  `Id_Materia` INT NOT NULL,
  `Id_Curso` INT NOT NULL,
  `Deletado_Materia_Curso` TINYINT(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`Id_Materia_Curso`),
    FOREIGN KEY (`Id_Materia`)
    REFERENCES `Materia` (`Id_Materia`)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION,
    FOREIGN KEY (`Id_Curso`)
    REFERENCES `Curso` (`id_Curso`)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION);
    
CREATE TABLE `Conexao` (
  `Id_Conexao` INT NOT NULL,
  `Solicitacao_Enviada` INT NOT NULL,
  `Solicitacao_Solicitada` INT NOT NULL,
  `Data_Conexao` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Deletada_Conexao` TINYINT(4) NOT NULL DEFAULT 0 ,
  PRIMARY KEY (`Id_Conexao`),
    FOREIGN KEY (`Solicitacao_Solicitada`)
    REFERENCES `Usuario` (`Id_Usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (`Solicitacao_Enviada`)
    REFERENCES `Usuario` (`Id_Usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE `Mensagem_Privada` (
  `Id_Mensagem_Privada` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `Id_Usuario_Emissor` INT,
  `Id_Usuario_Receptor` INT,
  `Mensagem` TEXT NOT NULL,
  `Localizacao_Midia` TEXT NULL,
  `Data_Mensagem` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Deletado_Mesagem_Privada` TINYINT(4) NOT NULL DEFAULT 0,
   FOREIGN KEY (`Id_Usuario_Emissor`)
   REFERENCES `Usuario` (`Id_Usuario`),
   FOREIGN KEY (`Id_Usuario_Receptor`)
   REFERENCES `Usuario` (`Id_Usuario`)
);

CREATE TABLE `Notificacao` (
  `Id_Notificacao` INT NOT NULL AUTO_INCREMENT,
  `Id_Usuario` INT NOT NULL,
  `Tipo_Notificacao` VARCHAR(50) NOT NULL,
  `Mensagem_Notificacao` TEXT NOT NULL,
  `Data_Notificacao` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Lida_Notificacao` TINYINT NULL DEFAULT 0,
  `Deletado_Notificacao` TINYINT(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`Id_Notificacao`),
    FOREIGN KEY (`Id_Usuario`)
    REFERENCES `Usuario` (`Id_Usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE `Grupo` (
  `Id_Grupo` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `Id_Criador_Professor` INT NOT NULL,
  `Nome_Grupo` VARCHAR(50) NOT NULL,
  `Descricao_Grupo` VARCHAR(50) NULL,
  `localizacao_Foto` TEXT NULL,
  `Data_Criacao` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Deletado_Grupo` TINYINT(4) NOT NULL DEFAULT 0,
   FOREIGN KEY (`Id_Criador_Professor`)
   REFERENCES `Professor` (`Id_Professor`)
);

CREATE TABLE `Integrante_Grupo` (
  `Id_Intregante_Grupo` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `Id_Grupo` INT NOT NULL,
  `Id_Usuario` INT NULL,
  `Id_Professor` INT NULL,
  `Data_Entrada` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Deletado_Integrante_Grupo` TINYINT(4) NOT NULL DEFAULT 0,
   FOREIGN KEY (`Id_Grupo`)
   REFERENCES `Grupo` (`Id_Grupo`),
   FOREIGN KEY (`Id_Usuario`)
   REFERENCES `Usuario` (`Id_Usuario`),
   FOREIGN KEY (`Id_Professor`)
   REFERENCES `Professor` (`Id_Professor`)
);

CREATE TABLE `Anexo` (
  `Id_Anexo` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `Id_Postagem` INT NULL,
  `Id_Mensagens_Privada` INT NULL,
  `Nome_Arquivo` VARCHAR(255) NOT NULL,
  `Tipo_Anexo` VARCHAR(50) NOT NULL,
  `Caminho_Anexo` VARCHAR(255) NOT NULL,
  `Data_Anexo` TIMESTAMP NOT NULL,
  `Deletado_Anexo` TINYINT(4) NOT NULL DEFAULT 0,
  FOREIGN KEY (`Id_Postagem`)
  REFERENCES `Postagem` (`Id_Postagem`),
  FOREIGN KEY (`Id_Mensagens_Privada`)
  REFERENCES `Mensagem_Privada` (`Id_Mensagem_Privada`)
);

CREATE TABLE `Mensagens_Grupo` (
	`Id_Mensagem_Grupo` INT PRIMARY KEY AUTO_INCREMENT,
    `Id_Grupo` INT,
    `Id_Usuario_Emissor` INT,
    `Mensagem` VARCHAR(256),
    `Localizacao_Arquivo` TEXT,
    `Data_Enviada` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `Deletado_Mensagem_Grupo` TINYINT(4) NOT NULL DEFAULT 0,
    FOREIGN KEY (`Id_Grupo`)
    REFERENCES `Grupo` (`Id_Grupo`),
	FOREIGN KEY (`Id_Usuario_Emissor`)
    REFERENCES `Usuario` (`Id_Usuario`)
);

CREATE TABLE Vagas(
	Id_Vagas INT PRIMARY KEY AUTO_INCREMENT,
    Id_Professor INT NOT NULL,
    Id_Curso INT NOT NULL,
    Nome_Vaga VARCHAR(50) NOT NULL,
    Descricao_Vaga VARCHAR(300) NOT NULL,
    Data_Vaga_Publicada TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Deletado_Vaga  TINYINT(4) NOT NULL DEFAULT 0,
		FOREIGN KEY (Id_Professor) 
		REFERENCES professor (Id_Professor),
		FOREIGN KEY (Id_Curso)
        REFERENCES curso (id_Curso)
);














