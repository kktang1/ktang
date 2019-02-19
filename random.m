%% check its symmetry I(X;Y) = I(Y;X)

for i = 1:185
    for j = 1:185
        mutual_info(i,j) = round(mutual_info(i,j),1);
    end
end
%% check if mutual information with itself is the max entropy 

b = zeros(185,185);

for i=1:185
    b(i,i) = entropy(bin(:,i)); % set it in the diagonal
end

if round(diag(b),1) == round(diag(mutual_info),1) 
    disp('yes it matches')
else
    disp('no it doesnt match')
end

%% looking for the lasrgest value in extracted

max_value = 0.0;

for i = 1:185
    for j = 1:185
        if mutual_info(j,i) > max_value
            max_value = mutual_info(j,i);
            disp('hello')
        end       
    end
end


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

title('Neural Connections for 185 neurons with 1 time bins k value of 0.2','position',[1 1])
disp('done3')
%% big spiking matrix that simon wants @19/2/2019

spike_matrix = bin_2';
imagesc(spike_matrix)
colormap(gray)
colorbar
xlabel('time(ms)');
ylabel('cells 1 - 185');
title('Spiking matrix for 185 cells with fix time window (20ms)')

