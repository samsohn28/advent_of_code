

def calculate(initnum1, initnum2, memory):
    #import pdb; pdb.set_trace()

    pointer = 0
    opcode = memory[pointer]
    memory[1] = initnum1
    memory[2] = initnum2

    while opcode != 99:
        operand1 = memory[memory[pointer + 1]]
        operand2 = memory[memory[pointer + 2]]
        instruction3 = memory[pointer + 3]

        if opcode == 1:
            memory[instruction3] = operand1 + operand2
        elif opcode == 2:
            memory[instruction3] = operand1 * operand2

        pointer += 4
        opcode = memory[pointer]
    
    return memory[0]

with open("input.txt", "r") as fp:
    memory = map(int,fp.readline().split(","))
    # Solution for part 1
    print(calculate(12,2,list(memory)))

    # Solution for part 2
    target = 19690720
    for noun in range(100):
        for verb in range(100):
            if calculate(noun,verb,memory[:]) == target:
                print(100 * noun + verb)
                break