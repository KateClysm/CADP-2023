{14. La biblioteca de la Universidad Nacional de La Plata necesita un programa para administrar
información de préstamos de libros efectuados en marzo de 2020. Para ello, se debe leer la información
de los préstamos realizados. De cada préstamo se lee: nro. de préstamo(cantidad de prestamos o es un código?), ISBN del libro prestado, nro. de
socio al que se prestó el libro, día del préstamo (1..31). La información de los préstamos se lee de manera
ordenada por ISBN y finaliza cuando se ingresa el ISBN -1 (que no debe procesarse).
Se pide:
A) Generar una estructura que contenga, para cada ISBN de libro, la cantidad de veces que fue
prestado. Esta estructura debe quedar ordenada por ISBN de libro.
B) Calcular e informar el día del mes en que se realizaron menos préstamos.
C) Calcular e informar el porcentaje de préstamos que poseen nro. de préstamo impar y nro. de socio par.}

Program p7ej14;

Type

	dia = [1..31];
	
	prestamo = record
		nro:integer;
		ISBN:integer;
		socio:integer;
		prestamoD:dia;
	end;
	
	listaPrestamos = ^nodo;
	nodo = record
		dato:prestamo;
		sig: ^listaPrestamos;
	end;

	vecesPrestado = record
		ISB:integer;
		cant:integer;
	end;
	
	listaVecesP = ^nodo;
	nodo = record
		dato:prestamo;
		sig: ^listaVecesP;
	end;
	
Procedure leerRegistro(var registro:prestamo);
Begin
	readLn(registro.nro);
	readLn(registro.ISBN);
	readLn(registro.socio);
	readLn(registro.prestamoD);
End;

//MÓDULO INSERTAR ORDENADO
Procedure insertarOrdenado (Var pI: listaPrestamos; registro:prestamo);
Var
	actual,anterior,nuevo:listaPrestamos;
Begin
	new (nuevo); //reservo memoria
	nuevo^.dato:= registro; //le paso el registro
	nuevo^.sig:=nil; //declaro al siguiente nil
	
	if (pI = nil) then    	//caso 1: si la lista es nil(está vacía), hacemos que el puntero Inicial apunte a la dir de nuevo.
		pI:= nuevo
	else begin				//la lista no está vacía, buscamos donde posicionar el nodo y vamos moviendo ant y act. 
		actual:= pI; ant:=pI;	//actual y anterior apuntarán a lo que apunta el puntero Inicial.
		while (actual <> nil) and (actual^.dato.ISBN < nuevo^.dato.ISBN) do   //mientras la lista no haya terminado y
		begin																  //el ISBN del nuevo dato sea mayor al del elemento actual,
			anterior:=actual;												  //ant apuntará a la dir de act
			actual:= actual^.sig;											  //act apuntará al siguiente nodo
		end;
	end;
	
	//cuando se sale del while se analiza el por qué salió
	
	if (actual = pI) then 	//caso 2: no cumplió con la segunda condición del while, es menor, debe ir adelante.
	begin
		nuevo^.sig:= pI;   //el sig al nuevo nodo apunta a lo que apunta pI
		pI:= nuevo;		   //el pI cambia a el nuevo nodo.
	end
	else
			//caso 3: no cumplió con la primera condición y quedó el actual en nil, es decir el nuevo nodo debe ir al final.
			//caso 4: salió del while porque el (ISBN)actual no es menor al (ISBN)nuevo y debemos posicionar a nuevo entre actual y anterior.
	begin
		anterior^.sig:= nuevo;   //el siguiente al anterior apunta al nuevo nodo
		nuevo^.sig:= actual;	 //y el siguiente al nuevo nodo apunta al actual, en caso de que sea al final de la lista, apuntará a nill.
	end;
End;

Procedure cargarListaOrdenada( Var listaP:listaPrestamos);
Var
	rPrestamo:prestamo;
Begin
	leerRegistro(rPrestamo);
	While (rPrestamo.ISBN <> -1) do 
	Begin
		insertarOrdenado(listaP, rPrestamo);
	end;
End;

//A) Generar una estructura que contenga, para cada ISBN de libro, la cantidad de veces que fue prestado. Esta estructura debe quedar ordenada por ISBN de libro.

Procedure procesarInfo(listaP:listaPrestamos; Var listaVP:listaVecesP);
Var
	registroActual : vecesPrestado;
	min:integer; minDia:dia; //dia con menos préstamos
	cantPrestamos:integer; prestamoCumple:integer; //porcentaje de préstamos que poseen nro de p impar y nro de socio par
Begin
	min:=9999; cantPrestamos:0; prestamoCumple:0;
	while (listaP <> nil) do
	begin
		registroActual.ISBN := listaP^.dato.ISBN;		//relleno el registro
		
		registroActual.cant := listaP^.dato.cant;	
		
		insertarOrdenado(listaVP, registroActual); 		//se lo paso al procedure insertar ordenado para que vaya creando la lista
		
		cantPrestamos:= cantPrestamos + listaP^.dato.cant;
		
		if (cumple(listaP^.dato.nro, listaP^.dato.socio)) then
			prestamoCumple:= prestamoCumple + 1;
		
		if (listaP^.dato.cant < min) then begin
			min:= listaP^.dato.cant;
			minDia:= listaP^.dato.prestamoD;
		end;
		
		listaP:= listaP^.sig;	//paso de posición
	end;
	
	//B) Calcular e informar el día del mes en que se realizaron menos préstamos.
	writeln('El día en el que se realizó menos prestaciones fue el día: ', minDia);
	
	//C) Calcular e informar el porcentaje de préstamos que poseen nro. de préstamo impar y nro. de socio par.
	WriteLn('El porcentaje de préstamos que poseen nro. de préstamos impar y nro de socio par es : ', (cantPrestamos/prestamoCumple);
End;

function cumple(nro1, nro2:integer):boolean;
begin
	cumple:= (    ((nro1 MOD 3) = 0)  AND ((nro2 MOD 2) = 0)  );
end;	


Var
	LP:listaPrestamos;
	LVP:listaVecesP;

//prog prin//
{se debe leer la información de los préstamos realizados.
La información de los préstamos se lee de manera ordenada por ISBN y finaliza cuando se ingresa el ISBN -1 (que no debe procesarse).}
Begin
	LP:=nil; 
	LVP:=nil;
	cargarListaOrdenada(LP);
	procesarInfo(LP, LVP);
	
End.
