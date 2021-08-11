abb= ^nodoArbol;
    
    nodoArbol=record
        num: integer;
        hi: abb;
        hd: abb;
    end;

procedure cargarArbol(var a: abb);
var
    num: integer;
begin
    readln(num);
    while(num <> 0) do begin
        crearArbol(a, num);
        readln(num);
    end;
end;


procedure crearArbol(var a: abb; num: integer);
begin
    if(a = nil)then begin
        new(a);
        a^.num:= num; a^.hi:= nil; a^.hd:= nil;
    end
    else begin
        if(num < a^.num)then begin
            crearArbol(a^.hi, num);
        end
        else begin
            crearArbol(a^.hd, num);
        end;
    end;
end;

procedure maximo(a: abb; var max: integer);
begin
	if(a^.hd <> nil)then begin
        masGrande(a^.hd, max);
    end
    else begin
        max:= a^.num;
    end;
end;

procedure minimo(a: abb; var min: integer);
begin
	if(a^.hi <> nil)then begin
        masChico(a^.hi, min);
    end
    else begin
        min:= a^.num;
    end;
end;

procedure cantElementos(a: abb; var cant: integer);
begin
    if(a <> nil)then begin
        cant:= cant + 1;
        cantElementos(a^.hi, cant);
        cantElementos(a^.hd, cant);
    end;
end;

//menor a mayor
procedure ordenCreciente(a: abb);
begin
    if(a <> nil)then begin
        ordenCreciente(a^.hi);
        writeln(a^.num);
        ordenCreciente(a^.hd);
    end;
end;

//mayor a menor
procedure ordenDecreciente(a: abb);
begin
    if(a <> nil)then begin
        ordenDecreciente(a^.hd);
        writeln(a^.num);
        ordenDecreciente(a^.hi);
    end;
end;

//desde las hojas
Procedure posOrden(a: abb);
begin
   if ( a<> nil ) then begin
    posOrden (a^.HI);
    posOrden (a^.HD);
    write (a^.dato);
   end;
end;


//cargar tal cual
procedure preOrden(a: abb);
begin
    if(a <> nil)then begin
        writeln(a^.num);
        ordenDecreciente(a^.hi);
        ordenDecreciente(a^.hd);
    end;
end;

procedure busqueda(a: abb; n: string; var e: boolean);
begin
    if(a <> nil) and (not e)then begin
        existe(a^.hi, n, e);
        existe(a^.hd, n, e);
        if(a^.nombre = n)then begin
            e:= true;
        end;
    end
end;

procedure mayorAlgo(A:arbol; var c:cliente);
begin
    if(A <> nil)then begin
        mayorAlgo(a^.hi, c);
        mayorAlgo(a^.hd,c);
        if(A^.dato.categoria > c.categoria)then begin
            c:= A^.dato;
        end;
    end;      
end;

procedure informar(a: abb);
begin
    if(a <> nil)then begin
            writeln(a^.alum.nombre);
            writeln(a^.alum.apellido);
            informar(a^.hd);
            informar(a^.hi);
    end;
end;

