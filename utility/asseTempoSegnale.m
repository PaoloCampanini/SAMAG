function t = asseTempoSegnale(S)
%asseTempoSegnale: Ritorna un vettore contenente gli
%   istanti di tempo in cui il segnale � stato campionato.
%   Il primo elemento del vettore dei tempi 't' � 't=1/f' mentre l'ultimo � 't=T', dove
%   'f' � la frequenza di campionamento del segnale mentre 'T' � la sua durata totale.
%   Il primo campionamento avviene quindi in corrispondenza dell'istante 't=1/f' mentre
%   l'ultimo campionamento in corrispondenza dell'istante 't=T'. Il segnale
%   si considera iniziare all'istante 't=0'.
%
%   INPUTS:
%   S: struct. Segnale di cui si vuole conoscere gli istanti di tempo in cui
%       � stato campionato.
%
%   OUTPUTS:
%   t: vettore Nx1 di double dove N � il numero di campionamenti del segnale 'S'.
%       Istanti di tempo in cui il segnale � stato campionato, in [s].
    
    if S.N <= 0
        % se il segnale fornito come argomento non contiene campionamenti
        % ritornare un vettore vuoto
        t = [];
        return
    end
    
    t = zeros(S.N,1); % alloco in memoria un vettore S.Nx1 di double
    Tc = 1/S.f;
    for i=1:S.N
        t(i) = i*Tc;
    end
end

