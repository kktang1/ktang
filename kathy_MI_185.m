load('cells.mat')

name = string(185);

for q = 1:185
    name(q) = cells(q).name;
end

name = name';

%%

id_split = split(name," - ");
new_id(:,1) = id_split(:,2);
new_id(:,2) = id_split(:,1);


%% data extraction

extracted = zeros(20000,185); %initialisation 

for i = 1:185
    for j = 1:1190 
        if new_id(i,1) == cells(j).expID && new_id(i,2) == cells(j).cellID
            for x = 1: length(cells(j).rf_spiketimes)
                extracted(x,i) = cells(j).rf_spiketimes(x);
            end
            break;
        end
    end
end

%% binning

bin = zeros(4611,185); % maximum value now is 922186ms, with time window of 200ms
lower_bound = 0.0;
upper_bound = 200.0;

% for i = 1:185
%     for j = 1: length(extracted(:,i))
%         round_extracted(j,i) =  round(extracted(j,i),1);
%     end
% end

%binning procedure, try to put everything in one loop so that all 185 can
%be calculated, ideally the outtest loop. 
for x = 1:185
    for i = 1:4611 %run for every time window 
        for j = 1: length(extracted(:,x)) %0-5
            if extracted(j,x) < upper_bound && extracted(j,x) >= lower_bound
                bin(i,x) = bin(i,x) + 1;
            end

            if extracted(j,x) > upper_bound
                 break;
            end
        end
        lower_bound = lower_bound + 200; %move to the next one 
        upper_bound = upper_bound + 200;
    end
    lower_bound = 0.0; %reset
    upper_bound = 200.0;
end

%% response matric (ratio determinatino)

count = zeros(185,33); %maximum of 20 spike count which is not likely to happen

a = 0 ;

for i = 1:185 %loop for each and every cell 
    for j = 1 :length(bin(:,i)) %every element vertically 
        for a = 1:33
            if bin(j,i) == a-1
                count(i,a) = count(i,a) + 1; 
            end
        end
    end
end

%% save them into a cell structure
%C = {};

for i = 1:185
    C{i,4} = count(i,:);
end 

%% convert eveything into a percentage 
C_percentage = {};

for i = 1:185
        C_percentage{i,1} = ((C{i,1})/30740)*100;
        C_percentage{i,2} = ((C{i,2})/18444)*100;
        C_percentage{i,3} = ((C{i,3})/9222)*100;
        C_percentage{i,4} = ((C{i,4})/4611)*100;
end 


%% mutual information testing 

mutual_info = zeros(185,185); %should not change this 

for i = 1:185
    for j = 1:185
        mutual_info(i,j) = mutualinfo(bin(:,i),bin(:,j));
    end
end
disp('done1')
imagesc(mutual_info)
colorbar
title('Connectiity Matrix for the 185 cells at 30ms bin window')

%% WORKING 

max_value =  1.3312; %max(mutual_info,[],'all');
condition = true;
k = 0.001;

while condition == true
    
    mutual_info = zeros(185,185); %should not change this 

    for i = 1:185
        for j = 1:185
            mutual_info(i,j) = mutualinfo(bin(:,i),bin(:,j));
        end
    end
    
    threshold = k*max_value;

    %taking into account threshold 
    for i = 1:185
        for j = 1:185
            if mutual_info(j,i) <= threshold
                mutual_info(j,i) = 0; %mutual_info is being replaced so remember to reset in the future
            end

        end
    end

    %binary conversion 
    for i = 1:185
        for j = 1:185
            if mutual_info(j,i) ~= 0
                mutual_info(j,i) = 1;
            end
        end
    end
    
    if nnz(mutual_info) <= round(185*185/2) %exit condition 
        disp('yo1')
        condition = false; %exit
    else
        condition = true;
        k = k+0.00001;
        disp('yo2')
    end
    
end



%%
G = graph(mutual_info);

%% plot spike time 
data_1 = round_extracted(:,1);
data_2 = round_extracted(:,2);
data_3 = round_extracted(:,3);
data_4 = round_extracted(:,4);
data_5 = round_extracted(:,5);
data_6 = round_extracted(:,6);
data_7 = round_extracted(:,7);
data_8 = round_extracted(:,8);
data_9 = round_extracted(:,9);
data_10 = round_extracted(:,10);

unique_data_1 = unique(data_1);
unique_data_1 = unique_data_1(2:end);

unique_data_2 = unique(data_2);
unique_data_2 = unique_data_2(2:end);

unique_data_3 = unique(data_3);
unique_data_3 = unique_data_3(2:end);

unique_data_4 = unique(data_4);
unique_data_4 = unique_data_4(2:end);

unique_data_5 = unique(data_5);
unique_data_5 = unique_data_5(2:end);

unique_data_6 = unique(data_6);
unique_data_6 = unique_data_6(2:end);

unique_data_7 = unique(data_7);
unique_data_7 = unique_data_7(2:end);

unique_data_8 = unique(data_8);
unique_data_8 = unique_data_8(2:end);

unique_data_9 = unique(data_9);
unique_data_9 = unique_data_9(2:end);

unique_data_10 = unique(data_10);
unique_data_10 = unique_data_10(2:end);

matrix = zeros(1000,1); %runs till 100s in the data set with 10 increments per second 
[r,c] = size(matrix); 

b = 0.1 ;

%predefined matrix for comparsion
for i = 1:r %1000
    matrix(i,1)= b;
    b = 0.1+b;
end

spike_matrix = zeros(10000,10); %the actual spike matrix 

for i = 1:length(unique_data_1)
    spike_matrix(unique_data_1(i)*10,1) = 1;
end

for i = 1:length(unique_data_2)
    spike_matrix(unique_data_2(i)*10,2) = 1;
end

for i = 1:length(unique_data_3)
    spike_matrix(unique_data_3(i)*10,3) = 1;
end

for i = 1:length(unique_data_4)
    spike_matrix(unique_data_4(i)*10,4) = 1;
end

for i = 1:length(unique_data_5)
    spike_matrix(unique_data_5(i)*10,5) = 1;
end

for i = 1:length(unique_data_6)
    spike_matrix(unique_data_6(i)*10,6) = 1;
end

for i = 1:length(unique_data_7)
    spike_matrix(unique_data_7(i)*10,7) = 1;
end

for i = 1:length(unique_data_8)
    spike_matrix(unique_data_8(i)*10,8) = 1;
end

for i = 1:length(unique_data_9)
    spike_matrix(unique_data_9(i)*10,9) = 1;
end

for i = 1:length(unique_data_10)
    spike_matrix(unique_data_10(i)*10,10) = 1;
end

rasterplot(find(spike_matrix),10,9500)
title('Raster Plot for Cells 1 - 10')

%% test histogram 
A = histogram(bin);

%% test redunadncy 

A = mrmr_mid_d(round_extracted, v_i, 1);
