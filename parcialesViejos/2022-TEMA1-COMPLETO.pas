{Una panadería artesanal de La Plata vende productos de elaboración propia. 
La panadería agrupa a sus productos en 26 categorías (por ej: 1.Pan; 2.Medialunas; 3.Masas Finas; etc.)
Para cada categoría se conoce su nobre y el precio por kilo del producto.
* 
Laa panadería dispone de la información de todas las compras realizadas en el último año.
* 
De cada compra se conoce el DNI del cliente, la categoría del productor (entre 1 y 26) y la cantidad de kilos comprados.
* 
La información se encuentra ordenada por DNI del cliente.
* 
a) Realizar un módulo que retorne la información de las categorías en una estructura de datos adecuada. 
La información se lee por teclado y sin ningún orden en particular.
De cada categoría se lee el nombre, el código (1 a 26) y el precio por kilo.
b)Realizar un módulo que reciba la información de todas las compras, la información de las categorías y retorne:
	1) DNI del cliente que más compras ha realizado.
	2) Monto total recaudado por cada categoría.
	3)Cantidad total de compras de clientes con DNI compuesto por al menos 3 dígitos pares.
NOTA: Implementar el programa principal.}


Program tema12022;

	categorias = [1..26];
Type
	producto = record		//Para cada categoría se conoce su nobre y el precio por kilo del producto.
		nombre:string;
		precioKilo:real;
	end;
	productos = array [categorias] of producto; //La panadería agrupa a sus productos en 26 categorías

	compra = record
		DNI:integer;	//DNI del cliente
		categoria:categorias;		//categoría del productor (entre 1 y 26)
		cantK:real;		//cantidad de kilos comprados.
	end;

	comprasRealizadas = ^nodo;		//Laa panadería dispone de la información de todas las compras realizadas en el último año.
	nodo = record					//La información se encuentra ordenada por DNI del cliente.
		dato : compra;
		sig: ^comprasRealizadas;
	end;
	

//MÓDULOS DISPUESTOS
Procedure leerCompra(Var reg:compra);
Procedure insertarOrdenado (Var listaCompras:comprasRealizadas; reg:compra); //insertará ordenado por DNI
Procedure cargarListaOrdenada(Var listaCompras:comprasRealizadas); //repite hasta alcanzar los 365 días, contempla caso día sin ventas

{a) Realizar un módulo que retorne la información de las categorías en una estructura de datos adecuada. 
La información se lee por teclado y sin ningún orden en particular.
De cada categoría se lee el nombre, el código (1 a 26) y el precio por kilo.}
	
Procedure leerProducto(Var prod:producto; Var cat:categorias);
Begin
	readLn(prod.cat); readLn(prod.nombre); readLn(prod.precioKilo);
End;


Procedure cargarVector(Var vProductos:productos);
Var
	cat:categorias; i:categorias; prod:producto;
Begin
	for i:=1 to 26 do begin
		leerProducto(prod, cat);
		vProductos[cat].nombre:= prod.nombre;
		vProductos[cat].precioKilo:= prod.precioKilo;
	end;
End;

{b)Realizar un módulo que reciba la información de todas las compras, la información de las categorías y retorne:
	1) DNI del cliente que más compras ha realizado.
	2) Monto total recaudado por cada categoría.
	3)Cantidad total de compras de clientes con DNI compuesto por al menos 3 dígitos pares.}

	
	
	
	
	
Var
	LC:comprasRealizadas;
	VP:productos;
Begin
	LC:=nil;
	cargarListaOrdenada(LC); //SE DISPONE
	cargarVector(VP);
End;
