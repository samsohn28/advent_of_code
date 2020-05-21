letters = {}
twos = 0
threes = 0

with open("input.txt", "r") as fp:
    for line in fp:
        letters = {}
        for i in range(0,len(line)-1):
            letter = line[i]
            if letter in letters:
                letters[letter] += 1
            else:
                letters[letter] = 1
        if 2 in letters.values():
            twos += 1
        if 3 in letters.values():
            threes += 1

print(twos * threes)