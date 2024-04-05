function [x, fx] = simplex_expand(x0, xr, x, fx, fxr, I, Gamma, N)
%
% Author : nicolas.douillet (at) free.fr, 2007-2024.


xe = x0 + Gamma * (x0 - x(:,N));
fxe = simplex_correlation(xe, I);

if fxe < fxr

    x(:,N) = xe;
    x = simplex_mapping(x, size(I));
    [x, fx] = simplex_reorder(x, fx, I, N);

elseif fxe >= fxr

    x(:,N) = xr;
    x = simplex_mapping(x, size(I));
    [x, fx] = simplex_reorder(x, fx, I, N);

end


end