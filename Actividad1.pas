program actividad1;
Type
    cliente=record
        apeynom:string;
        dni:integer;
        categoria:integer;
        monto: real;
    end;
    
    lista= ^nodo;
    
    nodo=record
        dato:cliente;
        sig:lista;
    end;
    
    arbol= ^nodoA;
    
    nodoA=record
        dato: cliente;
        HI: arbol;
        HD: arbol;
    end;
    
procedure leerCliente (var cli:cliente);
begin
    readln(cli.apeynom);
    readln(cli.dni);
    readln(cli.categoria);
    readln(cli.monto);
end;    

procedure cargarLista(var L:lista);
var
    cli: cliente;
    aux: lista;
begin
    leerCliente(cli);
    while (cli.apeynom <> 'ZZZ') do begin
        if (L = nil) then begin
            new(L);
            L^.dato:= cli;
            L^.sig:= nil; 
        end
        else begin
            new(aux);
            aux^.sig:= L;
            L:= aux;
        end;
        leerCliente(cli);
    end;
end;

procedure mostrarDNI(A: arbol);
begin    
    if(A <> nil)then begin
        mostrarDNI(A^.HI);
        writeln(A^.dato.dni);
        mostrarDNI(A^.HD);
    end;
end;

procedure agregarEnArbol(var A: arbol; c: cliente);
begin
    if(A = nil)then begin
        new(A);
        A^.dato:= c;
        A^.HI:= nil;
        A^.HD:= nil;
    end
    else begin
        if(c.dni < A^.dato.dni)then begin
            agregarEnArbol(A^.HI, c);
        end
        else begin
            agregarEnArbol(A^.HD, c);
        end;
    end;
end;

procedure generarArbol(L: lista; var A: arbol);
begin
    while (L <> nil) do begin
        agregarEnArbol(A, L^.dato);
        L:= L^.sig;
    end;
end;

procedure mayorCategoria(A:arbol; var c:cliente);
begin
    if(A <> nil)then begin
        mayorCategoria(A^.HI, c);
        mayorCategoria(A^.HD,c);
        if(A^.dato.categoria > c.categoria)then begin
            c:= A^.dato;
        end;
    end;      
end;

var
    L: lista;
    A: arbol;
    c: cliente;
begin
    c.categoria:= -1;
    cargarLista(L);
    generarArbol(L, A);	
    write ('Muestro los dni ordenados de menor a mayor');
    mostrarDNI(A);
    writeln;
    writeln;
    mayorCategoria(A, c); 	
    write('El cliente', c.apeynom, 'es el de mayor categora');
    readln;
end.
