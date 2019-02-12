%% plot of the neural connections
%# 60-by-60 sparse adjacency matrix
A = mutual_info;
N = length(A);

%# x/y coordinates of nodes in a circular layout
r =  1;
theta = linspace(0,2*pi,N+1)'; theta(end) = [];
xy = r .* [cos(theta) sin(theta)];

%# labels of nodes
txt = cellstr(num2str((1:N)','%02d'));

%# show nodes and edges
line(xy(:,1), xy(:,2), 'LineStyle','none', ...
    'Marker','.', 'MarkerSize',15, 'Color','g')
hold on
gplot(A, xy, 'b-')
axis([-1 1 -1 1]); axis equal off
hold off

%# show node labels
h = text(xy(:,1).*1.05, xy(:,2).*1.05, txt, 'FontSize',8)
set(h, {'Rotation'},num2cell(theta*180/pi))

title('Neural Connections for 185 neurons with 30ms time bins k value of 0.0014','position',[1 1])
disp('done3')