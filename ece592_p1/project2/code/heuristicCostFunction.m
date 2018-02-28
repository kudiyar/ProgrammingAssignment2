%{
ECE 592 Project 2
Kudiyar (Cody) Orazymbetov (korazym@ncsu.edu)
Nico Casale (ncasale@ncsu.edu)
%}

function heuristics = heuristicCostFunction(b, distances, labels)

   heuristics = zeros(1,length(labels));
   
   % find the distance from every node to b using Dijkstra's Algo.
   for i = 1:length(labels)
      a = i;
      if a == b
         heuristics(i) = inf;
         continue;
      end
      
      [~, heuristics(i)] = dijkstra(a, b, distances, labels);
      
      if heuristics(i) == 0
         heuristics(i) = inf;
      end
      
   end

end