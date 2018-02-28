%{
ECE 592 Project 2
Kudiyar (Cody) Orazymbetov (korazym@ncsu.edu)
Nico Casale (ncasale@ncsu.edu)
%}

function [path, totalDistance] = dijkstra(a, b, origDists, labels)

   % assign to every node a tentative distance
   % initial position gets 0, all other nodes get inf
   dists = inf*ones(1,size(origDists,1));
   dists(a) = 0;
   
   % the unvisited set
   visited = false(1,size(origDists,1));
   
   % keep track of parents
   parents = zeros(1,size(origDists,1),1);
   
   %{
   ----3----
   for current node: calculate tentative distances of all
   neighbors. Compare the tentative distances to the current
   distance that the neighbors hold and assign the smaller one.
   i.e. if current node is A and marked with a distance of 6, and the edge
   connecting it with a neighbor B has length 2, then the distance to B
   (through A) will be 6 + 2 = 8. If be was previously marked with a
   distance greater than 8 then change it to 8. Otherwise keep the current
   value.
   %}
   curr = 0;
   while(any(visited == 0))
      
      % choose unvisited node with the smallest distance
      tempDists = dists;
      tempDists(visited) = inf;
      last = curr;
      [~,curr] = min(tempDists);
      
      if (last == curr)
         break;
      end
      
      visited(curr) = 1;
      %nnz(visited)
      
      %{
      If the destination node has been marked visited
      or if the smallest tentative distance among the nodes in the unvisited
      set is infinity (when planning a complete traversal; occurs when there
      is no connection between the initial node and the remaining unvisited
      nodes), then stop the algo. 
      %}
      if visited(b) 
         %fprintf('Destination found.\n');
         break;
      end
      
      % find tentative distances to all neighbors
      tentativeDists = origDists(curr,:) + dists(curr);
      % among nonzero and noninf neighbors
      neighbors = ~isinf(tentativeDists);
      neighbors(curr) = 0;
      
      % don't assign neighbors' parents to current if current's parent has
      % a nieghbor... find locations where assigned dist is greater
      compareDists = dists > tentativeDists;
      compareDists(~neighbors) = 0;
      % set these locations to tentativeDists
      dists(compareDists) = tentativeDists(compareDists);
      
      parents(compareDists) = curr;
      
      % temporary print label
      %fprintf('Loc: %s\n', labels(current));
      
      if min(tentativeDists) == inf
         %fprintf('Warning: destination not found.\n');
      end
      
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
         path = [parents(trace) path];
         trace = parents(trace);
      catch
         totalDistance = 0;
         path = 0;
         return;
      end
   end
   path = [path b];
   path = path(2:end);
   
   totalDistance = dists(b);
   
end