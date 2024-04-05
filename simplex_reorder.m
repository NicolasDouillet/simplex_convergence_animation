function [x, fx] = simplex_reorder(x, fx, I, N)
%
% Author : nicolas.douillet (at) free.fr, 2007-2024.


for k = 1:N

    fx(:,k) = simplex_correlation(x(:,k), I);

end

[~, index] = sort(fx, 2, 'ascend');

x = x(:, index);

for k = 1:N

    fx(:,k) = simplex_correlation(x(:,k), I);

end


end