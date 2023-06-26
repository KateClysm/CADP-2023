{Una empresa de venta de tickets de tren esta analizando la información de los viajes realizados por sus trenes durante el año 2022. 
Para ello, se dispone de una estructura de datos con la información de todos los viajes.
De cada viaje se conoce el código de tren, el mes en que se realizó el viaje (entre 1 y 12), la cantidad de pasajeros que viajaron, y el código de la ciudad
de destino (entre 1 y 20). 
La información se encuentra ordenada por código de tren.
Además, la empresa dispone de una estructura de datos con información del costo del ticket por ciudad destino.

Realizar un programa que procese la información de los viajes y:
1) genere una lista que tenga por cada código del tren, la cantidad de viajes realizados.
2)Informe el mes con mayor monto recaudado.
3)COMPLETO: informe el promedio de pasajeros por cada tren entre todos sus viajes.}

Program p3;

Type
	rMeses = [1..12];
	rCiudades = [1..20];
	viaje = record
		tren:integer;
		mes:meses;
		pasajeros:integer;
		ciudad:rCiudades;
	end;
	listaViajes = ^nodoViajes;	//se dispone de una estructura de datos con la información de todos los viajes.
	nodoViajes = record
		dato:viaje;
		sig:lista;
	end;
	
	vectorCostos = array [rCiudades] of real;  //dispone de una estructura de datos con información del costo del ticket por ciudad destino.
	
	VPT = record
		tren:integer;
		viajes:integer;
	end;
	listaVPT = ^nodoVPT;
	nodoVPT = record
		dato:VPT;
		sig:listaVPT;
	end;
	
	vectorRecaudaciones = array [rMeses] of real;
	
//MÓDULOS
procedure cargarLista(var LV:listaViajes);//SE DISPONE
procedure cargarVector(var VT:vectorCostos);//SE DISPONE

procedure inicializarVector(Var v:vectorRecaudaciones);
var
	i:rMeses;
begin
	for i:=1 to 12 do v[i] := 0;
end;

function maximo( v:vectorRecaudaciones):real;
var
	max:real;
	mesMax, i: rMeses;
begin
	max:=-1;
	for i:=1 to 12 do
		if (v[i]>max) then begin
			max:=v[i];
			mesMax:?i;
		end;
	maximo:=mesMax;
end;


procedure procesarInfo(LV:listaViajes; VT:vectorCostos; var LVPT:listaVPT; rec:vectorRecaudaciones);
var
	tren:integer;  cantViajes, cantPasajeros:integer;
	costo:real;
	infoTren:LVPT; //lista viajes por tren
begin
	//1) genere una lista que tenga por cada código del tren, la cantidad de viajes realizados.
	//tener en mente q la info está ordenada por código de tren.
	new(LVPT); LVPT:=nil;
	while (LV <> nil) do begin
		trenActual:= LV^.dato.tren;
		cantViajes:=0;
		cantPasajeros:=0;
		while (LV <> nil) AND (LV^.dato.tren = trenActual) do begin
			cantViajes:= cantViajes + 1;
			cantPasajeros:= cantPasajeros + LV^.dato.pasajeros;
			costo:= v[LV^.dato.ciudad] * LV^.dato.pasajeros;
			rec[LV^.dato.mes]:= rec[LV^.dato.mes] + costo;
			
			LVPT:= LVPT^.sig;
		end;
		infoTren.tren:= trenActual;
		infoTren.viajes:= cantViajes;
		agregarAdelante(LVPT, infoTren);
		writeLn('El promedio de pasajeros del tren ', trenActual, ' es ', cantPasajeros/cantViajes);
		
		
	end;
end;


procedure agregarAdelante(var pInicial:listaViajes; infoTren:integer);
var
	nuevoNodo:listaViajes;
begin
	new(nuevoNodo);  
	nuevoNodo^.datosViajes:=infoTren; 
	nuevoNodo^.sig:=nil; 
	
	if (pI = nil) then pI:=nuevoNodo 
	else begin						
		nuevoNodo^.sig := pI; 	
		pI:=nuevoNodo;					
	end;
end;



//PROG PRIN
Var
	LV:listaViajes; VT:vectorCostos; 
	LVPT:listaVPT; //lista viajes por tren
	recaudaciones: vectorRecaudaciones;
Begin
	cargarLista(LV);	cargarVector(VT);  //SE DISPONEN
	LVPT:=NIL;
	inicializarVector(recaudaciones);
	procesarInfo(LV, VT,  LVPT, recaudaciones);
	writeLn('El Mes con mayor recaudacion fue:', maximo(recaudaciones));
End.
