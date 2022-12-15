with open("inputs/14.txt", "r") as f:
    inputs = f.read().splitlines()


MAP = {}
max_y = 0

# True = rock or sand
# False = air
def assign(x, y, value):
    key = f"{x},{y}"
    MAP[key] = MAP.get(key, True) and value


for line in inputs:
    coords = [[int(v) for v in coord.split(",")] for coord in line.split(" -> ")]
    x0, y0 = coords.pop(0)

    for x, y in coords:
        max_y = max(y, max_y)

        if x == x0:
            start, end = sorted([y, y0])

            for i in range(0, end + 1):
                assign(x, i, i < start)

        elif y == y0:
            start, end = sorted([x, x0])

            for j in range(start, end + 1):
                for k in range(0, y + 1):
                    assign(j, k, y > k)

        x0, y0 = x, y


class AbyssError(Exception):
    pass


def drop_sand(x, y, abyss=True):
    try:
        while MAP[f"{x},{y + 1}"]:
            y += 1

        if MAP[f"{x - 1},{y + 1}"]:
            drop_sand(x - 1, y + 1, abyss)
        elif MAP[f"{x + 1},{y + 1}"]:
            drop_sand(x + 1, y + 1, abyss)
        else:
            MAP[f"{x},{y}"] = False
    except KeyError:
        if abyss:
            raise AbyssError()

        end = max_y + 2

        for i in range(0, end + 1):
            for j in [x - 1, x, x + 1]:
                assign(j, i, i < end)
        drop_sand(x, y, False)


units = 0

try:
    while True:
        drop_sand(500, 0)
        units += 1
except AbyssError:
    print("Flows into the abyss at:", units)


while MAP["500,0"]:
    drop_sand(500, 0, False)
    units += 1

print("Blocks the source at:", units)
