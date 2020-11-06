
N = 100; 			% N points where I can see an ignition. 
M = 100; 			% M scenarios
P_i = 0.01;         % Probability of seeing an ignition at point i
ignition_results(N,M) = false;	% Results will be stored in an array
total_ignitions = 0;        % Counts all of the ignition points

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

