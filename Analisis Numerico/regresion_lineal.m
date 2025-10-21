
function regresion_lineal

clc; clear; close all;

fprintf('*** REGRESIÓN LINEAL ***\n');

% Ingreso de datos experimentales
% (Puedes modificarlos o leerlos desde un archivo)
x = input('Ingrese los valores de x (entre corchetes [ ]): ');
y = input('Ingrese los valores de y (entre corchetes [ ]): ');

% Verificamos que los vectores tengan la misma longitud
if length(x) ~= length(y)
    error('Los vectores x e y deben tener el mismo número de elementos.');
end

n = length(x);

% Cálculos de los parámetros de la recta y = a0 + a1*x
sum_x = sum(x);
sum_y = sum(y);
sum_xy = sum(x .* y);
sum_x2 = sum(x .^ 2);

a1 = (n * sum_xy - sum_x * sum_y) / (n * sum_x2 - sum_x^2);
a0 = mean(y) - a1 * mean(x);

% Cálculo de valores ajustados y error
y_pred = a0 + a1 * x;
error = y - y_pred;

% Cálculo del coeficiente de correlación (R)
r = (n * sum_xy - sum_x * sum_y) / sqrt((n * sum_x2 - sum_x^2) * (n * sum(y.^2) - sum_y^2));

% Mostramos los resultados
fprintf('\nEcuación de la recta: y = %.4f + %.4f*x\n', a0, a1);
fprintf('Coeficiente de correlación (r): %.4f\n', r);

% Graficar los datos y la línea de regresión
figure;
scatter(x, y, 'filled'); % Datos experimentales
hold on;
plot(x, y_pred, 'r-', 'LineWidth', 2); % Línea de regresión
xlabel('Valores de x');
ylabel('Valores de y');
title('Regresión Lineal');
legend('Datos experimentales', 'Línea de regresión');
grid on;
hold off;
end