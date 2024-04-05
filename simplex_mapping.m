function xcrt = simplex_mapping(xcrt, S)
%
% Author : nicolas.douillet (at) free.fr, 2007-2024.


H = S(1);
W = S(2);

e = find(xcrt(1,:) < 1 | xcrt(1,:) > W);
xcrt = map(xcrt, e, W, 1);

f = find(xcrt(2,:) < 1 | xcrt(2,:) > H);
xcrt = map(xcrt, f, H, 2);

% xcrt(1) = 1 + mod(xcrt(1),W);
% xcrt(2) = 1 + mod(xcrt(2),H);


end


function x = map(x, f, D, dim)
%
% Author : nicolas.douillet (at) free.fr, 2007-2024.


if ~isempty(f)
    for n = 1:length(f)
        if x(dim,f(1,n)) < -1 
            if x(dim,f(1,n)) >= -D
                x(dim,f(1,n)) = -x(dim,f(1,n));    
            elseif x(dim,f(1,n)) < -D
                x(dim,f(1,n)) = -D-x(dim,f(1,n));
            end            
        elseif x(dim,f(1,n)) > 0 && x(dim,f(1,n)) < 1     % compris entre 0 et 1 -> 1
            x(dim,f(1,n)) = 1;
        elseif x(dim,f(1,n)) >= -1 && x(dim,f(1,n)) <= 0  % compris entre -1 et 0 -> D
            x(dim,f(1,n)) = D;
        elseif x(dim,f(1,n)) > D
            x(dim,f(1,n)) = 2*D-x(dim,f(1,n));
        end
    end
end


end