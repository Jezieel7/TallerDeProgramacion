program seis;
const
    dimF= 8;
type
    indice= 1..dimF;
    vector= array[indice] of integer;

procedure inicializarVector(var v: vector);
var
	i: integer;
begin
	for i:= 1 to dimF do begin
		v[i]:= 0;
	end;
end;

procedure cargarVector(v: vector);
var
    i, num: integer;
begin
    for i:= 1 to dimF do begin
        readln(num);
        v[i]:= num;
    end;
end;
    
Procedure busquedaDicotomica (v: vector; ini,fin: indice; dato:integer; var pos: integer);
var
    medio: indice;
begin
    medio:= (ini + fin) div 2;
    if((ini <= fin) and (dato <> v[medio]))then begin
        if(dato < v[medio]) then begin
            busquedaDicotomica(v, ini, (medio - 1), dato, pos);
        end
        else begin
            busquedaDicotomica(v, (medio + 1), fin, dato, pos);
        end;
    end
    else if((ini <= fin) and (dato = v[medio]))then begin
        pos:= medio;
    end
    else if ((ini > fin) and (dato = v[medio]))then begin
        pos:= -1;
    end;
end;

var
    v: vector;
    ini, fin: indice;
    dato, pos: integer;
begin
    ini:= 1; fin:= dimF;
    inicializarVector(v);
    cargarVector(v);
    readln(dato);
    busquedaDicotomica(v, ini, fin, dato, pos);
    writeln(pos);
end.
