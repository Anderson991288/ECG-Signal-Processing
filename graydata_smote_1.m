clear; 
clc; 
close all; 

type = ['F'; 'S'];
L = 400;
k = 10; % consider 5 nearest neighbors
N = 9; % oversample to 1.5x the size of the original data

for i = 1:size(type, 1)
    % Load data for current heartbeat type
    X = zeros(500, L);
    for j = 1:500
        load(['D:\111專題\stft\raw data-', int2str(L), '\', type(i,:), '\', type(i,:), '_', num2str(j), '.mat']);
        X(j,:) = x(1:L);
    end
    
    % Apply SMOTE to oversample data
    Y = ones(N*size(X,1), 1);
    Y(1:size(X,1)) = 0;
    options.Class = Y;
    [X_smote, ~] = smote(X, N, k);

    % Rescale the data to [0, 1]
    X_smote = X_smote - min(X_smote(:));
    X_smote = X_smote ./ max(X_smote(:));
    
    % Save the oversampled data as grayscale images
    L_sqrt = sqrt(L);
    for j = 1:size(X_smote, 1)
        s_x = reshape(X_smote(j,:), L_sqrt, L_sqrt);
        imagesc(s_x);
        colormap(gray);
        set(gca, 'xtick', [], 'xticklabel', []);
        set(gca, 'ytick', [], 'yticklabel', []);
        saveas(gcf, ['D:\111專題\gray scale\gray scale_2-', int2str(L), '\5TYPE\', type(i,:), '\', type(i,:), '_', num2str(j), '.jpg']);
    end
end