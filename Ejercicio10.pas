Program diez;
type
    alumno=record
        legajo: integer;
        apellido: string;
        nombre: string;
        dni: integer;
        anoIngreso: integer;
    end;
    
    abb= ^arbol;
    
    arbol=record
        alum: alumno;
        hi: abb;
        hd: abb;
    end;
    
procedure leerAlumno(alum: alumno);
begin
    with alum do begin
        writeln('Introduzca año de ingreso del alumno');
        readln(anoIngreso);
        if(anoIngreso > 2000)then begin
            writeln('Introduzca el número de legajo del alumno');
            readln(legajo);
            writeln('Introduzca el nombre del alumno');
            readln(nombre);
            writeln('Introduzca el apellido del alumno');
            readln(apellido);
            writeln('Introduzca el dni del alumno');
            readln(dni);
        end;
    end;
end;

procedure agregarHoja(var a: abb; al: alumno);
begin
    new(a);
    a^.alum:= al; a^.hi:= nil; a^.hd:= nil;
end;

procedure crearArbol(var a: abb; al: alumno);
begin
    if(a = nil)then begin
        agregarHoja(a, al);
    end
    else begin
        if(al.legajo < a^.alum.legajo)then begin
            crearArbol(a^.hi, al);
        end
        else begin
            crearArbol(a^.hd, al);
        end;
    end;
end;

procedure cargarAlumnos(var a: abb);
var
    alum: alumno;
begin
    leerAlumno(alum);
    while(alum.anoIngreso > 2000)do begin
        crearArbol(a, alum);
        leerAlumno(alum);
    end;
end;

procedure informar12803(a: abb);
begin
    if((a <> nil) and (a^.alum.legajo > 12803))then begin
            writeln(a^.alum.nombre);
            writeln(a^.alum.apellido);
            informar12803(a^.hd);
            informar12803(a^.hi);
    end
    else if(a <> nil) and (a^.alum.legajo <= 12803)then begin
        informar12803(a^.hd);
    end;
end;

procedure informar2803(a: abb);
begin
    if((a <> nil) and (a^.alum.legajo > 2803) and (a^.alum.legajo < 6982))then begin
            writeln(a^.alum.nombre);
            writeln(a^.alum.apellido);
            informar12803(a^.hd);
            informar12803(a^.hi);
    end
    else if((a <> nil) and (a^.alum.legajo < 2803))then begin
        informar12803(a^.hd);
    end
    else if((a <> nil) and (a^.alum.legajo > 6982))then begin
        informar12803(a^.hi);
    end;
end;

var
    a: abb;
begin
    cargarAlumnos(a);
    informar12803(a);
    informar2803(a);
end.
