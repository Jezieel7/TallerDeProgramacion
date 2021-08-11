program siete;
const
    base= 2;

procedure aBinario(n: integer);
var
    binario: integer;
begin
    binario:= n mod 2;
    n:= n div 2;
    if n > 1 then begin
        aBinario(n);
    end
    else begin
        write(n);
    end;
    write(binario);
end;
var
    n: integer;
begin
    readln(n);
    aBinario(n);
end.

program ocho;
type
    abb= ^nodo;
    
    nodo=record
        num: integer;
        hi: abb;
        hd: abb;
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

procedure cargarNumeros(var a: abb);
var
    num: integer;
begin
    readln(num);
    while(num <> 0) do begin
        crearArbol(a, num);
        readln(num);
    end;
end;

procedure masGrande(a: abb; var max: integer);
begin
	if(a^.hd <> nil)then begin
        masGrande(a^.hd, max);
    end
    else begin
        max:= a^.num;
    end;
end;

procedure masChico(a: abb; var min: integer);
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

procedure ordenCreciente(a: abb);
begin
    if(a <> nil)then begin
        ordenCreciente(a^.hi);
        writeln(a^.num);
        ordenCreciente(a^.hd);
    end;
end;

procedure ordenDecreciente(a: abb);
begin
    if(a <> nil)then begin
        ordenDecreciente(a^.hd);
        writeln(a^.num);
        ordenDecreciente(a^.hi);
    end;
end;

var
    a: abb;
    min, max,cant: integer;
begin
    min:= 999; max:= -999; cant:= 0;
    cargarNumeros(a);
    writeln('cantElementos');
    cantElementos(a, cant);
    writeln(cant);
    writeln('miin');
    masChico(a, min);
    writeln(min);
    writeln('max');
    masGrande(a, max);
    writeln(max);
    writeln('ordenCreciente');
    ordenCreciente(a);
    writeln('ordenDecreciente');
    ordenDecreciente(a);
end.
