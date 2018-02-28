%{
ECE 592 Project 2
Kudiyar (Cody) Orazymbetov (korazym@ncsu.edu)
Nico Casale (ncasale@ncsu.edu)
%}

function [path, totalDistance] = Astar(a, b, heuristics, distances, labels)

   % the set of nodes already evaluated
   closedSet = false(1,size(distances,1));
   
   % the set of discovered nodes that are not evaluated yet
   % initially, only the start is known
   openSet = false(1,size(distances,1));
   openSet(a) = 1;

   % keep track of parents
   cameFrom = zeros(1,size(distances,1));
   
   % for each node, the cost of getting from a to that node
   gScore = inf*ones(1,size(distances,1));
   gScore(a) = 0;
   
   % for each node, the total cost of getting from the start node
   % to the goal by passing that node. partly known, partly heuristic
   fScore = inf*ones(1,size(distances,1));
   fScore(a) = heuristics(a);
   curr = 0;
   while any(openSet)
      tfScores = fScore;
      tfScores(~openSet) = inf;
      [mv, curr] = min(tfScores);
      
      if curr == b
         break;
      elseif mv == inf
         break;
      end
      
      openSet(curr) = 0;
      closedSet(curr) = 1;
      
      currentDists = distances(curr, :);
      % among nonzero and noninf neighbors
      neighbors = ~isinf(currentDists);
      neighbors(curr) = 0;
      neighbors(closedSet) = 0;
      
      openSet = openSet | neighbors;
      
      tentative_gScores = gScore(curr) + currentDists;
      compareDists = tentative_gScores < gScore;
      compareDists(~neighbors) = 0;
      
      cameFrom(compareDists) = curr;
      gScore(compareDists) = tentative_gScores(compareDists);
      fScore(compareDists) = gScore(compareDists) + heuristics(compareDists);
      
   end

   % walk backwards to find the path
   done = 0;
   path = [];
   trace = b;
   while(~done)
      if trace == a
         done = 1;
      end
      try
         path = [cameFrom(trace) path];
         trace = cameFrom(trace);
      catch
         totalDistance = 0;
         path = 0;
         return;
      end
   end
   path = [path b];
   path = path(2:end);
   
   totalDistance = gScore(b);
   
end