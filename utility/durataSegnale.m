function T = durataSegnale(S)
%durataSegnale: Ritorna la durata del segnale.
%
%   INPUTS:
%   S: struct. Segnale di cui si vuole conoscere la durata.
%
%   OUTPUTS:
%   T: double. Durata, in [s].

    assert(S.f>0, "Il segnale indicato ha una frequenza di campionamento negativa o nulla")

    T = S.N/S.f;
end

