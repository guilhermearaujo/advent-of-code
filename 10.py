with open("inputs/10.txt", "r") as f:
    inputs = f.read().splitlines()

X = 1

CYCLE = 0

SIGNAL_STRENTH = 0


GRID = [([False] * 40) for _ in range(6)]


def draw(line, col):
    global X, GRID

    if col in [X - 1, X, X + 1]:
        GRID[line][col] = True


def tick():
    global CYCLE, X, SIGNAL_STRENTH
    CYCLE += 1

    if (CYCLE + 20) % 40 == 0:
        SIGNAL_STRENTH += CYCLE * X

    draw(line=(CYCLE - 1) // 40, col=(CYCLE - 1) % 40)


for line in inputs:
    if line == "noop":
        tick()
        continue

    tick()
    v = int(line.split(" ")[-1])
    tick()
    X += v

print("Signal strength:", SIGNAL_STRENTH)
print()

for line in GRID:
    print("".join("\u2588" if i else " " for i in line))
