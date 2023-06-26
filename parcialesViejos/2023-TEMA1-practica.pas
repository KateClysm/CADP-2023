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

Program parcial1;
Type
	subrangoAviones = [1000..2500];
	viaje = record		
		codAvion:subrangoAviones;
		año:integer;
		pasajeros:integer;
		destino:string;
	end;
	listaViajes = ^nodo;
	nodo = record
		datosViajes:viaje;
		sig:lista;
	end;

	vCapacidad = array [subrangoAviones] of integer;   	//usado para capMaxPorAvion y para cantViajesPorAvion
	
	
//MÓDULOS//
procedure cargarLista(var L:listaViajes);	//SE DISPONE
procedure cargarCapacidad(var capacidad:vCapacidad); //SE DISPONE


procedure inicializarViajesYPasajeros( var cantViajes, cantPasajeros:vCapacidad);
var
	i:subrangoAviones;
begin
	for i:=1000 to 2500 do
		cantViajes[i] := 0;
		cantPasajeros[i] := 0;
end;


procedure procesarInfo(lv:listaViajes; var cantViajes, cantPasajeros:vCapacidad;  Var listaPC:listaViajes; vC:vCapacidad);
var
	avion:=subrangoAviones;
begin
	listaPC:=NIL; //inicio la lista en nil
	inicializarViajesYPasajeros(cantViajes, cantPasajeros); //inicializo el vector en 0's
	while (lv <> nil) do begin //mientras el valor no sea nil
		avion:=lv^.datosViajes.codAvion; //igualo avion al código del avion
		cantViajes[avion]:= cantViajes[avion] + 1; //aumento el vector cantViajes en la posición del código del avión
		//C) COMPLETO: Para cada avión, informe el promedio de pasajeros que viajaron entre todos sus viajes.
		cantPsajeros[avion]:= cantPasajeros[avion] + lv^.datosViajes.pasajeros;
		
		if (cumple(lv^.datosViajes, vC) then  //B)Genere una lista con los viajes realizados en años múltiplo de 10 
			agregarAdelante(listaPC, lv^.datosViajes);			//con destino "Punta Cana"  en los que el avión no alcanzó su capacidad máxima.
				
		lv:= lv^.sig; //analizo el siguiente
	end;
end;

procedure agregarAdelante(var pI:listaViajes; registro:viaje);
var
	nuevoNodo:listaViajes;
begin
	new(nuevoNodo);  //Reservo espacio
	nuevoNodo^.datosViajes:=registro; //el registro que cumplió lo paso a los datos del nuevo nodo
	nuevo^.sig:=nil; //pongo en nil al sig
	
	if (pI = nil) then pI:=nuevo //si la lista a la que estamos agregando está vacía, se convierte en el nuevo nodo
	else begin						//sino
		nuevoNodo^.sig := pI; 		//el puntero sig del nuevo nodo apunta a la dira la que apunta el puntero Inicial
		pI:=nuevo;					//Y el pI cambiará la dirección a la que apunta por la del nuevo nodo.
	end;
end;


function cumple(v:viaje; vC:vectorCapacidad):boolean;  //si el año es multiplo de 10, el destino Punta Cana y no se supera la capacidadMax
begin
	cumple:= (viaje.año MOD 10 = 0) AND 
		(viaje.destino = 'Punta Cana') AND 
		(viaje.pasajeros < vC[viaje.codAvion]);
end;


function maxViajes(cantViajes:vCapacidad); //calcula cuál avión realizó más viajes y devuelve su código
var
	i, codMax:subrangoAviones;
	maxVia:=integer;
 begin
	maxVia:= -1;
	for i:= 1000 to 2500 do
		if (cantViajes[i] > maxVia) then begin
			maxVia:= cantViajes[i];
			codMax:= [i];
		end;
	maxViajes:=codMax;
end;

function promedio (pasajeros, viajes:vCapacidad):real;
begin
	if (viajes > 0) then
		promedio := pasajeros/viajes
	else
		promedio := 0;
end;

//PROG PRINCIPAL
Var
	lv, lpc:listaViajes:listaViajes;   
	capMaxPorAvion, cantViajesPorAvion, cantPasajerosPorAvion:vCapacidad; 
	i:subrangoAviones;
Begin
	cargarLista(var lv); //SE DISPONE
	cargarCapacidad(capMaxPorAvion);  //SE DISPONE
	
	//LA INFORMACIÓN NO SE ENCUENTRA ORDENADA POR NINGÚN CRITERIO 
	procesarInfo(lv, cantViajesPorAvion,cantPasajerosPorAvion, lpc, capMaxPorAvion);
	
	//A) informe el código del avión que realizó la mayor cantidad de viajes
	writeLn('EL avion que realizó una mayor cantidad de viajes fue: ', maxViajes(cantViajesPorAvion) );
	
	//B)Genere una lista con los viajes realizados en años múltiplo de 10 con destino "Punta Cana"  en los que el avión no alcanzó su capacidad máxima.}
	//HECHO
	
	//C) COMPLETO: Para cada avión, informe el promedio de pasajeros que viajaron entre todos sus viajes.
	for i:=1000 to 2500 do begin
		writeln ('El avion ', i , 'tiene un promedio de ', promedio(cantPasajerosPorAvion[i], cantViajesPorAvion[i]), ' por viaje.');
End.

