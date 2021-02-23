function out = plotSegnale(S,varargin)
%plotSegnale: Plotta un segnale.
%
%   INPUTS:
%   S: struct. Segnale da plottare.
%   varargin: argomenti per funzione di Matlab 'plot'. 
%             https://it.mathworks.com/help/matlab/ref/plot.html#btzitot_sep_mw_3a76f056-2882-44d7-8e73-c695c0c54ca8
%
%   Es. plotSegnale(S1,'b-','LineWidth',3)
    
    out = plot(asseTempoSegnale(S),S.s,varargin{:});
    xlabel('tempo [s]');
end