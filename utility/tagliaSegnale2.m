function Sout = tagliaSegnale2(Sin,primo_camp,ultimo_camp)
%tagliaSegnale2: Taglia il segnale di ingresso tra i due campionamenti
%   indicati.
%
%   INPUTS:
%   Sin: struct. Segnale da tagliare.
%   primo_camp: double. Primo campionamento. Tutti i campionamenti
%       precedenti vengono tagliati.
%   ultimo_camp: double. Ultimo campionamento. Tutti i campionamenti
%       Successivi vengono tagliati.
%
%   OUTPUTS:
%   Sout: struct. Segnale tagliato.

    % Converti gli indici del primo e ultimo campionamento da tagliare da double a int
    primo_camp = ceil(primo_camp);
    ultimo_camp = floor(ultimo_camp);
    
    if primo_camp < 1
        primo_camp = 1;
    end
    
    if ultimo_camp > Sin.N
        ultimo_camp = Sin.N;
    end
    
    Sout.f = Sin.f;
    Sout.N = ultimo_camp - primo_camp + 1;
    
    if Sout.N <= 0
        Sout.N = 0;
        Sout.s = []; % vettore vuoto, nessun elemento
        return
    end
    
    Sout.s = zeros(Sout.N,1); % alloca in memoria un vettore Sout.Nx1 di double
    
    for i=1:Sout.N
        Sout.s(i) = Sin.s(i+primo_camp-1);
    end
end