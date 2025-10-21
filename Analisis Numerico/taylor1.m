function taylor1
% Con esta función calculamos la aproximación de e^x usando su serie de Taylor.
% Solicitamos los datos al usuario
n = input('Digite el número de términos de la serie (n): '); % Número detérminos
x = input('Digite el valor de x a evaluar: '); % Valor de x
% Inicializamos la suma de la serie
suma = 0;
% Calculamos la serie de Taylor término por término
fprintf('\nCálculo de la serie de Taylor para e^x:\n');
for i = 0:n
termino = (x^i) / factorial(i); % Calculamos el término i
suma = suma + termino; % Sumarlo a la suma total
fprintf('Término %d: (x^%d)/%d! = %.5f\n', i, i, i, termino); 
%Mostramos el término
end
% Mostramos el resultado final
fprintf('\nLa suma de la serie de Taylor para e^%.2f con n = %d es:%.5f\n', x, n, suma);