program Cine;
const
    cantGeneros= 8;
type
    pelicula=record
        cod: integer;
        codGenero: integer;
        puntaje: real;
    end;

    lista= ^nodo;
    
    nodo=record
        peliculas: pelicula;
        sig: lista;
    end;

    arrayGeneros= array[1..cantGeneros] of integer;
    arrayPuntajes= array[1..cantGeneros] of real;
    
procedure cargarPelicula(var p: pelicula);
begin
    with p do begin
        writeln('Introduzca el código de la película');
        readln(cod);
        if(cod <> -1)then begin
            writeln('Introduzca el código de género de la película');
            readln(codGenero);
            writeln('Introduzca el puntaje promedio de las críticas');
            readln(puntaje);
        end;
    end;
end;

procedure armarNodo(var n: lista; p: pelicula);
begin
    new(n); n^.peliculas:= p; n^.sig:= nil;
end;

procedure agregarPelicula(var l: lista; p: pelicula);
var
    nodo, ant, act: lista;
begin
    armarNodo(nodo, p);
    act:= l; ant:= l;
    while((act<>nil)and(act^.peliculas.codGenero<>nodo^.peliculas.codGenero))do begin
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

procedure imprimirLista(l: lista);
begin
    while(l<>nil)do begin
        writeln(l^.peliculas.codGenero);
        l:= l^.sig;
    end;
end;

procedure cargarLista(var l: lista);
var
    p: pelicula;
begin
    cargarPelicula(p);
    while(p.cod <> -1)do begin
        agregarPelicula(l, p);
        cargarPelicula(p);
    end;
end;

procedure inicializarArrayGeneros(var a: arrayGeneros);
var
    i: integer;
begin
    for i:= 1 to cantGeneros do
        a[i]:= 0;
end;

procedure inicializarArrayPuntajes(var a: arrayPuntajes);
var
    i: integer;
begin
    for i:= 1 to cantGeneros do
        a[i]:= 0;
end;

function esMayor(puntaje: real; puntajeActual: real): boolean;
begin
    esMayor:= puntaje > puntajeActual;
end;

procedure actualizarPuntajes(var a: arrayGeneros; codigoGenero: integer; nuevoCodigo: integer; var puntajes: arrayPuntajes; nuevoPuntaje: real);
begin
    a[codigoGenero]:= nuevoCodigo;
    puntajes[codigoGenero]:= nuevoPuntaje;
end;

procedure mayoresPuntajes(l: lista; var a: arrayGeneros);
var
    puntajes: arrayPuntajes;
begin
	inicializarArrayPuntajes(puntajes);
    while(l<>nil)do begin
        if(esMayor(l^.peliculas.puntaje, puntajes[l^.peliculas.codGenero]))then begin
            actualizarPuntajes(a, l^.peliculas.codGenero, l^.peliculas.cod, puntajes, l^.peliculas.puntaje);
        end;
        l:= l^.sig;
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

procedure mayorMenorPuntaje(a : arrayGeneros);
begin
    writeln('El código de la película con el menor puntaje es ' , a[1]);
    writeln('El código de la película con el mayor puntaje es ' , a[8]);
end;

var
    l: lista;
    a: arrayGeneros;
    puntajes: arrayPuntajes;
begin
    l:= nil;
    inicializarArrayPuntajes(puntajes);
    inicializarArrayGeneros(a);
    cargarLista(l);
    mayoresPuntajes(l, a);
    ordenarArray(a, puntajes);
    mayorMenorPuntaje(a);
end.
