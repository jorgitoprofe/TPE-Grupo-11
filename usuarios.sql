-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 24-09-2023 a las 20:33:19
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `tpe_comedor`
--
CREATE DATABASE IF NOT EXISTS `tpe_comedor` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `tpe_comedor`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `alumno`
--

CREATE TABLE `alumno` (
  `dni_alumno` int(11) NOT NULL,
  `Saldo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bandeja_pedidos`
--

CREATE TABLE `bandeja_pedidos` (
  `num_pedido` int(11) NOT NULL,
  `dni_empleado` int(11) NOT NULL,
  `estado` enum('en espera','en preparacion','completado') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cajero`
--

CREATE TABLE `cajero` (
  `dni_empleado` int(11) NOT NULL,
  `dni_alumno` int(11) DEFAULT NULL,
  `dinero_entregado` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cocinero`
--

CREATE TABLE `cocinero` (
  `dni_empleado` int(11) NOT NULL,
  `estado` enum('ocupado','libre') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleado`
--

CREATE TABLE `empleado` (
  `dni_empleado` int(11) NOT NULL,
  `horarioIngreso` datetime NOT NULL,
  `rol` enum('cajero','cocinero') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `menu`
--

CREATE TABLE `menu` (
  `dia` enum('lunes','martes','miercoles','jueves','viernes') NOT NULL,
  `menu` enum('menu1','menu2','menu3') NOT NULL,
  `precio` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ticket`
--

CREATE TABLE `ticket` (
  `num_pedido` int(11) NOT NULL,
  `dni_alumno` int(11) NOT NULL,
  `menu_seleccionado` enum('menu1','menu2','menu3') NOT NULL,
  `hora` datetime NOT NULL,
  `precio` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `dni` int(11) NOT NULL,
  `Nombre` varchar(20) NOT NULL,
  `Apellido` varchar(20) NOT NULL,
  `Contraseña` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `alumno`
--
ALTER TABLE `alumno`
  ADD KEY `dni_alumno` (`dni_alumno`);

--
-- Indices de la tabla `bandeja_pedidos`
--
ALTER TABLE `bandeja_pedidos`
  ADD KEY `num_pedido` (`num_pedido`);

--
-- Indices de la tabla `cajero`
--
ALTER TABLE `cajero`
  ADD KEY `dni_cajero` (`dni_empleado`);

--
-- Indices de la tabla `cocinero`
--
ALTER TABLE `cocinero`
  ADD KEY `dni_cocinero` (`dni_empleado`);

--
-- Indices de la tabla `empleado`
--
ALTER TABLE `empleado`
  ADD KEY `dni_empleado` (`dni_empleado`);

--
-- Indices de la tabla `ticket`
--
ALTER TABLE `ticket`
  ADD PRIMARY KEY (`num_pedido`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`dni`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `ticket`
--
ALTER TABLE `ticket`
  MODIFY `num_pedido` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `alumno`
--
ALTER TABLE `alumno`
  ADD CONSTRAINT `alumno_ibfk_1` FOREIGN KEY (`dni_alumno`) REFERENCES `usuario` (`dni`),
  ADD CONSTRAINT `dni_alumno` FOREIGN KEY (`dni_alumno`) REFERENCES `usuario` (`dni`);

--
-- Filtros para la tabla `bandeja_pedidos`
--
ALTER TABLE `bandeja_pedidos`
  ADD CONSTRAINT `num_pedido` FOREIGN KEY (`num_pedido`) REFERENCES `ticket` (`num_pedido`);

--
-- Filtros para la tabla `cajero`
--
ALTER TABLE `cajero`
  ADD CONSTRAINT `dni_cajero` FOREIGN KEY (`dni_empleado`) REFERENCES `empleado` (`dni_empleado`);

--
-- Filtros para la tabla `cocinero`
--
ALTER TABLE `cocinero`
  ADD CONSTRAINT `dni_cocinero` FOREIGN KEY (`dni_empleado`) REFERENCES `empleado` (`dni_empleado`);

--
-- Filtros para la tabla `empleado`
--
ALTER TABLE `empleado`
  ADD CONSTRAINT `dni_empleado` FOREIGN KEY (`dni_empleado`) REFERENCES `usuario` (`dni`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
