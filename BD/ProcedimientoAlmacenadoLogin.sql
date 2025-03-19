CREATE DATABASE ClinicaUH;
USE ClinicaUH;

-- Tabla Usuarios (Pacientes y Médicos)
CREATE TABLE Usuarios (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(50) NOT NULL,
    Apellido NVARCHAR(50) NOT NULL,
    Cedula NVARCHAR(20) UNIQUE NOT NULL,
    Telefono NVARCHAR(15) NOT NULL,
    Tipo NVARCHAR(20) CHECK (Tipo IN ('Paciente', 'Medico')) NOT NULL
);

-- Tabla Técnicos
CREATE TABLE Tecnicos (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(50) NOT NULL,
    Especialidad NVARCHAR(50) NOT NULL
);

-- Tabla Equipos Médicos
CREATE TABLE Equipos (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(50) NOT NULL,
    Descripcion NVARCHAR(MAX),
    IdTecnico INT,
    FOREIGN KEY (IdTecnico) REFERENCES Tecnicos(Id) ON DELETE SET NULL
);


USE ClinicaUH;
GO

-- Insertar 3 Usuarios (Pacientes y Medicos)
INSERT INTO Usuarios (Nombre, Apellido, Cedula, Telefono, Tipo)
VALUES 
('Roberto', 'Mendoza', '3216549870', '8111-2233', 'Paciente'),
('Elena', 'Vargas', '6549873210', '8222-3344', 'Paciente'),
('Fernando', 'Acosta', '7894561230', '8333-4455', 'Medico');

-- Insertar 3 Tecnicos
INSERT INTO Tecnicos (Nombre, Especialidad)
VALUES 
('Hector Ramirez', 'Rayos X'),
('Sofia Castillo', 'Laboratorio Clinico'),
('Mario Torres', 'Cardiologia');

-- Insertar 3 Equipos Medicos y asignarlos a Tecnicos
INSERT INTO Equipos (Nombre, Descripcion, IdTecnico)
VALUES 
('Tomografo', 'Equipo para tomografias computarizadas', 1),
('Analizador Hematologico', 'Equipo para analisis de sangre', 2),
('Electrocardiografo', 'Dispositivo para medir actividad cardiaca', 3);

-- Verificar que los datos fueron insertados correctamente
SELECT * FROM Usuarios;
SELECT * FROM Tecnicos;
SELECT * FROM Equipos;
GO


-- Procedimientos Almacenados para la Gestión de Usuarios
GO

CREATE PROCEDURE InsertarUsuario
    @Nombre NVARCHAR(50),
    @Apellido NVARCHAR(50),
    @Cedula NVARCHAR(20),
    @Telefono NVARCHAR(15),
    @Tipo NVARCHAR(20)
AS
BEGIN
    INSERT INTO Usuarios (Nombre, Apellido, Cedula, Telefono, Tipo)
    VALUES (@Nombre, @Apellido, @Cedula, @Telefono, @Tipo);
END;
GO

CREATE PROCEDURE ObtenerUsuarios
AS
BEGIN
    SELECT * FROM Usuarios;
END;
GO

CREATE PROCEDURE ModificarUsuario
    @Id INT,
    @Nombre NVARCHAR(50),
    @Apellido NVARCHAR(50),
    @Cedula NVARCHAR(20),
    @Telefono NVARCHAR(15),
    @Tipo NVARCHAR(20)
AS
BEGIN
    UPDATE Usuarios 
    SET Nombre = @Nombre, Apellido = @Apellido, Cedula = @Cedula, Telefono = @Telefono, Tipo = @Tipo
    WHERE Id = @Id;
END;
GO

CREATE PROCEDURE EliminarUsuario
    @Id INT
AS
BEGIN
    DELETE FROM Usuarios WHERE Id = @Id;
END;
GO