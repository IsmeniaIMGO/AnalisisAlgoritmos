%% ==============================================================
% PROYECTO: Estimación de la temperatura mediante interpolación de Lagrange
% AUTOR: [Ismenia - David]
% FECHA: [12 de noviembre del 2025]
% ==============================================================
clc; clear; close all;

%% ------------------------------------------------------------
% 1. DATOS DEL PROBLEMA
% ------------------------------------------------------------
% Puntos de medición (posición en cm y temperatura en °C)
x = [0 10 20 30];
y = [22.0 24.5 27.8 31.2];

% Punto a interpolar
x_interp = 15;         % cm
valor_real = 26.0;     % °C (valor simulado real para comparación)

%% ------------------------------------------------------------
% 2. FUNCIÓN DE INTERPOLACIÓN DE LAGRANGE
% ------------------------------------------------------------
% Implementación manual de la fórmula de Lagrange
function P = lagrange_interp(x, y, x_eval)
    n = length(x);
    P = 0;
    for i = 1:n
        L = 1;
        for j = 1:n
            if j ~= i
                L = L * (x_eval - x(j)) / (x(i) - x(j));
            end
        end
        P = P + y(i) * L;
    end
end

%% ------------------------------------------------------------
% 3. EVALUACIÓN USANDO DIFERENTE NÚMERO DE PUNTOS
% ------------------------------------------------------------

% (a) Usando 2 puntos cercanos (10 y 20 cm)
x2 = [10 20];
y2 = [24.5 27.8];
interp2 = lagrange_interp(x2, y2, x_interp);

% (b) Usando 3 puntos (0, 10 y 20 cm)
x3 = [0 10 20];
y3 = [22.0 24.5 27.8];
interp3 = lagrange_interp(x3, y3, x_interp);

% (c) Usando los 4 puntos
interp4 = lagrange_interp(x, y, x_interp);

%% ------------------------------------------------------------
% 4. CÁLCULO DE ERRORES
% ------------------------------------------------------------
% Error absoluto y relativo (%)
error_abs_2 = abs(valor_real - interp2);
error_abs_3 = abs(valor_real - interp3);
error_abs_4 = abs(valor_real - interp4);

error_rel_2 = (error_abs_2 / valor_real) * 100;
error_rel_3 = (error_abs_3 / valor_real) * 100;
error_rel_4 = (error_abs_4 / valor_real) * 100;

%% ------------------------------------------------------------
% 5. TABLAS COMPARATIVAS DE RESULTADOS
% ------------------------------------------------------------
Tabla_Errores = table([2;3;4], [interp2;interp3;interp4], ...
    [valor_real;valor_real;valor_real], ...
    [error_abs_2;error_abs_3;error_abs_4], ...
    [error_rel_2;error_rel_3;error_rel_4], ...
    'VariableNames', {'Nro_Puntos','Valor_Interpolado','Valor_Real','Error_Absoluto','Error_Relativo(%)'});

disp('--- TABLA DE RESULTADOS DE INTERPOLACIÓN ---');
disp(Tabla_Errores);

%% ------------------------------------------------------------
% 6. GRAFICAS DE VALIDACIÓN
% ------------------------------------------------------------

% Rango de posiciones para graficar el polinomio interpolado (4 puntos)
x_plot = linspace(0,30,100);
y_plot = zeros(size(x_plot));

for k = 1:length(x_plot)
    y_plot(k) = lagrange_interp(x, y, x_plot(k));
end

% Gráfica principal
figure;
plot(x, y, 'or', 'MarkerFaceColor','r', 'DisplayName','Puntos medidos'); hold on;
plot(x_plot, y_plot, '-b', 'LineWidth',1.5, 'DisplayName','Polinomio de Lagrange (4 pts)');
plot(x_interp, interp4, 'ks', 'MarkerFaceColor','y', 'DisplayName','Punto interpolado');
xlabel('Posición (cm)');
ylabel('Temperatura (°C)');
title('Interpolación de Lagrange - Estimación de temperatura');
legend show; grid on;

% Gráfica del error en función del número de puntos
figure;
bar([2 3 4], [error_rel_2 error_rel_3 error_rel_4]);
xlabel('Número de puntos usados');
ylabel('Error relativo (%)');
title('Comportamiento del error en función del número de puntos');
grid on;
