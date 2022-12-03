with open("inputs/01.txt", "r") as f:
    inputs = f.readlines()

top_three = [0, 0, 0]
current_calories = 0

for input in inputs:
    if input == "\n":
        if current_calories > top_three[0]:
            top_three = sorted(top_three[1:] + [current_calories])
        current_calories = 0
        continue

    current_calories += int(input[:-1])

print("Top 1:", max(top_three))
print("Top 3:", sum(top_three))
