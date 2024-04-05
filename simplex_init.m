function  xi = simplex_init(Omega0, N, Rho)
%
% Author : nicolas.douillet (at) free.fr, 2007-2024.

% Simplex surface & vertices positions (directions)
% Equal distance of the vertices to the estimated maximum (to be centered
% on it as much as possible)


xi0 = zeros(N-1,N);

for n = 1:size(xi0,1)
    
    xi0(n,:) = repmat(Omega0(n,1),[1,N]);
    
end

vtcscoord = zeros(N-1,N);


for i = 1:size(vtcscoord,1)
    
    for j = 1:size(vtcscoord,2)
        
        if j == i+1
            
            vtcscoord(i,j) = -i/sqrt(i*(i+1));
            
        elseif j <= i
            
            vtcscoord(i,j) = 1/sqrt(i*(i+1));
            
        elseif j > i+1
            
            vtcscoord(i,j) = 0;
            
        end
        
    end
    
end

vtcscoord = 0.5*sqrt(2)*vtcscoord;
xi = xi0 + Rho*vtcscoord;


end