CREATE SCHEMA IF NOT EXISTS `New_TCC` DEFAULT CHARACTER SET utf8 ;
USE `New_TCC` ;

-- -----------------------------------------------------
-- Table `New_TCC`.`Perfil`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `New_TCC`.`Perfil` (
  `id_Perfil` INT NOT NULL AUTO_INCREMENT,
  `Foto_perfil` VARCHAR(256) NULL,
  `Biografia_Perfil` TEXT NULL,
  `Data_atualizacao_Perfil` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_Perfil`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `New_TCC`.`Usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `New_TCC`.`Usuarios` (
  `id_Usuarios` INT NOT NULL AUTO_INCREMENT,
  `id_Perfil` INT NOT NULL,
  `Nome_Usuario` VARCHAR(45) NOT NULL,
  `CPF_Usuario` CHAR(11) NOT NULL,
  `Data_Nascimento_Usuario` DATE NOT NULL,
  `Cidade_Usuario` VARCHAR(45) NULL,
  `Email_Usuario` VARCHAR(100) NOT NULL,
  `Senha_Usuario` VARCHAR(100) NOT NULL,
  `Sexo_Usuario` ENUM("F", "M") NULL,
  `Nivel_acesso` INT NOT NULL DEFAULT DEFAULT(1),
  PRIMARY KEY (`id_Usuarios`),
  INDEX `fk_Usuarios_Perfil_idx` (`id_Perfil` ASC),
  CONSTRAINT `fk_Usuarios_Perfil`
    FOREIGN KEY (`id_Perfil`)
    REFERENCES `New_TCC`.`Perfil` (`id_Perfil`)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `New_TCC`.`Cursos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `New_TCC`.`Cursos` (
  `id_Cursos` INT NOT NULL AUTO_INCREMENT,
  `Nome_Curso` VARCHAR(45) NOT NULL,
  `Horario_Curso` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_Cursos`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `New_TCC`.`Postagem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `New_TCC`.`Postagem` (
  `id_Postagem` INT NOT NULL AUTO_INCREMENT,
  `id_Usuarios` INT NOT NULL,
  `Legenda_postagem` TEXT NULL,
  `Localizacao_midia_Postagem` VARCHAR(256) NULL,
  `Data_postagem` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_Postagem`),
  INDEX `fk_Usuarios_Postagem_idx` (`id_Usuarios` ASC),
  CONSTRAINT `fk_Usuarios_Postagem`
    FOREIGN KEY (`id_Usuarios`)
    REFERENCES `New_TCC`.`Usuarios` (`id_Usuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `New_TCC`.`Curtidas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `New_TCC`.`Curtidas` (
  `id_Curtidas` INT NOT NULL AUTO_INCREMENT,
  `id_Usuarios` INT NOT NULL,
  `id_Postagem` INT NOT NULL,
  `Data_curtida` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_Curtidas`),
  INDEX `fk_Usuarios_Curtidas_idx` (`id_Usuarios` ASC),
  INDEX `fk_Postagem_Curtidas_idx` (`id_Postagem` ASC),
  CONSTRAINT `fk_Usuarios_Curtidas`
    FOREIGN KEY (`id_Usuarios`)
    REFERENCES `New_TCC`.`Usuarios` (`id_Usuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Postagem_Curtidas`
    FOREIGN KEY (`id_Postagem`)
    REFERENCES `New_TCC`.`Postagem` (`id_Postagem`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `New_TCC`.`Comentarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `New_TCC`.`Comentarios` (
  `id_Comentarios` INT NOT NULL AUTO_INCREMENT,
  `id_Usuarios` INT NOT NULL,
  `id_Postagem` INT NOT NULL,
  `Comentario` VARCHAR(256) NULL,
  `Data_Comentario` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_Comentarios`),
  INDEX `fk_Usuarios_Comentarios_idx` (`id_Usuarios` ASC),
  INDEX `fk_Postagem_Comentarios_idx` (`id_Postagem` ASC),
  CONSTRAINT `fk_Usuarios_Comentarios`
    FOREIGN KEY (`id_Usuarios`)
    REFERENCES `New_TCC`.`Usuarios` (`id_Usuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Postagem_Comentarios`
    FOREIGN KEY (`id_Postagem`)
    REFERENCES `New_TCC`.`Postagem` (`id_Postagem`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `New_TCC`.`Professores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `New_TCC`.`Professores` (
  `id_Professores` INT NOT NULL AUTO_INCREMENT,
  `Nome_Professor` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_Professores`),
  UNIQUE INDEX `Nome_Professor_UNIQUE` (`Nome_Professor` ASC))
ENGINE = InnoDB;


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
    REFERENCES `New_TCC`.`Cursos` (`id_Cursos`)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Professores_Prof_Cursos`
    FOREIGN KEY (`id_Professor`)
    REFERENCES `New_TCC`.`Professores` (`id_Professores`)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `New_TCC`.`Matricula`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `New_TCC`.`Matricula` (
  `id_Matricula` INT NOT NULL AUTO_INCREMENT,
  `id_Usuario` INT NOT NULL,
  `id_Cursos` INT NOT NULL,
  PRIMARY KEY (`id_Matricula`),
  INDEX `fk_Usuario_Matricula_idx` (`id_Usuario` ASC),
  INDEX `fk_Cursos_Matricula_idx` (`id_Cursos` ASC),
  CONSTRAINT `fk_Usuario_Matricula`
    FOREIGN KEY (`id_Usuario`)
    REFERENCES `New_TCC`.`Usuarios` (`id_Usuarios`)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cursos_Matricula`
    FOREIGN KEY (`id_Cursos`)
    REFERENCES `New_TCC`.`Cursos` (`id_Cursos`)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `New_TCC`.`Materia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `New_TCC`.`Materia` (
  `id_Materia` INT NOT NULL AUTO_INCREMENT,
  `Id_Professor` INT NOT NULL,
  `Nome_Materia` VARCHAR(45) NOT NULL,
  `Modulo_Materia` INT NOT NULL,
  `id_professor` VARCHAR(45) NULL,
  PRIMARY KEY (`id_Materia`),
  UNIQUE INDEX `Nome_Materia_UNIQUE` (`Nome_Materia` ASC),
  INDEX `fk_Materia_Professor_idx` (`Id_Professor` ASC),
  CONSTRAINT `fk_Materia_Professor`
    FOREIGN KEY (`Id_Professor`)
    REFERENCES `New_TCC`.`Professores` (`id_Professores`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `New_TCC`.`Materia_Cursos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `New_TCC`.`Materia_Cursos` (
  `Id_Materia_Cursos` INT NOT NULL AUTO_INCREMENT,
  `Id_Materia` INT NOT NULL,
  `Id_Cursos` INT NOT NULL,
  PRIMARY KEY (`Id_Materia_Cursos`),
  INDEX `fk_MateCursos_Materia_idx` (`Id_Materia` ASC),
  INDEX `fk_MateCursos_Cursos_idx` (`Id_Cursos` ASC),
  CONSTRAINT `fk_MateCursos_Materia`
    FOREIGN KEY (`Id_Materia`)
    REFERENCES `New_TCC`.`Materia` (`id_Materia`)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_MateCursos_Cursos`
    FOREIGN KEY (`Id_Cursos`)
    REFERENCES `New_TCC`.`Cursos` (`id_Cursos`)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `New_TCC`.`Conexoes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `New_TCC`.`Conexoes` (
  `Solicitacao_Enviada` INT NOT NULL,
  `Solicitacao_Solicitada` INT NOT NULL,
  `Data_Conexao` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  INDEX `fk_Amizade_Usuarios_idx` (`Solicitacao_Solicitada` ASC),
  INDEX `fk_Amizade_Enviada_idx` (`Solicitacao_Enviada` ASC),
  CONSTRAINT `fk_Amizade_Solicitada`
    FOREIGN KEY (`Solicitacao_Solicitada`)
    REFERENCES `New_TCC`.`Usuarios` (`id_Usuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Amizade_Enviada`
    FOREIGN KEY (`Solicitacao_Enviada`)
    REFERENCES `New_TCC`.`Usuarios` (`id_Usuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `New_TCC`.`Mensagens_Privadas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `New_TCC`.`Mensagens_Privadas` (
  `Id_Mensagens_Privadas` INT NOT NULL AUTO_INCREMENT,
  `Id_Usuario_Emisssor` INT NOT NULL,
  `Id_Usuario_Receptor` INT NOT NULL,
  `Mensagem` TEXT NOT NULL,
  `Localizacao_Midia` TEXT NULL,
  `Data_Mensagem` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id_Mensagens_Privadas`),
  INDEX `fk_Usuario_Emissor_idx` (`Id_Usuario_Emisssor` ASC),
  INDEX `fk_Usuario_Receptor_idx` (`Id_Usuario_Receptor` ASC),
  CONSTRAINT `fk_Usuario_Emissor`
    FOREIGN KEY (`Id_Usuario_Emisssor`)
    REFERENCES `New_TCC`.`Usuarios` (`id_Usuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuario_Receptor`
    FOREIGN KEY (`Id_Usuario_Receptor`)
    REFERENCES `New_TCC`.`Usuarios` (`id_Usuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


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
    REFERENCES `New_TCC`.`Usuarios` (`id_Usuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `New_TCC`.`Grupos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `New_TCC`.`Grupos` (
  `Id_Grupos` INT NOT NULL AUTO_INCREMENT,
  `Id_Criador_Professor` INT NOT NULL,
  `Nome_Grupos` VARCHAR(50) NOT NULL,
  `Descricao_Grupos` VARCHAR(50) NULL,
  `localizacao_Foto` TEXT NULL,
  `Data_Criacao` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  INDEX `fk_Grupos_Professores_idx` (`Id_Criador_Professor` ASC),
  PRIMARY KEY (`Id_Grupos`),
  CONSTRAINT `fk_Grupos_Professores`
    FOREIGN KEY (`Id_Criador_Professor`)
    REFERENCES `New_TCC`.`Professores` (`id_Professores`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `New_TCC`.`Integrantes_Grupo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `New_TCC`.`Integrantes_Grupo` (
  `Id_Grupos_Usuarios` INT NOT NULL AUTO_INCREMENT,
  `Id_Grupos` INT NOT NULL,
  `Id_Usuarios` INT NOT NULL,
  `Id_Professores` INT NOT NULL,
  `Data_Entrada` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id_Grupos_Usuarios`),
  INDEX `fk_Integrantes_Grupos_idx` (`Id_Grupos` ASC),
  INDEX `fk_Integrantes_Usuarios_idx` (`Id_Usuarios` ASC),
  INDEX `fk_Integrantes_Professores_idx` (`Id_Professores` ASC),
  CONSTRAINT `fk_Integrantes_Grupos`
    FOREIGN KEY (`Id_Grupos`)
    REFERENCES `New_TCC`.`Grupos` (`Id_Grupos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Integrantes_Usuarios`
    FOREIGN KEY (`Id_Usuarios`)
    REFERENCES `New_TCC`.`Usuarios` (`id_Usuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Integrantes_Professores`
    FOREIGN KEY (`Id_Professores`)
    REFERENCES `New_TCC`.`Professores` (`id_Professores`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `New_TCC`.`Anexos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `New_TCC`.`Anexos` (
  `Id_Anexos` INT NOT NULL AUTO_INCREMENT,
  `Id_Postagem` INT NULL,
  `Id_Mensagens_Privadas` INT NULL,
  `Nome_Arquivo` VARCHAR(255) NOT NULL,
  `Tipo_Anexo` VARCHAR(50) NOT NULL,
  `Caminho_Anexo` VARCHAR(255) NOT NULL,
  `Data_Anexo` TIMESTAMP NOT NULL,
  PRIMARY KEY (`Id_Anexos`),
  INDEX `fk_Anexos_Postagem_idx` (`Id_Postagem` ASC),
  INDEX `fk_Anexos_Mensagens_Privadas_idx` (`Id_Mensagens_Privadas` ASC),
  CONSTRAINT `fk_Anexos_Postagem`
    FOREIGN KEY (`Id_Postagem`)
    REFERENCES `New_TCC`.`Postagem` (`id_Postagem`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Anexos_Mensagens_Privadas`
    FOREIGN KEY (`Id_Mensagens_Privadas`)
    REFERENCES `New_TCC`.`Mensagens_Privadas` (`Id_Mensagens_Privadas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;