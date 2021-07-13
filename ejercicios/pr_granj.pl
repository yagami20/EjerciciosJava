 glpt([d,d,d,d],_):- nl.
%caso base cuando ya están todos del lado derecho
glpt([M,M,P1,T1],R):- cambia(M,M2),
	cambia(M,L2),
	P2 = P1, T2 = T1,
	not(peligro(M2,L2,P2,T2)),
	not(elemento([M2,L2,P2,T2],R)),
	glpt([M2,L2,P2,T2],[[M,M,P1,T1]|R]),
	write('Cambia el granjero y el lobo... '),
	write(M2), write(L2), write(P2), write(T2), nl.

glpt([M,L1,M,T1],R):- cambia(M,M2),
	cambia(M,P2),
	L2 = L1, T2 = T1,
	not(peligro(M2,L2,P2,T2)),
	not(elemento([M2,L2,P2,T2],R)),
	glpt([M2,L2,P2,T2],[[M,L1,M,T1]|R]),
	write('Cambia el granjero y el pato... '),
	write(M2), write(L2), write(P2), write(T2), nl.

glpt([M,L1,P1,M],R):- cambia(M,M2),
	cambia(M,T2),
	P2 = P1,
	L2 = L1,
	not(peligro(M2,L2,P2,T2)),
	not(elemento([M2,L2,P2,T2],R)),
	glpt([M2,L2,P2,T2],[[M,L1,P1,M]|R]),
	write('Cambia el granjero y el trigo... '),
	write(M2), write(L2), write(P2), write(T2), nl.

glpt([M,L1,P1,T1],R):- cambia(M,M2),
	T2 = T1,
	P2 = P1,
	L2 = L1,
	not(peligro(M2,L2,P2,T2)),
	not(elemento([M2,L2,P2,T2],R)),
	glpt([M2,L2,P2,T2],[[M,L1,P1,T1]|R]),
	write('Cambia solo al granjero... '),
	write(M2), write(L2), write(P2), write(T2), nl.
peligro(d,i,i,_).
% hay peligro cuando el lobo y el pato están juntos del lado izquierdo
peligro(i,d,d,_).
% hay peligro cuando el lobo y el pato están juntos del lado derecha
peligro(d,_,i,i).
% hay peligro cuando el pato y el trigo están juntos del lado izquierdo.
%
peligro(i,_,d,d).
% hay peligro cuando el pato y el trigo están juntos del lado derecho
cambia(d,i).
% cambia de posición a los elementos de derecha a izquierda
cambia(i,d).
% cambia de posición a los elementos de izquierda a derecha.
elemento(X, [X|R]).
elemento(X, [Y|R]):- elemento(X,R). % saca el un elemento de la lista




%consulta
%1 ?- glpt([i,i,i,i],[]).

%Cambia el granjero y el pato... dddd
%Cambia solo al granjero... idid
%Cambia el granjero y el trigo... ddid
%Cambia el granjero y el pato... idii
%Cambia el granjero y el lobo... dddi
%Cambia solo al granjero... iidi
%Cambia el granjero y el pato... didi
%true .















