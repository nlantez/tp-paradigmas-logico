%Materias
esMateria(matematicaI,96).
esMateria(matematicaII,96).
esMateria(matematicaIII,96).
esMateria(laboratorioDeComputacionI,128).
esMateria(laboratorioDeComputacionII,128).
esMateria(electricidadYMagnetismo,128).
esMateria(basesDeDatos,128).
esMateria(sistemasDeProcesamientoDeDatos,128).
esMateria(metodosNumericos,80).
esMateria(sistemasOperativos,96).
esMateria(algoritmosI,160).
esMateria(algoritmosII,144).
esMateria(algoritmosIII,160).
esMateria(redesLocales,128).
esMateria(seminarioDeProgramacion,64).
esMateria(paradigmasDeProgramacion,64).
esMateria(proyectoDeSoftware,128).
esMateria(programacionHerramientasModernas,160).

%Promocionables
esPromocionable(matematicaI).
esPromocionable(matematicaII).
esPromocionable(laboratorioDeComputacionI).
esPromocionable(laboratorioDeComputacionII).
esPromocionable(electricidadYMagnetismo).
esPromocionable(sistemasDeProcesamientoDeDatos).
esPromocionable(sistemasOperativos).
esPromocionable(paradigmasDeProgramacion).

%Punto1
materiaPesada(Materia) :- masDe100Horas(Materia).

materiaPesada(Materia) :- esMateria(Materia,_), letrasMenorA15(Materia), not(esPromocionable(Materia)).

masDe100Horas(Materia) :- esMateria(Materia, Horas), Horas > 100.

letrasMenorA15(Materia) :- atom_length(Materia, CantidadLetras), CantidadLetras < 15.


%Punto2
esCorrelativaDe(matematicaI,matematicaII).
esCorrelativaDe(laboratorioDeComputacionI,matematicaII).

esCorrelativaDe(laboratorioDeComputacionI,laboratorioDeComputacionII).

esCorrelativaDe(laboratorioDeComputacionI,sistemasDeProcesamientoDeDatos).

esCorrelativaDe(laboratorioDeComputacionII,algoritmosI).
esCorrelativaDe(matematicaII,algoritmosI).
esCorrelativaDe(sistemasDeProcesamientoDeDatos,algoritmosI).

esCorrelativaDe(sistemasDeProcesamientoDeDatos,sistemasOperativos).
esCorrelativaDe(laboratorioDeComputacionII,sistemasOperativos).

esCorrelativaDe(matematicaII,matematicaIII).
esCorrelativaDe(laboratorioDeComputacionII,matematicaIII).

esCorrelativaDe(algoritmosI,algoritmosII).
esCorrelativaDe(matematicaIII,algoritmosII).

esCorrelativaDe(sistemasDeProcesamientoDeDatos,redesLocales).
esCorrelativaDe(sistemasOperativos,redesLocales).

esCorrelativaDe(algoritmosI,metodosNumericos).

esCorrelativaDe(algoritmosII,algoritmosIII).
esCorrelativaDe(redesLocales,algoritmosIII).

esCorrelativaDe(algoritmosII,basesDeDatos).

esCorrelativaDe(algoritmosIII,paradigmasDeProgramacion).

esCorrelativaDe(algoritmosII,seminarioDeProgramacion).
esCorrelativaDe(redesLocales,seminarioDeProgramacion).
esCorrelativaDe(metodosNumericos,seminarioDeProgramacion).

esCorrelativaDe(algoritmosIII,proyectoDeSoftware).
esCorrelativaDe(basesDeDatos,proyectoDeSoftware).

esCorrelativaDe(algoritmosIII,programacionHerramientasModernas).

%Punto2A
esMateriaInicial(Materia) :- esMateria(Materia,_), not(esCorrelativaDe(_,Materia)).

%Punto2B
hayMateriaNecesariaPara(Materia,MateriaNecesaria) :- 
    esCorrelativaDe(OtraMateria,Materia), 
    hayMateriaNecesariaPara(OtraMateria,MateriaNecesaria).

hayMateriaNecesariaPara(Materia,MateriaNecesaria) :- esCorrelativaDe(MateriaNecesaria,Materia).

%Punto2C
hayMateriaQueHabilitaA(Materia,MateriaQueHabilita) :- esCorrelativaDe(Materia,MateriaQueHabilita).

/* PUNTO 3 */
cursada(nico,matematicaI,8).
cursada(nico,matematicaII,8).
cursada(nico,test,2).
cursada(nico,algoritmosII,7).
cursada(pole,matematicaI,8).
rindioLibre(nico,matematicaIII).
rindioLibre(pole,algoritmosI).

examenFinal(nico, matematicaIII,8).
examenFinal(nico, algoritmosIII,8).
examenFinal(pole, algoritmosI,3).


/* Punto 3-A */
materiasCursadas(Alumno,Materias) :- 
    cursada(Alumno,Materias,Nota),
    Nota >= 4.

materiasCursadas(Alumno,Materias) :- rindioLibre(Alumno,Materias).


/* Punto 3-B */
materiasAprobadas(Alumno,Materias) :- 
    examenFinal(Alumno,Materias,Nota),
    Nota >= 4.

materiasAprobadas(Alumno,Materias) :- 
    cursada(Alumno,Materias,Nota),
    esPromocionable(Materias),
    Nota >= 7.


%Tests
:- begin_tests(cursada_universitaria).
test(algoritmosI_materia_pesada,nondet) :-
	materiaPesada(algoritmosI).
test(basesDeDatos_materia_pesada,nondet) :-
	materiaPesada(basesDeDatos).
test(metodosNumericos_materia_no_pesada,fail) :-
	materiaPesada(metodosNumericos).
	
test(materias_iniciales, set(Materias == [matematicaI, laboratorioDeComputacionI, electricidadYMagnetismo])) :-
		esMateriaInicial(Materias).
		
test(materias_necesarias_para_algoritmosI, set(MateriasNecesarias == [laboratorioDeComputacionI,matematicaI,matematicaII,laboratorioDeComputacionII,sistemasDeProcesamientoDeDatos])) :-
	hayMateriaNecesariaPara(algoritmosI,MateriasNecesarias).
	
:- end_tests(cursada_universitaria).




