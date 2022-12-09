with open("inputs/08.txt", "r") as f:
    inputs = f.read().splitlines()


grid = []

for line in inputs:
    grid.append([int(v) for v in [*line]])


len_x = len(grid[0])
len_y = len(grid)

# The border is always visible
visible = (len_x + len_y - 2) * 2

max_score = 0

for col in range(1, len_x - 1):
    for row in range(1, len_y - 1):
        current = grid[row][col]

        up = [r[col] for r in grid[:row]]
        down = [r[col] for r in grid[row + 1 :]]
        left = grid[row][:col]
        right = grid[row][col + 1 :]

        if any(all(tree < current for tree in dir) for dir in [up, down, left, right]):
            visible += 1

        def count_visible(height, trees):
            i = 0
            for tree in trees:
                if tree >= height:
                    i += 1
                    break
                i += 1
            return i

        i = count_visible(current, reversed(up))
        j = count_visible(current, down)
        k = count_visible(current, reversed(left))
        l = count_visible(current, right)

        if (score := i * j * k * l) > max_score:
            max_score = score


print("Visible trees:", visible)
print("Maximum scenic score:", max_score)
