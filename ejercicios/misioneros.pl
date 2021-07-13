miscan:-
	write('Numero de canibales: '),
	read(Cnum),
	write('Numero de misioneros:'),
	read(Mnum), nl,nl,
	write('Solucion:'), nl,nl,
	cambiap(Mnum,Mnum1),
	cambiap(Cnum,Cnum1),
	solucion([[Mnum1,Cnum1,1],[0,0,0]],[[0,0,0],[Mnum1,Cnum1,1]]).

solucion(Iniciopos,Finalpos):-
	movimientos(Iniciopos,Finalpos,[Iniciopos],L),
	imprimesol(L).

imprimesol([]).

imprimesol([L|T]):- imprimesol(T), imprimepaso(L), nl.

imprimepaso([[A,B,C],[D,E,F]]):- cambian(A,A1),
	cambian(B,B1),
	cambian(D,D1),
	cambian(E,E1),
	write(' Izquierda: '),
	write([A1,B1,C]),
	write(' Derecha: '),
	write([D1,E1,F]).

movimientos(Finalpos,Finalpos,L,L).

movimientos(Desde,Finalpos,Ltemp,L):- mueveuno(Desde,Hasta),
	noelemento(Hasta,Ltemp),
	movimientos(Hasta,Finalpos,[Hasta|Ltemp],L).


mueveuno([[Ml1,Cl1,1],[Mr1,Cr1,0]],[[Ml2,Cl2,0],[Mr2,Cr2,1]]):-
	menos(Arriba,s(s(0))),
	menos(s(0),Arriba),
	menos(Marriba,s(s(0))),
	add(Marriba,Carriba,Arriba),
	menos(s(0),Arriba),
	add(Ml2,Marriba,Ml1),
	add(Mr1,Marriba,Mr2),
	add(Cl2,Carriba,Cl1),
	add(Cr1,Carriba,Cr2),
	permitido([Ml2,Cl2]),
	permitido([Mr2,Cr2]).

mueveuno([[Ml1,Cl1,0],[Mr1,Cr1,1]],[L,R]):-
	mueveuno([[Mr1,Cr1,1],[Ml1,Cl1,0]],[R,L]).

permitido([0,_]).

permitido([s(M),C]):- menos(C,s(M)).

add(0,X,X).

add(s(X),Y,s(Z)):- add(X,Y,Z).

menos(0,_).

menos(s(X),s(Y)):- menos(X,Y).

cambian(0,0).

cambian(s(X),N):- cambian(X,N1),
	N is N1+1.

cambiap(0,0).

cambiap(N,s(X)):- N=\=0,
	N1 is N-1,
	cambiap(N1,X).

noelemento(_,[]).

noelemento(A,[H|T]):- A \== H,
	noelemento(A,T).





%Consulta
%2 ?- miscan.
%Numero de canibales: 3.
%Numero de misioneros:3.


%Solucion:

 %Izquierda: [3,3,1] Derecha: [0,0,0]
 %Izquierda: [3,1,0] Derecha: [0,2,1]
 %Izquierda: [3,2,1] Derecha: [0,1,0]
 %Izquierda: [3,0,0] Derecha: [0,3,1]
 %Izquierda: [3,1,1] Derecha: [0,2,0]
 %Izquierda: [1,1,0] Derecha: [2,2,1]
 %Izquierda: [2,2,1] Derecha: [1,1,0]
 %Izquierda: [0,2,0] Derecha: [3,1,1]
 %Izquierda: [0,3,1] Derecha: [3,0,0]
 %Izquierda: [0,1,0] Derecha: [3,2,1]
 %Izquierda: [0,2,1] Derecha: [3,1,0]
 %Izquierda: [0,0,0] Derecha: [3,3,1]
%true .






