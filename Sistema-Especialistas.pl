%----------------------DADOS----------------------
% paciente(Nome, Temperatura, Frequência Cardíaca, Frequência Respiratória, Pressão Arterial, Saturação Oxigênio, Dispnéia, Idade, Comorbidades)
paciente(ander, 37.1, 87, 17, 95, 98, false, 22, 1). %*****GRAVE*****
paciente(apolo, 36.6, 107, 27, 115, 103, false, 64, 0).  %*****GRAVE*****
paciente(gusman, 36, 90, 16, 120, 96, false, 37, 1). %*****LEVE*****
paciente(lucrecia, 35, 97, 10, 184, 95, false, 54, 0). %*****LEVE*****
paciente(cayetana, 38.3, 165, 28, 102, 96, true, 16, 1).  %*****GRAVE*****
paciente(samuel, 35, 97, 10, 184, 95, false, 36, 0). %*****LEVE*****
%********TESTE COM DADOS REAIS********%
paciente(pessoa1, 36, 81, 99, 180, 95, true, 79, 2). %*****GRAVE*****
%----------------------END-DADOS----------------------

%----------------------REGRAS----------------------
temperatura_media(N):-paciente(N,T,_,_,_,_,_,_,_), T < 35 ; paciente(N,T,_,_,_,_,_,_,_), T >= 37, paciente(N,T,_,_,_,_,_,_,_), T =< 39.
temperatura_alta(N):-paciente(N,T,_,_,_,_,_,_,_), T > 39.
frequencia_cardiaca(N):-paciente(N,_,FC,_,_,_,_,_,_), FC > 100.
frequencia_respiratoria(N):-paciente(N,_,_,FR,_,_,_,_,_), FR > 30.
pressao_arterial(N):-paciente(N,_,_,_,PA,_,_,_,_), PA < 100.
saturacao_oxigenio(N):-paciente(N,_,_,_,_,SAO,_,_,_), SAO < 95.
dispneia(N):-paciente(N,_,_,_,_,_,D,_,_), D = true.
idade_media(N):-paciente(N,_,_,_,_,_,_,I,_), I >= 60, paciente(N,_,_,_,_,_,_,I,_), I =< 79.
idade_alta(N):-paciente(N,_,_,_,_,_,_,I,_), I > 80.
comorbidade(N):-paciente(N,_,_,_,_,_,_,_,C), C > 1.
%----------------------END-REGRAS----------------------

%----------------------DIAGNOSTICO----------------------
classificacao_grave(X):-
    ((temperatura_alta(X); 
    frequencia_cardiaca(X); 
    frequencia_respiratoria(X);
    pressao_arterial(X);
    saturacao_oxigenio(X); 
    dispneia(X); 
    idade_alta(X);  
    comorbidade(X))
    ;   
    (temperatura_media(X),
    (frequencia_cardiaca(X); 
    frequencia_respiratoria(X);
    pressao_arterial(X);
    saturacao_oxigenio(X); 
    dispneia(X); 
    idade_alta(X);  
    comorbidade(X)))
    ;
    (idade_media(X) ,(temperatura_alta(X); 
    frequencia_cardiaca(X); 
    frequencia_respiratoria(X);
    pressao_arterial(X);
    saturacao_oxigenio(X); 
    dispneia(X); 
    comorbidade(X)))).

classificacao_leve(X):- 
    not(temperatura_alta(X)), 
	not(frequencia_cardiaca(X)), 
    not(frequencia_respiratoria(X)),
	not(pressao_arterial(X)), 
    not(saturacao_oxigenio(X)), 
	not(dispneia(X)), 
    not(idade_alta(X)), 
    not(comorbidade(X)).

resultado_leve(X):- 
    write("O paciente "), write(X), write(" deve ficar em casa, em observação por 14 dias.\n").

resultado_grave(X):-
    write("O paciente "), write(X), write(" deve ser encaminhado para o hospital\n").

diagnostico(X):-
    classificacao_leve(X) -> resultado_leve(X);
    classificacao_grave(X) -> resultado_grave(X).
%----------------------END-DIAGNOSTICO----------------------
