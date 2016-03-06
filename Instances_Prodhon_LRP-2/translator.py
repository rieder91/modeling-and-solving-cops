#!/usr/bin/env python3

import argparse, sys, re, math

parser = argparse.ArgumentParser(description='Translates a CLR file into MiniZinc dzn format.')
parser.add_argument('input', type=argparse.FileType('r'), help='Input file')
parser.add_argument('--output', type=argparse.FileType('w'), help='DZN output file, if not specified is the standard output', default=sys.stdout)

args = parser.parse_args()

def dist(i, j, customers, depots):
    a = customers[i] if i < len(customers) else depots[i - len(customers)]
    b = customers[j] if j < len(customers) else depots[j - len(customers)]
    return math.floor(math.sqrt(math.pow(a[0] - b[0], 2) + math.pow(a[1] - b[1], 2)) * 100)

content = []

for line in args.input:
    line = line.strip().rstrip('\n')
    if line:
        content.append(line)

i = 0
ncustomers = int(content[i])
args.output.write('ncustomers = {};\n'.format(ncustomers))
customers = []
i += 1
ndepots = int(content[i])
args.output.write('ndepots = {};\n'.format(ndepots))
depots = []
i += 1
for j in range(ndepots):
    d = map(int, re.split(r'[\s]', content[i + j]))
    depots.append(tuple(d))
i += ndepots
for j in range(ncustomers):
    c = map(int, re.split(r'[\s]', content[i + j]))
    customers.append(tuple(c))
i += ncustomers
vehicle_capacity = int(content[i])
args.output.write('vehicle_capacity = {};\n'.format(vehicle_capacity))
i += 1
args.output.write('capacities = [')
t = []
for j in range(ndepots):
    t.append(content[i + j])
args.output.write(','.join(t))
args.output.write('];\n')
i += ndepots
args.output.write('demands = [')
t = []
for j in range(ncustomers):
    t.append(content[i + j])
args.output.write(','.join(t))
args.output.write('];\n')
i += ncustomers
args.output.write('opening_cost = [')
t = []
for j in range(ndepots):
    t.append(content[i + j])
args.output.write(','.join(t))
args.output.write('];\n')
i += ndepots
args.output.write('route_cost = {};\n'.format(content[i]))
args.output.write('% the distance matrix is indexed as follows:\n')
args.output.write('% * the first ncustomers elements are the customers\n')
args.output.write('% * the elements between ncustomers + 1 and ncustomers + ndepots are depots\n')
args.output.write('distances = array2d(1..{}, 1..{}, [{}]);\n'.format(ncustomers + ndepots, ncustomers + ndepots, 
    ','.join([str(dist(i, j, customers, depots)) for i in range(ncustomers + ndepots) for j in range(ncustomers + ndepots)])))
