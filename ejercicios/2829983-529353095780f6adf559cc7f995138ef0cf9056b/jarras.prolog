% La jarra pequeña (P) tiene una capacidad de 3 unidades.
% La jarra grande (G) tiene una capacidad de 5 unidades.
% Existe una cantidad máxima de agua (A) que podemos utilizar para rellenar 
% las jarras.

% Los estados se representan como e(P, G, A), donde P y G son  las cantidades 
% de agua que hay en cada jarra y A es la cantidad de agua disponible.

% Se define una transición como aplica(e(P, G, A), e(P', G', A')). Esto quiere 
% decir que del estado e(P, G, A) podemos pasar al e(P', G', A') si se cumplen 
% ciertas restricciones.

% El estado inicial es e(0, 0, A), y el estado final es cualquiera en el que la 
% jarra grande tenga 4 unidades de agua, e(_, 4, _). 


% Rellenar completamente la jarra pequeña si no está llena y queda suficiente 
% agua.
aplica(e(P, G, A), e(3, G, NA)) :-
    A >= 3 - P,
    P < 3,
    NA is A - (3 - P).

% Rellenar completamente la jarra grande si no está llena y queda suficiente 
% agua.
aplica(e(P, G, A), e(P, 5, NA)) :-
    A >= 5 - G,
    G < 5,
    NA is A - (5 - G).

% Vaciar completamente la jarra pequeña si no está vacía.
aplica(e(P, G, A), e(0, G, A)) :- P > 0.

% Vaciar completamente la jarra grande si no está vacía.
aplica(e(P, G, A), e(P, 0, A)) :- G > 0.

% Si hay suficiente agua en la jarra pequeña, verterla en la jarra grande 
% hasta que se llene.
% (si a la grande le cabe lo que hay en la pequeña)
aplica(e(P, G, A), e(0, NG, A)) :-
    P > 0,
    G < 5,
    5 - G >= P,
    NG is P + G.

% (si a la grande *no* le cabe lo que hay en la pequeña)
aplica(e(P, G, A), e(NP, 5, A)) :-
    P > 0,
    G < 5,
    5 - G < P,
    NP is P - (5 - G).

% Si hay suficiente agua en la jarra grande, verterla en la jarra pequeña 
% hasta que se llene.
% (si a la pequeña le cabe lo que hay en la grande)
aplica(e(P, G, A), e(NP, 0, A)) :-
    G > 0,
    P < 3,
    3 - P >= G,
    NP is P + G.

% (si a la pequeña *no* le cabe lo que hay en la grande)
aplica(e(P, G, A), e(3, NG, A)) :-
    G > 0,
    P < 3,
    3 - P < G,
    NG is G - (3 - P).


% Vamos aplicando transiciones hasta que lleguemos a la configuración final. 
% Evitamos entrar en bucles infinitos no añadiendo estados duplicados.
busca([e(P0, G0, A0) | T], [e(P1, 4, A1), s(P0, G0, A0) | T]) :-
    aplica(e(P0, G0, A0), e(P1, 4, A1)),
    !.
    
busca([e(P0, G0, A0) | T], ES) :-
    aplica(e(P0, G0, A0), e(P1, G1, A1)),
    \+ member(e(P1, G1, A1), [e(P0, G0, A0) | T]),
    busca([e(P1, G1, A1), e(P0, G0, A0) | T], ES).


% Punto de entrada.
soluciona_jarras(A, ES) :- busca([e(0, 0, A)], ES).


% Para probarlo en Ciao y mostrar todas las soluciones:
% ensure_loaded('jarras.prolog').
% soluciona_jarras(9, ES), write(ES), nl, fail.

% Para calcular la solución que gasta el mínimo de agua, vamos ejecutando el 
% predicado de entrada disminuyendo la cantidad de agua disponible cada vez, 
% hasta que no se obtengan soluciones. La cantidad anterior a este punto será 
% la mínima cantidad de agua. En nuestro caso es 9.

% Si tomamos la mínima cantidad de agua, la aumentamos en una unidad y 
% mostramos las soluciones, podemos observar que existe una solución que gasta
% una mayor cantidad de agua, pero obtiene la solución en menos pasos:
% soluciona_jarras(10, ES), write(ES), nl, fail.