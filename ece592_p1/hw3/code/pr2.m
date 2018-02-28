clear; clc; close all;

prompt = {'Input sequence of numbers:', 'Value:'};
% Store input
array = inputdlg(prompt);
x = str2num(array{1,1});
v = str2num(array{2,1});

% step through array in linear time
found = 0;
for i=1:length(x)
   if(v == x(i));
       fprintf('%d\n', i);
	   found = 1;
       break;
   end  
end

% if not found
if (~found)
	fprintf('Value not found in sequence.');
end