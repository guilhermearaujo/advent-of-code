import json

from functools import cmp_to_key


with open("inputs/13.txt", "r") as f:
    inputs = f.read().splitlines()


def batch(iterable, n=1):
    l = len(iterable)
    for ndx in range(0, l, n):
        yield iterable[ndx : min(ndx + n, l)]


def compare(lhs, rhs):
    if isinstance(lhs, int) and isinstance(rhs, int):
        if lhs < rhs:
            return -1
        if lhs > rhs:
            return 1
        return 0

    elif isinstance(lhs, list) and isinstance(rhs, list):
        for i in range(len(lhs)):
            try:
                if (ret := compare(lhs[i], rhs[i])) != 0:
                    return ret
            except IndexError:
                return 1

        if len(rhs) > len(lhs):
            return -1

    elif isinstance(lhs, int):
        if (ret := compare([lhs], rhs)) != 0:
            return ret

    else:
        if (ret := compare(lhs, [rhs])) != 0:
            return ret

    return 0


sum = 0
packet = 1

DIVIDER_1 = [[2]]
DIVIDER_2 = [[6]]

PACKETS = [DIVIDER_1, DIVIDER_2]

for line_1, line_2, *_ in batch(inputs, 3):
    packet_1 = json.loads(line_1)
    packet_2 = json.loads(line_2)

    if compare(packet_1, packet_2) < 1:
        sum += packet
        PACKETS += [packet_1, packet_2]
    else:
        PACKETS += [packet_2, packet_1]

    packet += 1


PACKETS = sorted(PACKETS, key=cmp_to_key(compare))

print("Sum of indeces:", sum)
print("Decoder key:", (PACKETS.index(DIVIDER_1) + 1) * (PACKETS.index(DIVIDER_2) + 1))
