program teatro;
const
    dias= 7;
type
    subrango= 1..dias;
    
    entradas=record
        dia: subrango;
        codObra: integer;
        asiento: integer;
        monto: real;
    end;
    
    lista= ^nodo;
    
    nodo=record
        entradasVendidas: entradas;
        sig: lista;
    end;
    
    nuevoEntradas=record
        codObra: integer;
        totalEntradas: integer;
    end;
    
    nuevaLista= ^nuevoNodo;
    
    nuevoNodo=record
        total: nuevoEntradas;
        sig: nuevaLista;
    end;
    
    funciones= array[subrango] of lista;

procedure cargarEntradas(var e: entradas);
begin
    with e do begin
        readln(codObra);
        if(codObra <> 0)then begin
            readln(dia);
            readln(asiento);
            readln(monto);
        end;
    end;
end;

procedure inicializarEstructura(var f: funciones);
var
    i: integer;
begin
    for i:= 1 to dias do begin
        f[i]:= nil;
    end;
end;

procedure cargarNodo(var nodo: lista; e: entradas);
begin
    new(nodo); nodo^.entradasVendidas:= e; nodo^.sig:= nil;
end;

procedure insertar(var l: lista; e: entradas);
var
    ant, act, nodo: lista;
begin
    cargarNodo(nodo, e);
    ant:= l; act:= l;
    while((act <> nil) and (act^.entradasVendidas.codObra < nodo^.entradasVendidas.codObra))do begin
        ant:= act; act:= act^.sig;
    end;
    if(ant = act)then begin
        l:= nodo;
    end
    else begin
        ant^.sig:= nodo;
    end;
    nodo^.sig:= act;
end;

procedure cargarLista(var l: lista);
var
    e: entradas;
begin
    cargarEntradas(e);
    while(e.codObra <> 0)do begin
        insertar(l, e);
        cargarEntradas(e);
    end;
end;

procedure cargarEstructura(var f: funciones);
var
    i: integer;
begin
    for i:= 1 to dias do begin
        cargarLista(f[i]);
    end;
end;

procedure agregarAtras(var l: nuevaLista; var ultL: nuevaLista; entradasTotal: nuevoEntradas);
var
    nodo: nuevaLista;
begin
    new(nodo); nodo^.total.codObra:= entradasTotal.codObra; nodo^.total.totalEntradas:= entradasTotal.totalEntradas; nodo^.sig:= nil;
    If(l = nil) then begin
        l:= nodo; ultL:= nodo;
    end
    else begin
        ultL^.sig:= nodo;
        ultL:= nodo;
    end;
end;

procedure minimo(var f: funciones; var entradasTotal: nuevoEntradas);
var
    indiceMin, i: integer;
begin
    entradasTotal.codObra:= 999; indiceMin:= -1;
    for i:= 1 to dias do begin
        if(f[i] <> nil)then begin
            if(f[i]^.entradasVendidas.codObra <= entradasTotal.codObra)then begin
                indiceMin:= i; entradasTotal.codObra:= f[i]^.entradasVendidas.codObra;
            end;
        end;
    end;
    
    if(indiceMin <> -1)then begin
        entradasTotal.codObra:=  f[indiceMin]^.entradasVendidas.codObra;
        f[indiceMin]:= f[indiceMin]^.sig; 
    end;
end;

procedure generarLista(f: funciones; var l: nuevaLista);
var
    actualCodigo: integer;
    entradasTotal: nuevoEntradas;
    ultL: nuevaLista;
begin
    l:= nil; entradasTotal.totalEntradas:= 0;
    minimo(f, entradasTotal);
    while(entradasTotal.codObra <> 999)do begin
        actualCodigo:= entradasTotal.codObra; entradasTotal.totalEntradas:= 0;
        while((entradasTotal.codObra <> 999) and (entradasTotal.codObra = actualCodigo))do begin
            entradasTotal.totalEntradas:= entradasTotal.totalEntradas + 1;
            minimo(f, entradasTotal);
        end;
        agregarAtras(l, ultL, entradasTotal);
    end;
end;

var
    f: funciones;
    l: nuevaLista;
begin
    inicializarEstructura(f);
    cargarEstructura(f);
    generarLista(f, l);
end.
