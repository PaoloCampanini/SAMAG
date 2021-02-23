function Sd = derivaSegnale(Sin,n)
%derivaSegnale: Deriva il segnale applicando un filtro FIR della lunghezza indicata.
%
%   INPUTS:
%   Sin: struct. Segnale da derivare.
%   n: unsigned int. Lunghezza del filtro. 
%       Lunghezza della finestra usata dal filtro in numero di campionamenti consecutivi.
%       Sono ammessi valori da 2 a 8 per questo argomento.
%
%   OUTPUTS:
%   Sd: struct. Derivata del segnale. Non è possibile calcolare la derivata 
%       dei primi 'floor(n/2)' e degli ultimi 'n-floor(n/2)' campionamenti.
%       Per conservare la stessa durata e l'asse del tempo questi campionamenti
%       vengono settati a zero.
%       ('froor()' -> arrotondamento verso meno infinito)

    assert(Sin.N>=n, "Il segnale da derivare non ha abbastanza campionamenti")

    switch n
        case 2
            coeff = [1 -1];
        case 3
            coeff = [0.5 0 -0.5];
        case 4
            coeff = [0.3 0.1 -0.1 -0.3];
        case 5
            coeff = [0.2 0.1 0 -0.1 -0.2];    
        case 6
            coeff = [1/7 3/35 1/35 -1/35 -3/35 -1/7];
        case 7
            coeff = [3/28 1/14 1/28 0 -1/28 -1/14 -3/28];
        case 8
            coeff = [1/12 5/84 1/28 1/84 -1/84 -1/28 -5/84 -1/12];
        otherwise
            error("Sono ammessi valori da 2 a 8 per la lunghezza della finestra del filtro FIR")
            return
    end    
    
    coeff = coeff*Sin.f;
    
    Sd = Sin; % copia il segnale da derivare
    Sd.s(:) = 0; % inizializza tutti i valori a zero    
    
    % y(k) = coeff(1)*u(k)+coeff(2)*u(k-1)+...+coeff(n)*u(k-n+1),   k = n,...,Sd.N
    for i=n:Sd.N
        for j=1:n
            Sd.s(i) = Sd.s(i) + coeff(j)*Sin.s(i-j+1);
        end
    end
    
    % correggi l'asse del tempo della derivata del segnale con una traslazione
    Sd = traslaSegnale(Sd,-floor((n-1)/2),0,true);
    
end

