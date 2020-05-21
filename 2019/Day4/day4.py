
# Part 1
# def has_repeat(num):
#     for i in range(len(num) - 1):
#         if num[i] == num[i+1]:
#             return True
#     return False

def has_repeat(num):
    start = 0
    end = 1
    while True:
        if end >= len(num):
            if end - start == 2:
                return True
            return False
        elif num[start] == num[end]:
            end += 1
        elif num[start] != num[end]:
            if (end - start == 2):
                return True
            start = end
            end += 1

def is_increasing(num):
    for i in range(len(num) - 1):
        if num[i] > num[i+1]:
            return False
    return True

def checkpossibilities(start,end):
    count = 0
    current = start
    while current != end:
        if has_repeat(current) and is_increasing(current):
            count += 1
        current = str(int(current) + 1)
    return count

#input = "359282-820401"
print(checkpossibilities("359282","820401"))