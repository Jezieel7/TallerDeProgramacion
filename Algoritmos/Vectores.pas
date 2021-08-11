procedure inicializarArray(var a: arrayPuntajes);
var	
    i: integer;
begin
    for i:= 1 to constante do
        a[i]:= 0;
end;

procedure cargarVector(var v:vector; var dimL: integer);
var
    num: integer;
begin
    dimL:= 0;
    readln(num);
    while((dimL<dimF) and (num<>0))do begin
        dimL:= dimL + 1;
        v[dimL]:= num;
        readln(num);
    end;
end;

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

procedure imprimir(v: vector; dimL: integer);
var
    i, x:= integer;
begin
    for i:= 1 to dimL do begin
        x:= v[i];
        writeln(x);
    end;
end;

procedure maximo(v: vector; dimL: integer): integer;
var
    i, max: integer;
begin
    max:= -1;
    for i:= 1 to dimL do begin
        if(v[i] > max) then begin
            max:= v[i];
        end;
    end;
    Maximo:= max;
end;

procedure minimo(v: vector; dimL: integer): integer;
var
    i, min: integer;
begin
    Min:= 999;
    for i:= 1 to dimL do begin
        if(v[i] < min) then begin
            min:= v[i];
        end;
    end;
    Minimo:= min;
end;

procedure cantidad(v:vector; dimL: integer; num: integer): integer;
var
    i, cant: integer;
begin
    cant:= 0;
    for i:= 1 to dimL do begin
        if(v[i] = num) then begin
            cant:= cant + 1;
        end;
    end;
    cantidad:= cant;
end;

procedure recorrerCompleto(v:vector; dimL:integer; m:integer):integer;
var
    i, cant: integer;
begin
    cant:= 0;
    for i:= 1 to dimL do begin
        If((v[i] mod m) = 0)then begin
            cant:= cant + 1;
        end;
    end;
    multiplos:= cant;
end;

procedure recorrerParcial(v:vector; dimL: integer; m:integer): integer;
var
    i: integer;
    bool: boolean;
begin
    bool:= false; i:= 1;
    while((i<dimL) and (not bool) do begin
        If((v[dimL] mod m) = 0) then begin
            bool:= true;
        end
        else begin
            i:= i + 1;
        end;
    end;
    recorrerParcial:= i;
end;

procedure agregarFinal(var v:vector; var dimL: integer; var pude: boolean; va: integer);
begin
    pude:= false;
    if((dimL + 1) <= dimF)then begin
        pude:= true;
        dimL:= dimL + 1;
        v[dimL]:= va;
    end;
end;

Realice un programa que genere otro arreglo solo con numeros pares.
procedure  procesar(v: vector; dimL: integer; var v2: vector; var dimL2: integer);
var
    i: integer;
    pude: boolean;
begin
    dimL2:= 0;
    for i:= 1 to dimL do begin
        If(esPar(v[i])then begin
            agregar(v2, dimL2, v[i], pude);
        end;
    end;
end;

procedure insertar(var v: vector; var dimL: integer; va: integer; pos: integer; var pude: boolean);
var
    i: integer;
begin
    pude:= false;
    if(((dimL+1)<=dimF)and(pos<=dimL)and(pos >= 1))then begin
        for i:= dimL downto pos do begin
            a[i+1]:= a[i];
        end;
        pude:= true;
        a[pos]:= va;
        dimL:= dimL + 1;
    end;
end;

procedure eliminar(var v: vector; var dimL: integer; pos: integer, pude: boolean);
var
    i: integer;
begin
    pude:= false;
    if((pos<= dimL) and (pos>= 1))then begin
        for i:= pos downto (dim-1) do begin
            v[i]:= v[i+1];
        end;
        pude:= true;
        dimL:= dimL - 1;
    end;
end;

procedure buscarDesordenado(v: vector; var dimL:integer; n: integer): boolean;
var
    i: integer;
    esta: boolean;
begin
    i:= 1;
    esta:= false;
    while((i<=dimL) and (not esta))do begin
        if(v[i]=num)then begin
            esta:= true;
        end
        else begin
            pos:= pos + 1;
        end;
    end;
end;

procedure busquedaDicotomica(v: vector; dimL: integer; n: integer; var pude: boolean);
var
    pri, ult, medio: integer;
begin
    ok:= false;
    pri:= 1; ult:= dimL; medio:= (pri + ult) div 2;
    while((pri<= ult) and (n <> v[medio]) do begin
        if(n < vec[medio]) then begin
            ult:= medio - 1;
        end
        else begin
            pri:= medio + 1;
            medio:= (pri + ult) div 2;
        end;
    end;
    if((pri<= ult) and (n=v[medio]))then begin
        pude:= true;
    end;
end;

Procedure BusquedaDicotomica(v: vector; diml: integer; valor: integer) : boolean;
Var
 Pri, ult, medio: integer;
Begin
 Pri:= 1; ult:= diml; medio:= (pri + ult) div 2;
 While(pri<=ult) and (valor <> v[medio]) do begin
   If(valor < v[medio]) then begin
            Ult := medio - 1;
   End
   Else begin
             Pri:= medio + 1;
             Medio:= (pri + ult) div 2;
    End;
  End;
    If(pri <= ult) and (valor = v[medio]) then begin
            BusquedaDicotomica := true;
     End
     Else begin
             BusquedaDicotomica := false;
      End;
   End;

procedure ordenarIneficiente(var v: vector; dimL: integer);
var
    i, j, p, item: integer;
begin
    for i:= 1 to (dimL -1) do begin
        p:= i;
        for j:= i+1 to dimL do begin
            if(v[j] < v[p]) then begin
                p:= j;
            end;
        end;
        item:= v[p];
        v[p]:= v[i];
        v[i]:= item;
    end;
end;

procedure ordenarArray(var a: arrayGeneros; puntajes: arrayPuntajes);
var
    i, j: integer;
    actual: integer;
begin
    for i:= 2 to cantGeneros do begin
        actual:= a[i];
        j:= i - 1;
        while((j > 0) and (puntajes[a[j]] > puntajes[actual])) do begin
            a[j+1]:= a[j];
            j:= j - 1;
        end;
        a[j+1]:= actual;
    end;
end;

