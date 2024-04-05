function [] = simplex_convergence_animation()
%
% Author : nicolas.douillet (at) free.fr, 2008-2024.


clear all, close all, clc;


wiew_mode = '2D';

if strcmpi(wiew_mode,'3D')
    az = -37.5;
    el = 30;
    zoom_lvl = 1.1;
elseif strcmpi(wiew_mode,'2D')
    az = 0;
    el = 90;
    zoom_lvl = 1;
end


% Matlab 'peaks' function
S = 128; % grid_size
Z = peaks(S);


% Starting / initial point (triangle isobarycentre for simplex)
% Set at the grid centre by default, but may be adjusted
u0 = floor(0.5*[S;S]); % = [x0;y0] 

% Targeted point = (local) minimum of the function
[m,i] = min(Z(:));
[row,col] = ind2sub(S,i);
uf = [col;row;m]; % = [xf;yf;zf]


% Optimization algorithm
N = 3; % 3 in 2D | 4 in 3D | N+1 in ND
step = 0.7*S; % may be adjusted
xi = simplex_init(u0, N, step);
[vertices, height] = main_simplex(xi, Z, N);


% Options
disp_function_min = true;
draw_path         = false;

time_lapse = 0.25;
fig_title = 'Simplex convergence animation demo on Matlab peaks test function';
filename  = 'Simplex_convergence_animation_demo_test.gif';

%--- Display settings ---%
h = figure;
set(h,'Position',get(0,'ScreenSize'));
set(gcf,'Color',[0 0 0]);


for k = 1:size(vertices,3)
    
    surf(Z), shading interp, hold on;    
    
    if ~draw_path
        line(cat(2,vertices(1,:,k),vertices(1,1,k)),...
             cat(2,vertices(2,:,k),vertices(2,1,k)),...
             cat(2,height(1,:,k),height(1,1,k)),...
             'Color',[1 1 1],'Linewidth',2), hold on;
        
    else % if draw_path
        for j = 1:k
            line(cat(2,vertices(1,:,j),vertices(1,1,j)),...
                 cat(2,vertices(2,:,j),vertices(2,1,j)),...
                 cat(2,height(1,:,j),height(1,1,j)),...
                 'Color',[1 1 1],'Linewidth',2), hold on;
        end
    end

     hidden off;
     alpha(0.6);
    
    %--- Display settings ---%
    set(gca,'Color',[0 0 0]);
    view(az,el);
    axis square, axis auto;
    
    ax = gca;
    ax.Clipping = 'off';
    zoom(zoom_lvl);
    
    if disp_function_min
        plot3(uf(1),uf(2),uf(3),'o','Color',[1 0 0],'Linewidth',2), hold on;
        plot3(uf(1),uf(2),uf(3),'+','Color',[1 0 0],'Linewidth',2), hold on;     
        
        text(-floor(0.5*S),S,0,'Function known local minimum' ,'Color',[1 0 0],'FontSize',14), hold on;
        text(-floor(0.5*S),S-8,0,  ['x_f = ',num2str(col)]    ,'Color',[1 0 0],'FontSize',14), hold on;
        text(-floor(0.5*S),S-14,0, ['y_f = ',num2str(row)]    ,'Color',[1 0 0],'FontSize',14), hold on;
        text(-floor(0.5*S),S-20,0, ['z_f = ',num2str(m)]      ,'Color',[1 0 0],'FontSize',14), hold on;
    end
    
    text(-floor(0.5*S),S-34,0,'Convergence head point ',              'Color',[1 1 1],'FontSize',14), hold on;
    text(-floor(0.5*S),S-42,0,['x = ',num2str(mean(vertices(1,:,k)))],'Color',[1 1 1],'FontSize',14), hold on;
    text(-floor(0.5*S),S-48,0,['y = ',num2str(mean(vertices(2,:,k)))],'Color',[1 1 1],'FontSize',14), hold on;
    text(-floor(0.5*S),S-54,0,['z = ',num2str(mean(height(1,:,k)))],  'Color',[1 1 1],'FontSize',14), hold on;

    
    title(fig_title, 'Color', [1 1 1], 'FontSize', 16);
    
    drawnow;    
    frame = getframe(h);    
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,256);
    
    %--- Write to the .gif file ---%
    if k == 1
        imwrite(imind,cm,filename,'gif','Loopcount',Inf,     'DelayTime',time_lapse);
    else
        imwrite(imind,cm,filename,'gif','WriteMode','append','DelayTime',time_lapse);
    end
    
    clf;
    
end


end