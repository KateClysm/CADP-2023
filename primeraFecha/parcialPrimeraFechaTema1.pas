{Una empresa de venta de pasajes aéreos está analizando la información de los viajes realizados por sus aviones.
Para ello, se dispone de una estructura de datos con la información de todos los viajes.
De cada viaje se conoce el código de avión(entre 1000 y 2500), el año en que se realizó el viaje, la cantidad de pasajeros que viajaron,
y la ciudad de destino. La información no se encuentra ordenada por ningún criterio.
Además, la empresa dispone de una estructura de datos con información sobre la capacidad máxima de cada avión.

Realizar un programa que procese la información de los viajes e:
A) informe el código del avión que realizó la mayor cantidad de viajes.
* De acá extraemos la cantidad de viajes que hizo el avión
B)Genere una lista con los viajes realizados en años múltiplo de 10 con destino "Punta Cana" en los que el avión no alcanzó su capacidad máxima.
C) COMPLETO: Para cada avión, informe el promedio de pasajeros que viajaron entre todos sus viajes.
*
}


program parcialPrimeraFechaTema1;

Type
	codAviones = 1000..2500;
	viaje = record
		avion: codAviones;
		año:integer;
		pasajeros: integer;
		ciudad: string;
	end;
	lista = ^nodo;
	nodo = record
		dato:viaje;
		sig:lista;
	end;
	
	vectorCapacidad = array [codAviones] of integer;
	
//MÓDULOS
procedure cargarLista( var L:lista); //SE DISPONE
procedure cargarVector (var V:vectorCapacidad); //SE DISPONE
	
function maximo(v:vectorCapacidad):integer;
Var
	i, maxAvion:codAviones;
	capacidadMax:integer;
Begin
	capacidadMax:= -1;
	for i:= 1000 to 2500 do
		if (v[i] > capacidadMax) then begin
			capacidadMax:=v[1];
			maxAvion:=i;
		end;
	maximo:=maxAvion;
end;

function promedio (pasajeros, viajes: integer):real;
begin
	if (viajes > 0) then
		promedio := pasajeros/viajes
	else
		promedio := 0;
end;
procedure inicializarVectores(var v1,v2:vectorCapacidad);
var
	i:codAviones;
begin
	for i:= 1000 to 2500 do begin
		v1[i] := 0;
		v2[i] := 0;
	end;
end;

function cumple( via:viaje; v:vectorCapacidad):boolean;
begin
	cumple:= (via.año MOD 10 = 0) and (via.ciudad = "Punta Cana") and (via.pasajeros < v[via.avion]);
end;


Procedure procesarViajes(L:lista; V:vectorCapacidad; Var viajesPorAvion, totalPasajeros: vectorCapacidad; var puntaCana:lista);
var
	avion:codAviones;
begin
	puntaCana:=NIL;
	inicializarVectores(viajesPorAvion, totalPasajeros);
	while (L <> nil) do begin
		avion:= L^.dato.avion;
		viajesPorAvion[avion]:= viajesPorAvion[avion] + 1;
		totalPasajeros[avion] := totalPasajeros[avion] + L^.dato.pasajeros;
		
		if(cumple(L^.dato, V)) then
			agregarAdelante(puntaCana, L^.dato);
		
		
		L:= L^.sig;
	end;
end;



var
	L, viajesPuntaCana :lista; //SE DISPONE
	V, viajesPorAvion, totalPasajeros : vectorCapacidad; //SE DISPONE
	
	avionMax:codAviones;
	i:integer;
begin
	cargar(Lista L); //SE DISPONE
	cargarVector(V); //SE DISPONE
	
	procesarViajes( L, V, viajesPorAvion, totalPasajeros, viajesPuntaCana);
	
	avionMax:=maximo(viajesPorAvion);
	writeLn("El avion que realizo mas viajes es: ", avionMax);
	
	for i:= 1000 to 2500 do
		writeLn("El promedio de pasajeros del avion: ", i, "fue: ", promedio(totalPasajeros[i], viajesPorAvion[i]));
end.
	
