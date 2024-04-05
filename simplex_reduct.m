function [x, fx] = simplex_reduct(x, fx, I, Delta, N)
%
% Author : nicolas.douillet (at) free.fr, 2007-2024.


for m = 2:N

    x(:,m) = x(:,1) + Delta * (x(:,m) - x(:,1));

end

x = simplex_mapping(x, size(I));
[x, fx] = simplex_reorder(x, fx, I, N);


end