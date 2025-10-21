function falsa_posicion

clc; clear; close all;

fprintf('*** MÉTODO DE FALSA POSICIÓN ***\n');

% Definimos la función a evaluar (puedes cambiarla)
f = @(x) x.^3 - 4*x + 1;  

% Solicitamos los datos al usuario
a = input('Ingrese el límite inferior (a): ');
b = input('Ingrese el límite superior (b): ');
tol = input('Ingrese la tolerancia (por ejemplo 1e-5): ');
max_iter = input('Ingrese el número máximo de iteraciones: ');

% Verificamos que haya un cambio de signo
if f(a) * f(b) > 0
    error('No hay cambio de signo en el intervalo. Intente con otro [a,b].');
end

% Inicializamos variables
iter = 0;
error_aprox = inf;

fprintf('\nIter\t a\t\t b\t\t xr\t\t f(xr)\t\t Error\n');
fprintf('-------------------------------------------------------------\n');

% Ciclo principal del método
while error_aprox > tol && iter < max_iter
    iter = iter + 1;
    
    % Fórmula de la falsa posición (interpolación lineal)
    xr = b - (f(b)*(a - b)) / (f(a) - f(b));
    f_xr = f(xr);
    
    % Cálculo del error
    if iter > 1
        error_aprox = abs(xr - xr_ant);
    end
    
    % Mostrar valores de cada iteración
    fprintf('%d\t %.6f\t %.6f\t %.6f\t %.6f\t %.6f\n', iter, a, b, xr, f_xr, error_aprox);
    
    % Verificar cambio de signo y actualizar intervalo
    if f(a)*f_xr < 0
        b = xr;
    else
        a = xr;
    end
    
    xr_ant = xr;
end

% Resultado final
fprintf('\nLa raíz aproximada es x = %.6f\n', xr);
fprintf('Número de iteraciones: %d\n', iter);
fprintf('Error aproximado: %.6e\n', error_aprox);

% Graficamos la función y la raíz encontrada
x_vals = linspace(a-1, b+1, 200);
y_vals = f(x_vals);
figure;
plot(x_vals, y_vals, 'b-', 'LineWidth', 1.5);
hold on;
plot(xr, f(xr), 'ro', 'MarkerSize', 8, 'LineWidth', 1.5);
yline(0, 'k--');
xlabel('x');
ylabel('f(x)');
title('Método de Falsa Posición (Regula Falsi)');
legend('f(x)', 'Raíz aproximada');
grid on;
hold off;
