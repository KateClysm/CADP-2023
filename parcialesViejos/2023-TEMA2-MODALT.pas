{Una empresa de fabricación y venta de repuestos para automóviles dispone de información 
sobre el stock de repuestos para la venta. 
Para cada repuesto conoce su código de repuesto (entre 100 y 3400), la cantidad disponible en stock,
 el precio por unidad y el año de fabricación del repuesto.
 
Además, la empresa dispone también de la información de todas las ventas realizadas en el año.
De cada venta conoce el código de repuesto vendido y la cantidad vendida. Pueden aparecer muchas 
ventas de un mismo repuesto. 
La información de las ventas no posee ningún orden particular.

Realizar un programa que actualice la información del stock de la empresa, procesando la información 
de las ventas realizadas en el año, e informe:
a) para cada repuesto, la cantidad totalq ue se vendió durante todo el año.
b) los dos códigos de repuesto que generaron mayor ingreso de dinero(precio por unidad 
multiplicado por cantidad total vendida).
c) los códigos de los repuestos fabricados en años múltiplos de 5 que quedaron con stock 
menor o igual a cero luego de actualizar la información del stock.}


Program tema2ModAlt2023;

Type
	subrangoCodigoRepuesto = [100..3400]
	repuesto = record
		codigo : subrangoCodigoRepuesto;
		stock : integer;
		precio : real;
		añoFabricacion : integer;
	end;
	
	vectorRepuestos = array [subrangoCodigoRepuesto] of repuesto;
	
	vectorContadorVentasPorRepuesto = array [subrangoCodigoRepuesto] of integer;
	
	venta = record 
		codigo : subrangoCodigoRepuesto;
		cantidad : integer;
	end;
	listaVentas = ^nodo; //la empresa dispone también de la información de todas las ventas realizadas en el año.
	nodo = record
		dato : venta;
		sig : ^listaVentas;
	end;
	
	
	listaStock = ^nodoStock; 
	nodoStock = record
		codigo : subrangoCodigoRepuesto;
		sig : ^listaStock;
	end;


//MÓDULOS
procedure leerRepuesto ( var rep : repuesto);	//se dispone
procedure leerVenta ( var ven : venta);		//se dispone
procedure cargarVectorRepuestos (var listaR : listaRepuestos ; rep : repuesto);		//se dispone. carga 
procedure agregarAdelanteVenta (var listaV : listaVentas ; ven : venta);		//se dispone
procedure cargarListaVentas ( var listaV : listaVentas);		//se dispone
var
	ven: venta;
begin 
	//se dispone y usa agregarAdelanteVenta
end;

procedure inicializarVectorContador ( vector : vectorContadorVentasPorRepuesto);
var
	i : subrangoCodigoRepuesto;
begin
	for i:= 1000 to 3400 do begin
		vector[i] := 0;	
	end;
end;

procedure procesarInfo ( listaV: listaVentas; var vectorContador : vectorContadorVentasPorRepuesto; var vectorR : vectorRepuestos; var cod1, cod2:integer, Var ls : listaStock);
var
	numeroRepuesto : subrangoCodigoRepuesto;
	cantidad : integer;
	i:subrangoCodigoRepuesto;
	max1, max2:real;
begin
	while (listaV <> nil) do begin		//recorre la lista
		numeroRepuesto := listaV^.dato.codigo;
		cantidad := listaV^.dato.cantidad;
		vectorContador[numeroRepuesto] := vectorContador[numeroRepuesto] + cantidad;
		
		vectorR[numeroRepuesto].stock := vectorR[numeroRepuesto].stock - cantidad;
		
		
		listaV := listaV^.sig;
	end;
	
	//recorre el vector contador
	for i:=1000 to 3400 do begin
		if ((vectorContador[i] * vectorR[i].precio) > max1) then
			max2 := max1;
			max1 := (vectorContador[i] * vectorR[i].precio);
			cod2 := cod1;
			cod1 := i
		else
			max2 := (vectorContador[i] * vectorR[i].precio);
			cod2 := i;
		end;
	end;
	
	//recorre el vector de repuestos ya actualizados y va sumando a una lista lo que cumpla con el inciso C
	for i:= 1000 to 3400 do begin
		if (vectorR[i].stock <= 0) AND ((vectorR[i].añoFabricacion MOD 5) = 0) then
			agregarAdelanteListaStock( ls, vectorR[i].codigo);
	end;
end;

procedure agregarAdelanteListaStock(var ls : listaStock; codigo:subrangoCodigoRepuesto);
var
	nuevoNodo: nodoStock;
Begin
	new(nuevoNovo);
	nuevoNodo^.codigo := codigo;
	nuevoNodo^.sig := nil;
	
	if (ls = nil) then
		ls := nuevoNodo
	else begin
		nuevoNodo^.sig := ls;
		ls := nuevoNodo;
	end;
end;

Var
	VR : vectorRepuestos; LV : listaVentas;
	VCVPR: vectorContadorVentasPorRepuesto;
	cod1, cod2 : integer;
	i:subrangoCodigoRepuesto;
	LS:listaStock;
Begin
	LR : nil; LV : nil;
	cargarVectorRepuestos(LR);
	cargarListaVentas(LV);
	inicializarVectorContador(VCVPR);
//La información de las ventas no posee ningún orden particular.
//Realizar un programa que actualice la información del stock de la empresa, procesando la información de las ventas realizadas en el año, e informe:
	procesarInfo( LV, VCVPR, VR, cod1, cod2, LS);
//a) para cada repuesto, la cantidad totalq ue se vendió durante todo el año.
	for i:= 1 to 3400 do begin
		writeln('La cantidad de ventas del repuesto codigo: ', i , ' es de : ', VCVPR[i]);
	end;
//b) los dos códigos de repuesto que generaron mayor ingreso de dinero(precio por unidad multiplicado por cantidad total vendida).
	writeLn('Los dos códigos de repuesto que generaron mayor ingreso de dineor fueron: ', cod1 , ' y ', cod2);
//c) los códigos de los repuestos fabricados en años múltiplos de 5 que quedaron con stock menor o igual a cero luego de actualizar la información del stock.
	while (LS <> nil) do begin
		writeln(LS^.codigo);
		LS := LS^.sig;
	end;
End.
