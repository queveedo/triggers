USE GameStore;

--TABALA CREADA PARA USAR LA BITACORA  
CREATE TABLE BitaEncargado(
	id INT IDENTITY PRIMARY KEY,
	idEncargadoTienda  INT NOT NULL , 
	Nombre VARCHAR (30) NOT NULL,
	Fecha DATETIME NOT NULL,
	Usuario  VARCHAR (100)NOT NULL,
	Terminal  VARCHAR(100)NOT NULL,
	Evento  VARCHAR(30) NOT NULL,
	CHECK(Evento= 'INSERT'  OR Evento='DELETE')
)

---TRIGGER CREADO PARA CON INERT Y DELETE
CREATE TRIGGER encargadoTienda on registroGameStore.encargadoTienda
AFTER INSERT,DELETE
AS 
BEGIN
    SET NOCOUNT ON;
	INSERT INTO BitaEncargado
	(
    idEncargado,Nombres,Fecha,Usuario,Terminal,Evento
	)
	SELECT
	   i.idEncargado,i.Nombres,GETDATE(),SYSTEM_USER,HOST_NAME(),'INSERT'

	FROM inserted i
	UNION ALL
	SELECT
	    d.idEncargado,d.Nombres,GETDATE(),SYSTEM_USER,HOST_NAME(),'DELETE'
	FROM deleted d 
END;

--COMPROBAR INSERT
INSERT INTO registroGameStore.encargadoTienda(idEncargado,Nombres,Apellidos,Telefono,Salarios) 
VALUES(12,'Mario','Quevedo','76195364',2500)


---COMPROBAR DELETE
DELETE FROM registroGameStore.encargadoTienda WHERE idEncargado=8;


--VERIFICANDO 
SELECT * FROM BitaEncargado