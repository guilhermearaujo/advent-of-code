with open("inputs/12.txt", "r") as f:
    inputs = f.read().splitlines()

GRID = []


class UnreachableNodeError(Exception):
    pass


class TooManyStepsError(Exception):
    pass


class Node:
    def __init__(self, char) -> None:
        if char == "S":
            char = "a"
        elif char == "E":
            char = "z"

        self.value = ord(char) - ord("a")
        self.neighbors = set()


other_start_nodes = []

for row, line in enumerate(inputs):
    GRID.append([])

    for col, char in enumerate(line):
        node = Node(char=char)

        if char == "S":
            start_node = node
        elif char == "E":
            end_node = node
        elif char == "a":
            other_start_nodes.append(node)

        GRID[row].append(node)

        if row > 0:
            up_node = GRID[row - 1][col]
            if up_node.value <= node.value + 1:
                node.neighbors.add(up_node)
            if node.value <= up_node.value + 1:
                up_node.neighbors.add(node)

        if col > 0:
            left_node = GRID[row][col - 1]
            if left_node.value <= node.value + 1:
                node.neighbors.add(left_node)
            if node.value <= left_node.value + 1:
                left_node.neighbors.add(node)


def find_distance(start_node, end_node, ignored_nodes, limit=None):
    past_nodes = set(ignored_nodes)
    current_nodes = set([start_node])
    steps = 0

    while True:
        steps += 1
        next_nodes = set()

        # Find other nodes that can be reached
        for node in current_nodes:
            next_nodes = next_nodes.union(set(node.neighbors))
        # But discard those which have been visited before (avoid loops)
        next_nodes.discard(past_nodes)

        if end_node in next_nodes:
            return steps

        if len(next_nodes) == 0:
            raise UnreachableNodeError()
        if limit and steps >= limit:
            raise TooManyStepsError()

        past_nodes = current_nodes
        current_nodes = next_nodes


min_steps = find_distance(start_node, end_node, [])

print("Minimun steps from S:", min_steps)

ignored_nodes = [start_node]
for node in other_start_nodes:
    # Skip anything inside "an island", because only the edge will matter
    if {n.value for n in node.neighbors} == {node.value}:
        continue

    try:
        min_steps = find_distance(node, end_node, ignored_nodes, min_steps)
    except (TooManyStepsError, UnreachableNodeError):
        pass

    ignored_nodes.append(node)

print("Minimun steps from a:", min_steps)
