
M = 100; 			% M scenarios
P_i = 0.01;         % Probability of seeing an ignition at point i
ignition_results(N,M) = false;	% Results will be stored in an array
total_ignitions = 0;        % Counts all of the ignition points

format long
line_info = readmatrix('C:\\Users\\sofie\\OneDrive\\Documents\\UW\\Research\\Single_Line_Coords.xlsx', 'Sheet', 'Single_Line', 'VariableNamingRule', 'Preserve');
x_coord_start = line_info(1,17);
y_coord_start = line_info(1,18);
x_coord_end = line_info(1,19);
y_coord_end = line_info(1,20);

slope = (y_coord_end - y_coord_start)/(x_coord_end-x_coord_start);
y_intercept = y_coord_start-(slope*x_coord_start);

x_coord_list(1) = x_coord_start;
y_coord_list(1) = y_coord_start;

for index = 1:1:1000000
    x_coord_list(index+1) = x_coord_list(index) + 0.0001;
    y_coord_list(index+1) = x_coord_list(index+1)*slope + y_intercept;
    
    if x_coord_list(index) >= x_coord_end
        break;
    end
end

N = index; 			% N points where I can see an ignition. 

% Generate all M ignition scenarios
for j = 1:M
	% Generate ignition scenario j for all N points along the line
	for i = 1:N
		R = rand;
		if R < P_i
			% We get an ignition at point i
			ignition_results(i,j) = true;
            total_ignitions = total_ignitions + 1;
		end
	end
end

