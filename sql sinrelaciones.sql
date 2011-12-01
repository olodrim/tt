SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

DROP SCHEMA IF EXISTS `mydb` ;
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
  PRIMARY KEY (`rutusuario`) );


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
  PRIMARY KEY (`rutempresa`) )
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `mydb`.`Entidad-Info`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Entidad-Info` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`Entidad-Info` (
  `rut` VARCHAR(10) NOT NULL ,
  `id_info` TINYINT NOT NULL AUTO_INCREMENT ,
  PRIMARY KEY (`id_info`, `rut`) )
ENGINE = InnoDB;


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
  PRIMARY KEY (`id_rol`, `rutusuario`) )
ENGINE = InnoDB;


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
  PRIMARY KEY (`id_trans`) )
ENGINE = InnoDB;


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
  PRIMARY KEY (`id_documento`) )
ENGINE = InnoDB;


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
  PRIMARY KEY (`id_producto`) )
ENGINE = InnoDB;


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
  PRIMARY KEY (`id_documento`, `id_detalle`, `id_producto`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Producto_Empresa`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Producto_Empresa` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`Producto_Empresa` (
  `rutempresa` VARCHAR(10) NOT NULL ,
  `id_producto` INT NOT NULL ,
  PRIMARY KEY (`rutempresa`, `id_producto`) )
ENGINE = InnoDB;


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
  PRIMARY KEY (`id_documento`, `fechapago`) )
ENGINE = MyISAM;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
