
function regresion_cuadratica

clc; clear; close all;

fprintf('*** REGRESIÓN CUADRÁTICA ***\n');

% Ingreso de datos experimentales
x = input('Ingrese los valores de x (entre corchetes [ ]): ');
y = input('Ingrese los valores de y (entre corchetes [ ]): ');

% Verificamos que los vectores tengan la misma longitud
if length(x) ~= length(y)
    error('Los vectores x e y deben tener el mismo número de elementos.');
end

n = length(x);

% Construimos el sistema de ecuaciones normales para a0, a1 y a2
Sx = sum(x);
Sx2 = sum(x.^2);
Sx3 = sum(x.^3);
Sx4 = sum(x.^4);
Sy = sum(y);
Sxy = sum(x .* y);
Sx2y = sum(x.^2 .* y);

% Matriz del sistema
A = [n, Sx, Sx2;
     Sx, Sx2, Sx3;
     Sx2, Sx3, Sx4];

% Vector del lado derecho
B = [Sy; Sxy; Sx2y];

% Resolución del sistema
coef = A\B;
a0 = coef(1);
a1 = coef(2);
a2 = coef(3);

% Cálculo de valores ajustados
y_pred = a0 + a1*x + a2*x.^2;
error = y - y_pred;

% Cálculo del coeficiente de determinación R^2
St = sum((y - mean(y)).^2);
Sr = sum((y - y_pred).^2);
r2 = 1 - (Sr / St); % Corrección en el cálculo de R^2
r = sqrt(r2);

% Mostrar resultados
fprintf('\nEcuación del modelo cuadrático: y = %.4f + %.4f*x + %.4f*x^2\n', a0, a1, a2);
fprintf('Coeficiente de determinación (R^2): %.4f\n', r2);
fprintf('Coeficiente de correlación (R): %.4f\n', r);

% Tabla de resultados
fprintf('\nTabla de valores:\n');
fprintf('x\t\t y\t\t y_ajustada\t Error\n');
fprintf('----------------------------------------------\n');
for i = 1:n
    fprintf('%.4f\t %.4f\t %.4f\t %.4f\n', x(i), y(i), y_pred(i), error(i));
end

% Graficamos los datos y la curva ajustada
x_fit = linspace(min(x), max(x), 200);
y_fit = a0 + a1*x_fit + a2*x_fit.^2;

figure;
plot(x, y, 'bo', 'MarkerFaceColor', 'b'); hold on;
plot(x_fit, y_fit, 'r-', 'LineWidth', 1.5);
xlabel('x');
ylabel('y');
title('Regresión Cuadrática - Ajuste de Datos');
legend('Datos experimentales', 'Curva ajustada', 'Location', 'best');
grid on;

% Interpretación del resultado
if r2 > 0.9
    fprintf('\nEl modelo tiene un excelente ajuste a los datos.\n');
elseif r2 > 0.7
    fprintf('\nEl modelo tiene un ajuste aceptable a los datos.\n');
else
    fprintf('\nEl modelo no representa bien los datos.\n');
end

end