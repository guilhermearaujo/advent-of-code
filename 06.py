with open("inputs/06.txt", "r") as f:
    inputs = f.read().splitlines()


def find_different(input, length):
    i = 0

    while len(set([*input[i : i + length]])) < length:
        i += 1

    return i + length


print("Start of packet", find_different(inputs[0], 4))
print("Start of message", find_different(inputs[0], 14))
