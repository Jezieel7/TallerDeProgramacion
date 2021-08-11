program agencia;
type
    subrango=2010..2018;
    
    auto=record
        patente: string;
        anoF: integer;
        marca: string;
        modelo: string;
    end;
    
    abb= ^nodo;
    
    nodo=record
        autos: auto;
        hi: abb;
        hd: abb;
    end;
    
    lista= ^nodoLista;
    
    nodoLista=record
        autos: auto;
        sig: lista;
    end;
    
    arrAnoF= array [subrango] of lista;
    
procedure cargarAuto(var a: auto);
begin
    with a do begin
        readln(patente);
        if(patente <> 'ZZZ')then begin
            readln(anoF);
            readln(marca);
            readln(modelo);
        end;
    end;
end;

procedure crearArbol(var a: abb; au: auto);
begin
    if(a=nil)then begin
        new(a); a^.autos:= au; a^.hi:= nil; a^.hd:= nil;
    end
    else begin
        if(au.patente < a^.autos.patente)then begin
            crearArbol(a^.hi, au);
        end
        else begin
            crearArbol(a^.hd, au);
        end;
    end;
end;

procedure cargarArbol(var a: abb);
var
    au: auto;
begin
    cargarAuto(au);
    while(au.patente <> 'ZZZ')do begin
        crearArbol(a, au);
        cargarAuto(au);
    end;
end;

procedure cantAutosMarca(a: abb; marca: string; var cant: integer);
begin
    if(a<>nil)then begin
        if(a^.autos.marca = marca)then begin
            cant:= cant + 1;
        end;
        cantAutosMarca(a^.hi, marca, cant);
        cantAutosMarca(a^.hd, marca, cant);
    end;
end;

procedure inicializarEstructura(var arr: arrAnoF);
var
    i: integer;
begin
    for i:= 2010 to 2018 do begin
        arr[i]:= nil;
    end;
end;

procedure cargarEstructura(a: abb; var arr: arrAnoF);
var
    aux: lista;
begin
    if(a<>nil)then begin
        new(aux); aux^.autos:= a^.autos; aux^.sig:= nil;
        if(arr[a^.autos.anoF] = nil)then begin
            arr[a^.autos.anoF]:= aux;
        end
        else begin
            aux^.sig:= arr[a^.autos.anoF];
            arr[a^.autos.anoF]:= aux;
        end;
        cargarEstructura(a^.hi, arr);
        cargarEstructura(a^.hd, arr);
    end;
end;

procedure patenteAnoF(a: abb; patente: string; var anoF: integer);
begin
    if((a<>nil) and (a^.autos.patente <> patente))then begin
        if(a^.autos.patente > patente)then begin
            patenteAnoF(a^.hi, patente, anoF);
        end
        else begin
            patenteAnoF(a^.hd, patente, anoF);
        end;
    end;
    if((a<>nil) and (a^.autos.patente = patente))then begin
        anoF:= a^.autos.anoF;
    end;
end;

var
    a: abb; cant, anoF: integer; marca, patente: string; arr: arrAnoF;
begin
    inicializarEstructura(arr);
    cargarArbol(a);
    readln(marca);
    cantAutosMarca(a, marca, cant);
    cargarEstructura(a, arr);
    readln(patente);
    patenteAnoF(a, patente, anoF);
    writeln(cant);
    writeln(anoF);
end.
