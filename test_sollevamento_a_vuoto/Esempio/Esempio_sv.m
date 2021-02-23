%% ESEMPIO TEST DI DIAGNOSTICA "SOLLEVAMENTO A VUOTO"

%% Carica segnale nominale e segnali acquisiti
close all;
clear all;
load('pesi/T_sol_0_t5s.mat') % usato come segnale nominale in questo esempio
load('pesi/T_sol_22_t5s.mat') % usato come segnale acquisito in questo esempio

figure
plot(T_sol_0_t5s(:,1)./1000,T_sol_0_t5s(:,2))
hold on
plot(T_sol_22_t5s(:,1)./1000,T_sol_22_t5s(:,2))
title('Segnale nominale e acquisito grezzi')
xlabel('tempo [s]');
ylabel('corrente')
legend('nom','acq')

% Ricampiono il segnale nominale ad una frequenza di campionamento fissa
Sn = ricampionaSegnale(T_sol_0_t5s(:,2), T_sol_0_t5s(:,1)./1000,0);

% Ricampiono il segnale acquisito ad una frequenza di campionamento fissa
% uguale a quella del segnale nominale
S = ricampionaSegnale(T_sol_22_t5s(:,2), T_sol_22_t5s(:,1)./1000,Sn.f);

figure
plotSegnale(Sn);
hold on;
ylabel('corrente')
plotSegnale(S)
title('Segnale nominale e segnale acquisito dopo ricampionamento')
legend('nom','acq')


%% Elaborazione del segnale nominale

n_d = 8; % ordine del filtro FIR per derivata prima
inizio_soglia = 0.7; % (0,1], soglia come moltiplicatore per determinare l'inizio del segnale utile
fine_soglia = 0.7; % (0,1], soglia come moltiplicatore per determinare la fine del segnale utile
margine_inizio = 1; % [s] margine di tempo aggiunto all'inizio del segnale utile identificato
margine_fine = 1; % [s] margine di tempo aggiunto alla fine del segnale utile identificato

Sn_t = tagliaSegnaleUtile_sv(Sn,n_d,inizio_soglia,fine_soglia,margine_inizio,margine_fine);
Sn_d = derivaSegnale(Sn,n_d);

figure
plotSegnale(Sn);
hold on;
plotSegnale(Sn_d);
title('Derivata prima del segnale nominale')

figure
plotSegnale(Sn_t);
title('Parte utile del segnale nominale')



%% Elaborazione del segnale acquisito

n_d = 8; % ordine del filtro FIR per derivata prima
inizio_soglia = 0.7; % (0,1], soglia come moltiplicatore per determinare l'inizio del segnale utile
fine_soglia = 0.7; % (0,1], soglia come moltiplicatore per determinare la fine del segnale utile
margine_inizio = 1; % [s] margine di tempo aggiunto all'inizio del segnale utile identificato
margine_fine = 1; % [s] margine di tempo aggiunto alla fine del segnale utile identificato

S_t = tagliaSegnaleUtile_sv(S,n_d,inizio_soglia,fine_soglia,margine_inizio,margine_fine);
S_d = derivaSegnale(S,n_d);

figure
plotSegnale(S);
hold on;
plotSegnale(S_d);
title('Derivata prima del segnale acquisito')

figure
plotSegnale(S_t);
title('Parte utile del segnale acquisito')


%% Calcolo indice "Errore QuadraticoMedio"

%S_t.s = S_t.s*1.6;
%S_t = traslaSegnale(S_t,50,0,false);
%S_t = addNoise(S_t,0.00001,0.001);

figure
plotSegnale(Sn_t);
hold on
plotSegnale(S_t);

ind = Ind_minErroreQuadraticoMedio_sv(Sn_t,S_t)

