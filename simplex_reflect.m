function [x, xr, fx, fxr] = simplex_reflect(x0, x, fx, I, Alpha, N)
%
% Author : nicolas.douillet (at) free.fr, 2007-2024.


xr = x0 + Alpha * (x0 - x(:,N));
fxr = simplex_correlation(xr, I);

if (fx(1,1) <= fxr) && (fxr < fx(1,N-1))

    x(:,N) = xr;
    [x, fx] = simplex_reorder(x, fx, I, N);

end


end