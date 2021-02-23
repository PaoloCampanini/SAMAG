function Sout = traslaSegnale(Sin,offset_N,padding,conserva_durata)
%traslaSegnale: Trasla il segnale di 'offset_N' campionamenti.
%   Se 'offset_N' è negativo il segnale ritornato risulterà tagliato
%   all'inizio. In questo caso se 'conserva_durata=true' verranno aggiunti
%   elementi con valore 'padding' alla fine del segnale per conservarne la durata
%   originale, altrimenti il segnale risulterà di durata minore.
%   Se 'offset_N' è positivo verranno aggiunti campionamenti all'inizio con 
%   valore 'padding'. In questo caso se 'conserva_durata=true' il segnale ritornato 
%   risulterà tagliato alla fine per conservarne la durata originale, 
%   altrimenti il segnale risulterà di durata maggiore.
%
%   INPUTS:
%   Sin: struct. Segnale che si vuole traslare.
%   offset_N: int. Numero di campionamenti di cui si vuole traslare il segnale.
%   padding: double. Valore dei campionamenti che potrebbero essere aggiunti
%       all'inizio o alla fine del segnale.
%   conserva_durata: bool. Indica se il segnale traslato deve conservare la
%       stessa durata del segnale originale.
%
%   OUTPUTS:
%   Sout: struct. Segnale traslato.

    Sout.f = Sin.f;
    if conserva_durata == true
        Sout.N = Sin.N;        
    else
        Sout.N = Sin.N+offset_N;
    end
    
    if Sout.N<=0
        Sout.N=0;
        Sout.s = []; % vettore vuoto, nessun elemento
        return
    end
    
    for i=1:Sout.N
        if i-offset_N>=1 && i-offset_N<=Sin.N
            Sout.s(i) = Sin.s(i-offset_N);
        else
            Sout.s(i) = padding;
        end
    end
end

