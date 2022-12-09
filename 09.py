with open("inputs/09.txt", "r") as f:
    inputs = f.read().splitlines()


def pos(x, y):
    return f"({x},{y})"


def move_tail(rope_x, rope_y):
    for i in range(1, len(rope_x)):
        prev_x = rope_x[i - 1]
        prev_y = rope_y[i - 1]

        match prev_x - rope_x[i], prev_y - rope_y[i]:
            case 2, 2:
                rope_x[i] += 1
                rope_y[i] += 1
            case 2, -2:
                rope_x[i] += 1
                rope_y[i] -= 1
            case -2, 2:
                rope_x[i] -= 1
                rope_y[i] += 1
            case -2, -2:
                rope_x[i] -= 1
                rope_y[i] -= 1

            case 2, 0:
                rope_x[i] += 1
            case 2, _:
                rope_x[i] += 1
                rope_y[i] = prev_y

            case -2, 0:
                rope_x[i] -= 1
            case -2, _:
                rope_x[i] -= 1
                rope_y[i] = prev_y

            case 0, 2:
                rope_y[i] += 1
            case _, 2:
                rope_x[i] = prev_x
                rope_y[i] += 1

            case 0, -2:
                rope_y[i] -= 1
            case _, -2:
                rope_x[i] = prev_x
                rope_y[i] -= 1

    return rope_x, rope_y


def move_head(commands, number_of_tail_knots):
    rope_x = rope_y = [0] * (1 + number_of_tail_knots)

    tail_positions = {}

    for command in commands:
        direction, count = command.split(" ")

        for _ in range(int(count)):
            match direction:
                case "U":
                    rope_y[0] += 1
                case "D":
                    rope_y[0] -= 1
                case "R":
                    rope_x[0] += 1
                case "L":
                    rope_x[0] -= 1

            rope_x, rope_y = move_tail([*rope_x], [*rope_y])

            current = pos(rope_x[-1], rope_y[-1])
            tail_positions[current] = tail_positions.get(current, 0) + 1

    return tail_positions


print("Tail with 1 knot:", len(move_head(inputs, 1)))
print("Tail with 9 knots:", len(move_head(inputs, 9)))
