procedure minimoLista(l: lista; var min: integer);
begin
    if(l <> nil)then begin
        if(l^.numeros < min)then begin
            min:= l^.numeros;
        end;	
        l:= l^.sig;
        minimo(l, min);
    end;
end;

procedure maximoLista(l: lista; var max: integer);
begin
    if(l <> nil)then begin
        if(l^.numeros > max)then begin
            max:= l^.numeros;
        end;
        maximo(l^.sig, max);
    end;
end;

function encontrarLista(l: lista; v: integer): boolean;
begin
    if(l <> nil)then begin 
        if(l^.numeros <> v)then begin
            encontrar:= encontrar(l^.sig, v);
        end
        else begin
            encontrar:= true;
        end;
    end
    else begin
		encontrar:= false;
	end;
end;

procedure maximoVector(v: vectorInt; i: integer; var maximo: integer);
begin
    if(i <= dimF)then begin
        if(maximo < v[i])then begin
            maximo:= v[i];
        end;
        max(v, (i+1), maximo);
    end;
end;

procedure sumaVector(v: vectorInt; i: integer; var sumatoria: integer);
begin
    if(i <= dimF)then begin
        sumatoria:= sumatoria + v[i];
        suma(v, (i+1), sumatoria);
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

procedure decimalABinario(n: integer);
var
    binario: integer;
begin
    binario:= n mod 2;
    n:= n div 2;
    if n > 1 then begin
        aBinario(n);
    end
    else begin
        write(n);
    end;
    write(binario);
end;

