function taylor2
% Serie de Taylor para seno(x)
syms x; 
% Declaramos x como una variable para trabajar con expresiones algebraicas
% Definimos la función seno
f = sin(x); 
% Función original a aproximar
% Definimos el punto de expansión (a = 0, para la serie de Taylor estándar de seno(x))
a = 0;
% Solicitamos el número de términos al usuario
num_terms = input('Ingrese el número de términos para la serie de Taylor: ');
if num_terms <= 0
error('El número de términos debe ser mayor a 0.');
end
% Inicializamos la Serie de Taylor
taylor_series = 0; % Variable para acumular los términos de la serie
% Calculamos la Serie de Taylor
fprintf('\nCálculo de la Serie de Taylor:\n');
for n = 0:num_terms-1
% Calculamos la n-ésima derivada de f(x)
f_n = diff(f, n); % Derivada de orden n
% Evaluamos la n-ésima derivada en el punto a
f_n_at_a = double(subs(f_n, x, a)); 
% Sustitución de x = a (evaluar la derivada)
% Calculamos el término n-ésimo de la serie
termino = (f_n_at_a / factorial(n)) * (x - a)^n;
% Agregamos el término a la serie acumulada
taylor_series = taylor_series + termino;
% Mostramos el término actual en consola
fprintf('Término %d: (%g / %d!) * (x - %g)^%d = %s\n', ...
n, f_n_at_a, n, a, n, char(termino));
end
% Mostramos la Serie Generada
fprintf('\nLa serie de Taylor para sin(x) es:\n');
pretty(taylor_series); % Mostrar la serie en un formato legible
% Graficamos la función seno y la serie de Taylor
% Definimos las funciones para graficar
f_plot = @(x_val) sin(x_val); % Función seno
taylor_plot = @(x_val) double(subs(taylor_series, x, x_val)); 
% Serie de Taylor evaluada
% Creamos un rango de valores para x
x_vals = linspace(-2*pi, 2*pi, 100); 
% Rango para graficar entre -2π y 2π
y_vals = f_plot(x_vals); % Valores reales de sin(x)
y_taylor_vals = taylor_plot(x_vals); % Valores de la serie de Taylor
% Generamos la gráfica
figure;
plot(x_vals, y_vals, 'b-', 'LineWidth', 1.5); % Graficamos seno(x) en azul
hold on;
plot(x_vals, y_taylor_vals, 'r--', 'LineWidth', 1.5); 
% Graficamos la serie en rojo punteado hold off;
% Etiquetas y título
title(sprintf('Función sin(x) y su Serie de Taylor (n = %d)', num_terms));
xlabel('x');
ylabel('y');
legend('sin(x)', 'Serie de Taylor');
grid on; % Activar la cuadrícula