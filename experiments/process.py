import sys
from os import listdir
from os.path import isfile, join

if (len(sys.argv) != 3):
    print "Usage: process.py {client for HotStuff | order or exec for Pompe} {result dir}"
    exit()

files = [f for f in listdir("./" + sys.argv[2]) if isfile(join("./" + sys.argv[2], f))]
#print onlyfiles

count = 0
latencies = []
average = 0.0
for file in files:
    if sys.argv[1] in file:
        f = open("./" + sys.argv[2] + "/" + file, "r")
        for line in f.readlines():
            count = count + 1
            latencies.append(float(line.split()[-1]))
            average = average + float(line.split()[-1])

latencies.sort()

latency50 = latencies[int(count * 0.5)]
latency90 = latencies[int(count * 0.9)]
latency99 = latencies[int(count * 0.99)]
average = average / count

#print latencies
print "Total:", count, " transactions"
print "50%: ", latency50 * 1000
print "90%: ", latency90 * 1000
print "99%: ", latency99 * 1000
print "Average: ", average * 1000

