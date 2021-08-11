program Libreria;
const
    rubros= 6;
    elementos= 30;
type
    cantRubros= 1..rubros;
    cantElementos= 1..elementos;
    
    producto=record
        cod: integer;
        codRubro: cantRubros;
        precio: real;
    end;
    
    lista= ^nodo;
    
    nodo=record
        productos: producto;
        sig: lista;
    end;
    
    arrayRubros= array[cantRubros] of lista;
    
    arrayRubroTres= array[1..elementos] of producto;
    
procedure cargarProducto(var p: producto);
begin
    with p do begin
        writeln('Introduzca el precio del producto');
        readln(precio);
        if(precio <> -1)then begin
            writeln('Introduzca el código del producto');
            readln(cod);
            writeln('Introduzca el código del rubro del producto');
            readln(codRubro);
        end;
    end;
end;

procedure cargarNodo(var n: lista; p: producto);
begin
    new(n); n^.productos:= p; n^.sig:= nil;
end;

procedure insertarPorCodigo(var l: lista; p: producto);
var
    nodo, act, ant: lista;
begin
    cargarNodo(nodo, p);
    act:= l; ant:= l;
    while(act<>nil) and (act^.productos.cod < nodo^.productos.cod)do begin
        ant:= act; act:= act^.sig;
    end;
    if(act = ant)then begin
      l:= nodo;
    end
    else begin
      ant^.sig:= nodo;
    end;
    nodo^.sig:= act;
end;

procedure cargarRubros(var r: arrayRubros);
var
    p: producto;
begin
    cargarProducto(p);
    while(p.precio <> -1)do begin
        insertarPorCodigo(r[p.codRubro], p);
        cargarProducto(p);
    end;
end;

procedure imprimirLista(l: lista);
begin
    while(l <> nil)do begin
        writeln(l^.productos.cod);
        l:= l^.sig;
    end;
end;

procedure imprimirCodigos(r: arrayRubros);
var
    i: integer;
begin
    for i:= 1 to rubros do begin
        writeln('Códigos de los productos pertenecientes al rubro ' , i);
        imprimirLista(r[i]);
    end;
end;

procedure cargarRubro(var t: arrayRubroTres; var dimL: integer; l: lista);
begin
    dimL:= 0;
    while(dimL < elementos) do begin
        dimL:= dimL + 1;
        t[dimL]:= l^.productos;
        l:= l^.sig;
    end;
end;

procedure ordenarPrecioRubro(r: arrayRubros; var t: arrayRubroTres; var dimL: integer);
var
    i, j: integer;
    actual: producto;
begin
    cargarRubro(t, dimL, r[3]);
    for i:= 2 to dimL do begin
        actual:= t[i];
        j:= i - 1;
        while((j > 0) and (t[i].precio > actual.precio))do begin
            t[j+1]:= t[j];
            j:= j - 1;
        end;
        t[j+1]:= actual;
    end;
end;

procedure imprimirPrecios(t: arrayRubroTres; dimL: integer);
var
    i: integer;
begin
    for i:= 1 to dimL do begin
        writeln(t[i].precio);
    end;
end;

var
    r: arrayRubros;
    t: arrayRubroTres;
    dimL: integer;
begin
    cargarRubros(r);
    imprimirCodigos(r);
    ordenarPrecioRubro(r, t, dimL);
    imprimirPrecios(t, dimL);
end.
