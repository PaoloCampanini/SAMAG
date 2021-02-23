function [M,indice] = maxSegnale(S)
%maxSegnale: Ritorna il valore massimo del segnale e il numero del realtivo
%   campionamento.
%
%   INPUTS:
%   S: struct. Segnale di cui si vuole conoscere il valore massimo e relativo indice.
%
%   OUTPUTS:
%   M: double. Valore massimo del segnale.
%   indice: unsigned int. Numero del campionamento relativo al valore
%       massimo trovato ('S.s(indice)=M').
    
    assert(S.N >= 1, "Il segnale non contiene elementi")
    
    indice = 1;
    M = S.s(1);    
    for i=2:S.N
        if S.s(i) > M
            indice = i;
            M = S.s(i);
        end
    end
end

