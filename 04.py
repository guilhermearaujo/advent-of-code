with open("inputs/04.txt", "r") as f:
    inputs = f.read().splitlines()


def swap(a1, a2, b1, b2):
    return b1, b2, a1, a2


full_overlap = 0
some_overlap = 0


for input in inputs:
    a, b = input.split(",")
    a1, a2 = [int(v) for v in a.split("-")]
    b1, b2 = [int(v) for v in b.split("-")]

    if a1 > b1 or (a1 == b1 and a2 < b2):
        a1, a2, b1, b2 = swap(a1, a2, b1, b2)

    if a1 <= b1 <= a2:
        some_overlap += 1

        if a1 <= b2 <= a2:
            full_overlap += 1

print("Full overlap:", full_overlap)
print("Some overlap:", some_overlap)
