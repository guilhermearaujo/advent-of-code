import re
from typing import List

with open("inputs/05.txt", "r") as f:
    inputs = f.read().splitlines()


class Crate:
    def __init__(self, label, bottom_crate):
        self.label = label
        self.bottom_crate = bottom_crate


def load_stacks(data):
    length = int(data.pop(0).split(" ")[-1])
    stacks: List[Crate | None] = [None] * length

    for row in data:
        for col, label in enumerate(row[1::4]):
            if label != " ":
                bottom_crate = stacks[col]
                stacks[col] = Crate(label, bottom_crate)

    return stacks


stacks_part1 = load_stacks(list(reversed(inputs[:9])))
stacks_part2 = load_stacks(list(reversed(inputs[:9])))


def operate_crane_9000(stack, quantity, source, destination):
    for _ in range(quantity):
        moving_crate = stack[source]
        stack[source] = moving_crate.bottom_crate
        moving_crate.bottom_crate = stack[destination]
        stack[destination] = moving_crate


def operate_crane_9001(stack, quantity, source, destination):
    top_crate = stack[source]
    moving_crate = top_crate

    for _ in range(quantity - 1):
        moving_crate = moving_crate.bottom_crate

    stack[source] = moving_crate.bottom_crate
    moving_crate.bottom_crate = stack[destination]
    stack[destination] = top_crate


def print_top_crates(stacks):
    print("".join([crate.label if crate else " " for crate in stacks]))


for command in inputs[10:]:
    if params := re.match(r"move (\d+) from (\d+) to (\d+)", command):
        quantity, source, destination = (
            int(params[1]),
            int(params[2]) - 1,
            int(params[3]) - 1,
        )
        operate_crane_9000(stacks_part1, quantity, source, destination)
        operate_crane_9001(stacks_part2, quantity, source, destination)

print_top_crates(stacks_part1)
print_top_crates(stacks_part2)
