program libreria;
const
    cantSucursales= 4;
type
    fecha=record
        dia: integer;
        mes: integer;
        ano: integer;
    end;

    venta=record
        fechaVenta: fecha;
        codigoProducto: integer;
        codigoSucursal: integer;
        cantidadVendida: integer;
    end;
    
    lista= ^nodo;
    
    nodo=record
        v: venta;
        sig: lista;
    end;
    
    vectorSucursales= array[1..cantSucursales] of lista;

procedure cargarFecha(var f: fecha);
begin
    with f do begin
        writeln('Introduzca día');
        readln(dia);
        writeln('Introduzca mes');
        readln(mes);
        writeln('Introduzca año');
        readln(ano);
    end;
end;

procedure cargarVenta(var v: venta);
begin
    with v do begin
        writeln('Introduzca fecha de la venta');
        cargarFecha(fechaVenta);
        writeln('Introduzca el código del producto');
        readln(codigoProducto);
        writeln('Introduzca el código de la sucursal');
        readln(codigoSucursal);
        writeln('Introduzca la cantidad vendida');
        readln(cantidadVendida);
    end;
end;

procedure armarNodo(var nodo: lista; v: venta);
begin
    new(nodo); nodo^.v:= v; nodo^.sig:= nil;
end;

procedure recorrerSucursal(var act: lista; var ant: lista; nodo: lista);
begin
    while((act <> nil) and (act^.v.codigoProducto < nodo^.v.codigoProducto)) do begin
        ant:= act; act:= act^.sig;
    end;
end;

procedure insertar(var sucursal: lista; v: venta);
var
    ant, act, nodo: lista;
begin
    armarNodo(nodo, v);
    ant:= sucursal; act:= sucursal;
    recorrerSucursal(act, ant, nodo);
    if(act = ant)then begin
        sucursal:= act;
    end
    else begin
        ant^.sig:= nodo;
    end;
    nodo^.sig:= act;
end;

procedure cargarSucursal(var sucursal: lista);
var
    v: venta;
begin
    cargarVenta(v);
    while(v.codigoSucursal <> 0) do begin
        insertar(sucursal, v);
        cargarVenta(v);
    end;
end;

procedure cargarVentas(var vectorS: vectorSucursales);
var
    i: integer;
begin
    for i:= 1 to cantSucursales do begin
        vectorS[i]:= nil;
        cargarSucursal(vectorS[i]);
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

procedure agregarAtras(var totalesPorCodigo: lista; var ultTotal: lista; ventaTotal: venta);
var
    nodo: lista;
begin
    armarNodo(nodo, ventaTotal);
    If(totalesPorCodigo = nil) then begin
        totalesPorCodigo:= nodo; ultTotal:= nodo;
    end
    else begin
        ultTotal^.sig:= nodo;
        ultTotal:= nodo;
  end;
end;

procedure cargarTotal(vectorS: vectorSucursales; var totalesPorCodigo: lista);
var
    actualCodigo, cantVendidaTotal: integer;
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

procedure imprimirLista(l: lista);
begin
    while(l <> nil)do begin
        writeln(l^.v.codigoProducto);
        writeln(l^.v.cantidadVendida);
        l:= l^.sig;
    end;
end;

var
    vectorS: vectorSucursales;
    totalesPorCodigo: lista;
begin
    cargarVentas(vectorS);
    cargarTotal(vectorS, totalesPorCodigo);
    imprimirLista(totalesPorCodigo);
end.
