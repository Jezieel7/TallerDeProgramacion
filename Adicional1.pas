program funciones;
const
    dias= 7;
type
    semana= 1..7;
    
    entrada=record
        codObra: integer;
        asiento: integer;
        monto: real;
    end;
    
    lista= ^nodo;
    
    nodo=record
        entradas: entrada;
        sig: lista;
    end;
    
    arrSem= array[semana] of lista;
    
    totales=record
        cant: integer;
        codObra: integer;
    end;
    
    listaTotal= ^total;
    
    total=record
        t: totales;
        sig: listaTotal;
    end;
    
procedure cargarEntrada(var e: entrada);
begin
    with e do begin
        readln(codObra);
        if(codObra<>0)then begin
            readln(asiento);
            readln(monto);
        end;
    end;
end;

procedure insertarCodObra(var l: lista; e: entrada);
var
    aux, ant, act: lista;
begin
    new(aux); aux^.entradas:= e; aux^.sig:= nil;
    act:= l; ant:= l;
    while((act <> nil)and(act^.entradas.codObra < aux^.entradas.codObra))do begin
        ant:= act; act:= act^.sig;
    end;
    if(act = ant)then begin
        l:= aux;
    end
    else begin
        ant^.sig:= aux;
    end;
    aux^.sig:= act;
end;

procedure cargarLista(var l: lista);
var
    e: entrada;
begin
    cargarEntrada(e);
    while(e.codObra <> 0)do begin
        insertarCodObra(l, e);
        cargarEntrada(e);
    end;
end;

procedure inicializarEstructura(var ventas: arrSem);
var
    i: integer;
begin
    for i:= 1 to dias do begin
        ventas[i]:= nil;
    end;
end;

procedure cargarEstructura(var ventas: arrSem);
var
    i: integer;
begin
    for i:= 1 to dias do begin
        cargarLista(ventas[i]);
    end;
end;

procedure agregarAtras(var l: listaTotal; var ult: listaTotal; tot: totales);
var
    aux: listaTotal;
begin
    new(aux); aux^.t:= tot; aux^.sig:= nil;
    If(l = nil) then begin
        l:= aux; ult:= aux;
    end
    else begin
        ult^.sig:= aux;
        ult:= aux;
    end;
end;

procedure minimo(var ventas: arrSem; var minCod: integer);
var
    indiceMin, i: integer;
begin
    minCod:= 999; indiceMin:= -1;
    for i:= 1 to dias do begin
        if(ventas[i] <> nil)then begin
            if(ventas[i]^.entradas.codObra <= minCod)then begin
                indiceMin:= i; minCod:= ventas[i]^.entradas.codObra;
            end;
        end;
    end;
    if(indiceMin <> -1)then begin
        minCod:= ventas[indiceMin]^.entradas.codObra;
        ventas[indiceMin]:= ventas[indiceMin]^.sig;
    end;
end;

procedure merge(ventas: arrSem; var list: listaTotal; var pUltimo: listaTotal);
var
    actual: integer; tot: totales;
begin
    list:= nil; pUltimo:= nil;
    tot.codObra:= 999;
    minimo(ventas, tot.codObra);
    while(tot.codObra <> 999)do begin
        actual:= tot.codObra; tot.cant:= 0;
        while(tot.codObra <> 999) and (tot.codObra = actual)do begin
            tot.cant:= tot.cant + 1;
            minimo(ventas, tot.codObra);
        end;
        agregarAtras(list, pUltimo, tot);
    end;
end;

procedure informar(l: listaTotal);
begin
    if(l<>nil)then begin
        writeln(l^.t.codObra);
        writeln(l^.t.cant);
        informar(l^.sig);
    end;
end;

var
    estructura: arrSem;
    nLista, ult: listaTotal;
begin
    inicializarEstructura(estructura);
    cargarEstructura(estructura);
    merge(estructura, nLista, ult);
    informar(nLista);
end.
