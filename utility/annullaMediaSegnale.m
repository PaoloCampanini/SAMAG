function Sout = annullaMediaSegnale(Sin)
%annullaMediaSegnale: Sottrae al segnale il suo valore medio.
%   Il segnale ritornato avrà quindi valore medio nullo.
%
%   INPUTS:
%   Sin: struct. Segnale di cui si vuole annullare il valore medio.
%
%   OUTPUTS:
%   Sout: struct. Segnale con valore medio nullo, risultato dell'operazione.

    Sout = Sin; % copia il segnale originale
    
    if Sin.N <= 0 % segnale vuoto
        return 
    end
    
    media = mediaSegnale(Sin); % calcola il valore medio
    
    for i=1:Sout.N
        Sout.s(i) = Sin.s(i) - media;
    end
end

