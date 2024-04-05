function [x, fx] = simplex_contract(x0, x, fx, I, Rho, N)
%
% Author : nicolas.douillet (at) free.fr, 2007-2024.


xc = x(:,N) + Rho * (x0 - x(:,N));
fxc = simplex_correlation(xc, I);

if fxc <= fx(:,N)

    x(:,N) = xc;
    x = simplex_mapping(x, size(I));
    [x, fx] = simplex_reorder(x, fx, I, N);

end


end