fuelReq = 0

with open("input.txt", "r") as fp:
    for line in fp:
        fuelReq += (int(line) / 3) - 2

print(fuelReq)