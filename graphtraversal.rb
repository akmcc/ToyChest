require 'minitest/autorun'

class Graph

  def initialize(neighbors)
    @neighbors = neighbors
    @parents = {}
  end

  def find_path(start, finish)
    storage = [start]
    loop do 
      current_node = storage.shift
      break if current_node == finish
      @neighbors[current_node].each do |node|
        unless shortest_parent_known?(node)
          @parents[node] = current_node
          storage << node
        end
      end
    end
    trace_parents(start, finish)
  end

  private

  def shortest_parent_known?(node)
    @parents.include?(node)
  end

  def trace_parents(start, finish)
    path = []
    current_child = finish
    loop do
      path.unshift(current_child)
      break if current_child == start
      current_child = @parents[current_child]
    end
    path
  end
end

##test##
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
   g = Graph.new(graph)
   g.find_path(1,10).must_equal [1,2,5,6,10]
 end
end