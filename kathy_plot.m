%% load data
clear
load('extracted.mat')

%% extract data 

data = zeros(20000,185);
round_data = zeros(20000,185);
unique_data = zeros(20000,185);

for i = 1:185
    if extracted(1,i) < 0.05
        extracted(:,i) = circshift(extracted(:,i),-1); %do it when the first element is too small ie need to remove it or something
    end
end

for i = 1:185
%     if extracted(1,i) < 0.05
%          extracted = circshift(extracted(:,i),1); %Y = circshift(A,3)
%     end
%     
    for j = 1:find(extracted(:,i)==0,1,'first') -1 %until the first zero appear in the very end 

        data (j,i) = extracted(j,i);
    end
end

%% organisation

for i = 1:185
    round_data(:,i) = round(data(:,i),1);
end

%% code

spike_matrix = zeros(63571,185); %127140 is the maximum element in extracted 

%final_data = zeros(20000,185);

% for i = 1:185
%     for j = 1:20000
%         final_data(j,i) = (round_data(j,i))*10;
%     end
% end
% 
% final_data = int64(final_data);



for i = 1:185
    for j = 1:find(extracted(:,i)==0,1,'first') -1
        spike_matrix(extracted(j,i),i) = 1; 
        
        
%         if final_data(j,i) == 0
%             disp(yoyo);
%             break;
    end
end


%rasterplot(find(spike_matrix),10,9500) %9500 cause 921*10 = 9210, covers more 

%% plot

for i = 1:185
    rasterplot(find(bin_2(:,i)),1,63486)
    title (sprintf('cell %d',i))
    saveas(gcf, sprintf('cell_%d',i),'fig')
    disp(i)
    
end

%% combine them together 5 plots each and then 37 times 

for i = 1:5:185
    % Load saved figures
    name_i = sprintf('%s%d%s','cell_',i,'.fig'); %1
    a=hgload(name_i);
    name_j = sprintf('%s%d%s','cell_',i+1,'.fig'); %2
    b=hgload(name_j);
    name_k = sprintf('%s%d%s','cell_',i+2,'.fig'); %3
    c=hgload(name_k);
    name_x = sprintf('%s%d%s','cell_',i+3,'.fig'); %4
    d=hgload(name_x);
    name_y = sprintf('%s%d%s','cell_',i+4,'.fig'); %5
    e=hgload(name_y);
    % Prepare subplots     % Paste figures on the subplots
    figure;
    
    h(1)=subplot(6,1,1);
    copyobj(allchild(get(a,'CurrentAxes')),h(1));
    legend(sprintf('cell %d',i))
    
    h(2)=subplot(6,1,2);
    copyobj(allchild(get(b,'CurrentAxes')),h(2));
    legend(sprintf('cell %d',i+1))
  
    h(3)=subplot(6,1,3);
    copyobj(allchild(get(c,'CurrentAxes')),h(3));
    legend(sprintf('cell %d',i+2))
    
    h(4)=subplot(6,1,4);
    copyobj(allchild(get(d,'CurrentAxes')),h(4));
    legend(sprintf('cell %d',i+3))
    
    h(5)=subplot(6,1,5);
    copyobj(allchild(get(e,'CurrentAxes')),h(5));
    legend(sprintf('cell %d',i+4))
    saveas(gcf, sprintf('raster_plot_%d_%d',i,i+4),'fig')
end 
    % Add legends
%     l(1)=legend(h(1),'cell = ',num2str(i),ornt);
%     l(2)=legend(h(2),'cell = ',num2str(i+1),ornt);
    %legend([h(1),h(2)], sprintf('cell = %d',i) , sprintf('cell = %d',i+1))
   


% for i = 1:185clc

%     rasterplot(find(spike_matrix(:,i)),1,find(spike_matrix(:,i),1,'last'))
%     title (sprintf('cell %d',i))
%     saveas(gcf, sprintf('cell %d',i),'fig')
% end


% train_1 = spike_matrix(:,1);
% train_2 = spike_matrix(:,2);
% 
% %subplot(2,1,1)
% rasterplot(find(train_1),1,find(train_1,1,'last')) %find(train_1,1,'last')
% 
% %subplot(2,1,2)
% rasterplot(find(train_2),1,find(train_2,1,'last'))


% m=(rand(1000,10)>0.9); 
% rasterplot(find(m),10,1000)s

%   RASTERPLOT(T,N,L) Plots the rasters of spiketimes (T in samples) for N trials, each of length
%   L samples, Sampling rate = 1kHz. Spiketimes are hashed by the trial length.
