function [m,indice] = minSegnale(S)
%minSegnale: Ritorna il valore minimo del segnale e il numero del realtivo
%   campionamento.
%
%   INPUTS:
%   S: struct. Segnale di cui si vuole conoscere il valore minimo e relativo indice.
%
%   OUTPUTS:
%   m: double. Valore minimo del segnale.
%   indice: unsigned int. Numero del campionamento relativo al valore
%       minimo trovato ('S.s(indice)=m').

    assert(S.N >= 1, "Il segnale non contiene elementi")
    
    indice = 1;
    m = S.s(1);    
    for i=2:S.N
        if S.s(i) < m
            indice = i;
            m = S.s(i);
        end
    end
end

