% for i = 1:185
%     if sum(count(i,:)) ~= 4611
%         disp(i)
%     end
% end
% 
% for i = 1:185
%     for j = 1:4
%         if round(sum(C_percentage{i,j})) ~= 100
%         disp('do it again')
%         end
%     end 
% end 


    for i = 1:185
        plot(C_percentage{i,4});
        hold on;
    end 
    title('Percentage of spikes in 185 cells for time window 200ms')



