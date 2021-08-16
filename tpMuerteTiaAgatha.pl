% 1a)
viveEnLaMansion(tiaAgatha).
viveEnLaMansion(mayordomo).
viveEnLaMansion(charles).

odia(tiaAgatha,Persona):-
    viveEnLaMansion(Persona),    
    Persona \= mayordomo.

odia(charles,Persona):-
    viveEnLaMansion(Persona),
    not(odia(tiaAgatha,Persona)).

odia(mayordomo,Persona):-
    odia(tiaAgatha,Persona).

esMasRicoQue(Persona1,tiaAgatha):-
    viveEnLaMansion(Persona1),
    not(odia(mayordomo,Persona1)).

quienMata(Asesino,Persona):-
    odia(Asesino,Persona),
    not(esMasRicoQue(Asesino,Persona)).

/* 1b)  quienMataA(tiaAgatha,Asesino).
    Asesino = tiaAgatha.

2b)  Si existe alguien que odie a milhouse.

   odia(_,milhouse).       
   false.

    A quién odia charles.

 odia(charles,Persona).
 Persona = mayordomo ; 
 false.

   El nombre de quien odia a tía Ágatha.

 odia(Persona,tiaAgatha).
 Persona = tiaAgatha ;
 Persona = mayordomo.

   Todos los odiadores y sus odiados.

 odia(Odiadores,Odiados).
 Odiadores = Odiados, Odiados = tiaAgatha ;
 Odiadores = tiaAgatha,
 Odiados = charles ;
 Odiadores = charles,
 Odiados = mayordomo ;
 Odiadores = mayordomo,
 Odiados = tiaAgatha ;
 Odiadores = mayordomo,
 Odiados = charles.

   Si es cierto que el mayordomo odia a alguien

odia(mayordomo,_).
 true ;
 true.
*/