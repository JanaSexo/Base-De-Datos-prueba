CREATE OR REPLACE FUNCTION obtener_autor(p_idpublicacion IN CHAR)
RETURN VARCHAR2 IS v_autor VARCHAR2(100);
BEGIN
    SELECT autor INTO v_autor
    FROM publicacion
    WHERE idpublicacion = p_idpublicacion;

    RETURN v_autor;

END;

SELECT obtener_autor('LIB00001') AS autor FROM dual;


