%% load data
clear
load('extracted.mat')

%% extract data 

data = zeros(20000,185);
round_data = zeros(20000,185);
unique_data = zeros(20000,185);

for i = 1:185
    if extracted(1,i) < 0.05
        extracted(:,i) = circshift(extracted(:,i),-1);
    end
end

for i = 1:185
%     if extracted(1,i) < 0.05
%          extracted = circshift(extracted(:,i),1); %Y = circshift(A,3)
%     end
%     
    for j = 1:find(extracted(:,i)==0,1,'first') -1

        data (j,i) = extracted(j,i);
    end
end

%% organisation

for i = 1:185
    round_data(:,i) = round(data(:,i),1);
end

%% code

spike_matrix = zeros(20000,185); %the actual spike matrix 

final_data = zeros(20000,185);

for i = 1:185
    for j = 1:20000
        final_data(j,i) = (round_data(j,i))*10;
    end
end

final_data = int64(final_data);

for i = 1:185
    
    for j = 1:find(final_data(:,i)==0,1,'first') -1
        spike_matrix(final_data(j,i),i) = 1; 
        
        
%         if final_data(j,i) == 0
%             disp(yoyo);
%             break;
    end
end


%rasterplot(find(spike_matrix),10,9500) %9500 cause 921*10 = 9210, covers more 

%% plot

for i = 1:185
    rasterplot(find(spike_matrix(:,i)),1,find(spike_matrix(:,i),1,'last'))
    title (sprintf('cell %d',i))
    saveas(gcf, sprintf('cell %d',i),'fig')
end


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
