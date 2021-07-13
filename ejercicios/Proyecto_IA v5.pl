%
%                                                                                
%                     .: Proyecto Final de Inteligencia Artificial :.
%  
% Autor:
%    - Alain Sanchez Gutierrez
%    Facultad 9 "Multimedia, Software Educativo & Meteorologia"
%    Universidad de las Ciencias Informaticas
%    Cuba.
%    email: asanchezg@estudiantes.uci.cu
%  
  

% ---  Problema   ---

% El problema de la zorra, la oca, el grano y el campesino consistente en lo siguiente: 
% Suponga que un campesino tiene una zorra, una oca y un saco de granos, y que desea cruzar un río. 
% Para eso tiene un bote en el que puede cruzar el río con uno solo de los otros elementos 
% (zorra, oca o grano). En cada viaje, en cualquiera de los dos sentidos, debe viajar el campesino
% ya que es el que debe remar. En un inicio están los 4 de un lado del río y el objetivo final es 
% que estén los 4 del otro lado. Hay dos restricciones importantes que son las siguientes. 
% Cuando el campesino no está, no pueden quedar juntos la zorra y la oca porque la primera se come 
% a la segunda. Tampoco pueden quedar junto la oca y el grano porque la primera se come al segundo.
% El objetivo es encontrar la secuencia de viajes que permita realizar el paso del río. 
% Sugerencia: representar en hechos los movimientos posibles que pueden hacerse con el bote,
% y en otros hechos los estados prohibidos.

% Prográmelo de manera tal que se pueda generalizar a cualquier cantidad de zorras, ocas, sacos 
% de grano y de posibles viajeros en el bote, de manera que la explicación anterior sea sólo el caso
% particular donde hay una zorra, una oca, un saco de granos, y un espacio en el bote además del
% campesino.

% ---  Solucion   ---

% #region Datos del problema

% estado inicial
inicio(estado(lado(1, Zorras, Ocas, Granos), lado(0, 0, 0, 0), CapBote)):-
	write('\tcantidad de Zorras : '), read(Zorras),
	write('\tcantidad de Ocas : '), read(Ocas),
	write('\tcantidad de Granos : '), read(Granos),
	write('\tcapacidad del Bote : '), read(CapBote).

% estado final
fin(estado(lado(0, 0, 0, 0), lado(1, _, _, _), _)).


% restrincion(es) de peligro
% no hay peligro solo cuando en ambos lados los animales estan a salvo
sin_problemas(E):-
	E = estado(Li, Lf, _),
	es_seguro(Li),
	es_seguro(Lf).
% no hay ocas y en la orilla hay zorras y granos
es_seguro(L):-
	L = lado(_, Zorras, Ocas, Granos),
	Ocas = 0, Zorras > 0, Granos > 0.
% no hay ocas, pero en la orilla hay zorras
es_seguro(L):-
	L = lado(_, Zorras, Ocas, _),
	Ocas = 0, Zorras > 0.
% no hay ocas, pero en la orilla hay granos
es_seguro(L):-
	L = lado(_, _, Ocas, Granos),
	Ocas = 0, Granos > 0.
% no hay zorras ni granos, pero en la orilla hay ocas
es_seguro(L):-
	L = lado(_, Zorras, Ocas, Granos),
	Ocas > 0, Zorras = 0, Granos = 0.
% las ocas y el hombre estan en la misma orilla
es_seguro(L):-
	L = lado(Hombre, _, Ocas, _),
	Ocas > 0, Hombre = 1.
% no queda ningun elemento en la orilla
es_seguro(L):-
	L = lado(_, Zorras, Ocas, Granos),
	Ocas = 0, Zorras = 0, Granos = 0.


% Son movimientos posibles cuando ...
% viaje el Hombre de un lado a otro
ir_desde(Ei, Ef):-
	Ei = estado(Li1, Li2, CB),
	Li1 = lado(Hi1, Zi1, Oi1, Gi1),
	Li2 = lado(Hi2, Zi2, Oi2, Gi2),	

	Ef = estado(Lf1, Lf2, CB),
	Lf1 = lado(Hf1, Zf1, Of1, Gf1),
	Lf2 = lado(Hf2, Zf2, Of2, Gf2),
	
	Hf1 is Hi2, Hf2 is Hi1,
	Zf1 is Zi1, Zf2 is Zi2,
	Gf1 is Gi1, Gf2 is Gi2,
	Of1 is Oi1, Of2 is Oi2,
%	M = '.: vija el Hombre al otro lado :.',
	 %  ' H,'+Oi1+'O -> '

	sin_problemas(Ef).


% viaje el Hombre con las Ocas de Ei a Ef cuando Ocas = CB-1
ir_desde(Ei, Ef):-
	Ei = estado(Li1, Li2, CB),
	Li1 = lado(Hi1, Zi1, Oi1, Gi1),
	Li2 = lado(Hi2, Zi2, Oi2, Gi2),	

	Ef = estado(Lf1, Lf2, CB),
	Lf1 = lado(Hf1, Zf1, Of1, Gf1),
	Lf2 = lado(Hf2, Zf2, Of2, Gf2),
	
	Oi1 =:= (CB-1),
	Of1 is Oi1 - (CB - 1),
	Of2 is Oi2 + (CB - 1),

	Hf1 is Hi2, Hf2 is Hi1,
	Zf1 is Zi1, Zf2 is Zi2,
	Gf1 is Gi1, Gf2 is Gi2,

%	M = '.: viaja el Hombre con ,'+Oi1+'Ocas del lado 1 al lado 2
%	:.',

	sin_problemas(Ef).

% viaje el Hombre con las Ocas de Ef a Ei cuando Ocas = CB-1
ir_desde(Ei, Ef):-
	Ei = estado(Li1, Li2, CB),
	Li1 = lado(Hi1, Zi1, Oi1, Gi1),
	Li2 = lado(Hi2, Zi2, Oi2, Gi2),	

	Ef = estado(Lf1, Lf2, CB),
	Lf1 = lado(Hf1, Zf1, Of1, Gf1),
	Lf2 = lado(Hf2, Zf2, Of2, Gf2),
	
	Oi2 =:= (CB-1),
	Of1 is Oi1 + (CB - 1),
	Of2 is Oi2 - (CB - 1),

	Hf1 is Hi2, Hf2 is Hi1,
	Zf1 is Zi1, Zf2 is Zi2,
	Gf1 is Gi1, Gf2 is Gi2,

%	M = '.: viaja el Hombre con ,'+Oi2+'Ocas del lado 2 al lado 1
%	:.',

	sin_problemas(Ef).

% viaje el Hombre con las Ocas de Ei a Ef cuando Ocas < CB-1
% y la cantidad de Granos y Zorras caben en el espacio vacio
ir_desde(Ei, Ef):-
	Ei = estado(Li1, Li2, CB),
	Li1 = lado(Hi1, Zi1, Oi1, Gi1),
	Li2 = lado(Hi2, Zi2, Oi2, Gi2),	

	Ef = estado(Lf1, Lf2, CB),
	Lf1 = lado(Hf1, Zf1, Of1, Gf1),
	Lf2 = lado(Hf2, Zf2, Of2, Gf2),

	% si las Ocas es menor que la capacidad del bote
	Oi1 < (CB-1), Gi1 =< (CB - 1) - Oi1, Zi1 =< (((CB - 1) - Oi1) - Gi1),
	% el granjero se lleva todas las Ocas, las Zorras y Granos que quepan en el bote
	Of1 is 0, Of2 is Oi2 + Oi1,
	Gf1 is 0, Gf2 is Gi2 + Gi1,
	Zf1 is 0, Zf2 is Zi2 + Zi1,

	Hf1 is Hi2, Hf2 is Hi1,

%M = '.: viaja el Hombre con '+Zi1+'Zorras,'+Oi1+'Ocas,'+Gi1+'Granos 
%del lado 1 al lado 2 :.',	
	sin_problemas(Ef).


% viaje el Hombre con las Ocas de Ei a Ef cuando Ocas < CB-1
% y la cantidad de Zorras cabe en el espacio vacio
ir_desde(Ei, Ef):-
	Ei = estado(Li1, Li2, CB),
	Li1 = lado(Hi1, Zi1, Oi1, Gi1),
	Li2 = lado(Hi2, Zi2, Oi2, Gi2),	

	Ef = estado(Lf1, Lf2, CB),
	Lf1 = lado(Hf1, Zf1, Of1, Gf1),
	Lf2 = lado(Hf2, Zf2, Of2, Gf2),

	% si las Ocas es menor que la capacidad del bote
	Oi1 < (CB-1), Zi1 =< (CB - 1) - Oi1,
	% el granjero se lleva todas las Ocas y las Zorras
	Of1 is 0, Of2 is Oi2 + Oi1,
	Zf1 is 0, Zf2 is Zi2 + Zi1,

	Hf1 is Hi2, Hf2 is Hi1,
	Gf1 is Gi1, Gf2 is Gi2,

%M = '.: viaja el Hombre con '+Zi1+'Zorras y '+Oi1+'Ocas del
% lado 1 al lado 2 :.',	
        sin_problemas(Ef).


% viaje el Hombre con las Ocas de Ei a Ef cuando Ocas < CB-1
% y la cantidad de Granos cabe en el espacio vacio
ir_desde(Ei, Ef):-
	Ei = estado(Li1, Li2, CB),
	Li1 = lado(Hi1, Zi1, Oi1, Gi1),
	Li2 = lado(Hi2, Zi2, Oi2, Gi2),	

	Ef = estado(Lf1, Lf2, CB),
	Lf1 = lado(Hf1, Zf1, Of1, Gf1),
	Lf2 = lado(Hf2, Zf2, Of2, Gf2),

	% si las Ocas es menor que la capacidad del bote
	Oi1 < (CB-1), Gi1 =< (CB - 1) - Oi1,
	% el granjero se lleva todas las Ocas y las Zorras
	Of1 is 0, Of2 is Oi2 + Oi1,
	Gf1 is 0, Gf2 is Gi2 + Gi1,

	Hf1 is Hi2, Hf2 is Hi1,
	Zf1 is Zi1, Zf2 is Zi2,

%	M = '.: viaja el Hombre con '+Oi1+'Ocas y '+Gi1+'Granos del lado
%	1 al lado 2 :.', 

	sin_problemas(Ef).


% viaje el Hombre con las Ocas de Ei a Ef cuando Ocas < CB-1
ir_desde(Ei, Ef):-
	Ei = estado(Li1, Li2, CB),
	Li1 = lado(Hi1, Zi1, Oi1, Gi1),
	Li2 = lado(Hi2, Zi2, Oi2, Gi2),	

	Ef = estado(Lf1, Lf2, CB),
	Lf1 = lado(Hf1, Zf1, Of1, Gf1),
	Lf2 = lado(Hf2, Zf2, Of2, Gf2),

	% si las Ocas es menor que la capacidad del bote
	Oi1 < (CB-1),
	% el granjero se lleva todas las Ocas
	Of1 is 0, 
	Of2 is Oi2 + Oi1,

	Hf1 is Hi2, Hf2 is Hi1,
	Zf1 is Zi1, Zf2 is Zi2,
	Gf1 is Gi1, Gf2 is Gi2,

%	M = '.: viaja el Hombre con '+Oi1+'Ocas del lado 1 al lado 2
%	:.',

	sin_problemas(Ef).	

% viaje el Hombre con las Ocas de Ef a Ei cuando Ocas < CB-1
ir_desde(Ei, Ef):-
	Ei = estado(Li1, Li2, CB),
	Li1 = lado(Hi1, Zi1, Oi1, Gi1),
	Li2 = lado(Hi2, Zi2, Oi2, Gi2),	

	Ef = estado(Lf1, Lf2, CB),
	Lf1 = lado(Hf1, Zf1, Of1, Gf1),
	Lf2 = lado(Hf2, Zf2, Of2, Gf2),

	% si las Ocas es menor que la capacidad del bote
	Oi2 < (CB-1),
	% el granjero se lleva todas las Ocas
	Of2 is 0, 
	Of1 is Oi2 + Oi1,

	Hf1 is Hi2, Hf2 is Hi1,
	Zf1 is Zi1, Zf2 is Zi2,
	Gf1 is Gi1, Gf2 is Gi2,

%	M = '.: viaja el Hombre con '+Oi2+'Ocas del lado 2 al lado 1
%	:.',

	sin_problemas(Ef).

% viaje el Hombre de Ei a Ef cuando Ocas < CB-1 y Zorras > CB-1
ir_desde(Ei, Ef):-
	Ei = estado(Li1, Li2, CB),
	Li1 = lado(Hi1, Zi1, Oi1, Gi1),
	Li2 = lado(Hi2, Zi2, Oi2, Gi2),

	Ef = estado(Lf1, Lf2, CB),
	Lf1 = lado(Hf1, Zf1, Of1, Gf1),
	Lf2 = lado(Hf2, Zf2, Of2, Gf2),
	
	% verifico que Ocas < CB-1 y Zorras > CB-1
	Oi1 < (CB - 1), Zi1 > (CB - 1),

	% muevo las ocas y las zorras que quepan en el bote
	Of1 is 0, Of2 is Oi1 + Oi2,
	Zf1 is Zi1 - ((CB - 1) - Oi1), Zf2 is Zi2 + ((CB - 1) - Oi1),

	Gf1 is Gi1, Gf2 is Gi2,
	Hf1 is Hi2, Hf2 is Hi1,

%	Zt is ((CB - 1) - Oi1),

%	M = '.: viaja el Hombre con '+Zt+'Zorras y '+Oi1+'Ocas del lado
%	1 al lado 2 :.',
	
	sin_problemas(Ef).


% viaja el Hombre de Ei a Ef cuando Ocas > CB-1 y no hay Ocas ni Zorras
% en la orilla que cargar
ir_desde(Ei, Ef):-
	Ei = estado(Li1, Li2, CB),
	Li1 = lado(Hi1, Zi1, Oi1, Gi1),
	Li2 = lado(Hi2, Zi2, Oi2, Gi2),	

	Ef = estado(Lf1, Lf2, CB),
	Lf1 = lado(Hf1, Zf1, Of1, Gf1),
	Lf2 = lado(Hf2, Zf2, Of2, Gf2),

	% si las Ocas es mayor que la capacidad del bote
	Oi1 >= (CB-1), Zi1 =:= 0, Gi1 =:= 0,
        % y no hay Zorras ni Granos en la orilla, el Hombre se lleva las Ocas que caben en el bote
	Of1 is Oi1 - (CB-1),
	Of2 is Oi2 + (CB-1),

	Hf1 is Hi2, Hf2 is Hi1,
	Zf1 is Zi1, Zf2 is Zi2,
	Gf1 is Gi1, Gf2 is Gi2,
%	Ot is Oi1 - (CB-1),

%	M = '.: viaja el Hombre con '+Ot+'Ocas del lado 1 al lado 2 :.',
	
	sin_problemas(Ef).

% viaje el Hombre de Ei a Ef con otro elemento cuando Ocas > CB-1
% y la suma de las Zorras y las Granos es < CB-1
ir_desde(Ei, Ef):-
	Ei = estado(Li1, Li2, CB),
	Li1 = lado(Hi1, Zi1, Oi1, Gi1),
	Li2 = lado(Hi2, Zi2, Oi2, Gi2),	

	Ef = estado(Lf1, Lf2, CB),
	Lf1 = lado(Hf1, Zf1, Of1, Gf1),
	Lf2 = lado(Hf2, Zf2, Of2, Gf2),

	% si las Ocas es mayor que la capacidad del bote
	Oi1 >= (CB-1), (Zi1 + Gi1) =< (CB-1),
	% y las Zorras + Granos < CB-1, el granjero se los lleva
	Zf1 is 0, Zf2 is Zi2 + Zi1,
	Gf1 is 0, Gf2 is Gi2 + Gi1,

	Hf1 is Hi2, Hf2 is Hi1,
	Of1 is Oi1, Of2 is Oi2,

%	M = '.: viaja el Hombre con '+Zi1+'Zorras y '+Gi1+'Granos del
%	lado 1 al lado 2 :.',
	
	sin_problemas(Ef).

% viaje el Hombre de Ef a Ei con otro elemento cuando Ocas > CB-1
% y la suma de las Zorras y las Granos es < CB-1
ir_desde(Ei, Ef):-
	Ei = estado(Li1, Li2, CB),
	Li1 = lado(Hi1, Zi1, Oi1, Gi1),
	Li2 = lado(Hi2, Zi2, Oi2, Gi2),	

	Ef = estado(Lf1, Lf2, CB),
	Lf1 = lado(Hf1, Zf1, Of1, Gf1),
	Lf2 = lado(Hf2, Zf2, Of2, Gf2),

	% si las Ocas es mayor que la capacidad del bote
	Oi2 >= (CB-1), (Zi2 + Gi2) =< (CB-1),
	% y las Zorras + Granos < CB-1, el granjero se los lleva
	Zf2 is 0, Zf1 is Zi2 + Zi1,
	Gf2 is 0, Gf1 is Gi2 + Gi1,

	Hf1 is Hi2, Hf2 is Hi1,
	Of1 is Oi1, Of2 is Oi2,	

%	M = '.: viaja el Hombre con '+Zi2+'Zorras y '+Gi2+'Granos del
%	lado 2 al lado 1 :.',

	sin_problemas(Ef).


% viaje el Hombre con las Zorras cuando Zorras = CB-1
ir_desde(Ei, Ef):-
	Ei = estado(Li1, Li2, CB),
	Li1 = lado(Hi1, Zi1, Oi1, Gi1),
	Li2 = lado(Hi2, Zi2, Oi2, Gi2),	

	Ef = estado(Lf1, Lf2, CB),
	Lf1 = lado(Hf1, Zf1, Of1, Gf1),
	Lf2 = lado(Hf2, Zf2, Of2, Gf2),
	
	Zi1 =:= (CB - 1),
	Zf1 is Zi1 - (CB - 1),
	Zf2 is Zi2 + (CB - 1),

	Hf1 is Hi2, Hf2 is Hi1,
	Of1 is Oi1, Of2 is Oi2,
	Gf1 is Gi1, Gf2 is Gi2,

%	M = '.: viaja el Hombre con '+Zi1+'Zorras del lado 1 al lado 2
%	:.',

	sin_problemas(Ef).

% viaje el Hombre con las Zorras cuando Zorras < CB-1 y caben Granos
ir_desde(Ei, Ef):-
	Ei = estado(Li1, Li2, CB),
	Li1 = lado(Hi1, Zi1, Oi1, Gi1),
	Li2 = lado(Hi2, Zi2, Oi2, Gi2),	

	Ef = estado(Lf1, Lf2, CB),
	Lf1 = lado(Hf1, Zf1, Of1, Gf1),
	Lf2 = lado(Hf2, Zf2, Of2, Gf2),
	% si las Zorras son menor que la capacidad del bote y caben Granos
	Zi1 < (CB - 1), Gi1 =< (CB - 1) - Zi1,
	% el granjero se lleva todas las zorras y los Granos que quepan
	Zf1 is 0, Zf2 is Zi2 + Zi1,
	Gf1 is 0, Gf2 is Gi2 + Gi1,

	Hf1 is Hi2, Hf2 is Hi1,
	Of1 is Oi1, Of2 is Oi2,	

%	M = '.: viaja el Hombre con '+Zi1+'Zorras y '+Gi1+' del lado 1
%	al lado 2 :.',

	sin_problemas(Ef).

% viaje el Hombre con las Zorras cuando Zorras < CB-1
ir_desde(Ei, Ef):-
	Ei = estado(Li1, Li2, CB),
	Li1 = lado(Hi1, Zi1, Oi1, Gi1),
	Li2 = lado(Hi2, Zi2, Oi2, Gi2),	

	Ef = estado(Lf1, Lf2, CB),
	Lf1 = lado(Hf1, Zf1, Of1, Gf1),
	Lf2 = lado(Hf2, Zf2, Of2, Gf2),
	% si las Zorras son menor que la capacidad del bote
	Zi1 < (CB - 1),
	% el granjero se lleva todas las zorras
	Zf1 is 0,
	Zf2 is Zi2 + Zi1,

	Hf1 is Hi2, Hf2 is Hi1,
	Of1 is Oi1, Of2 is Oi2,
	Gf1 is Gi1, Gf2 is Gi2,

%	M = '.: viaja el Hombre con '+Zi1+'Zorras del lado 1 al lado 2
%	:.',

	sin_problemas(Ef).



% viaje el Hombre con los Granos cuando Granos = CB-1
ir_desde(Ei, Ef):-
	Ei = estado(Li1, Li2, CB),
	Li1 = lado(Hi1, Zi1, Oi1, Gi1),
	Li2 = lado(Hi2, Zi2, Oi2, Gi2),	

	Ef = estado(Lf1, Lf2, CB),
	Lf1 = lado(Hf1, Zf1, Of1, Gf1),
	Lf2 = lado(Hf2, Zf2, Of2, Gf2),

	Gi1 =:= (CB - 1),
	Gf1 is Gi1 - (CB - 1),
	Gf2 is Gi2 + (CB - 1),

	Hf1 is Hi2, Hf2 is Hi1,
	Of1 is Oi1, Of2 is Oi2,
	Zf1 is Zi1, Zf2 is Zi2,

%	M = '.: viaja el Hombre con '+Gi1+'Granos del lado 1 al lado 2
%	:.',

	sin_problemas(Ef).

% viaje el Hombre con los Granos de Ei a Ef cuando Granos < CB-1 
% y caben Zorras
ir_desde(Ei, Ef):-
	Ei = estado(Li1, Li2, CB),
	Li1 = lado(Hi1, Zi1, Oi1, Gi1),
	Li2 = lado(Hi2, Zi2, Oi2, Gi2),	

	Ef = estado(Lf1, Lf2, CB),
	Lf1 = lado(Hf1, Zf1, Of1, Gf1),
	Lf2 = lado(Hf2, Zf2, Of2, Gf2),

	Gi1 < (CB - 1),  Zi1 =< (CB - 1) - Gi1,
	Gf1 is 0, Gf2 is Gi2 + Gi1,
	Zf1 is 0, Zf2 is Zi2 + Zi1,

	Hf1 is Hi2, Hf2 is Hi1,
	Of1 is Oi1, Of2 is Oi2,

%	M = '.: viaja el Hombre con '+Zi1+'Zorras y '+Gi1+'Granos del
%	lado 1 al lado 2 :.',

	sin_problemas(Ef).

% viaje el Hombre con los Granos de Ei a Ef cuando Granos < CB-1
ir_desde(Ei, Ef):-
	Ei = estado(Li1, Li2, CB),
	Li1 = lado(Hi1, Zi1, Oi1, Gi1),
	Li2 = lado(Hi2, Zi2, Oi2, Gi2),	

	Ef = estado(Lf1, Lf2, CB),
	Lf1 = lado(Hf1, Zf1, Of1, Gf1),
	Lf2 = lado(Hf2, Zf2, Of2, Gf2),

	Gi1 < (CB - 1), 
	Gf1 is 0,
	Gf2 is Gi2 + Gi1,

	Hf1 is Hi2, Hf2 is Hi1,
	Of1 is Oi1, Of2 is Oi2,
	Zf1 is Zi1, Zf2 is Zi2,

%	M = '.: viaja el Hombre con '+Gi1+'Granos del lado 1 al lado 2
%	:.',

	sin_problemas(Ef).

% viaje el Hombre con los Granos de Ei a  Ef cuando Granos > CB-1
ir_desde(Ei, Ef):-
	Ei = estado(Li1, Li2, CB),
	Li1 = lado(Hi1, Zi1, Oi1, Gi1),
	Li2 = lado(Hi2, Zi2, Oi2, Gi2),	

	Ef = estado(Lf1, Lf2, CB),
	Lf1 = lado(Hf1, Zf1, Of1, Gf1),
	Lf2 = lado(Hf2, Zf2, Of2, Gf2),

	Gi1 > (CB - 1), 
	Gf1 is Gi1 - (CB - 1),
	Gf2 is Gi2 + (CB - 1),

	Hf1 is Hi2, Hf2 is Hi1,
	Of1 is Oi1, Of2 is Oi2,
	Zf1 is Zi1, Zf2 is Zi2,
%	Gt is (CB - 1),
	
%	M = '.: viaja el Hombre con '+Gt+'Granos del lado 1 al lado 2
%	:.',

	sin_problemas(Ef).

% #endregion Datos del problema


mostrar([E]):-
	E = estado(L1, L2, _),
	L1 = lado(H1, Z1, O1, G1),
	L2 = lado(H2, Z2, O2, G2),	
	write(H1),write('\t'),write(Z1),write('\t'),write(O1),write('\t'),write(G1),
	write('   ----   '),
	write(H2),write('\t'),write(Z2),write('\t'),write(O2),write('\t'),write(G2),nl.
%	write('.: incialmente estan todos en el lado 1 :.'),nl.
mostrar([E|List]):-
	mostrar(List),
	E = estado(L1, L2, _),
	L1 = lado(H1, Z1, O1, G1),
	L2 = lado(H2, Z2, O2, G2),
	write(H1),write('\t'),write(Z1),write('\t'),write(O1),write('\t'),write(G1),
	write('   ----   '),
	write(H2),write('\t'),write(Z2),write('\t'),write(O2),write('\t'),write(G2),nl.
%	write(M),nl.



% resolver(E, C, R) realiza una busqueda en profundidad donde : 
%  E: Estado de partida
%  C: Camino recorrido (en reversa)
%  R: Camino total hasta la solucion (en reversa)
resolver(E, C, C) :- fin(E).
resolver(E, C, R) :- ir_desde(E, E1), not(member(E1, C)),
           resolver(E1, [E1|C], R).



solucion:- 
	nl,
	write(' .: Problema de la Zorra, la Oca, el Grano y el Hombre (version general) :.'),
	nl,nl,
	write('- Entrada de datos...'),nl,
	inicio(Ei),
	Ei = estado(Li, Lf, CB),
	Ef = estado(Lf, Li ,CB),
	fin(Ef),
	E = Ei,
	resolver(E, [E], R),nl,
	write('- Solucion encontrada mediante busqueda en profundidad...'),nl,
	write('\tLado 1'),write('\t\t\t'),write('\tLado 2'),nl,
	write('H\tZ\tO\tG'),
	write('          '),
	write('H\tZ\tO\tG'),nl,
	mostrar(R).
