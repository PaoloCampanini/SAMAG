function ind = Ind_minErroreQuadraticoMedio_sv(Sn,S)
%Ind_minErroreQuadraticoMedio_sv: Calcola 
%   Detailed explanation goes here

    assert(Sn.N>=1 && S.N>=1, "I segnali da utilizzare per il calcolo dell'indicatore non possono essere segnali vuoti")

    err2 = zeros(Sn.N+S.N-1,1); % alloco in memoria un vettore (Sn.N+S.N-1)x1 di double
    for i=1-S.N:Sn.N-1
        err2(i+S.N) = erroreQuadraticoMedio(Sn, S, i);
    end
    
    % converto il vettore 'err2' in un segnale per poterlo elaborare con le
    % altre funzioni
    Serr2.f = Sn.f; % (solo per conservare lo stesso asse del tempo degli altri segnali e compararli meglio)
    Serr2.s = err2;
    Serr2.N = length(err2); % numero di elementi del vettore 'err2'    
    
    finestra_minLocali = ceil(durataSegnale(Sn)*Sn.f/5); % (aumentare o ridurre questa finestra se si dovessero avere problemi nell'identificare il minimo corretto)
    [m_loc,indice,cont] = minLocaliSegnale(Serr2,finestra_minLocali);
    
    assert(cont>=1, "Errore nell'identificazione del minimo errore quadratico medio, nessun minimo trovato")
    
    % Cerco il minimo locale più vicino al campionamento centrale
    centro = ceil(Serr2.N/2); % indice del campionamento centrale
    min_dist_centro = abs(centro-indice(1)); % ('abs()' restituisce il modulo ovvero il valore assoluto)
    indice_min_dist_centro = 1;
    for i=2:cont
        if min_dist_centro>abs(centro-indice(i))
            min_dist_centro = abs(centro-indice(i));
            indice_min_dist_centro = i;
        end
    end
    
    ind = m_loc(indice_min_dist_centro);
    
    figure
    plotSegnale(Serr2);
    hold on
    plot(indice(indice_min_dist_centro)/Sn.f,m_loc(indice_min_dist_centro),'.')
end