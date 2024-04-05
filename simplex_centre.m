function x0 = simplex_centre(x, N)
%
% Author : nicolas.douillet (at) free.fr, 2007-2024.

x0 = mean(x(:,1:N-1),2);


end