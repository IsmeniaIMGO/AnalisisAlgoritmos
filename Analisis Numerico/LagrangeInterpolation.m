
function LagrangeInterpolation
    % Definición de los puntos de datos
    x = [1, 2, 3, 4]; % Puntos x
    y = [1, 4, 9, 16]; % Puntos y (por ejemplo, y = x^2)

    % Valor en el que se desea interpolar
    x_interp = 2.5; 

    % Calcular el valor interpolado
    y_interp = lagrange(x, y, x_interp);

    % Mostrar el resultado
    fprintf('El valor interpolado en x = %.2f es y = %.2f\n', x_interp, y_interp);

    % Graficar los puntos y el polinomio interpolante
    x_fit = linspace(min(x), max(x), 100);
    y_fit = arrayfun(@(xi) lagrange(x, y, xi), x_fit);

    figure;
    plot(x, y, 'ro', 'MarkerFaceColor', 'r'); hold on;
    plot(x_fit, y_fit, 'b-', 'LineWidth', 1.5);
    xlabel('x');
    ylabel('y');
    title('Interpolación de Lagrange');
    legend('Puntos de datos', 'Polinomio interpolante', 'Location', 'best');
    grid on;
end

function y_interp = lagrange(x, y, x_interp)
    % Función para calcular el polinomio de Lagrange
    n = length(x);
    y_interp = 0;

    for i = 1:n
        % Calcular el término de Lagrange
        L = 1;
        for j = 1:n
            if j ~= i
                L = L * (x_interp - x(j)) / (x(i) - x(j));
            end
        end
        % Sumar el término al resultado
        y_interp = y_interp + y(i) * L;
    end
end