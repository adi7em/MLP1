%% taking input
%  inp = csvread('data.txt');
  out = csvread('label.txt');
inp = Z;
%% kmeans
idx = kmeans(inp,5); %idx stores the clster number for all points

temp = (linspace(1,5000,5000))';
data_idx = [temp idx]; %data_idx have point number with its corros cluster number

% sorting the data_idx according to cluster numbers
[~,i] = sort(data_idx(:,2)); % sort just the decond column
sorted_data_idx = data_idx(i,:);   % sort the whole matrix using the sort indices

temp = zeros(5000,1);
sorted_data_idx = [sorted_data_idx temp];

%creating the decimal output matrix
decimal_output_matrix = zeros(5000,1);

for i = 1:5000
    count = 0;
    for j = 1:10
        if(out(i,j) == 1)
            break
        end
        count = count+1;
    end
    decimal_output_matrix(i) = count;
end
for i = 1:5000
    sorted_data_idx(i,3) = decimal_output_matrix(sorted_data_idx(i,1));
end

% labelling each cluster with most frequently occuring digit
%iterating cluster number
no_of_clusters = 5;
for i = 1 : no_of_clusters
    temp = [];
    for j = 1 : 5000
        if sorted_data_idx(j,2) == i
            temp = [temp;sorted_data_idx(j,3)];
        end
    end
    temper = mode(temp);
    for j = 1 : 5000
        if sorted_data_idx(j,2) == i
            sorted_data_idx(j,3) = temper;
        end
    end
end
% Create Confusion matrix
%some sorting
[~,i] = sort(sorted_data_idx(:,1)); % sort just the decond column
sorted_data_idx = sorted_data_idx(i,:);   % sort the whole matrix using the sort indices

Confusion_M = zeros(10,10);
col = [];
for i=1:5000
    Confusion_M(decimal_output_matrix(i)+1,sorted_data_idx(i,3)+1) = Confusion_M(decimal_output_matrix(i)+1,sorted_data_idx(i,3)+1)+1; 
end

%calculate accuracy

acc = (trace(Confusion_M)/5000)*100;
