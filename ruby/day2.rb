# Find out how to access files with and without code blocks. What is the benefit of the code block?

# With code blocks
File.open "file.txt" do |f|
  if f then
    # parent process
    puts "Got: #{f.gets}"
  else
    # child process
    puts "in Child"
  end
end

# Without code blocks
file = File.open('file.txt', 'r')

if file.nil?
  # child process
  puts "in Child"
  exit
else
  # parent process
  puts "Got: #{file.gets}"
end

# How would you translate a hash to an array? Can you translate arrays to hashes?

hash = { "a"=>["a", "b", "c"], "b"=>["b", "c"] } # {"a"=>["a", "b", "c"], "b"=>["b", "c"]}
hash.values # [["a", "b", "c"], ["b", "c"]]
hash.map { |key, value| value } # [["a", "b", "c"], ["b", "c"]]
hash.collect { |k, v| v } # [["a", "b", "c"], ["b", "c"]]

array = ["a", "b", "c", "d"] # ["a", "b", "c", "d"]
Hash[*array] # {"a"=>"b", "c"=>"d"}
Hash[array.each_slice(2).to_a] # {"a"=>"b", "c"=>"d"}
[["a", "b"], ["c", "d"]].to_h # {"a"=>"b", "c"=>"d"}

# Print the contents of an array of sixteen numbers, four numbers at a time, using just each. Now, do the same with each_slice in Enumerable.

buffer = []

(1..16).to_a.each do |num|
  buffer.push(num)
  if  num % 4 == 0
    puts buffer, '----'
    buffer = [] if num % 4 == 0
  end
end

(1..16).to_a.each_slice(4) {|num| puts num, '----'}

# The Tree class was interesting, but it did not allow you to specify a new tree with a clean user interface. Let the initializer accept a nested structure with hashes and arrays. You should be able to specify a tree like this: {’grandpa’ => { ’dad’ => {’child 1’ => {}, ’child 2’ => {} }, ’uncle’ => {’child 3’ => {}, ’child 4’ => {} } } }.

class Tree
  attr_accessor :children, :node_name

  def initialize(name, children = [])
    @node_name
    @children

    if name.is_a?(Hash)
      name, children = name.first
      @node_name = name
      @children = children
    end

    @node_name = name
    @children = children
  end

  def visit_all(&block)
    visit(&block)
    @children.each { |c| c.visit_all &block } if @children.is_a?(Array)
    @children.each { |c| Tree.new(Hash[*c]).visit_all &block } if @children.is_a?(Hash)
  end

  def visit(&block)
    block.call self
  end
end

ruby_tree = Tree.new("Ruby", [Tree.new("Reia"), Tree.new("MacRuby")])

puts 'Visiting a node'
ruby_tree.visit {|node| puts node.node_name}
puts

puts "Visiting entire tree"
ruby_tree.visit_all {|node| puts node.node_name}
puts

puts 'Visiting real tree'
tree = { 'grandpa' => { 'dad' => { 'child1' => {}, 'child2' => {} }, 'uncle' => { 'child3' => {}, 'child4' => {} } } }
ruby_real_tree = Tree.new(tree)
puts
puts 'Visiting a node'
ruby_real_tree.visit {|node| puts node.node_name}
puts
puts "Visiting entire tree"
ruby_real_tree.visit_all {|node| puts node.node_name}

# Write a simple grep that will print the lines of a file having any occurrences of a phrase anywhere in that line. You will need to do a simple regular expression match and read lines from a file. (This is surprisingly simple in Ruby.) If you want, include line numbers.
File.new('file.txt').each_with_index {|row, i| puts "#{i} -> #{row}" if row.include? "any_world_in_file"}
