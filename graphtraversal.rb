require 'minitest/autorun'

class Queue1 < Array
  
  undef_method :unshift

  def initialize
    @queue = []
  end

  def pop
    self.shift
  end
end

class Stack < Array
  undef_method :shift, :unshift
end

class Graph

  def initialize(adjacency_list, type_of_search)
    @adjacency_list = adjacency_list
    if type_of_search == "depth-first"
      @storage = Stack.new
    elsif type_of_search == "breadth-first"
      @storage = Queue1.new
    end
  end

  def find_path(start, finish)
    parents = {}
    @storage << start
      loop do 
        current_node = @storage.pop
        break if current_node == finish
        @adjacency_list[current_node].each do |node|
          unless (parents.include?(node) || @storage.include?(node))
            @storage << node
            parents[node] ||= current_node
          end
        end
      end
    trace_parents(parents, start, finish)
  end

def trace_parents(parents, start, finish)
  puts "beginning trace_parents"
  puts "parents is #{parents}"
  path = []
  current_child = finish
  until current_child == start
    puts "path is #{path}"
    path << current_child
    current_child = parents[current_child]
  end
  path << start
  path.reverse
end

end


##tests##
describe Graph do
  it "should return a path from 1 to 10 " do
   graph = { 1 => [2,4],
    2 => [3,5],
    4 => [1,7],
    7 => [4],
    3 => [2],
    5 => [2,6,8],
    6 => [10,9,5],
    8 => [5],
    10 => [11,6],
    9 => [12,6],
    11 => [10],
    12 => [9]  
    }
   g = Graph.new(graph, "breadth-first")
   g.find_path(1,10).must_equal [1,2,5,6,10]
 end
end