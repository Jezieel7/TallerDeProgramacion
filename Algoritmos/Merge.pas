const
    cantG= 8;
type
    subrango= 1..cantG;
    	
    pelicula=record
        cod: integer;
        codGenero: subrango;
        puntaje: real;
    end;
    
    lista= ^nodo;
    
    nodo=record
        peliculas: pelicula;
        sig: lista;
    end;
    
    generos= array[subrango] of lista;

procedure inicializarEstructura(var f: funciones);
var
    i: integer;
begin
    for i:= 1 to dias do begin
        f[i]:= nil;
    end;
end;

procedure cargarEstructura(var g: generos);
var
    i: integer;
begin
    for i:= 1 to cantG do begin
        cargarLista(g[i]);
    end;
end;

procedure minimoChafa(var g: generos; var p: pelicula);
var
    i, pos: integer;
begin
    p.cod:= -1; pos:= -1;
    for i:= 1 to cantG do begin
        if(g[i]^.peliculas.cod <= p.cod)then begin
            pos:= i; p:= g[i]^.peliculas;
        end;
    end;
    p:= g[pos]^.peliculas;
    g[pos]:= g[pos]^.sig;
end;

procedure mergeChafa(g: generos; var l: lista);
var
    codigoActual: integer;
    p: pelicula;
    ult: lista;
begin
    l:= nil;
    minimo(g, p);
    while(p.cod <> -1)do begin
        agregarAtras(l, ult, p);
        minimo(g, p);
    end;
end;

procedure minimo(var vectorS: vectorSucursales; var ventaTotal: venta);
var
    indiceMin, i: integer;
begin
    ventaTotal.codigoProducto:= -1; indiceMin:= -1;
    for i:= 1 to cantSucursales do begin
        if(vectorS[i] <> nil)then begin
            if(vectorS[i]^.v.codigoProducto <= ventaTotal.codigoProducto)then begin
                indiceMin:= i; ventaTotal.codigoProducto:= vectorS[i]^.v.codigoProducto;
            end;
        end;
    end;
    if(indiceMin <> -1)then begin
        ventaTotal:= vectorS[indiceMin]^.v;
        vectorS[indiceMin]:= vectorS[indiceMin]^.sig; 
    end;
end;

procedure merge(vectorS: vectorSucursales; var totalesPorCodigo: lista);
var
    i, actualCodigo, cantVendidaTotal: integer;
    ventaTotal: venta;
    ultTotal: lista;
begin
    totalesPorCodigo:= nil;
    minimo(vectorS, ventaTotal);
    while(ventaTotal.codigoProducto <> -1)do begin
        actualCodigo:= ventaTotal.codigoProducto; cantVendidaTotal:= 0;
        while((ventaTotal.codigoProducto <> -1) and (ventaTotal.codigoProducto = actualCodigo))do begin
            cantVendidaTotal:= cantVendidaTotal + ventaTotal.cantidadVendida;
            minimo(vectorS, ventaTotal);
        end;
        agregarAtras(totalesPorCodigo, ultTotal, ventaTotal);
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

procedure merge(f: funciones; var l: nuevaLista);
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

