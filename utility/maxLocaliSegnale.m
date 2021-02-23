function [M_loc,indice,cont] = maxLocaliSegnale(S,n)
%maxLocaliSegnale: Ritorna un vettore con i valori dei massimi locali e un
%   vettore con i numeri dei relativi campionamenti. Un campionamento è un
%   massimo locale se tutti i precedenti 'n' e i successivi 'n' campionamenti
%   hanno valore strettamente minore.
%
%   INPUTS:
%   S: struct. Segnale di cui si vogliono conoscere i massimi locali e i relativi indici.
%   n: unsigned int. Un campionamento è considerato un massimo locale se 
%       tutti i precedenti 'n' e i successivi 'n' campionamenti
%       hanno valore strettamente minore. Questo argomento può assumere
%       valori maggiori o uguali a 1.
%
%   OUTPUTS:
%   M_loc: vettore di double di lunghezza variabile. Massimi locali del segnale.
%   indice: vettore di unsigned int di lunghezza variabile. Indici dei campionamenti
%       identificati come massimi locali (es. 'S.s(indice(1)=M_loc(1))' primo massimo locale trovato).
%   cont: unsigned int. Numero di massimi locali trovati, ovvero numero di
%       elementi dei due vettori ritornati.

    assert(n>=1,"E' richiesto n>=1")
    
    cont = 0;
    M_loc = zeros(ceil(S.N/2),1); % alloca in memoria un vettore di ceil(S.N/2)x1 double
    indice = zeros(ceil(S.N/2),1); % alloca in memoria un vettore di ceil(S.N/2)x1 unsigned int

    for i=1:S.N
        
        if i-n<=1 % inizio_finestra=max(1,i-n)
            inizio_finestra = 1;
        else
            inizio_finestra = i-n;
        end
        
        if S.N<=i+n % fine_finestra = min(S.N,i+n)
            fine_finestra = S.N;
        else
            fine_finestra = i+n;
        end        
        
        massimo = true; % inizializzo la flag a 'true'
        
        for j=inizio_finestra:i-1 % controllo campionamenti precedenti a 'i'
            if S.s(j)>=S.s(i)
                massimo = false;
                break % Interrompi ciclo for
            end
        end
        
        if massimo==true
            for j=i+1:fine_finestra % controllo campionamenti successivi a 'i'
                if S.s(j)>=S.s(i)
                    massimo = false;
                    break % Interrompi ciclo for
                end
            end            
        end       
        
        if massimo==true % ho trovato un massimo locale
            cont = cont+1;
            M_loc(cont) = S.s(i);
            indice(cont) = i;
        end
    end
    
    % ridimensiono i vettori da restituire in base alle loro dimensioni
    % effettive
    % (Nota: questa operazione potrebbe non essere fattibile in altri
    % linguaggi di programmazione. Non è comunque un'operazione obbligatoria dal momento
    % che si ritorna anche la variabile 'cont', il contatore di massimi locali
    % trovati, ovvero il numero di elementi nei due vettori ritornati)
    if cont+1<=length(M_loc)
        M_loc(cont+1:length(M_loc))=[];
        indice(cont+1:length(indice))=[];
    end
end