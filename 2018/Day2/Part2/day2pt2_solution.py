# We will sort the data and then go through it in 1 pass

fp = open('input.txt', 'r')
lines = fp.readlines()
lines.sort()

last = ''
mismatch_count = 0
mismatch_letter = ''

for line in lines:
    if not last:
        last = line
    else:
        for i in range (0,len(line)-1):
            if last[i] != line[i]:
                mismatch_count += 1
                mismatch_letter = last[i]
        if mismatch_count == 1:
            print(last)
            print(line)
            break
        else:
            mismatch_count = 0
            mismatch_letter = ''
            last = line

            