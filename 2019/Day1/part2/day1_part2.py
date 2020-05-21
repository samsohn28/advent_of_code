totalFuel = 0

def calculateFuel(fuel):
    if fuel <= 0:
        return 0
    else:
        return fuel + calculateFuel((fuel / 3) - 2)

with open("input.txt", "r") as fp:
    for line in fp:
        moduleMass = int(line)
        totalFuel += calculateFuel((moduleMass / 3) - 2)
        
print(totalFuel)