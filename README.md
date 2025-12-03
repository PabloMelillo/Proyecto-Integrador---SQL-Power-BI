
1. 📋 Descripción del Proyecto


En este proyecto estaremos trabajando con la base de datos cruda creada en el proyecto anterior como el Google sheets y Power BI pero ampliada con algunas tablas adicionales para dar una visión mas transversal del negocio.



2. 🎯Objetivos del Proyecto

Entender el conjunto de datos y el negocio.
Lograr crear consultas basicas y complejas para responder a las necesidades de negocio.



3. 📝 Contexto

En este proyecto trabajé sobre una base de datos simulada que representa una empresa dedicada a brindar servicios de inspección técnica industrial PMG siguiendo el hilo de lo ya desarrollado. El objetivo fue aplicar conocimientos de SQL para resolver consultas clave que respondan a preguntas de negocio concretas, y así obtener información valiosa para la toma de decisiones.



4. 🕵️ Habilidades Adquiridas

Creemos que tienes las habilidades necesarias para llevar a cabo este proyecto ya que

consideramos que estas preparado para realizar las siguientes actividades:

✅  Aprender a leer modelos relacionales y tablas en una empresa

✅  Aprender a explorar datos para entenderlos mejora antes de trabajar con los datos

✅  Saber como desglosamos una pregunta de negocio para entenderla

✅  Como traducir preguntas de negocio a lenguaje de SQL

✅  Escribir querys complejas que responden a necesidades de negocio




5. 🛠️ Herramientas a utilizar



En este proyecto utilizaremos lenguaje de SQL y el gestor de base de datos MYSQL y Power BI.

📙 Glosario del proyecto:


🔹 Orden de servicio:
 Documento o registro que indica una tarea o inspección a realizar en una fecha determinada, generalmente asociada a un cliente o requerimiento técnico.

🔹 Inspección: Actividad técnica realizada por un empleado
Actividad técnica realizada por un empleado para verificar el cumplimiento de normas, condiciones técnicas o estándares de calidad.

🔹 Empleado: Persona
Persona asignada a realizar tareas dentro de la empresa, relacionadas con un departamento y con historial de inspecciones.

🔹 Departamento: Área funcional a la que
Área funcional a la que pertenece cada empleado (por ejemplo: calidad, mantenimiento, seguridad técnica, etc.).

🔹 Procedimiento Almacenado:
 Bloque de código SQL que permite ejecutar una serie de instrucciones de forma automatizada, reutilizable y segura.

🔹 Evento programado:
 Mecanismo en MySQL para ejecutar procedimientos de forma automática en momentos definidos (por ejemplo, todos los días o una sola vez).

🔹 NULL:
 Valor nulo en bases de datos, indica ausencia de datos (por ejemplo, fecha no ingresada).

🔹 Diagrama EER (Diagrama Entidad-Relación Extendido):
 Representación visual de las tablas de una base de datos y las relaciones entre ellas.



🧠 Funciones y conceptos SQL aplicados

rank()
over()
COUNT(), SUM(), MIN(), MAX(), y AVG()
JOIN(), INNER JOIN(), LEFT JOIN()
IFNULL()
CASE()
ORDER BY()
CREATE PROCEDURE()
EVENTS()
SET GLOBAL()
CALL()



6. 📶 Conjunto de datos del proyecto

En este proyecto trabajamos con una base de datos compuesta por varias tablas relacionadas. A continuación, se presenta una descripción general de las mismas, incluyendo sus campos principales y su propósito dentro del análisis. Esta sección funciona como un diccionario de datos , útil para comprender la estructura y el alcance de la información disponible.



<img width="801" height="854" alt="Grafico_Relacion" src="https://github.com/user-attachments/assets/c040cd14-5d81-47b6-80be-38e46e904dad" />



🔍 Análisis de Relaciones del Modelo EER 

El modelo refleja la gestión completa de servicios de inspección:


ordenes_servicio es el núcleo de la base, conectando clientes, servicios, empleados, logística, inspecciones y facturación.

clientes solicitan servicios.

Los servicios definen el tipo y costo base.

los empleados ejecutan inspecciones, y cada uno pertenece a un departamento .

inspecciones vincula empleados con órdenes, registrando resultados.

logistica gestiona el movimiento de equipos por orden.

facturas registra el monto, estado de pago y fecha de emisión.

Cada tabla está interrelacionada para dar seguimiento desde la solicitud hasta el pago, incluyendo procesos técnicos y administrativos.



📊 Exploración por Tabla



clientes : contiene información básica (nombre, industria, país). Permite segmentar por sector o región.

servicios : define tipos de servicio y su costo base. Útil para analizar la rentabilidad.

ordenes_servicio : registra cada solicitud con fechas clave. Fundamental para análisis temporales o cumplimiento.

empleados : permite cruzar roles y especialidades con productividad.

departamentos : estructura organizacional. Útil para evaluar carga y presupuesto por área.

inspecciones : da seguimiento técnico. Se pueden analizar resultados, frecuencia y desempeño.

logistica : permite observar eficiencia en envíos y recepción de equipos.

facturas : facilita el análisis financiero: montos, pagos y períodos de facturación.



💰Análisis Financiero


Estas son algunas propuestas concretas que se puede hacer como parte del análisis del negocio:



📊 1. Análisis de clientes

¿Qué industrias contratan más servicios?
¿De qué países o provincias viene la mayoría de los clientes?
¿Cuántos clientes están activos o inactivos (por estado)?

💼 2. Análisis de servicios ofrecidos

¿Cuáles son los servicios más solicitados?
¿Cuál es el ingreso total estimado por cada tipo de servicio?
¿Qué servicio tiene el mayor costo base?

👷‍♂️ 3. Análisis de personal

¿Cuántos empleados hay por rol? (Ej.: técnicos, auditores, administrativos)
¿Qué especialidades son más comunes?
¿Qué departamento tiene más empleados?

📍 4. Análisis de departamentos

¿Cuál es el presupuesto por departamento?
¿Qué departamentos están ubicados en qué provincias?
¿Hay relación entre el presupuesto y la cantidad de empleados por departamento?


📝 5. Análisis de órdenes de servicio (si incluye fecha, cliente y servicio)

¿Cuántas órdenes se generan por mes?

¿Qué cliente genera más ingresos o más órdenes?

¿Cuál es el servicio más solicitado por región?



