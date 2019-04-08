frequency = 0

with open("input.txt", "r") as fp:
    for line in fp:
        if line[0] == "+":
            frequency += int(line[1:])
        else:
            frequency -= int(line[1:])

print(frequency)