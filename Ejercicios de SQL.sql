use 5entrega;
-- Creación de tablas principales (Padres)
CREATE TABLE Departamento (
    id_departamento INT PRIMARY KEY,
    nombre VARCHAR(100),
    ubicacion VARCHAR(100)
);
CREATE TABLE Puesto (
    id_puesto INT PRIMARY KEY,
    nombre VARCHAR(100),
    nivel INT
);

CREATE TABLE Beneficio (
    id_beneficio INT PRIMARY KEY,
    nombre VARCHAR(100),
    descripcion TEXT,
    costo DECIMAL(10, 2)
);

CREATE TABLE Proveedor (
    id_proveedor INT PRIMARY KEY,
    nombre VARCHAR(100),
    contacto VARCHAR(100),
    telefono VARCHAR(20)
);

-- Creación de tablas dependientes (Hijas)
CREATE TABLE Empleado (
    id_empleado INT PRIMARY KEY,
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    fecha_nacimiento DATE,
    genero CHAR(1),
    salario DECIMAL(10, 2),
    id_departamento INT,
    id_puesto INT,
    FOREIGN KEY (id_departamento) REFERENCES Departamento(id_departamento),
    FOREIGN KEY (id_puesto) REFERENCES Puesto(id_puesto)
);

CREATE TABLE Proyecto (
    id_proyecto INT PRIMARY KEY,
    nombre VARCHAR(100),
    fecha_inicio DATE,
    fecha_fin DATE,
    id_departamento INT,
    FOREIGN KEY (id_departamento) REFERENCES Departamento(id_departamento)
);

CREATE TABLE Capacitacion (
    id_capacitacion INT PRIMARY KEY,
    nombre VARCHAR(100),
    descripcion TEXT,
    fecha_inicio DATE,
    fecha_fin DATE,
    id_proveedor INT,
    FOREIGN KEY (id_proveedor) REFERENCES Proveedor(id_proveedor)
);

-- Creación de tablas intermedias (Relaciones M:N)
CREATE TABLE Empleado_Proyecto (
    id_empleado_proyecto INT PRIMARY KEY,
    id_empleado INT,
    id_proyecto INT,
    horas_asignadas INT,
    FOREIGN KEY (id_empleado) REFERENCES Empleado(id_empleado),
    FOREIGN KEY (id_proyecto) REFERENCES Proyecto(id_proyecto)
);

CREATE TABLE Empleado_Capacitacion (
    id_empleado_capacitacion INT PRIMARY KEY,
    id_empleado INT,
    id_capacitacion INT,
    calificacion DECIMAL(5, 2),
    asistencia CHAR(1),  -- 'S' para sí, 'N' para no
    FOREIGN KEY (id_empleado) REFERENCES Empleado(id_empleado),
    FOREIGN KEY (id_capacitacion) REFERENCES Capacitacion(id_capacitacion)
);

CREATE TABLE Empleado_Beneficio (
    id_empleado_beneficio INT PRIMARY KEY,
    id_empleado INT,
    id_beneficio INT,
    fecha_inicio DATE,
    fecha_fin DATE,
    FOREIGN KEY (id_empleado) REFERENCES Empleado(id_empleado),
    FOREIGN KEY (id_beneficio) REFERENCES Beneficio(id_beneficio)
);

-- Creación de tablas adicionales (para evaluar el desempeño, permisos, asistencia)
CREATE TABLE Evaluacion_Desempeno (
    id_evaluacion INT PRIMARY KEY,
    id_empleado INT,
    fecha DATE,
    puntaje DECIMAL(3, 2),
    comentarios TEXT,
    FOREIGN KEY (id_empleado) REFERENCES Empleado(id_empleado)
);

CREATE TABLE Permiso (
    id_permiso INT PRIMARY KEY,
    id_empleado INT,
    fecha_inicio DATE,
    fecha_fin DATE,
    motivo VARCHAR(255),
    estatus VARCHAR(50),
    FOREIGN KEY (id_empleado) REFERENCES Empleado(id_empleado)
);

CREATE TABLE Asistencia (
    id_asistencia INT PRIMARY KEY,
    id_empleado INT,
    fecha DATE,
    hora_entrada TIME,
    hora_salida TIME,
    estatus VARCHAR(50), -- 'Presente', 'Ausente', etc.
    FOREIGN KEY (id_empleado) REFERENCES Empleado(id_empleado)
);
-- Datos de prueba para Departamento
INSERT INTO Departamento (id_departamento, nombre, ubicacion)
VALUES
(1, 'Recursos Humanos', 'Edificio A'),
(2, 'Tecnología', 'Edificio B'),
(3, 'Finanzas', 'Edificio C'),
(4, 'Marketing', 'Edificio D'),
(5, 'Ventas', 'Edificio E');

-- Datos de prueba para Puesto
INSERT INTO Puesto (id_puesto, nombre, nivel)
VALUES
(1, 'Gerente', 5),
(2, 'Analista', 3),
(3, 'Desarrollador', 4),
(4, 'Contador', 3),
(5, 'Representante de Ventas', 2);

-- Datos de prueba para Beneficio
INSERT INTO Beneficio (id_beneficio, nombre, descripcion, costo)
VALUES
(1, 'Seguro Médico', 'Cobertura médica completa', 1500.00),
(2, 'Vale de Comida', 'Vales mensuales para restaurantes', 200.00),
(3, 'Bonos de Desempeño', 'Bonos por buen desempeño', 500.00),
(4, 'Capacitación', 'Cursos de formación profesional', 300.00),
(5, 'Gimnasio', 'Acceso al gimnasio corporativo', 100.00);

-- Datos de prueba para Proveedor
INSERT INTO Proveedor (id_proveedor, nombre, contacto, telefono)
VALUES
(1, 'Proveedor A', 'contactoA@example.com', '123456789'),
(2, 'Proveedor B', 'contactoB@example.com', '987654321'),
(3, 'Proveedor C', 'contactoC@example.com', '456123789'),
(4, 'Proveedor D', 'contactoD@example.com', '789456123'),
(5, 'Proveedor E', 'contactoE@example.com', '321654987');
-- Datos de prueba para Empleado
INSERT INTO Empleado (id_empleado, nombre, apellido, fecha_nacimiento, genero, salario, id_departamento, id_puesto)
VALUES
(1, 'Juan', 'Pérez', '1985-05-15', 'M', 50000.00, 1, 1),
(2, 'Ana', 'García', '1990-07-22', 'F', 45000.00, 2, 3),
(3, 'Carlos', 'López', '1980-09-30', 'M', 48000.00, 3, 4),
(4, 'Lucía', 'Martínez', '1995-12-10', 'F', 42000.00, 4, 2),
(5, 'Mario', 'González', '1975-03-18', 'M', 40000.00, 5, 5);

-- Datos de prueba para Proyecto
INSERT INTO Proyecto (id_proyecto, nombre, fecha_inicio, fecha_fin, id_departamento)
VALUES
(1, 'Implementación ERP', '2022-01-01', '2023-12-31', 2),
(2, 'Rebranding Corporativo', '2021-05-01', '2022-12-31', 4),
(3, 'Optimización de Procesos', '2023-02-01', '2023-11-30', 3),
(4, 'Estrategia de Ventas 2024', '2023-06-01', '2024-05-31', 5),
(5, 'Capacitación Interna', '2022-09-01', '2023-03-31', 1);

-- Datos de prueba para Capacitacion
INSERT INTO Capacitacion (id_capacitacion, nombre, descripcion, fecha_inicio, fecha_fin, id_proveedor)
VALUES
(1, 'Curso de Liderazgo', 'Formación en habilidades de liderazgo', '2022-01-15', '2022-03-15', 1),
(2, 'Taller de Innovación', 'Técnicas de innovación en el trabajo', '2022-04-01', '2022-06-01', 2),
(3, 'Seminario Financiero', 'Gestión financiera avanzada', '2022-07-10', '2022-09-10', 3),
(4, 'Workshop de Marketing', 'Estrategias de marketing digital', '2022-10-01', '2022-12-01', 4),
(5, 'Entrenamiento en Ventas', 'Mejora de técnicas de ventas', '2023-01-15', '2023-03-15', 5);
-- Datos de prueba para Empleado_Proyecto
INSERT INTO Empleado_Proyecto (id_empleado_proyecto, id_empleado, id_proyecto, horas_asignadas)
VALUES
(1, 1, 1, 100),
(2, 2, 2, 120),
(3, 3, 3, 150),
(4, 4, 4, 80),
(5, 5, 5, 110);

-- Datos de prueba para Empleado_Capacitacion
INSERT INTO Empleado_Capacitacion (id_empleado_capacitacion, id_empleado, id_capacitacion, calificacion, asistencia)
VALUES
(1, 1, 1, 4.5, 'S'),
(2, 2, 2, 3.8, 'S'),
(3, 3, 3, 4.2, 'N'),
(4, 4, 4, 3.6, 'S'),
(5, 5, 5, 4.0, 'N');

-- Datos de prueba para Empleado_Beneficio
INSERT INTO Empleado_Beneficio (id_empleado_beneficio, id_empleado, id_beneficio, fecha_inicio, fecha_fin)
VALUES
(1, 1, 1, '2022-01-01', '2023-01-01'),
(2, 2, 2, '2022-02-01', '2023-02-01'),
(3, 3, 3, '2022-03-01', '2023-03-01'),
(4, 4, 4, '2022-04-01', '2023-04-01'),
(5, 5, 5, '2022-05-01', '2023-05-01');
-- Datos de prueba para Evaluacion_Desempeno
INSERT INTO Evaluacion_Desempeno (id_evaluacion, id_empleado, fecha, puntaje, comentarios)
VALUES
(1, 1, '2023-06-01', 4.5, 'Excelente desempeño'),
(2, 2, '2023-06-01', 4.0, 'Buen desempeño'),
(3, 3, '2023-06-01', 3.8, 'Desempeño aceptable'),
(4, 4, '2023-06-01', 4.2, 'Muy buen desempeño'),
(5, 5, '2023-06-01', 3.5, 'Desempeño mejorable');

-- Datos de prueba para Permiso
INSERT INTO Permiso (id_permiso, id_empleado, fecha_inicio, fecha_fin, motivo, estatus)
VALUES
(1, 1, '2023-07-01', '2023-07-10', 'Vacaciones', 'Aprobado'),
(2, 2, '2023-08-01', '2023-08-05', 'Asuntos personales', 'Aprobado'),
(3, 3, '2023-09-01', '2023-09-03', 'Enfermedad', 'Aprobado'),
(4, 4, '2023-10-01', '2023-10-07', 'Capacitación', 'Aprobado'),
(5, 5, '2023-11-01', '2023-11-04', 'Viaje', 'Aprobado');

-- Datos de prueba para Asistencia
INSERT INTO Asistencia (id_asistencia, id_empleado, fecha, hora_entrada, hora_salida, estatus)
VALUES
(1, 1, '2023-11-01', '08:00:00', '17:00:00', 'Presente'),
(2, 2, '2023-11-01', '08:15:00', '17:15:00', 'Presente'),
(3, 3, '2023-11-01', '08:30:00', '17:30:00', 'Presente'),
(4, 4, '2023-11-01', '08:45:00', '17:45:00', 'Presente'),
(5, 5, '2023-11-01', '09:00:00', '18:00:00', 'Presente');
