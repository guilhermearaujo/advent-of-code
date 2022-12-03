with open("inputs/02.txt", "r") as f:
    inputs = f.readlines()

SHAPE_SCORE = {
    "A": 1,
    "B": 2,
    "C": 3,
}

GAME = "ABCABC"


def calculate_1st_strategy(theirs, mine):
    mine = chr(ord(mine) - 23)
    points = SHAPE_SCORE[mine]

    if theirs == mine:
        return points + 3

    i = GAME.index(theirs)
    if GAME[i:].index(mine) == 1:
        return points + 6

    return points


def calculate_2nd_strategy(theirs, outcome):
    match outcome:
        case "X":  # Lose
            mine = GAME[GAME.index(theirs) - 1]
            points = 0
        case "Y":  # Draw
            mine = theirs
            points = 3
        case _:  # Win
            mine = GAME[GAME.index(theirs) + 1]
            points = 6

    return points + SHAPE_SCORE[mine]


total_1 = 0
total_2 = 0

for first, _, second, _ in inputs:
    total_1 += calculate_1st_strategy(first, second)
    total_2 += calculate_2nd_strategy(first, second)

print(total_1)
print(total_2)
