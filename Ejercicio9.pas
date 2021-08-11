program nueve;
type
    abb= ^arbol;
    
    arbol=record
        nombre: string;
        hi: abb;
        hd: abb;
    end;

procedure agregarHoja(var a: abb; n: string);
begin
    new(a);
    a^.nombre:= n; a^.hi:= nil; a^.hd:= nil;
end;

procedure crearArbol(var a: abb; n: string);
begin
    if(a = nil)then begin
        agregarHoja(a, n);
    end
    else begin
        if(n < a^.nombre)then begin
            crearArbol(a^.hi, n);
        end
        else begin
            crearArbol(a^.hd, n);
        end;
    end;
end;

procedure agregarNombres(var a: abb);
var
    nombre: string;
begin
    readln(nombre);
    while(nombre <> 'ZZZ')do begin
        crearArbol(a, nombre);
        readln(nombre);
    end;
end;

procedure existe(a: abb; n: string; var e: boolean);
begin
    if(a <> nil) and (not e)then begin
        existe(a^.hi, n, e);
        existe(a^.hd, n, e);
        if(a^.nombre = n)then begin
            e:= true;
        end;
    end
end;

var
    ar: abb;
    nom: string;
    ex: boolean;
begin
    ex:= false;
    agregarNombres(ar);
    readln(nom);
    existe(ar, nom, ex);
    writeln(ex);
end.
