%% 1st: generate a random seqeucence X and then copy to Y and use the mI toolbox to calculate MI. expected 1 as it is exactly the same, ideally the more the better 

X_1 = randi([0,1],[1,100]);
Y_1 = X_1;
validation_1 = mutualinfo(X_1,Y_1); % expected 1
 
X_2 = randi([0,1],[1,100]);
Y_2 = randi([0,1],[1,100]);
validation_2 = mutualinfo(X_2,Y_2); % expected 0