with open("inputs/07.txt", "r") as f:
    inputs = f.read().splitlines()


def new_dir():
    return {"dirs": {}, "files": [], "size": 0}


def print_tree(tree, depth=0, indent=2):
    if depth == 0:
        print("\033[94m/\033[0m", f"\033[92m(dir, size={tree['size']})\033[0m")

    for name, dir in tree["dirs"].items():
        print(
            "⤷".rjust(depth * indent),
            f"\033[94m/{name}\033[0m",
            f"\033[92m(dir, size={dir['size']})\033[0m",
        )
        print_tree(dir, depth + 1)

    for name, size in tree["files"]:
        print(
            " ".rjust(depth * indent), f"\033[91m{name}\033[0m", f"(file, size={size})"
        )

    if depth == 0:
        print()


total_space = 70_000_000
root = new_dir()
cwd = root
path = "/"

for line in inputs:
    if line == "$ ls":
        continue

    if line == "$ cd /":
        cwd = root
        path = "/"
        continue

    if line == "$ cd ..":
        path_components = path.split("/")[:-2]
        path = "/".join(path_components) + "/"
        cwd = root
        for dir in path_components[1:]:
            cwd = cwd["dirs"][dir]
        continue

    if line.startswith("$ cd"):
        dir = line.split(" ")[-1]
        cwd = cwd["dirs"][dir]
        path += dir + "/"
        continue

    if line.startswith("dir"):
        dir = line.split(" ")[-1]
        if dir not in cwd:
            cwd["dirs"][dir] = new_dir()
        continue

    size, filename = line.split(" ")
    cwd["files"].append([filename, int(size)])


def calculate_dir_sizes(tree):
    for dir in tree["dirs"].values():
        tree["size"] += calculate_dir_sizes(dir)

    tree["size"] += sum(size for _, size in tree["files"])

    return tree["size"]


def sum_small_dirs_once(tree, max_size):
    acc = 0
    for dir in tree["dirs"].values():
        if dir["size"] <= max_size:
            acc += dir["size"]
        else:
            acc += sum_small_dirs_once(dir, max_size)

    return acc


def sum_small_dirs(tree, max_size):
    acc = 0
    for dir in tree["dirs"].values():
        if dir["size"] <= max_size:
            acc += dir["size"]
        acc += sum_small_dirs(dir, max_size)

    return acc


def find_smaller_dir(path, tree, required_space):
    min_path = path
    min_size = tree["size"]

    if tree["size"] <= required_space:
        return min_path, min_size

    for name, dir in tree["dirs"].items():
        _path, size = find_smaller_dir(f"{path}{name}/", dir, required_space)
        if required_space <= size < min_size:
            min_path = _path
            min_size = size

    return min_path, min_size


calculate_dir_sizes(root)
print_tree(root)

print("Sum of dirs smaller than 100000:", sum_small_dirs(root, 100_000))


free_space = total_space - root["size"]
required_space = 30_000_000 - free_space

path, size = find_smaller_dir("/", root, required_space)
print("Smaller dir that frees enough space:", path, f"(size={size})")
