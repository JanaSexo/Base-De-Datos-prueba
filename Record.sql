--SET SERVEROUTPUT ON;
DECLARE
    TYPE titulo_rec IS RECORD
    (
        nombre venta.cliente%TYPE,
        titulo publicacion.titulo%TYPE,
        autor publicacion.autor%TYPE
    );
    v_compra titulo_rec;
BEGIN
    SELECT v.cliente,p.titulo,p.autor
    INTO v_compra.nombre, v_compra.titulo,v_compra.autor
    FROM venta v
    INNER JOIN publicacion p ON v.idpublicacion=p.idpublicacion
    WHERE idventa = &idven;
    
    dbms_output.put_line(v_compra.nombre||' compró el título: "'||v_compra.titulo||'" del autor '||v_compra.autor);
    
END;

--SELECT * FROM VENTA;