import time

# Making a really slow brute force solution
def wiremap(wire):
    x = 0
    y = 0
    locations = []
    for instruction in wire:
        direction = instruction[0]
        distance = int(instruction[1:])
        if direction == "U":
            for i in range(distance):
                y += 1
                locations.append((x,y))
        elif direction == "D":
            for i in range(distance):
                y -= 1
                locations.append((x,y))
        elif direction == "R":
            for i in range(distance):
                x += 1
                locations.append((x,y))
        elif direction == "L":
            for i in range(distance):
                x -= 1
                locations.append((x,y))
    return locations

def checkintersections(wire1, wire2):
    time1 = perf_counter()
    intersections = []
    for location in wire1:
        if (location in wire2) and (location not in intersections):
            intersections.append(location)
    time2 = perf_counter()
    print("Intersections time: " + str(time2 - time1))
    return intersections

def closest(intersections):
    result = 0
    for location in intersections:
        current = abs(location[0] - 0) + abs(location[1] - 0)
        if current < result or result == 0:
            result = current
    return result

def checksteps(wire1, wire2, intersections):
    result = 0
    for location in intersections:
        current = wire1.index(location) + wire2.index(location) + 2
        if current < result or result == 0:
            result = current
    return result

#wire1 = wiremap(['R75','D30','R83','U83','L12','D49','R71','U7','L72'])
#wire2 = wiremap(['U62','R66','U55','R34','D71','R55','D58','R83'])

# wire1 = wiremap(['R98','U47','R26','D63','R33','U87','L62','D20','R33','U53','R51'])
# wire2 = wiremap(['U98','R91','D20','R16','D67','R40','U7','R15','U6','R7'])

# print(checksteps(wire1, wire2, checkintersections(wire1, wire2)))


with open("input.txt") as _file:
    time1 = time.perf_counter()
    wire1 = wiremap(_file.readline().split(","))
    time2 = time.perf_counter()
    print("wire1 time: " + str(time2 - time1))
    
    time1 = time.perf_counter()
    wire2 = wiremap(_file.readline().split(","))
    time2 = time.perf_counter()
    print("wire2 time: " + str(time2 - time1))
#     print(closest(checkintersections(wiremap(wire1),wiremap(wire2))))
    print(checksteps(wire1, wire2, checkintersections(wire1, wire2)))