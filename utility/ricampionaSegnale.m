function S = ricampionaSegnale(s, t, fc)
%ricampionaSegnale: La funzione riceve in input un segnale definito da un 
%   vettore con i valori dei campionamenti insieme a
%   un vettore con i tempi in cui ciascun campionamento è stato acquisito.
%   La funzione ricampiona il segnale alla frequenza di campionamento fissa
%   indicata.
%   Il nuovo primo campionamento sarà all'istante 'time=1/fc'. In base alla
%   frequenza di campionamento scelta il nuovo numero di campionamenti
%   potrebbe essere minore o maggiore del numero di campionamenti
%   originale.
%   Se la frequenza di campionamento indicata è minore o uguale a zero (non
%   valida) verrà utilizzata la frequenza media di acquisizione del segnale in
%   input.
%   I campionamenti del segnale ricampionato sono calcolati tramite
%   interpolazione lineare dei dati campionamenti originali.
%
%   INPUTS:
%   s: vettore Nx1 di double. Serie di campionamenti.
%   t: vettore Nx1 di double. Istanti di tempo in cui ciascun campionamento
%       è stato acquisito, in [s].
%   fc: double. Nuova frequenza di campionamento, in [Hz].
%
%   OUTPUTS:
%   S: struct. Segnale ricampionato.

    % Controlla validità argomenti
    assert(length(s) == length(t), "I vettori 's' e 't' devono avere lo stesso numero di elementi")
    
    N = length(s); % numero originale di campionamenti
    assert(N >= 2, "I vettori 's' e 't' devono contenere almeno due elementi")
    
    for i=1:N-1
        assert(t(i) < t(i+1), "I tempi indicati nel vettore 't' devono essere in ordine monotono crescente")
    end
        
    
    % Creo nuovo segnale
    if fc <= 0
        % non viene fornita una frequenza di campionamento, si calcola la
        % frequenza di campionamento media
        fc = (N-1)/(t(N)-t(1));
    end
    
    assert(fc>0, "La nuova frequenza di campionamento indicata non è valida")
    Tc = 1/fc; % periodo tra due campionamenti consecutivi
    
    S.f = fc;
    S.N = floor((t(N)-t(1))*fc + 1);
    S.s = zeros(S.N,1); % alloco in memoria un vettore di S.Nx1 double    
    
    
    
    % Shift del vettore dei tempi 't' in modo che 't(1)=1/fc=Tc'
    shift = t(1)-Tc;
    for i=1:N
        t(i) = t(i) - shift;
    end
    
    % Ricampionamento con interpolazione lineare
    S.s(1) = s(1); % il primo campionamento è copiato direttamente come primo elemento del nuovo segnale, primo istante di tempo 'time=1/fc=Tc'
    j = 2; % indice per scorrere il vettore 't'
    i = 2; % indice per scorrere i nuovi campionamenti a frequenza di campionamento fissa
    
    while i <= S.N
        % calcolare il valore del campionamento all'istante di tempo 'time=i/fc=i*Tc'
        
        while j<=N && t(j)<i*Tc % (<-ATTENZIONE se la prima condizione del ciclo è falsa la seconda non deve essere valutata)
            % scorri il vettore 't' finchè non trovi un campionamento avvenuto dopo l'istante di tempo che stiamo considerando
            j=j+1;
        end
        
        if j>N % questo 'if' serve per evitare possibili errori numerici nel confronto di double nel ciclo while precedente
            j=N; % potrebbero esserci degli errori numerici nel confronto di double per cui si verifica 't(N)<S.N*Tc' e quindi il ciclo while precedente esce perchè si verifica 'j>N'
        end
        
        S.s(i) = (s(j)-s(j-1))*(i*Tc-t(j-1))/(t(j)-t(j-1)) + s(j-1);
        i=i+1;
    end
    
%     figure
%     plot(t,s)
%     hold on
%     plotSegnale(S)
end

    
    
