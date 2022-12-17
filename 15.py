import re

with open("inputs/15.txt", "r") as f:
    inputs = f.read().splitlines()


def distance(x1, y1, x2, y2):
    return abs(x1 - x2) + abs(y1 - y2)


class Beacon:
    def __init__(self, x, y) -> None:
        self.x = int(x)
        self.y = int(y)


class Sensor:
    def __init__(self, x, y, beacon) -> None:
        self.x = int(x)
        self.y = int(y)
        self.beacon = beacon

    @property
    def radius(self):
        return distance(self.x, self.y, self.beacon.x, self.beacon.y)


SENSORS = []
for line in inputs:
    matches = re.match(
        r"Sensor at x=(-?\d+), y=(-?\d+): closest beacon is at x=(-?\d+), y=(-?\d+)",
        line,
    )
    SENSORS.append(Sensor(matches[1], matches[2], Beacon(matches[3], matches[4])))


def count(target_y):
    line = set()
    for sensor in SENSORS:
        if not (sensor.y - sensor.radius <= target_y <= sensor.y + sensor.radius):
            continue

        delta_y = abs(target_y - sensor.y)
        for x in range(
            sensor.x - (sensor.radius - delta_y),
            sensor.x + (sensor.radius - delta_y),
        ):
            line.add(x)

    return len(line)


print("Positions without a beacon:", count(2_000_000))


def find_distress_beacon(max):
    def is_unreachable(x, y):
        return (
            0 <= x < max
            and 0 <= y < max
            and all(
                distance(s.x, s.y, x, y) > s.radius
                for s in set(SENSORS).difference({sensor})
            )
        )

    for sensor in SENSORS:
        # For each sensor, start right above its top vertex and navigate clockwise
        x = sensor.x
        y = sensor.y + sensor.radius + 1

        while y < sensor.y:
            if is_unreachable(x, y):
                return x, y
            x += 1
            y += 1
        while x > sensor.x:
            if is_unreachable(x, y):
                return x, y
            x -= 1
            y += 1
        while y > sensor.y:
            if is_unreachable(x, y):
                return x, y
            x -= 1
            y -= 1
        while x < sensor.x:
            if is_unreachable(x, y):
                return x, y
            x += 1
            y -= 1
    raise Exception("Could not find")


x, y = find_distress_beacon(4_000_000)

print("Distress signal tuning frequency:", 4_000_000 * x + y)
