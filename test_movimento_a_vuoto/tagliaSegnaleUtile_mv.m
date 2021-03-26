function S_t = tagliaSegnaleUtile_mv(S,n,soglia_inizio,durata,margine_inizio)
%tagliaSegnaleUtile_mv: Identifica l'inizio e la fine del sollevamento nel
%   dal segnale indicato e taglia la parte di segnale utile compresa.
%
%   INPUTS:
%   S: struct. Segnale con i valori di corrente acquisiti durante il test.
%   n: unsigned int. Ordine del filtro FIR usato per derivare il segnale di corrente. 
%       Sono ammessi valori da 2 a 8 per questo argomento.
%   soglia_inizio: double. Soglia definita come moltiplicatore del picco massimo
%       della derivata del segnale, usata per determinare l'inizio del
%       segnale utile. Valore ammissibile maggiore di 0 e minore o uguale a 1.
%   durata: double. L'inizio del segnale utile viene identificato
%       automaticamente dalla funzione, la fine invece viene determinata da
%       questo parametro, in [s].
%   margine_inizio: double. L'inizio del segnale utile identificato
%       dalla funzione viene anticipato di questo tempo, in [s]. Il segnale
%       tagliato avrà una durata totale uguale a 'margine_inizio+durata'.

    assert(soglia_inizio>0 && soglia_inizio<=1, "L'argomento 'inizio_soglia' deve essere maggiore di 0 e minore o uguale a 1")
    assert(durata>0, " L'argometno 'durata' deve essere un valore positivo")

    S_d = derivaSegnale(S,n);
    [M,indice_M] = maxSegnale(S_d); % ('indice_M' non viene usato in questa funzione)

    primo_camp = 1; % primo campionamento del segnale utile identificato
    while primo_camp<=S_d.N && S_d.s(primo_camp)<M*soglia_inizio % (<-ATTENZIONE se la prima condizione del ciclo è falsa la seconda non deve essere valutata)
        primo_camp = primo_camp+1;
    end
    
    S_t = tagliaSegnale2(S,primo_camp - margine_inizio*S.f,primo_camp + durata*S.f);

end

