%% ==============================================================
% PROYECTO: Modelado del consumo energético en función de la temperatura
% MÉTODOS: Regresión Lineal y Regresión Cuadrática
% Autor: [Ismenia - David]
% Fecha: [12 de noviembre del 2025]
% ==============================================================

clc; clear; close all;

%% -----------------------------
% 1. GENERACIÓN DE DATOS SIMULADOS
% -----------------------------
% Temperaturas entre 10 y 35 °C
T = linspace(10,35,20)'; 

% Modelo teórico del consumo (simulación)
% Supongamos que el consumo aumenta con la temperatura, con ligera curvatura
% y un poco de ruido aleatorio (simula datos reales)
consumo_real = 0.2*T.^2 - 3*T + 80 + randn(size(T))*2;

% Visualización de los datos simulados
figure;
scatter(T, consumo_real, 60, 'filled');
xlabel('Temperatura (°C)');
ylabel('Consumo energético (kWh)');
title('Datos simulados de consumo energético');
grid on;

%% -----------------------------
% 2. MODELO DE REGRESIÓN LINEAL
% -----------------------------
% Ajuste lineal: y = a1*x + a0
coef_lineal = polyfit(T, consumo_real, 1);
consumo_lineal = polyval(coef_lineal, T);

% Cálculo de métricas de ajuste
resid_lineal = consumo_real - consumo_lineal;
ECM_lineal = mean(resid_lineal.^2);        % Error cuadrático medio
EAM_lineal = mean(abs(resid_lineal));      % Error absoluto medio
R2_lineal = 1 - sum(resid_lineal.^2)/sum((consumo_real - mean(consumo_real)).^2);

%% -----------------------------
% 3. MODELO DE REGRESIÓN CUADRÁTICA
% -----------------------------
% Ajuste cuadrático: y = a2*x^2 + a1*x + a0
coef_cuad = polyfit(T, consumo_real, 2);
consumo_cuad = polyval(coef_cuad, T);

% Cálculo de métricas de ajuste
resid_cuad = consumo_real - consumo_cuad;
ECM_cuad = mean(resid_cuad.^2);
EAM_cuad = mean(abs(resid_cuad));
R2_cuad = 1 - sum(resid_cuad.^2)/sum((consumo_real - mean(consumo_real)).^2);

%% -----------------------------
% 4. TABLAS DE RESULTADOS
% -----------------------------
% Comparación de valores reales y predichos (primeros 10)
Tabla_Prediccion = table(T(1:10), consumo_real(1:10), ...
    consumo_lineal(1:10), consumo_cuad(1:10), ...
    abs(consumo_real(1:10) - consumo_lineal(1:10)), ...
    abs(consumo_real(1:10) - consumo_cuad(1:10)), ...
    'VariableNames', {'Temp_(°C)','Consumo_real','Modelo_Lineal','Modelo_Cuadrático', ...
    'ErrorAbs_Lineal','ErrorAbs_Cuadrático'});

disp('--- TABLA DE PREDICCIÓN Y ERRORES ---');
disp(Tabla_Prediccion);

% Tabla comparativa de métricas globales
Tabla_Metricas = table({'Lineal';'Cuadrática'}, [ECM_lineal; ECM_cuad], ...
    [EAM_lineal; EAM_cuad], [R2_lineal; R2_cuad], ...
    'VariableNames', {'Modelo','ECM','EAM','R2'});

disp('--- TABLA DE MÉTRICAS DE AJUSTE ---');
disp(Tabla_Metricas);

%% -----------------------------
% 5. GRAFICAS COMPARATIVAS
% -----------------------------
figure;
scatter(T, consumo_real, 60, 'filled', 'DisplayName','Datos reales'); hold on;
plot(T, consumo_lineal, '-r', 'LineWidth',1.5, 'DisplayName','Regresión lineal');
plot(T, consumo_cuad, '--b', 'LineWidth',1.5, 'DisplayName','Regresión cuadrática');
xlabel('Temperatura (°C)');
ylabel('Consumo energético (kWh)');
title('Comparación de modelos de regresión');
legend show; grid on;

% Gráfica de residuos
figure;
subplot(2,1,1);
stem(T, resid_lineal, 'r','filled');
xlabel('Temperatura (°C)'); ylabel('Residuo (kWh)');
title('Residuos - Modelo Lineal'); grid on;

subplot(2,1,2);
stem(T, resid_cuad, 'b','filled');
xlabel('Temperatura (°C)'); ylabel('Residuo (kWh)');
title('Residuos - Modelo Cuadrático'); grid on;

%% -----------------------------
% 6. IMPRESIÓN DE CONCLUSIONES NUMÉRICAS
% -----------------------------
fprintf('\n---- RESULTADOS GLOBALES ----\n');
fprintf('Modelo Lineal: ECM = %.4f, EAM = %.4f, R2 = %.4f\n', ECM_lineal, EAM_lineal, R2_lineal);
fprintf('Modelo Cuadrático: ECM = %.4f, EAM = %.4f, R2 = %.4f\n', ECM_cuad, EAM_cuad, R2_cuad);
