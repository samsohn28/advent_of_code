from intcode import calculate
from itertools import permutations

def get_thruster_signal(ps_seq, memory):
    return 0

with open("input.txt") as _file:
    ps_sequences = list(permutations([0,1,2,3,4]))
    memory = _file.split(",")
    max_thruster_signal = 0
    for ps_seq in ps_sequences:
        thruster_signal = get_thruster_signal(ps_seq, memory[:])
        if thruster_signal > max_thruster_signal:
            max_thruster_signal = thruster_signal
    return max_thruster_signal