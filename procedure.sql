
CREATE OR REPLACE PROCEDURE listaLibros IS
BEGIN
    dbms_output.put_line('Listado de libros disponibles:');

    FOR libro_rec IN (
        SELECT idpublicacion, titulo, autor
        FROM publicacion
        ORDER BY titulo
    ) LOOP
        dbms_output.put_line('ID: ' || libro_rec.idpublicacion || 
                             ' | Título: ' || libro_rec.titulo || 
                             ' | Autor: ' || libro_rec.autor);
    END LOOP;

EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('Error al listar libros: ' || SQLERRM);
END;

EXEC listaLibros;