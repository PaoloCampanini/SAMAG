function Sout = tagliaSegnale(Sin,inizio,fine)
%tagliaSegnale: Taglia il segnale di ingresso tra i due istanti di tempo
%   indicati.
%
%   INPUTS:
%   Sin: struct. Segnale da tagliare.
%   inizio: double. Istante di tempo in cui iniziare il taglio, in [s].
%   fine: double. Istante di tempo in cui termiare il taglio, in [s].
%
%   OUTPUTS:
%   Sout: struct. Segnale tagliato.

    primo_camp = ceil(Sin.f*inizio); % indice del primo campionamento del segnale tagliato
    ultimo_camp = floor(Sin.f*fine); % indice dell'ultimo campionamento del segnale tagliato
    
    Sout = tagliaSegnale2(Sin,primo_camp,ultimo_camp);
end