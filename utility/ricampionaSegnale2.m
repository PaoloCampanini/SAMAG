function Sout = ricampionaSegnale2(Sin, fc)
%ricampionaSegnale2: Ricampiona il segnale con una nuova frequenza di
%   campionamento.
%   In base alla frequenza di campionamento scelta il nuovo numero di campionamenti
%   potrebbe essere minore o maggiore del numero di campionamenti originale.
%   I campionamenti del segnale ricampionato sono calcolati tramite
%   interpolazione lineare dei dati campionamenti originali.
%
%   INPUTS:
%   Sin: struct. Segnale da ricampionare.
%   fc: double. Nuova frequenza di campionamento, in [Hz].
%
%   OUTPUTS:
%   Sout: struct. Segnale ricampionato.

    % Controlla validità argomenti
    assert(Sin.N >= 2, "I segnale da ricampionare deve contenere almeno due elementi")
    assert(fc>0, "La nuova frequenza di campionamento indicata non è valida")
    assert(fc >= 2*Sin.f/Sin.N, "La nuova frequenza di campionamento indicata è eccessivamente bassa")
        
    % Modifica del segnale da ricampionare per poter sfruttare la funzione
    % "ricampionaSegnale"
    
    tin = asseTempoSegnale(Sin); % Asse dei tempi del segnale originale
    Tc = 1/fc; % periodo tra due campionamenti consecutivi
        
    if Sin.f >= fc               
        % cerca il primo campionamento del segnale originale che segue nel
        % tempo il primo campionamento del nuovo segnale
        j = 2;        
        while j<=Sin.N && tin(j)<=Tc % (<-ATTENZIONE se la prima condizione del ciclo è falsa la seconda non deve essere valutata)
            j=j+1;
        end
        
        % calcolo tramite interpolazione lineare il valore del primo
        % campionamento del nuovo segnale e inserisco nel segnale originale
        
        Sin.s(j-1) = (Sin.s(j)-Sin.s(j-1))*(Sin.f*Tc - j+1) + Sin.s(j-1);
        tin(j-1) = Tc;
        
        % taglio il segnale originale dove ho effettuato la sostituzione
        s = Sin.s(j-1:Sin.N); % (creo una copia del vettore dal suo elemento con indice 'j-1' in poi)
        t = tin(j-1:Sin.N); % (creo una copia del vettore dal suo elemento con indice 'j-1' in poi)
        
    else
        % calcolo tramite interpolazione lineare i primi campionamenti 
        % del nuovo segnale che precedono nel tempo il primo campionamento
        % del segnale originale
        Npre = ceil(fc/Sin.f-1);
        s_app = zeros(Npre,1); % alloco in memoria un vettore Nprex1 di double
        t_app = zeros(Npre,1); % alloco in memoria un vettore Nprex1 di double
        
        for i=1:Npre
            t_app(i) = i*Tc;
            s_app(i) = (Sin.s(2)-Sin.s(1))*(t_app(i)*Sin.f - 1) + Sin.s(1);            
        end
        
        % Aggiungo all'inizio del segnale originale i nuovi campionamenti
        % appena calcolati
        
        s = [s_app; Sin.s]; % vettore (Npre+Sin.N)x1 di double
        t = [t_app; tin]; % vettore (Npre+Sin.N)x1 di double        
    end    
    
    Sout = ricampionaSegnale(s, t, fc); 
end