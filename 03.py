with open("inputs/03.txt", "r") as f:
    inputs = f.read().splitlines()


def calculate_priority(item):
    if item >= "a":
        return ord(item) - ord("a") + 1
    else:
        return ord(item) - ord("A") + 27


priorities = 0
badge_priorities = 0
group = []

for input in inputs:
    l = len(input) // 2

    repeated = set(input[:l]).intersection(set(input[l:])).pop()

    priorities += calculate_priority(repeated)

    group.append(set(input))

    if len(group) == 3:
        badge = group[0].intersection(group[1]).intersection(group[2]).pop()
        badge_priorities += calculate_priority(badge)
        group = []


print(priorities)
print(badge_priorities)
