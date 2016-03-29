include "count_eq.mzn";
include "nvalue.mzn";
include "member.mzn";
include "decreasing.mzn";

% these come from the data file
int: ncustomers;
int: ndepots;
int: vehicle_capacity;
array[1 .. ndepots] of int: capacities;
array[1 .. ndepots] of int: opening_cost;

int: nedges = ncustomers + ndepots;
int: nvehicles = ndepots;

int: route_cost;    
array[1 .. ncustomers] of int: demands;
array[1 .. nedges, 1..nedges] of int: distances;

% end of data file variables



% for convinience
set of int: iDepots = ncustomers + 1 .. ncustomers + ndepots;
set of int: iCustomers = 1 .. ncustomers;
set of int: iEdges = 1 .. ncustomers + ndepots;
set of int: iVehicles = 1 .. nvehicles;



% decision variables

% edge between i and j is used by vehicle k
array[iEdges, iEdges, iVehicles]  of var 0..1: edge_taken;

% depot i is open
array[iDepots] of var 0..1: depot_open;

% customer j is assigned to depot i
array[iDepots, iEdges] of var 0..1: depot_customer;



% constraints

% every customers is visited by exactly one vehicle
constraint
  forall(j in iCustomers)(
    sum(k in iVehicles, i in iEdges)(edge_taken[i, j, k]) == 1
);


% each vehicle only visits as many customers as it can service with its capacity
constraint
  forall(k in iVehicles)(
    sum(j in iCustomers, i in iEdges)(demands[j] * edge_taken[i, j, k]) <= vehicle_capacity
);


% the demands of the customers assigned to a depot don't exceed its capacity
constraint
  forall(i in iDepots)(
    sum(j in iCustomers)(demands[j] * depot_customer[i, j]) <= depot_open[i] * capacities[i - ncustomers]
);


% the incoming degree and outgoing degree of each vertex are equal (i.e. each route is cyclic)
constraint
  forall(k in iVehicles, i in iEdges)(
    sum(j in iEdges)(edge_taken[i, j, k]) - sum(j in iEdges)(edge_taken[j, i, k]) == 0
);


% this ensures that we start and end at the same depot
constraint
  forall(k in iVehicles)(
    sum(i in iCustomers, j in iDepots)(edge_taken[i, j, k]) <= 1
);


% ensures that a vehicles only drives to the customers that are assigned to the depot
%
% in detail:
%  * the first sum is the number of customers that are visited by the vehicle
%  * the second sum is the number of nodes that are visited by the vehicle
%  * this must be smaller than 1 (the depot) + the number of customers mapped to this depot
%  
constraint
  forall(i in iDepots, j in iCustomers,k in iVehicles)(
    sum(u in iCustomers)(edge_taken[i, u, k]) + sum(u in iEdges where u != j)(edge_taken[u, j, k]) <= 1 + depot_customer[i, j]
);


% subtour elimination (Miller, Tucker Zemlin)
array[iVehicles, iEdges] of var 0..vehicle_capacity: subtour_helper;
constraint
    forall(i in iEdges, j in iCustomers, k in iVehicles)(
        subtour_helper[k, i] - subtour_helper[k, j] + vehicle_capacity * edge_taken[i, j, k] <= vehicle_capacity - demands[j]
    )
    /\ forall(i in iCustomers, k in iVehicles)(
        demands[i] <= subtour_helper[k, i]
);


% disallow edges between depots
constraint
  forall(k in iVehicles)(
    sum(i in iDepots, j in iDepots)(edge_taken[i, j, k]) = 0
);


% the cost is the sum of:
%  * the cost of opening a depot
%  * the cost of a vehicle driving an edge
%  * a fixed cost that occurs when a vehicle is used
var int: cost = sum(i in iDepots)(opening_cost[i - ncustomers] * depot_open[i]) +
                sum(i in iEdges, j in iEdges, k in iVehicles)(edge_taken[i, j, k] * distances[i, j]) +
                sum(i in iCustomers, j in iDepots, k in iVehicles)(edge_taken[i, j, k] * route_cost);


solve
  :: int_search([depot_customer[i, j] | i in iDepots, j in iCustomers], input_order, indomain_min, complete)
minimize cost;


%solve minimize cost;




output ["Cost: " ++ show(cost) ++ "\n"]
  ++ ["Number of open depots: " ++ show(sum(depot_open)) ++ "\n"]
  ++ ["Available capacity: " ++ show(sum(i in iDepots)(depot_open[i] * capacities[i - ncustomers])) ++ "\n"]
  ++ ["Total demand: " ++ show(sum(demands)) ++ "\n"]
  ++ ["Opening costs: " ++ show(sum(i in iDepots)(depot_open[i] * opening_cost[i - ncustomers])) ++ "\n"]
  ++ ["Vehicle costs: " ++ show(cost - sum(i in iDepots)(depot_open[i] * opening_cost[i - ncustomers])) ++ "\n"]
 

