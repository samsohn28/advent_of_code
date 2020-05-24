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

def get_orbits_list(orbits, obj):
    if obj not in orbits:
        return []
    else:
        return [orbits[obj]]+get_orbits_list(orbits,orbits[obj])

def total_orbits(orbits, objects):
    total = 0
    for obj in objects:
        total += get_orbits(orbits, obj)
    print(total)

def orbital_transfers_required(from_obj, to_obj, orbits, objects):
    common_objs = set(get_orbits_list(orbits,from_obj)).intersection(get_orbits_list(orbits,to_obj))
    to_steps = 0
    from_steps = 0
    from_obj = orbits[from_obj]
    to_obj = orbits[to_obj]
    while from_obj != to_obj:
        if from_obj not in common_objs:
            from_obj = orbits[from_obj]
            from_steps += 1
        if to_obj not in common_objs:
            to_obj = orbits[to_obj]
            to_steps += 1
    return from_steps + to_steps


# with open("input1.txt") as _file:
#     orbits, objects = get_hash_set(_file)
#     print(orbital_transfers_required("YOU","SAN",orbits,objects))

with open("input.txt") as _file:
    orbits, objects = get_hash_set(_file)
    # part1
    total_orbits(orbits, objects)
    # part2
    print(orbital_transfers_required("YOU","SAN",orbits,objects))