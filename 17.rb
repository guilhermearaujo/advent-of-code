require 'digest'

class Node
  attr_reader :coordinate
  attr_accessor :up, :down, :left, :right, :door_used

  X = 0
  Y = 1

  def initialize(coordinate = [0, 0])
    @coordinate = coordinate
  end

  def lockdown?
    !(up || down || left || right)
  end
end

def check_doors(node, path)
  up, down, left, right = Digest::MD5.hexdigest("#{PASSWORD}#{path}")[0..3].split(//)

  node.up    = up    > ?a && node.coordinate[Node::Y] > 0 if node.up == nil
  node.down  = down  > ?a && node.coordinate[Node::Y] < 3 if node.down == nil
  node.left  = left  > ?a && node.coordinate[Node::X] > 0 if node.left == nil
  node.right = right > ?a && node.coordinate[Node::X] < 3 if node.right == nil
end

def pick_door(node)
  case
  when node.up    then ?U
  when node.down  then ?D
  when node.left  then ?L
  when node.right then ?R
  else false
  end
end

def next_node(current)
  x, y = current.coordinate

  case current.door_used
  when ?U then y -= 1
  when ?D then y += 1
  when ?L then x -= 1
  when ?R then x += 1
  end

  Node.new([x, y])
end

def lock_door(node)
  case node.door_used
  when ?U then node.up    = false
  when ?D then node.down  = false
  when ?L then node.left  = false
  when ?R then node.right = false
  end
  node.door_used = nil
end

def find_path(path = [Node.new], limit = Float::INFINITY)
  node = path.last

  while node.coordinate != [3, 3]
    check_doors(node, path.map(&:door_used).join)

    if node.lockdown? || path.length >= limit
      path.pop

      return nil if path.empty?

      lock_door(path.last)
    else
      node.door_used = pick_door(node)
      path << next_node(node)
    end

    node = path.last
  end

  path
end

path = find_path

######################################################################

print 'Part 1: '

def find_shortest(shortest_path)
  loop do
    alt_path = shortest_path.map { |n| n.dup }

    alt_path.pop
    lock_door(alt_path.last)

    while alt_path.last.lockdown?
      alt_path.pop
      lock_door(alt_path.last)
    end

    shorter = find_path(alt_path, shortest_path.length)
    break if shorter == nil

    shortest_path = shorter
  end

  shortest_path
end

PASSWORD = 'pxxbnzuo'.freeze

shortest = find_shortest(path)

puts "The shortest path to the vault is #{shortest.map(&:door_used).join}"

######################################################################

print 'Part 2: '

def find_longest(current_path)
  longest_path = current_path.map { |n| n.dup }

  loop do
    alt_path = current_path.map { |n| n.dup }

    alt_path.pop(1)
    lock_door(alt_path.last)

    while alt_path.last.lockdown?
      alt_path.pop
      lock_door(alt_path.last)
    end

    longer = find_path(alt_path)
    break if longer == nil

    if longer.length >= current_path.length
      current_path = longer
    else
      current_path.pop
    end

    longest_path = current_path.map { |n| n.dup } if current_path.length > longest_path.length
  end

  longest_path
end

longest = find_longest(path)

puts "The longest path to the vault requires #{longest.count - 1} steps"
