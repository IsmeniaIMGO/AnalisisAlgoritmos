%% Integración Numérica - Tabla y Gráfica Comparativa (Trapecio vs Simpson)
% Script en español. Cambiar f1/f2, intervalos y n según se requiera.
clear; clc; close all;

%% --------- Parámetros y funciones (editar según necesidad) -------------
% Funciones: se pueden modificar por f = @(x) ... 
f1 = @(x) exp(x);          a1 = 0;  b1 = 1;    I_exacta_1 = exp(1) - 1;
f2 = @(x) sin(x);          a2 = 0;  b2 = pi;   I_exacta_2 = 2;

% Número de subintervalos (n debe ser par para aplicar Simpson 1/3)
n = 10;   
if mod(n,2) ~= 0
    error('n debe ser par para aplicar Simpson 1/3. Cambie n por un número par.');
end

%% ---------------- Cálculo para f1 ------------------------------------
h1 = (b1 - a1)/n;
x1 = linspace(a1, b1, n+1);
y1 = f1(x1);

% Trapecio compuesto
I_trap_1 = h1*( y1(1)/2 + sum(y1(2:end-1)) + y1(end)/2 );

% Simpson compuesto (n par)
I_simp_1 = (h1/3)*( y1(1) + 4*sum(y1(2:2:end-1)) + 2*sum(y1(3:2:end-2)) + y1(end) );

%% ---------------- Cálculo para f2 ------------------------------------
h2 = (b2 - a2)/n;
x2 = linspace(a2, b2, n+1);
y2 = f2(x2);

% Trapecio compuesto
I_trap_2 = h2*( y2(1)/2 + sum(y2(2:end-1)) + y2(end)/2 );

% Simpson compuesto (n par)
I_simp_2 = (h2/3)*( y2(1) + 4*sum(y2(2:2:end-1)) + 2*sum(y2(3:2:end-2)) + y2(end) );

%% ---------------- Errores ---------------------------------------------
EA_trap_1 = abs(I_exacta_1 - I_trap_1);
EA_simp_1 = abs(I_exacta_1 - I_simp_1);
ER_trap_1 = (EA_trap_1 / abs(I_exacta_1)) * 100;
ER_simp_1 = (EA_simp_1 / abs(I_exacta_1)) * 100;

EA_trap_2 = abs(I_exacta_2 - I_trap_2);
EA_simp_2 = abs(I_exacta_2 - I_simp_2);
ER_trap_2 = (EA_trap_2 / abs(I_exacta_2)) * 100;
ER_simp_2 = (EA_simp_2 / abs(I_exacta_2)) * 100;

%% ---------------- Construir la Tabla 1 --------------------------------
Tabla1 = table( ...
    ["exp(x)"; "sin(x)"], ...
    [I_exacta_1; I_exacta_2], ...
    [I_trap_1; I_trap_2], ...
    [I_simp_1; I_simp_2], ...
    [EA_trap_1; EA_trap_2], ...
    [EA_simp_1; EA_simp_2], ...
    [ER_trap_1; ER_trap_2], ...
    [ER_simp_1; ER_simp_2], ...
    'VariableNames', ...
    {'Funcion','Valor_Exacto','Trapecio','Simpson','EA_Trapecio','EA_Simpson','ER_Trapecio_%','ER_Simpson_%'} ...
);

disp('Tabla 1. Validación de resultados numéricos: Trapecio vs Simpson');
disp(Tabla1);

%% -------------- Gráfica comparativa para f1 ----------------------------
xx = linspace(a1, b1, 400);
yy = f1(xx);

figure('Name','Comparativa Trapecio vs Simpson - f1','NumberTitle','off');
plot(xx, yy, 'b', 'LineWidth', 1.8); hold on;
plot(x1, y1, 'ro', 'MarkerFaceColor','r');

% --- Sombreado Trapecio (amarillo) ---
for k = 1:length(x1)-1
    xtrap = [x1(k), x1(k+1), x1(k+1), x1(k)];
    ytrap = [0, 0, y1(k+1), y1(k)];
    fill(xtrap, ytrap, [1 0.85 0.2], 'FaceAlpha', 0.35, 'EdgeColor','none'); % amarillo claro
end

% --- Sombreado Simpson (cian) mediante polinomio cuadrático por bloques ---
for k = 1:2:(length(x1)-2)
    xs_local = linspace(x1(k), x1(k+2), 60);   % malla fina en el subintervalo doble
    % calcular polinomio cuadrático que interpola los tres puntos
    coeffs = polyfit(x1(k:k+2), y1(k:k+2), 2);
    ys_quad = polyval(coeffs, xs_local);
    fill([xs_local fliplr(xs_local)], [ys_quad zeros(size(ys_quad))], [0 0.8 1], 'FaceAlpha', 0.28, 'EdgeColor','none');
end

% estética y leyenda
title(sprintf('Comparativa Trapecio (amarillo) vs Simpson (cian) - %s',[func2str(f1)]));
xlabel('x'); ylabel('f(x)');
legend('Curva real','Puntos muestreo','Trapecio (áreas)','Simpson (áreas)','Location','BestOutside');
grid on;
hold off;

%% -------------- Gráfica comparativa para f2 ----------------------------
xx = linspace(a2, b2, 400);
yy = f2(xx);

figure('Name','Comparativa Trapecio vs Simpson - f2','NumberTitle','off');
plot(xx, yy, 'b', 'LineWidth', 1.8); hold on;
plot(x2, y2, 'ro', 'MarkerFaceColor','r');

% --- Sombreado Trapecio (amarillo) ---
for k = 1:length(x2)-1
    xtrap = [x2(k), x2(k+1), x2(k+1), x2(k)];
    ytrap = [0, 0, y2(k+1), y2(k)];
    fill(xtrap, ytrap, [1 0.85 0.2], 'FaceAlpha', 0.35, 'EdgeColor','none');
end

% --- Sombreado Simpson (cian) mediante polinomio cuadrático por bloques ---
for k = 1:2:(length(x2)-2)
    xs_local = linspace(x2(k), x2(k+2), 60);
    coeffs = polyfit(x2(k:k+2), y2(k:k+2), 2);
    ys_quad = polyval(coeffs, xs_local);
    fill([xs_local fliplr(xs_local)], [ys_quad zeros(size(ys_quad))], [0 0.8 1], 'FaceAlpha', 0.28, 'EdgeColor','none');
end

title(sprintf('Comparativa Trapecio (amarillo) vs Simpson (cian) - %s',[func2str(f2)]));
xlabel('x'); ylabel('f(x)');
legend('Curva real','Puntos muestreo','Trapecio (áreas)','Simpson (áreas)','Location','BestOutside');
grid on;
hold off;

%% ---------------- Comentarios finales --------------------------------
% - Trapecio: se sombrean trapezoides exactamente con sus vértices en (x_i, f(x_i)).
% - Simpson: se sombrean las parábolas aproximadas (polinomio cuadrático interpolante en cada par de subintervalos).
% - Cambiar f1, f2, a1,b1,a2,b2 y n según se necesite; recordar n par para Simpson.