%{
ECE 592 Project 2
Kudiyar (Cody) Orazymbetov (korazym@ncsu.edu)
Nico Casale (ncasale@ncsu.edu)
%}

clear; close all;
addpath('..');

global seed
seed = 475859; rng(seed);

global imagesFolder
imagesFolder = '../images/';
addpath(imagesFolder);
overwriteImage = 1;

fprintf('ECE 592 Project 2\n');
fprintf(strcat(datestr(now),'\n'));

%% data retrieval and preprocessing
[distances, labels] = retrieveData();

%% Dijkstra's Algorithm
% choose two cities
a = 'Sylva';
b = 'Kitty Hawk';

%a = 'Asheville';
%b = 'Oak Island';

%a = 'Cullowhee';
%b = 'Moyock';

fprintf('\nStart: %s\nFinish: %s\n', a, b);

% get indexes of cities
a = find(labels == a);
b = find(labels == b);

[path, totalDistance] = dijkstra(a, b, distances, labels);

% print path
fprintf('\nThe Tao:\n');
for i = 1:length(path)
   fprintf('\t%s, index: %d\n', labels(path(i)), path(i));
end

fprintf('\nHops: %d\nTotal Distance: %3.2f\n', length(path), totalDistance);

%% Time Complexity of Dijkstra's Algorithm
samples = 5000;
hops = zeros(1, samples);
times = zeros(1, samples);

for i = 1:samples
   a = randi(length(labels));
   b = randi(length(labels));
   
   fprintf('\nSample: %d', i);
   %fprintf(', Start: %s, Finish: %s\n', labels(a), labels(b));
   
   tic;
   [path, totalDistance] = dijkstra(a, b, distances, labels);
   if (isempty(path) || length(path) == 1)
      continue; 
   end
   times(i) = toc;
   
   hops(i) = length(path);
   %fprintf('Hops: %d\nTime: %2.2f\nTotal Distance: %3.2f\n', length(path), times(i), totalDistance);
end

%% plot results
figure(1); clf; hold on;
h(1) = scatter(hops, times);

% theoretical results - slope 2
[hops, I] = sort(hops);
times = times(I);
X = [ones(length(hops),1) hops'];
b = X\times'; % b(2) - m b(1) - b
yTh = X*b;
h(2) = plot(hops, yTh, 'LineWidth', 3);
hold off;

axis([0 45 0 0.025]);
%set(gca,'xscale','log', 'yscale', 'log')
xlabel('Nodes Traversed (Hops)');
ylabel('Execution Time (s)');
title(sprintf('Nodes Traversed vs. Time for Dijkstra''s Algorithm\nRandom Pairs: %d, -log10(slope) = %2.2f', samples, -log10(b(2))));
legend('Empirical Results', 'Linear Regression', 'Location', 'Southeast');

%% save images
if (overwriteImage)
   file = sprintf('dijkstraEmpirical');
   file = strcat(imagesFolder, file);
   print(file, '-dpng');
end

%% A* Algorithm
% choose two cities
a = 'Sylva';
b = 'Kitty Hawk';

%a = 'Asheville';
%b = 'Oak Island';

%a = 'Cullowhee';
%b = 'Moyock';

fprintf('\nStart: %s\nFinish: %s\n', a, b);

% get indexes of cities
a = find(labels == a);
b = find(labels == b);

% find the distance from every node to b using Dijkstra's Algo.
heuristics = heuristicCostFunction(b, distances, labels);
[path_A, totalDistance_A] = Astar(a, b, heuristics, distances, labels);

% print path
fprintf('\nThe Tao:\n');
for i = 1:length(path_A)
   fprintf('\t%s, index: %d\n', labels(path_A(i)), path_A(i));
end

fprintf('\nHops: %d\nTotal Distance: %3.2f\n', length(path_A), totalDistance_A);

%% Time Complexity of the A* Algorithm
samples = 10000;
hops = zeros(1, samples);
times = zeros(1, samples);

b = 'Charlotte';
b = find(labels == b);
heuristics = heuristicCostFunction(b, distances, labels);

for i = 1:samples
   a = randi(length(labels));
   
   fprintf('\nSample: %d', i);
   %fprintf(', Start: %s, Finish: %s\n', labels(a), labels(b));
   
   tic;
   [path, totalDistance] = Astar(a, b, heuristics, distances, labels);
   if (isempty(path) || length(path) == 1)
      continue; 
   end
   times(i) = toc;
   
   hops(i) = length(path);
   %fprintf('Hops: %d\nTime: %2.2f\nTotal Distance: %3.2f\n', length(path), times(i), totalDistance);
   
   if i == samples/2
      b = 'Raleigh';
      b = find(labels == b);
      heuristics = heuristicCostFunction(b, distances, labels);
   end
end

%% plot results
figure(2); clf; hold on;
h(1) = scatter(hops, times);

% theoretical results - slope 2
[hops, I] = sort(hops);
times = times(I);
X = [ones(length(hops),1) hops'];
b = X\times'; % b(2) - m b(1) - b
yTh = X*b;
h(2) = plot(hops, yTh, 'LineWidth', 3);
hold off;

axis([0 30 0.01 0.04]);
%set(gca,'xscale','log', 'yscale', 'log')
xlabel('Nodes Traversed (Hops)');
ylabel('Execution Time (s)');
title(sprintf('Nodes Traversed vs. Time for the A* Algorithm\nRandom Pairs: %d, -log10(slope) = %2.2f', samples, -log10(b(2))));
legend('Empirical Results', 'Linear Regression', 'Location', 'Southeast');

%% save images
if (overwriteImage)
   file = sprintf('AstarEmpirical');
   file = strcat(imagesFolder, file);
   print(file, '-dpng');
end
