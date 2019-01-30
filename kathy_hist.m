
for i = 1:length(bin(1,:))
    
data_C{i} = bin(1:find(bin(:,i),1,'last'),i); %save it in the cell instead of matrix 

end
%% 
for i = 1:length(bin(1,:))
    histfit(data_C{i},int8(size(data_C{i},1)));
    hold on;
end

title('Histogram of spike counts in 5ms windows for 185 cells')
xlabel('Number of spike counts in each time window')
ylabel('Probability')
set(gca,'XLim',[0 302])




