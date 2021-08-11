program cinco;
const
    dimF= 20;
type
    subrango= 1..20;
    
    vectorInt= array[subrango] of integer;
    
procedure cargarVector(var v: vectorInt; i: integer);
var
    num: integer;
begin
    for i:= 1 to dimF do begin
        readln(num);
        v[i]:= num;
    end;
end;

procedure max(v: vectorInt; i: integer; var maximo: integer);
begin
    if(i <= dimF)then begin
        if(maximo < v[i])then begin
            maximo:= v[i];
        end;
        max(v, (i+1), maximo);
    end;
end;

procedure suma(v: vectorInt; i: integer; var sumatoria: integer);
begin
    if(i <= dimF)then begin
        sumatoria:= sumatoria + v[i];
        i:= i + 1;
        suma(v, i, sumatoria);
    end;
end;

var
    v: vectorInt;
    i, maximo, sumatoria: integer;
begin
    i:= 1; sumatoria:= 0;
    cargarVector(v, i);
    max(v, i, maximo);
    writeln(maximo);
    suma(v, i, sumatoria);
    writeln(sumatoria);
end.
