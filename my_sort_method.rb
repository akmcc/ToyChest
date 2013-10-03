require 'colorize'

def my_sort
end








def tester(*words)
real_sort=(*words).sort
this_sort = my_sort(*words)

if this_sort != real_sort
  puts "Test failed".red
  puts "This is how you sorted it:"
  puts "#{this_sort}"
  puts "It should have sorted this way:"
  puts "#{real_sort}"
end

end



tester(3, 6, 1, 9, 5, 3, 4)