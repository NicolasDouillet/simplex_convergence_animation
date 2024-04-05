function Corrval = simplex_correlation(x, I)
%
% Author : nicolas.douillet (at) free.fr, 2007-2024.


xt = simplex_mapping([floor(x(1,1));floor(x(2,1))],size(I));
a = xt(1,:);
b = xt(2,:);

Corrval = I(b,a);


end