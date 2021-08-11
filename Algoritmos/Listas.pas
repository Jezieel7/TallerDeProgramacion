lista= ^nodoLista;
    	
    nodoLista=record
        numeros: integer;
        sig: lista;
    end;

procedure cargarLista(var l: lista);
var
    aux: lista;
    v: integer;
begin
    readln(v);
    while(v <> 0) do begin
        agregarAdelante(l, v);
        readln(v);
  end;
end;

procedure agregarAdelante(var l: lista; v: integer);
var
    aux: lista;
begin
    new(aux); aux^.elem:= v; aux^.sig:= nil;
    if(l = nil) then begin
        l:= aux;
    end
    else begin
        aux^.sig:= l;
        l:= aux;
    end;
end;

procedure agregarAdelante(var l: lista; num: integer);
var
    nodo: lista;
begin
    new(aux); aux^.elem:= v; aux^.sig:= nil;
    if(l <> nil)then
        nodo^.sig:= l;
    l:= nodo;
end;

procedure agregarAtras(var l: lista; v: integer);
var
    aux, act: lista;
begin
    new(aux); aux^.elem:= v; aux^.sig:= nil;
    If(l = nil) then begin
        l:= aux;
    end
    else begin
        act:= l;
        while(act <> nil)do begin
            act:= act^.sig;
        end;
        act:= aux;
    end;
end;

procedure agregarAtrasUlt(var l: lista; var ult: lista; v: integer);
var
    aux: lista;
begin
    new(aux); aux^.elem:= v; aux^.sig:= nil;
    If(l = nil) then begin
        l:= aux; ult:= aux;
    end
    else begin
        ult^.sig:= aux;
        ult:= aux;
    end;
end;

procedure insertarMenorMayor(var l: lista; v: integer);
var
    aux, ant, act: lista;
begin
    new(aux); aux^.elem:= v; aux^.sig:= nil;
    act:= l; ant:= l;
    while((act <> nil)and(act^.elem < aux^.elem))then begin
        ant:= act; act:= act^.sig;
    end;
    if(act = ant)then begin
        l:= aux;
    end
    else begin
        ant^.sig:= aux;
    end;
    aux^.sig:= act;
end;

procedure imprimirLista(l: lista);
begin
    while(l <> nil) do begin
        writeln(l^.elem);
        l:= l^.sig;
    end;
end;

procedure buscarDesordenado(l: lista; v: integer): boolean;
var
    act: lista;
    encontre: boolean;
begin
    act:= l;
    encontre:= false;
    while((act<>nil) and (encontre=false))do begin
        if(act^.elem = v)then begin
            encontre:= true;
        end
        else begin
            act:= act^.sig;
        end;
    end;
    buscarDesordenado:= encontre;
end;

procedure buscarOrdenado(l: lista; v: integer): boolean;
var
    act: lista;
    encontre: boolean;
begin
    act:= l; 
    encontre:= false;
    while((act<>nil)and(act^.elem<v))do begin
        act:= act^.sig;
    end; 
    if(act<>nil)and (act^.elem = v) then begin
        encontre:= true;
    end;
    buscar:= encontre;
end;

procedure eliminar(var l: lista; v: integer);
var
    ant, act: lista;
begin
    act:= l;
    while((act<>nil) and (act^.elem <> v))do begin
        ant:= act; act:= act^.sig;
    end;
    if(act <> nil)then begin
        if(act = l) then
            l:= l^.sig;
        end
        else begin
            ant^.sig:= act^.sig;
        end;
        dispose(act);
    end;
end;

