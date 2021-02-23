function err2 = erroreQuadraticoMedio(S1, S2, offset)
%erroreQuadraticoMedio: Calcola l'errore quadratico medio tra due segnali.
%   Il secondo segnale può essere traslato rispetto al primo di 'offset' campionamenti
%   in entrambe le direzioni.
%   Se 'offset=0' il primo campionamento del primo segnale è allineato con
%   il primo campionamento del secondo segnale.
%   Solo la parte per cui i due segnali risultano sovrapposti viene
%   considerata per il calcolo dell'errore quadratico medio.
%
%   INPUTS:
%   S1: struct. Primo segnale.
%   S2: struct. Secondo segnale.
%   offset: int. Numero di campionamenti di cui traslare il secondo segnale.
%
%   OUTPUTS:
%   err2: double. Errore quadratico medio.
    
    assert(S1.f == S2.f, "I due segnali devono avere la stessa frequenza di campionamento")
    assert(S1.N>=1 && S2.N>=1, "Uno o entrambi i segnali non contengono elementi")
    
    primo_camp_S1 = 1;
    ultimo_camp_S1 = S1.N;
    primo_camp_S2 = 1+offset;
    ultimo_camp_S2 = S2.N+offset;
    
    if primo_camp_S1 < primo_camp_S2    
        primo_camp = primo_camp_S2;
    else
        primo_camp = primo_camp_S1;
    end
    
    if ultimo_camp_S1 > ultimo_camp_S2    
        ultimo_camp = ultimo_camp_S2;
    else
        ultimo_camp = ultimo_camp_S1;
    end
        
    err2 = 0;
    for i=primo_camp:ultimo_camp
        err2 = err2 + (S1.s(i)-S2.s(i-offset))^2;
    end
    
    err2 = err2/S1.N;
end