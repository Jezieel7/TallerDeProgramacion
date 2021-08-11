program administradorEdificios;
const
    cantOficinas= 300;
type
    oficina=record
        cod: integer;
        dni: integer;
        valorExpensa: real;
    end;
    
    vectorOficinas= array[1..cantOficinas] of oficina;
    
procedure cargarOficina(var o: oficina);
begin
    with o do begin
        readln(cod);
        if(cod <> -1)then begin
            readln(dni);
            readln(valorExpensa);
        end;
    end;
end;

procedure cargarVector(var oficinas: vectorOficinas; var dimL: integer);
var
    o: oficina;
begin
    dimL:= 0;
    cargarOficina(o);
    while(o.cod <> -1)do begin
        dimL:= dimL + 1;
        oficinas[dimL]:= o;
    end;
end;

procedure ordenar(var oficinas: vectorOficinas; var dimL: integer);
var
    i, j: integer;
    actual: oficina;
begin
    for i:= 2 to dimL do begin
        actual:= oficinas[i];
        j:= i - 1;
        while((j>0) and (oficinas[j].cod > actual.cod))do begin
            oficinas[j+1]:= oficinas[j];
            j:= j - 1; 
        end;
        oficinas[j+1]:= actual;
    end;
end;

procedure busquedaDicotomica(oficinas: vectorOficinas; dimL: integer; valorABuscar: integer);
var
    pri, ult, medio: integer;
begin
    pri:= 1; ult:= dimL; medio:= (pri+ult) div 2;
    while((pri <= ult) and (valorABuscar <> oficinas[medio].cod))do begin
        if(valorABuscar < oficinas[medio].cod)then begin
            ult:= medio -1;
        end
        else begin
            pri:= medio + 1;
            medio:= (pri + ult) div 2;
        end;
    end;
    if((pri <= ult) and (valorABuscar = oficinas[medio].cod))then begin
        writeln(oficinas[medio].dni);
    end
    else begin
        writeln('El código buscado no existe');
    end;
end;

var
    oficinas: vectorOficinas;
    dimL: integer;
    valorABuscar: integer;
begin
    cargarVector(oficinas, dimL);
    writeln('Introduzca el valor a buscar');
    readln(valorABuscar);
    busquedaDicotomica(oficinas, dimL, valorABuscar);
end.
