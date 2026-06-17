clc;
clear;

Pn = 1.38e3;       % Puissance nominale [W]
P = 2;             % Nombre de paires de pôles (p=2)

Rs = 0.8;          % Résistance statorique [Ohm]
Ld = 1.10e-3;      % Inductance d'axe d [H] (1.10 mH)
Lq = 1.32e-3;      % Inductance d'axe q [H] (1.32 mH)

Phi_n = 0.15;       % Flux des aimants [Wb]
J = 0.9;       % Moment d'inertie [kg.m^2]
F = 0.59e-4;      % Coefficient de frottement visqueux [Nm/rd/s]


R = [Rs 0; 0 Rs];  % Matrice des résistances
L = [Ld 0; 0 Lq];  % Matrice des inductances
A = [0 -Lq; Ld 0]; % Matrice de couplage (termes croisés)
PhiF = [0 ; Phi_n];% Vecteur flux des aimants (selon votre convention précédente)

% clc;
% clear;
% 
% % Paramètres de la machine
% Rs = 0.6;          % Résistance statorique [Ohm]
% Ld = 1.4e-3;       % Inductance d'axe d [H]
% Lq = 2.8e-3;       % Inductance d'axe q [H]
% J = 0,0115;          % Moment d'inertie [kg.m^2]
% F = 0.0014;        % Coefficient de frottement visqueux
% P = 4;             % Nombre de pôles
% Fie = 0.2;         % Flux des aimants (Phi_f) [Wb]
% 
% % Définition des matrices du modèle d-q
% R = [Rs 0; 0 Rs];  % Matrice des résistances
% L = [Ld 0; 0 Lq];  % Matrice des inductances
% A = [0 -Lq; Ld 0]; % Matrice de couplage lié à la rotation
% PhiF = [0; Fie];   % Vecteur flux des aimants