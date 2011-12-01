SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Ciudades`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Ciudades` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`Ciudades` (
  `id_ciudad` TINYINT NOT NULL AUTO_INCREMENT ,
  `ciudad` VARCHAR(20) NOT NULL ,
  PRIMARY KEY (`id_ciudad`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Usuarios`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Usuarios` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`Usuarios` (
  `rutusuario` VARCHAR(10) NOT NULL ,
  `nombre` VARCHAR(20) NOT NULL ,
  `apaterno` VARCHAR(20) NOT NULL ,
  `amaterno` VARCHAR(20) NULL ,
  `clave` VARCHAR(15) NOT NULL ,
  `id_ciudad` TINYINT NOT NULL ,
  PRIMARY KEY (`rutusuario`) ,
  CONSTRAINT `fk_Usuarios_Ciudades`
    FOREIGN KEY (`id_ciudad` )
    REFERENCES `mydb`.`Ciudades` (`id_ciudad` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX `fk_Usuarios_Ciudades` ON `mydb`.`Usuarios` (`id_ciudad` ASC) ;


-- -----------------------------------------------------
-- Table `mydb`.`Info`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Info` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`Info` (
  `id_info` TINYINT NOT NULL AUTO_INCREMENT ,
  `telefono` VARCHAR(20) NULL ,
  `email` VARCHAR(20) NULL ,
  PRIMARY KEY (`id_info`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Empresas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Empresas` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`Empresas` (
  `rutempresa` VARCHAR(10) NOT NULL ,
  `nombre` VARCHAR(20) NOT NULL ,
  `direccion` VARCHAR(45) NOT NULL ,
  `tipoempresa` TINYINT NOT NULL ,
  `id_ciudad` TINYINT NOT NULL ,
  PRIMARY KEY (`rutempresa`) ,
  CONSTRAINT `fk_Empresas_Ciudades`
    FOREIGN KEY (`id_ciudad` )
    REFERENCES `mydb`.`Ciudades` (`ciudad` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = MyISAM;

CREATE INDEX `fk_Empresas_Ciudades` ON `mydb`.`Empresas` (`id_ciudad` ASC) ;


-- -----------------------------------------------------
-- Table `mydb`.`Entidad-Info`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Entidad-Info` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`Entidad-Info` (
  `rut` VARCHAR(10) NOT NULL ,
  `id_info` TINYINT NOT NULL AUTO_INCREMENT ,
  PRIMARY KEY (`id_info`, `rut`) ,
  CONSTRAINT `fk_Entidad-Info_Usuarios`
    FOREIGN KEY (`rut` )
    REFERENCES `mydb`.`Usuarios` (`rutusuario` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Entidad-Info_Info`
    FOREIGN KEY (`id_info` )
    REFERENCES `mydb`.`Info` (`id_info` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Entidad-Info_Empresas`
    FOREIGN KEY (`rut` )
    REFERENCES `mydb`.`Empresas` (`rutempresa` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Entidad-Info_Usuarios` ON `mydb`.`Entidad-Info` (`rut` ASC) ;

CREATE INDEX `fk_Entidad-Info_Info` ON `mydb`.`Entidad-Info` (`id_info` ASC) ;

CREATE INDEX `fk_Entidad-Info_Empresas` ON `mydb`.`Entidad-Info` (`rut` ASC) ;


-- -----------------------------------------------------
-- Table `mydb`.`Roles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Roles` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`Roles` (
  `id_rol` TINYINT NOT NULL AUTO_INCREMENT ,
  `nombre` VARCHAR(20) NOT NULL ,
  `descripcion` VARCHAR(50) NOT NULL ,
  PRIMARY KEY (`id_rol`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Usuario_Rol`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Usuario_Rol` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`Usuario_Rol` (
  `rutusuario` VARCHAR(10) NOT NULL ,
  `id_rol` TINYINT NOT NULL ,
  PRIMARY KEY (`id_rol`, `rutusuario`) ,
  CONSTRAINT `fk_Usuario_Rol_Roles`
    FOREIGN KEY (`id_rol` )
    REFERENCES `mydb`.`Roles` (`id_rol` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuario_Rol_Usuarios`
    FOREIGN KEY (`rutusuario` )
    REFERENCES `mydb`.`Usuarios` (`rutusuario` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Usuario_Rol_Roles` ON `mydb`.`Usuario_Rol` (`id_rol` ASC) ;

CREATE INDEX `fk_Usuario_Rol_Usuarios` ON `mydb`.`Usuario_Rol` (`rutusuario` ASC) ;


-- -----------------------------------------------------
-- Table `mydb`.`Transacciones`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Transacciones` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`Transacciones` (
  `id_trans` BIGINT NOT NULL AUTO_INCREMENT ,
  `fecha_trans` DATE NOT NULL ,
  `rutusuario` VARCHAR(10) NOT NULL ,
  `rutempresa` VARCHAR(10) NOT NULL ,
  `tipo_trans` TINYINT NOT NULL ,
  `estado` TINYINT NULL ,
  `nota` BIGINT NULL ,
  PRIMARY KEY (`id_trans`) ,
  CONSTRAINT `fk_Transacciones_Usuarios`
    FOREIGN KEY (`rutusuario` )
    REFERENCES `mydb`.`Usuarios` (`rutusuario` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Transacciones_Empresas`
    FOREIGN KEY (`rutempresa` )
    REFERENCES `mydb`.`Empresas` (`rutempresa` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Transacciones_Usuarios` ON `mydb`.`Transacciones` (`rutusuario` ASC) ;

CREATE INDEX `fk_Transacciones_Empresas` ON `mydb`.`Transacciones` (`rutempresa` ASC) ;


-- -----------------------------------------------------
-- Table `mydb`.`Documentos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Documentos` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`Documentos` (
  `id_documento` BIGINT NOT NULL ,
  `id_trans` BIGINT NOT NULL ,
  `tipo_documento` TINYINT NOT NULL ,
  `numero` INT NOT NULL ,
  `neto` INT NOT NULL ,
  `total` INT NULL ,
  `estapago` TINYINT NOT NULL ,
  PRIMARY KEY (`id_documento`) ,
  CONSTRAINT `fk_Documentos_Transacciones`
    FOREIGN KEY (`id_trans` )
    REFERENCES `mydb`.`Transacciones` (`id_trans` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Documentos_Transacciones` ON `mydb`.`Documentos` (`id_trans` ASC) ;


-- -----------------------------------------------------
-- Table `mydb`.`Familia`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Familia` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`Familia` (
  `id_familia` TINYINT NOT NULL AUTO_INCREMENT ,
  `nombre` VARCHAR(20) NOT NULL ,
  `medida` VARCHAR(10) NOT NULL ,
  `descripcion` VARCHAR(45) NULL ,
  PRIMARY KEY (`id_familia`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Productos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Productos` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`Productos` (
  `id_producto` INT NOT NULL AUTO_INCREMENT ,
  `nombre` VARCHAR(20) NOT NULL ,
  `precio` INT NULL ,
  `stockminimo` INT NULL ,
  `stockactual` INT NOT NULL ,
  `id_familia` TINYINT NOT NULL ,
  PRIMARY KEY (`id_producto`) ,
  CONSTRAINT `fk_Productos_Familia`
    FOREIGN KEY (`id_familia` )
    REFERENCES `mydb`.`Familia` (`id_familia` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Productos_Familia` ON `mydb`.`Productos` (`id_familia` ASC) ;


-- -----------------------------------------------------
-- Table `mydb`.`Detalles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Detalles` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`Detalles` (
  `id_detalle` INT NOT NULL ,
  `id_documento` BIGINT NOT NULL ,
  `id_producto` INT NOT NULL ,
  `cantidad` INT NOT NULL ,
  `neto` INT NOT NULL ,
  PRIMARY KEY (`id_documento`, `id_detalle`, `id_producto`) ,
  CONSTRAINT `fk_Detalles_Documentos`
    FOREIGN KEY (`id_documento` )
    REFERENCES `mydb`.`Documentos` (`id_documento` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Detalles_Productos`
    FOREIGN KEY (`id_producto` )
    REFERENCES `mydb`.`Productos` (`id_producto` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Detalles_Documentos` ON `mydb`.`Detalles` (`id_documento` ASC) ;

CREATE INDEX `fk_Detalles_Productos` ON `mydb`.`Detalles` (`id_producto` ASC) ;


-- -----------------------------------------------------
-- Table `mydb`.`Producto_Empresa`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Producto_Empresa` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`Producto_Empresa` (
  `rutempresa` VARCHAR(10) NOT NULL ,
  `id_producto` INT NOT NULL ,
  PRIMARY KEY (`rutempresa`, `id_producto`) ,
  CONSTRAINT `fk_Producto_Empresa_Empresas`
    FOREIGN KEY (`rutempresa` )
    REFERENCES `mydb`.`Empresas` (`rutempresa` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Producto_Empresa_Productos`
    FOREIGN KEY (`id_producto` )
    REFERENCES `mydb`.`Productos` (`id_producto` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Producto_Empresa_Empresas` ON `mydb`.`Producto_Empresa` (`rutempresa` ASC) ;

CREATE INDEX `fk_Producto_Empresa_Productos` ON `mydb`.`Producto_Empresa` (`id_producto` ASC) ;


-- -----------------------------------------------------
-- Table `mydb`.`Pagos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Pagos` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`Pagos` (
  `id_documento` BIGINT NOT NULL ,
  `fechapago` DATE NOT NULL ,
  `total` INT NOT NULL ,
  `tipo_pago` TINYINT NOT NULL ,
  `otro` VARCHAR(50) NULL ,
  PRIMARY KEY (`id_documento`, `fechapago`) ,
  CONSTRAINT `fk_Pagos_Documentos1`
    FOREIGN KEY (`id_documento` )
    REFERENCES `mydb`.`Documentos` (`id_documento` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = MyISAM;

CREATE INDEX `fk_Pagos_Documentos1` ON `mydb`.`Pagos` (`id_documento` ASC) ;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
