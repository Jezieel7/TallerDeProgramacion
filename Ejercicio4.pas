program cuatro;
type	
    lista= ^nodo;
    
    nodo=record
        numeros: integer;
        sig: lista;
    end;
  
procedure armarNodo(var n: lista; num: integer);
begin
    new(n); n^.numeros:= num; n^.sig:= nil;
end;

procedure agregar(var l: lista; num: integer);
var
    nodo: lista;
begin
    armarNodo(nodo, num);
    if(l <> nil)then
        nodo^.sig:= l;
    l:= nodo;
end;

procedure cargarLista(var l: lista);
var
	num: integer;
begin
	readln(num);
	while(num <> 0)do begin
	    agregar(l, num);
	    readln(num);
	end;
end;

procedure minimo(l: lista; var min: integer);
begin
    if(l <> nil)then begin
        if(l^.numeros < min)then begin
            min:= l^.numeros;
        end;
        l:= l^.sig;
        minimo(l, min);
    end;
end;

procedure maximo(l: lista; var max: integer);
begin
    if(l <> nil)then begin
        if(l^.numeros > max)then begin
            max:= l^.numeros;
        end;
        maximo(l^.sig, max);
    end;
end;

function encontrar(l: lista; v: integer): boolean;
begin
    if(l <> nil)then begin 
        if(l^.numeros <> v)then begin
            l:= l^.sig;
            encontrar:= encontrar(l, v);
        end
        else begin
            encontrar:= true;
        end;
    end
    else begin
		encontrar:= false;
	end;
end;

var
    l: lista;
    min, max, valor: integer;
begin
    min:= 9999; max:= -9999;
    cargarLista(l);
    minimo(l, min);
    maximo(l, max);
    writeln(min);
    writeln(max);
    readln(valor);
    writeln(encontrar(l, valor));
end.
