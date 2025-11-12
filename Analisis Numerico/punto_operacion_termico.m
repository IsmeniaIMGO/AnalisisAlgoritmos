%% ==============================================================
% PROYECTO: Determinación del punto de operación en un sistema de control térmico
% MÉTODOS: Bisección y Newton-Raphson
% Autor: [Ismenia - David]
% Fecha: [12 de noviembre del 2025]
% ==============================================================

clc; clear; close all;

%% -----------------------------
% Parámetros del sistema térmico
% -----------------------------
k = 5;          % Coeficiente logarítmico
alpha = 0.1;    % Coeficiente cuadrático
Q = 20;         % Flujo de calor constante

% Definición de la función y su derivada
f = @(T) k*log(T) + alpha*T.^2 - Q;
df = @(T) k./T + 2*alpha*T;

% Intervalo inicial (válido para Bisección)
a = 5; 
b = 10;

tol = 1e-6;           % Tolerancia deseada
maxIter = 100;        % Número máximo de iteraciones

%% ==============================================================
% MÉTODO DE BISECCIÓN
% ==============================================================

fprintf('---- MÉTODO DE BISECCIÓN ----\n');

iter_b = 0;
error_b = 1;
T_b = [];

if f(a)*f(b) > 0
    error('El intervalo no es válido: f(a)*f(b) > 0');
end

while error_b > tol && iter_b < maxIter
    iter_b = iter_b + 1;
    Tm = (a + b)/2;        % Punto medio
    T_b(iter_b) = Tm;      % Almacenar valor estimado
    if f(a)*f(Tm) < 0
        b = Tm;
    else
        a = Tm;
    end
    if iter_b > 1
        error_b = abs(T_b(iter_b) - T_b(iter_b-1));
    end
end

root_bisec = T_b(end);
fprintf('Raíz aproximada (Bisección): %.6f\n', root_bisec);
fprintf('Iteraciones: %d\n', iter_b);
fprintf('Error final: %.2e\n', error_b);

%% ==============================================================
% MÉTODO DE NEWTON-RAPHSON
% ==============================================================

fprintf('\n---- MÉTODO DE NEWTON-RAPHSON ----\n');

Tn = 3;  % Valor inicial (buena estimación dentro del intervalo)
iter_n = 0;
error_n = 1;
T_newton = Tn;

while error_n > tol && iter_n < maxIter
    iter_n = iter_n + 1;
    T_next = Tn - f(Tn)/df(Tn);
    error_n = abs(T_next - Tn);
    Tn = T_next;
    T_newton(iter_n+1) = Tn;
end

root_newton = Tn;
fprintf('Raíz aproximada (Newton): %.6f\n', root_newton);
fprintf('Iteraciones: %d\n', iter_n);
fprintf('Error final: %.2e\n', error_n);

%% ==============================================================
% TABLAS COMPARATIVAS DE ITERACIÓN Y ERROR
% ==============================================================

% Crear tablas para cada método
error_abs_b = [abs(diff(T_b)) NaN]; % igualamos longitud
Tabla_Biseccion = table((1:iter_b)', T_b', error_abs_b', ...
    'VariableNames', {'Iteración','Raíz_estimada','Error_absoluto'});

error_abs_n = [abs(diff(T_newton)) NaN];
Tabla_Newton = table((0:iter_n)', T_newton', error_abs_n', ...
    'VariableNames', {'Iteración','Raíz_estimada','Error_absoluto'});

disp(' ');
disp('TABLA - Método de Bisección');
disp(Tabla_Biseccion);

disp(' ');
disp('TABLA - Método de Newton-Raphson');
disp(Tabla_Newton);

%% ==============================================================
% COMPARACIÓN GLOBAL
% ==============================================================

fprintf('\n---- COMPARACIÓN DE MÉTODOS ----\n');
fprintf('Raíz (Bisección)     = %.6f\n', root_bisec);
fprintf('Raíz (Newton)        = %.6f\n', root_newton);
fprintf('Iteraciones (Bisección) = %d\n', iter_b);
fprintf('Iteraciones (Newton)    = %d\n', iter_n);

% Gráficas de convergencia
figure;
plot(1:iter_b, T_b, 'o-b','LineWidth',1.5); hold on;
plot(0:iter_n, T_newton, 's-r','LineWidth',1.5);
xlabel('Iteración');
ylabel('Raíz estimada T (°C)');
title('Evolución de la raíz estimada por iteración');
legend('Bisección','Newton-Raphson');
grid on;

% Gráfica de error
figure;
figure;
semilogy(1:length(diff(T_b)), abs(diff(T_b)),'-ob','LineWidth',1.5); hold on;
semilogy(1:length(diff(T_newton)), abs(diff(T_newton)),'-sr','LineWidth',1.5);
xlabel('Iteración');
ylabel('Error absoluto (escala log)');
title('Comparación del error por iteración');
legend('Bisección','Newton-Raphson');
grid on;


