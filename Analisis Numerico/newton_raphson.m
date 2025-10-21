function newton_raphson

clc; clear; close all;

fprintf('*** MÉTODO DE NEWTON-RAPHSON ***\n');

% Definimos la función (puedes cambiarla según el caso)
syms x;
f = x^3 - 4*x + 1;  % Ejemplo de función no lineal

% Calculamos la derivada simbólica
df = diff(f, x);

% Convertimos a funciones numéricas
f_num = matlabFunction(f);
df_num = matlabFunction(df);

% Solicitamos datos al usuario
x0 = input('Ingrese el valor inicial (x0): ');
tol = input('Ingrese la tolerancia (por ejemplo 1e-5): ');
max_iter = input('Ingrese el número máximo de iteraciones: ');

% Inicializamos variables
iter = 0;
error_aprox = inf;

fprintf('\nIter\t x\t\t f(x)\t\t f''(x)\t\t Error\n');
fprintf('-----------------------------------------------------------\n');

% Ciclo iterativo
while error_aprox > tol && iter < max_iter
    iter = iter + 1;
    
    fx = f_num(x0);
    dfx = df_num(x0);
    
    % Evitar división por cero
    if dfx == 0
        error('La derivada se anuló. El método no puede continuar.');
    end
    
    % Cálculo del nuevo valor
    x1 = x0 - fx/dfx;
    
    % Cálculo del error
    if iter > 1
        error_aprox = abs(x1 - x0);
    end
    
    % Mostrar valores por iteración
    fprintf('%d\t %.6f\t %.6f\t %.6f\t %.6f\n', iter, x0, fx, dfx, error_aprox);
    
    % Actualizar el valor
    x0 = x1;
end

% Resultado final
fprintf('\nLa raíz aproximada es x = %.6f\n', x1);
fprintf('Número de iteraciones: %d\n', iter);
fprintf('Error aproximado: %.6e\n', error_aprox);

% Graficamos la función y la raíz
x_vals = linspace(x1 - 2, x1 + 2, 200);
y_vals = f_num(x_vals);
figure;
plot(x_vals, y_vals, 'b-', 'LineWidth', 1.5);
hold on;
plot(x1, f_num(x1), 'ro', 'MarkerSize', 8, 'LineWidth', 1.5);
yline(0, 'k--');
xlabel('x');
ylabel('f(x)');
title('Método de Newton-Raphson');
legend('f(x)', 'Raíz aproximada');
grid on;
hold off;
