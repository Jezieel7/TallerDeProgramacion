program cine;
const
    cantG= 8;
type
    subrango= 1..cantG;
    	
    pelicula=record
        cod: integer;
        codGenero: subrango;
        puntaje: real;
    end;
    
    lista= ^nodo;
    
    nodo=record
        peliculas: pelicula;
        sig: lista;
    end;
    
    generos= array[subrango] of lista;
    
procedure cargarPelicula(var p: pelicula);
begin
    with p do begin
        readln(cod);
        if(cod <> -1)then begin
            readln(codGenero);
            readln(puntaje);
        end;
    end;
end;

procedure cargarNodo(var nodo: lista; p: pelicula);
begin
    new(nodo); nodo^.peliculas:= p; nodo^.sig:= nil;
end;

procedure insertar(var l: lista; p: pelicula);
var
    ant, act, nodo: lista;
begin
    cargarNodo(nodo, p);
    ant:= l; act:= l;
    while((act <> nil) and (act^.peliculas.cod < nodo^.peliculas.cod))do begin
        ant:= act; act:= act^.sig;
    end;
    if(ant = act)then begin
        l:= nodo;
    end
    else begin
        ant^.sig:= nodo;
    end;
    nodo^.sig:= act;
end;

procedure cargarLista(var l: lista);
var
    p: pelicula;
begin
    cargarPelicula(p);
    while(p.cod <> -1)do begin
        insertar(l, p);
        cargarPelicula(p);
    end;
end;

procedure cargarEstructura(var g: generos);
var
    i: integer;
begin
    for i:= 1 to cantG do begin
        cargarLista(g[i]);
    end;
end;

procedure agregarAtras(var l: lista; var ult: lista; p: pelicula);
var
    nodo: lista;
begin
    new(nodo); nodo^.peliculas:= p; nodo^.sig:= nil;
    if(l = nil)then begin
        l:= nodo; ult:= nodo;
    end
    else begin
        ult^.sig:= nodo;
        ult:= nodo;
    end;
end;

procedure minimo(var g: generos; var p: pelicula);
var
    i, pos: integer;
begin
    p.cod:= -1; pos:= -1;
    for i:= 1 to cantG do begin
        if(g[i]^.peliculas.cod <= p.cod)then begin
            pos:= i; p:= g[i]^.peliculas;
        end;
    end;
    p:= g[pos]^.peliculas;
    g[pos]:= g[pos]^.sig;
end;

procedure generarLista(g: generos; var l: lista);
var
    p: pelicula;
    ult: lista;
begin
    l:= nil;
    minimo(g, p);
    while(p.cod <> -1)do begin
        agregarAtras(l, ult, p);
        minimo(g, p);
    end;
end;

var
    g: generos;
    l: lista;
begin
    cargarEstructura(g);
    generarLista(g, l);
end.
