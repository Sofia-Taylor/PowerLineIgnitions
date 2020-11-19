format long                     % Format decimal values

% Variable Definitions
M = 100;                        % M scenarios
P_i = 0.01;                     % Probability of seeing an ignition at point i
total_ignitions = 0;            % Counts all of the ignition points

% Read Excel file as a matrix
filename = 'C:\\Users\\sofie\\OneDrive\\Documents\\UW\\Research\\RTSGMLC_coords.xlsx'; 
line_info = readmatrix(filename, 'Sheet', 'All_Lines', 'VariableNamingRule', 'Preserve');

% Get total number of power lines from excel sheet
for r=1:1:1000
    if isnan(line_info(r))      % If cell contains NaN, stop
        break
    end
end

L = r - 1;

% Results will be stored in a 3D matrix with N rows, M columns, and
% num_lines pages
ignition_results(N,M,L) = false;	


% Iterate through all power lines
for line = 1:1:L

    line = 1;                     % Corresponds to a row in excel sheet, where row 1 contains data for the first power line

    % Obtain x and y coordinate start and end values for a line
    x_coord_start = line_info(line,17);  
    y_coord_start = line_info(line,18);
    x_coord_end = line_info(line,19);
    y_coord_end = line_info(line,20);

    % Calculate the slope and y intercept of the line
    slope = (y_coord_end - y_coord_start)/(x_coord_end-x_coord_start);
    y_intercept = y_coord_start-(slope*x_coord_start);

    % Create 2 arrays to store lists of a x and y coordinate points
    x_coord_list(1) = x_coord_start;
    y_coord_list(1) = y_coord_start;


    % Generate the lists of x and y coordinates at X resolution = 0.0001
    for index = 1:1:1000000
        x_coord_list(index+1) = x_coord_list(index) + 0.0001;
        y_coord_list(index+1) = x_coord_list(index+1)*slope + y_intercept;

        % Stop when we reach the last x coordinate value
        if x_coord_list(index) >= x_coord_end
            break;
        end
    end

    % Number of x,y pairs generated => N points where I can see an ignition.
    N = index; 

    % Generate all M ignition scenarios
    
    for j = 1:M
        % Generate ignition scenario j for all N points along the line
        for i = 1:N
            R = rand;
            if R < P_i
                % We get an ignition at point i during scenario j on the
                % current line
                ignition_results(i,j,line) = true;
                total_ignitions = total_ignitions + 1;
            end
        end % for loop that iterates through all N points
        
    end % for loop that iterates through all M scenarios  
    
end % for loop that iterates through all L lines