% 2 dimension simplex / Nelder-mead algorithm
function [x, fx] = main_simplex(xi, I, N) % N: parameter (hyper)space dimension (correlation)
                                          % En 2D, N = 3 ! (le simplex est un triangle)

S = size(I);                                          
x(:,:,1) = xi;
x0 = simplex_centre(x(:,:,1), N);

for k = 1:N

    fx(:,k,1) = simplex_correlation(x(:,:,1), I);

end


% Parameters to adjust
Alpha = 1;
Gamma = 2;
Rho   = 0.5;
Delta = 0.5;

% TODO : eps_thres à mettre en paramètre d'entrée
threshold = 5e-1; % 1e4*eps; % condition d'arrêt altitude/corrélation des sommets % et un certain pourcentage du max de correlation
s = 1;

while max(norm(x(:,:,end) - repmat(x0, [1, size(x,2), 1]))) > threshold % critère général dim N: distance / surface / volume - distance entre x0 et le point le plus éloigné

    % I Order
    [x(:,:,end+1), fx(:,:,end+1)] = simplex_reorder(x(:,:,end), fx(:,:,end), I, N);

    % II Centre
    x0 = simplex_centre(x(:,:,end), N);

    % III Reflection
    [x(:,:,end+1), xr, fx(:,:,end+1), fxr] = simplex_reflect(x0, x(:,:,end), fx(:,:,end), I, Alpha, N);
    % x = simplex_noise(x, I, N, 3*H);
    x(:,:,end) = simplex_mapping(x(:,:,end), S);

    if fxr < fx(:,1,end) % IV Expansion...

        [x(:,:,end+1), fx(:,:,end+1)] = simplex_expand(x0, xr, x(:,:,end), fx(:,:,end), fxr, I, Gamma, N);
        % x = simplex_noise(x, I, N, 3*H);
        x(:,:,end) = simplex_mapping(x(:,:,end), S);

    elseif fx(:,N,end) <= fxr % V ...or Contraction

        [x(:,:,end+1), fx(:,:,end+1)] = simplex_contract(x0, x(:,:,end), fx(:,:,end), I, Rho, N);
        % x = simplex_noise(x, I, N, 3*H);
        x(:,:,end) = simplex_mapping(x(:,:,end), S);

    end

    % VI Reduction
    [x(:,:,end+1), fx(:,:,end+1)] = simplex_reduct(x(:,:,end), fx(:,:,end), I, Delta, N);
    % x = splxnoise(x, I, N, 3*H);
    x(:,:,end) = simplex_mapping(x(:,:,end), S);

    s = s+1;

end


end