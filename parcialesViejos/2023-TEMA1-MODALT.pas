{Una cátedra dispone de información de sus alumnos en la cursada 2022. De cada alumno se conoce:
nro de legajo, apellido y nombre, año de inscripción a la carrera y nota obtenida en cada una 
de las 10 autoevaluaciones rendidas durante la cursada.
Se pide:
* 
a) Informar apellido y nombre de los alumnos cuyo año de inscripción sea impar.
b) informar, para cada autoevaluación, cuántos alumnos obtuvieron nota mayor a 4.
c) generar una estructura que contenga a los alumnos con promedio mayor a 7 (en las autoevaluaciones)}


Program tema1MODALT;
Type
	calificacion = [1..10];
	
	vectorNotas = array [calificacion] of calificacion;		//se dispone
	
	registroAlumno = record						//Se dispone
		legajo:integer;
		apellidoynombre:string;
		añoInscripcion:integer;
		notas:vectorNotas;
	end;
	
	listaAlumnos = ^nodo;			//se dispone
	nodo = record
		dato:alumno;
		sig: ^listaAlumnos;
	end;

	vectorContadorNotas = array [calificacion] of integer; ////b) informar, para cada autoevaluación, cuántos alumnos obtuvieron nota mayor a 4.

//MÓDULOS DISPUESTOS
procedure leerAlumno(Var alumno:registroAlumno);
var
	i:calificacion;
begin
	readLn(alumno.legajo); readLn(alumno.apellidoynombre); readln(alumno.añoInscripcion); 
	for i:= 1 to 10 do 
		readLn(alumno.notas[i]);
end;
procedure cargarLista(alumnos:listaAlumnos);

procedure inicializarVector(vector:vectorContadorNotas);
var
	i:calificacion
begin
	for i:=1 to 10 do
		vector[i]:= 0;
end;


procedure procesarInfo(alumnos:listaAlumnos; var VCN:vectorContadorNotas; var LAP7:listaAlumnos);
var
	i:calificacion; sumatoriaNotas:integer; 
begin
	while (alumnos <> nil) do
	begin
		sumatoriaNotas:=0;
		//a) Informar apellido y nombre de los alumnos cuyo año de inscripción sea impar.
		if (cumple(alumnos^.dato.añoInscripcion)) then writeln('El alumno ', alumno^.dato.apellidoynombre, ' se inscribió en un año impar.');
	
		//b) informar, para cada autoevaluación, cuántos alumnos obtuvieron nota mayor a 4.
		for i:=1 to 10 do begin	//para cada autoevaluación
			if (alumnos^.dato.nota[i] > 4 )then	//si la nota de la autoevaluación fue mayor a 4
				VCN[i]:=VCN[i]+1;	//le sumo uno al contador de esa autoevauación
			
			sumatoriaNotas:= sumatoriaNotas + alumnos^.dato.nota[i]		
		end;
		
		//c) generar una estructura que contenga a los alumnos con promedio mayor a 7 (en las autoevaluaciones)
		if ((sumatoriaNotas / 10) > 7) then
			agregarAdelante(LAP7, alumno^.dato); //si tiene un promedio mayor a 7 lo agrego a la lista. 
		
		alumnos:= alumnos^.sig;
	end;
	
	//b) informar, para cada autoevaluación, cuántos alumnos obtuvieron nota mayor a 4.
	for i:=1 to 10 do
		writeLn('Los alumnos que sacaron más de 4 en la autoevaluación ', i , ' fueron: ', VCN[i]);
end;


function cumple(numero:integer):boolean;
begin
	cumple:= ((numero MOD 3) = 0));
end;

procedure agregarAdelante(pI:listaAlumnos; registro:alumno);
var
	nuevo:listaAlumnos;
begin
	new(nuevo);
	nuevo^.dato:=registro; nuevo^.sig:=nil;
	
	if(pI = nil) then
		pI:= nuevo;
	else begin
		nuevo^sig:= pI;
		pI:=nuevo;
	end;
end;


Var
	LA:listaAlumnos;	//se dispone
	vContadorNotas:vectorContadorNotas;
	LAP7:listaAlumnos; //lista alumnos promedio may a 7
Begin
	cargarLista(LA);	//se dispone
	inicializarVector(vContadorNotas);
	
	procesarInfo(LA, vContadorNotas, LAP7);
End.
