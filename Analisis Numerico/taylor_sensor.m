%% ==============================================================
%  PROYECTO: Estimación del comportamiento térmico en un sensor digital
%  mediante aproximación de funciones trascendentales con series de Taylor
%  Autor: [Ismenia - David]
%  Fecha: [12 de noviembre del 2025]
%  ===============================================================
%  Objetivo:
%  Aproximar exp(x), sin(x) y ln(1+x) mediante series de Taylor
%  y comparar su error absoluto y relativo con los valores reales.
%  ==============================================================

clc; clear; close all;

%% -----------------------------
%  Parámetros de simulación
% -----------------------------
% Definimos los intervalos de estudio
x_exp = linspace(0,2,10);       % exp(x)
x_sin = linspace(0,pi,10);      % sin(x)
x_ln  = linspace(0,1,10);       % ln(1+x)

max_terms = 10;  % Máximo número de términos de la serie

%% ==============================================================
%  1. Aproximación de exp(x)
% ==============================================================

fprintf('\n---- APROXIMACIÓN DE exp(x) ----\n');

f_real = exp(x_exp);
errors_abs = zeros(max_terms, length(x_exp));
errors_rel = zeros(max_terms, length(x_exp));

for n = 1:max_terms
    % Serie de Taylor de exp(x): sum_{k=0}^n x^k / k!
    Tn = zeros(size(x_exp));
    for k = 0:n
        Tn = Tn + (x_exp.^k)/factorial(k);
    end

    % Errores
    errors_abs(n,:) = abs(f_real - Tn);
    errors_rel(n,:) = abs(f_real - Tn)./abs(f_real)*100;
end

% Mostrar tabla de error para n = 5 y n = 10
T_exp = table(x_exp', errors_abs(5,:)', errors_rel(5,:)', ...
    errors_abs(10,:)', errors_rel(10,:)','VariableNames', ...
    {'x','ErrorAbs_n5','ErrorRel_n5(%)','ErrorAbs_n10','ErrorRel_n10(%)'})

% Gráfica
figure;
plot(x_exp,f_real,'k','LineWidth',1.5); hold on;
for n = [2 4 6 8 10]
    Tn = zeros(size(x_exp));
    for k = 0:n
        Tn = Tn + (x_exp.^k)/factorial(k);
    end
    plot(x_exp,Tn,'--','DisplayName',['n=',num2str(n)]);
end
xlabel('x'); ylabel('f(x)');
title('Aproximación de e^x con series de Taylor');
legend show; grid on;

%% ==============================================================
%  2. Aproximación de sin(x)
% ==============================================================

fprintf('\n---- APROXIMACIÓN DE sin(x) ----\n');

f_real = sin(x_sin);
errors_abs = zeros(max_terms, length(x_sin));
errors_rel = zeros(max_terms, length(x_sin));

for n = 1:max_terms
    % Serie de Taylor: sum_{k=0}^n (-1)^k * x^(2k+1) / (2k+1)!
    Tn = zeros(size(x_sin));
    for k = 0:n
        Tn = Tn + (-1)^k * (x_sin.^(2*k+1)) / factorial(2*k+1);
    end

    errors_abs(n,:) = abs(f_real - Tn);
    errors_rel(n,:) = abs(f_real - Tn)./abs(f_real)*100;
end

T_sin = table(x_sin', errors_abs(5,:)', errors_rel(5,:)', ...
    errors_abs(10,:)', errors_rel(10,:)','VariableNames', ...
    {'x','ErrorAbs_n5','ErrorRel_n5(%)','ErrorAbs_n10','ErrorRel_n10(%)'})

figure;
plot(x_sin,f_real,'k','LineWidth',1.5); hold on;
for n = [2 4 6 8 10]
    Tn = zeros(size(x_sin));
    for k = 0:n
        Tn = Tn + (-1)^k * (x_sin.^(2*k+1)) / factorial(2*k+1);
    end
    plot(x_sin,Tn,'--','DisplayName',['n=',num2str(n)]);
end
xlabel('x'); ylabel('f(x)');
title('Aproximación de sin(x) con series de Taylor');
legend show; grid on;

%% ==============================================================
%  3. Aproximación de ln(1+x)
% ==============================================================

fprintf('\n---- APROXIMACIÓN DE ln(1+x) ----\n');

f_real = log(1 + x_ln);
errors_abs = zeros(max_terms, length(x_ln));
errors_rel = zeros(max_terms, length(x_ln));

for n = 1:max_terms
    % Serie de Taylor: sum_{k=1}^n (-1)^(k+1) * x^k / k
    Tn = zeros(size(x_ln));
    for k = 1:n
        Tn = Tn + ((-1)^(k+1)) * (x_ln.^k)/k;
    end

    errors_abs(n,:) = abs(f_real - Tn);
    errors_rel(n,:) = abs(f_real - Tn)./abs(f_real)*100;
end

T_ln = table(x_ln', errors_abs(5,:)', errors_rel(5,:)', ...
    errors_abs(10,:)', errors_rel(10,:)','VariableNames', ...
    {'x','ErrorAbs_n5','ErrorRel_n5(%)','ErrorAbs_n10','ErrorRel_n10(%)'})

figure;
plot(x_ln,f_real,'k','LineWidth',1.5); hold on;
for n = [2 4 6 8 10]
    Tn = zeros(size(x_ln));
    for k = 1:n
        Tn = Tn + ((-1)^(k+1)) * (x_ln.^k)/k;
    end
    plot(x_ln,Tn,'--','DisplayName',['n=',num2str(n)]);
end
xlabel('x'); ylabel('f(x)');
title('Aproximación de ln(1+x) con series de Taylor');
legend show; grid on;

%% ==============================================================
%  4. Análisis de convergencia
% ==============================================================

% Determinar número mínimo de términos para error < 0.01%
tol = 0.01; % %
fprintf('\n---- CONVERGENCIA ----\n');

% exp(x)
err_mean = mean(errors_rel,2);
idx = find(err_mean < tol, 1);
fprintf('exp(x): Se requiere n = %d términos para error < %.2f%%\n', idx, tol);

% sin(x)
err_mean = mean(errors_rel,2);
idx = find(err_mean < tol, 1);
fprintf('sin(x): Se requiere n = %d términos para error < %.2f%%\n', idx, tol);

% ln(1+x)
err_mean = mean(errors_rel,2);
idx = find(err_mean < tol, 1);
fprintf('ln(1+x): Se requiere n = %d términos para error < %.2f%%\n', idx, tol);
