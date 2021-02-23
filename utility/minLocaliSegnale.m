function [m_loc,indice,cont] = minLocaliSegnale(S,n)
%minLocaliSegnale: Ritorna un vettore con i valori dei minimi locali e un
%   vettore con i numeri dei relativi campionamenti. Un campionamento è un
%   minimo locale se tutti i precedenti 'n' e i successivi 'n' campionamenti
%   hanno valore strettamente maggiore.
%
%   INPUTS:
%   S: struct. Segnale di cui si vogliono conoscere i minimi locali e i relativi indici.
%   n: unsigned int. Un campionamento è considerato un minimo locale se 
%       tutti i precedenti 'n' e i successivi 'n' campionamenti
%       hanno valore strettamente maggiore. Questo argomento può assumere
%       valori maggiori o uguali a 1.
%
%   OUTPUTS:
%   M_loc: vettore di double di lunghezza variabile. Minimi locali del segnale.
%   indice: vettore di unsigned int di lunghezza variabile. Indici dei campionamenti
%       identificati come minimi locali (es. 'S.s(indice(1)=m_loc(1))' primo minimo locale trovato).
%   cont: unsigned int. Numero di minimi locali trovati, ovvero numero di
%       elementi dei due vettori ritornati.

    assert(n>=1,"E' richiesto n>=1")
    
    cont = 0;
    m_loc = zeros(ceil(S.N/2),1); % alloca in memoria un vettore di ceil(S.N/2)x1 double
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
        
        minimo = true; % inizializzo la flag a 'true'
        
        for j=inizio_finestra:i-1 % controllo campionamenti precedenti a 'i'
            if S.s(j)<=S.s(i)
                minimo = false;
                break % Interrompi ciclo for
            end
        end
        
        if minimo==true
            for j=i+1:fine_finestra % controllo campionamenti successivi a 'i'
                if S.s(j)<=S.s(i)
                    minimo = false;
                    break % Interrompi ciclo for
                end
            end            
        end       
        
        if minimo==true % ho trovato un massimo locale
            cont = cont+1;
            m_loc(cont) = S.s(i);
            indice(cont) = i;
        end
    end
    
    % ridimensiono i vettori da restituire in base alle loro dimensioni
    % effettive
    % (Nota: questa operazione potrebbe non essere fattibile in altri
    % linguaggi di programmazione. Non è comunque un'operazione obbligatoria dal momento
    % che si ritorna anche la variabile 'cont', il contatore di minimi locali
    % trovati, ovvero il numero di elementi nei due vettori ritornati)
    if cont+1<=length(m_loc)
        m_loc(cont+1:length(m_loc))=[];
        indice(cont+1:length(indice))=[];
    end
end