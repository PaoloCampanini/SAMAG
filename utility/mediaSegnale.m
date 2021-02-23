function media = mediaSegnale(S)
%mediaSegnale: Ritorna il valore medio del segnale.
%
%   INPUTS:
%   S: struct. Segnale di cui si vuole calcolare il valore medio.
%
%   OUTPUTS:
%   media: double. Valore medio del segnale.

    assert(S.N>=1, "Il segnale di cui si vuole calcolare il valore medio non contiene campionamenti")
    
    temp = 0;
    for i=1:S.N
        temp = temp + S.s(i);
    end
    
    media = temp/S.N;
end

