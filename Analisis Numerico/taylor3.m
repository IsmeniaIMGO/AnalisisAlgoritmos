function taylor3

clc; clear; close all;

% Declaramos variable simbólica
syms x;

% Definimos la función original
f = log(1 + x);  % ln(1 + x)

% Definimos el punto de expansión (a = 0)
a = 0;

% Solicitamos el número de términos al usuario
num_terms = input('Ingrese el número de términos para la serie de Taylor: ');
if num_terms <= 0
    error('El número de términos debe ser mayor a 0.');
end

% Inicializamos la serie de Taylor
taylor_series = 0;

fprintf('\nCálculo de la Serie de Taylor para ln(1 + x):\n');

% Cálculo de los términos de la serie de Taylor
for n = 1:num_terms
    % Derivada n-ésima de f(x)
    f_n = diff(f, n);
    % Evaluamos la derivada en a = 0
    f_n_at_a = double(subs(f_n, x, a));
    % Término n-ésimo de la serie
    termino = (f_n_at_a / factorial(n)) * (x - a)^n;
    % Acumulamos los términos
    taylor_series = taylor_series + termino;
    % Mostramos el término actual
    fprintf('Término %d: (%.5f/%d!) * (x - %.1f)^%d = %s\n', ...
        n, f_n_at_a, n, a, n, char(termino));
end

% Mostramos la serie generada
fprintf('\nSerie de Taylor para ln(1 + x) con n = %d términos:\n', num_terms);
pretty(taylor_series);

% Definimos las funciones para graficar
f_plot = @(x_val) log(1 + x_val); % Función original
taylor_plot = @(x_val) double(subs(taylor_series, x, x_val)); % Serie

% Rango para graficar (la serie converge para -1 < x ≤ 1)
x_vals = linspace(-0.9, 1, 200);
y_vals = f_plot(x_vals);
y_taylor_vals = taylor_plot(x_vals);

% Graficamos la función y la serie
figure;
plot(x_vals, y_vals, 'b-', 'LineWidth', 1.5);
hold on;
plot(x_vals, y_taylor_vals, 'r--', 'LineWidth', 1.5);
hold off;

% Etiquetas y leyenda
title(sprintf('Aproximación de ln(1 + x) mediante Serie de Taylor (n = %d)', num_terms));
xlabel('x');
ylabel('y');
legend('ln(1 + x)', 'Serie de Taylor', 'Location', 'best');
grid on;

