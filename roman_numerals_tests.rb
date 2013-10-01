require addition_only_roman_numerals

def tester(arg, expected_answer)
  actual_answer = romanize(arg)
  if actual_answer != expected_answer
    puts "test failed"
    puts actual_answer, "not equal to ", expected_answer
  end
end