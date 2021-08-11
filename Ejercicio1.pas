program Edificio;
const
    oficinas= 300; //cantidad de oficinas
type

//registro de oficina
    oficina=record
        cod: integer;
        dniProp: integer;
        valorExpensa: real;
    end;
    
//vector de oficinas   
    vectorOficinas= array[1..oficinas] of oficina;
    
//carga el registro de oficina con los datos 
procedure cargarOficina(var o: oficina);
begin
    with o do begin
        writeln('Introduzca el código de identificación');
        readln(cod);
        if(cod <> -1)then begin
            writeln('Introduzca el DNI del propietario');
            readln(dniProp);
            writeln('Introduzca el valor de la expensa');
            readln(valorExpensa);
        end;
    end;
end; 

//carga el vector vec con los datos de las oficinas o, mientras el vector no este completo y el codigo sea distinto de -1
procedure cargarVector(var vec: vectorOficinas; var dimL: integer);
var
    o: oficina;
begin
    dimL:= 0;
    cargarOficina(o);
    while((dimL < oficinas) and (o.cod <> -1))do begin
        dimL:= dimL + 1;
        vec[dimL]:= o;
        cargarOficina(o);
    end;
end;

//ordena el vector vec de menor a mayor según el código de la oficina
procedure ordenarVector(var vec: vectorOficinas; dimL: integer);
var
    i, j: integer;
    actual: oficina;
begin
    for i:= 2 to dimL do begin
        actual:= vec[i];
        j:= i - 1;
        while((j > 0) and (vec[j].cod > actual.cod))do begin
            vec[j+1]:= vec[j];
            j:= j - 1;
        end;
        vec[j+1]:= actual;
    end;
end;

var
    vec: vectorOficinas;
    dimL: integer;
begin
    cargarVector(vec, dimL);
    ordenarVector(vec, dimL);
end.

var
    vec: vectorOficinas;
    dimL: integer;
begin
    cargarVector(vec, dimL);
    ordenarVector(vec, dimL);
end.
