include "count_eq.mzn";
include "nvalue.mzn";
include "member.mzn";
include "decreasing.mzn";

int: ncustomers;
int: ndepots;
int: vehicle_capacity;
array[1..ndepots] of int: capacities;
array[1..ndepots] of int: opening_cost;

% pretty sure ndepots is correct and not ncustomers
int: nvehicles = ndepots;

int: edges = ncustomers+ndepots;
int: route_cost;    
array[1..ncustomers] of int: demands;
array[1..edges, 1..edges] of int: distances;


set of int: iDepots = ncustomers+1..ncustomers+ndepots;
set of int: iCustomers = 1..ncustomers;
set of int: iEdges = 1..ncustomers+ndepots;
set of int: iVehicles = 1..nvehicles;

% edge between i and j is used by vehicle k
array[1..edges, 1..edges, 1..nvehicles]  of var 0..1: x;

% depot i is open
array[iDepots] of var 0..1: y;

% customer j is assigned to depot i
array[iDepots, iEdges] of var 0..1: f;


% 2
constraint
  forall(j in iCustomers)(
    sum(k in iVehicles, i in iEdges)(x[i, j, k]) == 1
);

%3
constraint
  forall(k in iVehicles)(
    sum(j in iCustomers, i in iEdges)(demands[j] * x[i, j, k]) <= vehicle_capacity
);

%4

% todo fix capacities array access
constraint
  forall(i in iDepots)(
    sum(j in iCustomers)(demands[j] * f[i, j]) <= y[i] * capacities[i - ncustomers]
);

%5
constraint
  forall(k in iVehicles, i in iEdges)(
    sum(j in iEdges)(x[i, j, k]) - sum(j in iEdges)(x[j, i, k]) == 0
);

%6
constraint
  forall(k in iVehicles)(
    sum(i in iCustomers, j in iDepots)(x[i, j, k]) <= 1
);

%7
% subtour elimination
array[iVehicles, iEdges] of var 0..vehicle_capacity: u;

% Subtour elimination (Miller, Tucker Zemlin)
constraint
    forall(k in iVehicles, i in iEdges, j in iCustomers)(
        u[k, i] - u[k, j] + vehicle_capacity * x[i, j, k] <= vehicle_capacity - demands[j]
    )
    /\ forall(k in iVehicles, i in iCustomers)(
        demands[i] <= u[k, i]
    );






% pathetic attempts at optimization
%
array[iVehicles] of var 0..vehicle_capacity: load;

constraint
  forall(k in iVehicles)(
    load[k] = sum(i in iCustomers, j in iEdges)(x[i, j, k])
);

constraint decreasing(load);



array[iVehicles] of var 0..vehicle_capacity: lowest_idx_served;

constraint
  forall(k in iVehicles)(
    lowest_idx_served[k] == max([i | i in iEdges, j in iEdges where x[i, j, k] == 1])
);

constraint decreasing(lowest_idx_served);









%8
constraint
  forall(k in iVehicles, j in iCustomers, i in iDepots)(
    sum(u in iCustomers)(x[i, u, k]) + sum(u in iEdges where u != j)(x[u, j, k]) <= 1 + f[i, j]
);

%9
%constraint
%  forall(i in iDepots, j in iEdges, k in iVehicles)(
%    (x[i, j, k] == 0) \/ (x[i, j, k] == 1)
%);

%10
%constraint
%  forall(i in iDepots)(
%    (y[i] == 0) \/ (y[i] == 1)
%);

%11
%constraint
%  forall(i in iDepots, j in iEdges)(
%     (f[i, j] == 0) \/ (f[i, j] == 1)
%);




var int: cost = sum(i in iDepots)(opening_cost[i-ncustomers] * y[i]) +
                sum(i in iEdges, j in iEdges, k in iVehicles)(x[i, j, k] * distances[i, j]) +
                sum(i in iCustomers, j in iDepots, k in iVehicles)(x[i, j, k] * route_cost);

solve minimize cost;




output ["Cost: " ++ show(cost) ++ "\n"]
  ++ ["Test: " ++ show(load) ++ "\n"]
  ++ ["Open depots: " ++ show(y) ++ "\n"]
  ++ ["Lowest index: " ++ show(lowest_idx_served) ++ "\n"]