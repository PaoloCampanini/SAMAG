function S_t = tagliaSegnaleUtile_sv(S,n,soglia_inizio,soglia_fine,margine_inizio,margine_fine)
%tagliaSegnaleUtile_sv: Identifica l'inizio e la fine del sollevamento nel
%   dal segnale indicato e taglia la parte di segnale utile compresa.
%
%   INPUTS:
%   S: struct. Segnale con i valori di corrente acquisiti durante il test.
%   n: unsigned int. Ordine del filtro FIR usato per derivare il segnale di corrente. 
%       Sono ammessi valori da 2 a 8 per questo argomento.
%   soglia_inizio: double. Soglia definita come moltiplicatore del picco massimo
%       della derivata del segnale, usata per determinare l'inizio del
%       segnale utile. Valore ammissibile maggiore di 0 e minore o uguale a 1.
%   soglia_fine: double. Soglia definita come moltiplicatore del picco minimo
%       della derivata del segnale, usata per determinare la fine del
%       segnale utile. Valore ammissibile maggiore di 0 e minore o uguale a 1.
%   margine_inizio: double. L'inizio del segnale utile identificato
%       dalla funzione viene anticipato di questo tempo, in [s].
%   margine_fine: double. La fine del segnale utile identificato
%       dalla funzione viene posticipato di questo tempo, in [s]. 

    assert(soglia_inizio>0 && soglia_inizio<=1, "L'argomento 'inizio_soglia' deve essere maggiore di 0 e minore o uguale a 1")
    assert(soglia_fine>0 && soglia_fine<=1, "L'argomento 'fine_soglia' deve essere maggiore di 0 e minore o uguale a 1")

    S_d = derivaSegnale(S,n);
    [M,indice_M] = maxSegnale(S_d); % ('indice_M' non viene usato in questa funzione)
    [m,indice_m] = minSegnale(S_d); % ('indice_m' non viene usato in questa funzione)

    primo_camp = 1; % primo campionamento del segnale utile identificato
    while primo_camp<=S_d.N && S_d.s(primo_camp)<M*soglia_inizio % (<-ATTENZIONE se la prima condizione del ciclo è falsa la seconda non deve essere valutata)
        primo_camp = primo_camp+1;
    end

    ultimo_camp = S_d.N; % ultimo campionamento del segnale utile identificato
    while ultimo_camp>=1 && S_d.s(ultimo_camp)>m*soglia_fine % (<-ATTENZIONE se la prima condizione del ciclo è falsa la seconda non deve essere valutata)
        ultimo_camp = ultimo_camp-1;
    end

    S_t = tagliaSegnale2(S,primo_camp - margine_inizio*S.f,ultimo_camp + margine_fine*S.f);

end

