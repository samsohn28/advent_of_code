

def calculate(input, memory):
    #import pdb; pdb.set_trace()

    pointer = 0
    parameter = memory[pointer]
    teststring = ""
    
    # Get the opcode and parameters
    opcode = parameter % 100

    while opcode != 99:

        # Get mode of 1st parameter
        parameter = parameter / 100
        parameter1 = parameter % 10

        # Get mode of 2nd parameter
        parameter = parameter / 10
        parameter2 = parameter % 10

        #Get mode of 3rd parameter
        parameter = parameter / 10
        parameter3 = parameter % 10

        if opcode in (1,2,7,8):
            instruction1 = memory[pointer + 1]
            instruction2 = memory[pointer + 2]
            instruction3 = memory[pointer + 3]

            if parameter1 == 0:
                operand1 = memory[instruction1]
            elif parameter1 == 1:
                operand1 = instruction1

            if parameter2 == 0:
                operand2 = memory[instruction2]
            elif parameter2 == 1:
                operand2 = instruction2

            if opcode == 1:
                memory[instruction3] = operand1 + operand2  
            elif opcode == 2:
                memory[instruction3] = operand1 * operand2
            elif opcode == 7:
                if operand1 < operand2:
                    memory[instruction3] = 1 
                else:
                    memory[instruction3] = 0
            elif opcode == 8:
                if operand1 == operand2:
                    memory[instruction3] = 1
                else:
                    memory[instruction3] = 0

            pointer += 4

        elif opcode == 3:
            instruction1 = memory[pointer + 1]
            memory[instruction1] = input
            pointer += 2

        elif opcode == 4:
            instruction1 = memory[pointer + 1]
            #teststring = teststring + str(memory[instruction1])
            if parameter1 == 0:
                teststring = teststring + str(memory[instruction1])
            elif parameter1 == 1:
                teststring = teststring + str(instruction1)
            pointer += 2

        elif opcode in (5,6):
            instruction1 = memory[pointer + 1]
            instruction2 = memory[pointer + 2]

            if parameter1 == 0:
                operand1 = memory[instruction1]
            else:
                operand1 = instruction1
            
            if parameter2 == 0:
                operand2 = memory[instruction2]
            else:
                operand2 = instruction2

            if opcode == 5 and operand1 != 0:
                pointer = operand2
            elif opcode == 6 and operand1 == 0:
                pointer = operand2
            else:
                pointer += 3

        parameter = memory[pointer]
        opcode = parameter % 100
    
    print(teststring)


# memory = [3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9]

with open("input.txt", "r") as fp:
    memory = map(int,fp.readline().split(","))
    
#     # Day 5: part 1
#     input = 1
#     calculate(input, memory[:])

    #   Day 5: part 2
    input = 5
    calculate(input,memory[:])