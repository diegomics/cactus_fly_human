#! /usr/bin/env python

## Filter a posteriori intra species
## De Panis 2017

import sys
import numpy


file_in = open(sys.argv[1], 'r')
file_out_filtered = open(sys.argv[2], 'w')
file_out_prob_noise = open(sys.argv[3], 'w')

for line in file_in:
    col=line.split()
    l = [float(i) for i in col[1:9]]
    av = sum(l)/9
    dev = numpy.std(l)
    rel = av/(dev + 0.000001)
#    if av <= 1:
#    if av <= 0.75:
    if av <= 0.5:
        print(col[0] + "\t" + "too low")
        file_out_prob_noise.write(line)
        continue
    elif ((dev*100)/av) > 150 and rel < 0.5:
        print(col[0] + "\t" + "too noisy")
        file_out_prob_noise.write(line)
        continue
#    elif av > 4000 and ((dev*100)/av) > 25:
#    elif av > 6000 and ((dev*100)/av) > 30:
#    elif av > 8000 and ((dev*100)/av) > 40:
    elif av > 5000 and ((dev*100)/av) > 50:
#    elif av > 6000 and ((dev*100)/av) > 60:
#    elif av > 10000 and ((dev*100)/av) > 100:
        print(col[0] + "\t" + "too high")
        file_out_prob_noise.write(line)
        continue
    elif l.count(0) >=12:
        print(col[0] + "\t" + "too few")
        file_out_prob_noise.write(line)
        continue
    else:
        file_out_filtered.write(line)

file_in.close()
file_out_filtered.close()
file_out_prob_noise.close()
sys.exit()
