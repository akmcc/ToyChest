require 'colorize'

class Sorter
  def initialize
    @unsorted_list = []
    @sorted_list = []
    
  end

  def my_sort(*things_to_sort)
    if @unsorted_list == []
      @unsorted_list = *things_to_sort
    end

    @sorted_list.unshift(@unsorted_list.max)
    #delete_at is what allows for duplicate values to be sorted correctly
    #rather than deleting all instances of the maximum value
    @unsorted_list.delete_at(@unsorted_list.index(@unsorted_list.max)) 
    
    if @unsorted_list.size == 1
      @sorted_list.unshift(@unsorted_list[0])
    elsif @unsorted_list.size > 1
      my_sort(@unsorted_list)
    end

    @sorted_list 
  end

  def tester(*things_to_sort)
    real_sort= *things_to_sort.sort
    this_sort = my_sort(*things_to_sort)
    if this_sort != real_sort
      puts "Test failed".red
      puts "This is how you sorted it:"
      puts "#{this_sort}"
      puts "It should have sorted this way:"
      puts "#{real_sort}"
    else 
      puts "It passed!".green
      puts "Your list sorted as:"
      puts "#{this_sort}"
    end
  end

end

sort_list = Sorter.new
#sort_list.tester(3, 6, 1, 9, 5, 3, 4)
sort_list.tester("hi", "this", "is", "for", "testing", "a", "sorting", "method")