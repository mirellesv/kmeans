% Número máximo de iterações
max_iterations = 100;

% Número total de pontos
size = 50;

% Geração dinâmica do dataset entre 1 e 10:
% De forma geral, podemos gerar n números aleatórios em um
% intervalo [a, b] com a fórmula r = a + (b-a).*rand(N,1)
a = 1; % Valor inicial do intervalo
b = 20; % Valor final do intervalo
values = a + (b-a).*rand(size, 2);

% Número de clusters = 3

% Posicionamento aleatório inicial dos centróides de cada cluster
c1 = a + (b-a).*rand(1, 2);
c2 = a + (b-a).*rand(1, 2);
c3 = a + (b-a).*rand(1, 2);

% Plotando os pontos antes de iniciar o algoritmo
figure;
scatter(values(:,1), values(:,2), 'k', 'filled');
title('Pontos Iniciais');
xlabel('Eixo X');
ylabel('Eixo Y');
legend('Pontos');
grid on;

% Limiar de convergência
tolerance = 1e-6;

for it = 1:max_iterations
    % Calculando a distância euclidiana dos pontos em relação aos centróides
    dis_1 = sqrt(power(values(:, 1) - c1(1), 2) + power(values(:, 2) - c1(2), 2));
    dis_2 = sqrt(power(values(:, 1) - c2(1), 2) + power(values(:, 2) - c2(2), 2));
    dis_3 = sqrt(power(values(:, 1) - c3(1), 2) + power(values(:, 2) - c3(2), 2));
    
    distances = [dis_1, dis_2, dis_3];
    % Em relação a qual centróide, o ponto possui a menor distância?
    
    [~, closestCentroidIndex] = min(distances, [], 2);
    
    % Inicializando arrays para armazenar os clusters
    cluster1 = [];
    cluster2 = [];
    cluster3 = [];
    
    % Preenchendo os arrays com base nos índices dos centróides mais próximos
    for i = 1:length(closestCentroidIndex)
        %fprintf('Ponto %d: (%f, %f) -> Centr. %d\n', i, values(i, 1), values(i, 2), closestCentroidIndex(i));
        if closestCentroidIndex(i) == 1
            cluster1 = [cluster1; values(i, :)];
        elseif closestCentroidIndex(i) == 2
            cluster2 = [cluster2; values(i, :)];
        elseif closestCentroidIndex(i) == 3
            cluster3 = [cluster3; values(i, :)];
        end
    end
    
    %display(cluster1);
    %display(cluster2);
    %display(cluster3);
    
    % Calculando os novos centróides como a média dos pontos em cada cluster
    prev_c1 = c1;
    prev_c2 = c2;
    prev_c3 = c3;
    
    if ~isempty(cluster1)
        c1 = mean(cluster1, 1)
    end
    
    if ~isempty(cluster2)
        c2 = mean(cluster2, 1)
    end
    
    if ~isempty(cluster3)
        c3 = mean(cluster3, 1)
    end
    
    % Verificando a convergência usando norma da diferença
    if norm(c1 - prev_c1) < tolerance && norm(c2 - prev_c2) < tolerance && norm(c3 - prev_c3) < tolerance
        disp('Houve convergência!');
        break;
    end

end

    % Plotando os clusters e os centróides
figure;
hold on;
scatter(cluster1(:,1), cluster1(:,2), 'r', 'filled');
scatter(cluster2(:,1), cluster2(:,2), 'g', 'filled');
scatter(cluster3(:,1), cluster3(:,2), 'b', 'filled');
scatter(c1(1), c1(2), 100, 'r', 'd', 'filled');
scatter(c2(1), c2(2), 100, 'g', 'd', 'filled');
scatter(c3(1), c3(2), 100, 'b', 'd', 'filled');
title('Algoritmo K-Means');
xlabel('Eixo X');
ylabel('Eixo Y');
legend('Cluster 1', 'Cluster 2', 'Cluster 3', 'Centróide 1', 'Centróide 2', 'Centróide 3');
grid on;
hold off;