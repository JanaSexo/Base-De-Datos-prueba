
CREATE SEQUENCE venta_seq START WITH 25 INCREMENT BY 1;
CREATE OR REPLACE PACKAGE libreria_pkg AS
    PROCEDURE comprar_libro(
        p_cliente IN VARCHAR2,
        p_idpublicacion IN CHAR,
        p_cantidad IN NUMBER,
        p_idempleado IN NUMBER
    );
END libreria_pkg;

CREATE OR REPLACE PACKAGE BODY libreria_pkg AS

    PROCEDURE comprar_libro(
        p_cliente IN VARCHAR2,
        p_idpublicacion IN CHAR,
        p_cantidad IN NUMBER,
        p_idempleado IN NUMBER
    ) IS
        v_precio   NUMBER(10,2);
        v_stock    NUMBER;
        v_total    NUMBER(10,2);
    BEGIN
        SELECT precio, stock INTO v_precio, v_stock
        FROM publicacion
        WHERE idpublicacion = p_idpublicacion;

        IF v_stock < p_cantidad THEN
            dbms_output.put_line('No hay stock');
            RETURN;
        END IF;

        v_total := p_cantidad * v_precio;

        INSERT INTO venta (idventa, cliente, fecha,idempleado,idpublicacion, cantidad,precio,dcto,subtotal,impuesto, total)
        VALUES (venta_seq.NEXTVAL, p_cliente, SYSDATE ,p_idempleado, p_idpublicacion, p_cantidad,v_precio,0,v_total,0, v_total);

        UPDATE publicacion
        SET stock = stock - p_cantidad
        WHERE idpublicacion = p_idpublicacion;

        COMMIT;

        dbms_output.put_line('Compra registrada correctamente.');
        dbms_output.put_line('Total a pagar: $' || v_total);

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            dbms_output.put_line('El libro no existe.');
        WHEN OTHERS THEN
            dbms_output.put_line('Error al procesar la compra: ' || SQLERRM);
    END comprar_libro;

END libreria_pkg;

EXEC libreria_pkg.comprar_libro('Gonzalo', 'SEP00005', 2, 1);
select * from venta;

DROP SEQUENCE venta_seq;
