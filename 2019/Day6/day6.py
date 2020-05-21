# Day 6: Universal Orbit Map

def get_hash_set(_file):
    orbits = {}
    objects = set()

    for line in _file:
        primary, satellite = line.rstrip().split(")")
        orbits[satellite] = primary
        objects.add(satellite)
        objects.add(primary)
    
    return orbits, objects

def get_orbits(orbits, obj):
    if obj not in orbits:
        return 0
    else:
        return 1 + get_orbits(orbits, orbits[obj])

def total_orbits(orbits, objects):
    total = 0
    for obj in objects:
        total += get_orbits(orbits, obj)
    print(total)


with open("input.txt") as _file:
    orbits, objects = get_hash_set(_file)
    # part1
    total_orbits(orbits, objects)
    
