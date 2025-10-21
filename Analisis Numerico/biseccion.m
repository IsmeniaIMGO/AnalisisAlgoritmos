function biseccion

clc; clear; close all;

fprintf('*** MÉTODO DE BISECCIÓN ***\n');

% Definimos la función a evaluar
% Puedes cambiar esta función por la que desees analizar
f = @(x) x.^3 - 4*x + 1;  

% Pedimos al usuario el intervalo inicial
a = input('Ingrese el límite inferior (a): ');
b = input('Ingrese el límite superior (b): ');
tol = input('Ingrese la tolerancia (por ejemplo 1e-5): ');
max_iter = input('Ingrese el número máximo de iteraciones: ');

% Verificamos que haya un cambio de signo en el intervalo
if f(a) * f(b) > 0
    error('No hay cambio de signo en el intervalo. Intente con otro [a,b].');
end

% Inicializamos variables
iter = 0;
error_aprox = inf;

fprintf('\nIter\t a\t\t b\t\t x_medio\t f(x_medio)\t Error\n');
fprintf('-------------------------------------------------------------\n');

% Ciclo del método
while error_aprox > tol && iter < max_iter
    iter = iter + 1;
    x_m = (a + b)/2;         % Punto medio
    f_xm = f(x_m);
    
    % Mostrar los valores en cada iteración
    if iter > 1
        error_aprox = abs(x_m - x_ant);
    end
    fprintf('%d\t %.6f\t %.6f\t %.6f\t %.6f\t %.6f\n', iter, a, b, x_m, f_xm, error_aprox);
    
    % Verificar el signo para actualizar el intervalo
    if f(a)*f_xm < 0
        b = x_m;
    else
        a = x_m;
    end
    
    x_ant = x_m;
end

% Resultado final
fprintf('\nLa raíz aproximada es x = %.6f\n', x_m);
fprintf('Número de iteraciones: %d\n', iter);
fprintf('Error aproximado: %.6e\n', error_aprox);

% Graficamos la función y la raíz encontrada
x_vals = linspace(a-1, b+1, 200);
y_vals = f(x_vals);
figure;
plot(x_vals, y_vals, 'b-', 'LineWidth', 1.5);
hold on;
plot(x_m, f(x_m), 'ro', 'MarkerSize', 8, 'LineWidth', 1.5);
yline(0, 'k--');
xlabel('x');
ylabel('f(x)');
title('Método de Bisección');
legend('f(x)', 'Raíz aproximada');
grid on;
hold off;
