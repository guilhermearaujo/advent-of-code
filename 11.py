import math
import re

with open("inputs/11.txt", "r") as f:
    inputs = f.read().splitlines()


class Monkey:
    def __init__(self, id, items, operation, divisor, true_case, false_case) -> None:
        self.id = id
        self.items = items
        self.operation = operation
        self.divisor = divisor
        self.true_case = true_case
        self.false_case = false_case
        self.inspections = 0

    @classmethod
    def from_input(cls, data):
        return Monkey(
            id=re.findall(r"\d+", data[0])[0],
            items=[int(i) for i in re.findall(r"\d+", data[1])],
            operation=re.findall(r"new = (.*)", data[2])[0],
            divisor=int(re.findall(r"\d+", data[3])[0]),
            true_case=int(re.findall(r"\d+", data[4])[0]),
            false_case=int(re.findall(r"\d+", data[5])[0]),
        )


def batch(iterable, n=1):
    l = len(iterable)
    for ndx in range(0, l, n):
        yield iterable[ndx : min(ndx + n, l)]


monkeys = []


def take_turn(monkey, relief_func):
    global monkeys
    while monkey.items:
        monkey.inspections += 1

        old = monkey.items.pop(0)
        new = relief_func(eval(monkey.operation))

        index = monkey.true_case if new % monkey.divisor == 0 else monkey.false_case
        monkeys[index].items.append(new)


def run(rounds, relief):
    global monkeys
    monkeys = []

    for data in batch(inputs, 7):
        monkeys.append(Monkey.from_input(data))

    if relief:
        relief_func = lambda w: w // 3
    else:
        lcm = math.lcm(*[m.divisor for m in monkeys])
        relief_func = lambda w: w % lcm

    for _ in range(rounds):
        for m in monkeys:
            take_turn(m, relief_func)

    for m in monkeys:
        print(f"Monkey {m.id} inspected items {m.inspections} times")
    print()

    top_two = sorted([m.inspections for m in monkeys], reverse=True)[:2]
    print("Level of monkey business:", math.prod(top_two), "\n")


run(20, relief=True)
run(10_000, relief=False)
