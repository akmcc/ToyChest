require "minitest/autorun"

class EasierCalculator
  def initialize
    @stack = []
    @post_fix = []
    @pre_fix = []
  end

  #splits string into array of integers and strings
  def tokenize string
    characters = string.split(" ")
    characters =  characters.map do |char|
      if char.match(/\d/)
        char.to_i
      else
        char = char
      end
    end
  end

  #to facilitate order of operations
  def prescedence_of operator
    case operator
    when "*" then 2
    when "/" then 2
    when "+" then 1
    when "-" then 1
    when "(" then 0  
    end
  end

  #shunting yard algorithm to convert infix to postfix expressions using a stack
  def convert_to_postfix tokens
    tokens.each do |token|
      if token.is_a? Integer
        @post_fix << token
      elsif token == "("
        @stack << token
      elsif token.match(/[\*\/\+\-]/)
        while @stack.last && @stack.last.match(/[\*\/\+\-]/) && (prescedence_of(token) <= prescedence_of(@stack.last))
          @post_fix << @stack.pop
        end
        @stack << token
      elsif token == "("
        @stack << token
      elsif token == ")"
        until @stack.last == "("
          @post_fix << @stack.pop
        end
        @stack.pop #throw away the left paren that was stored in the stack
      end
    end 
    until @stack.empty?
      @post_fix << @stack.pop
    end 
  end
  
  def evaluate post_fix_expression
    stack = []
    while !post_fix_expression.empty? 
      top = post_fix_expression.shift
      if top == "*"
        y, x = stack.pop, stack.pop
        stack.push(x * y)
      elsif top == "/"
        y, x = stack.pop, stack.pop
        stack.push(x/y)
      elsif top == "+"
        y, x = stack.pop, stack.pop
        stack.push(x+y)
      elsif top == "-"
        y, x = stack.pop, stack.pop
        stack.push(x-y)
      else
        stack.push(top)
      end
    end
    stack
  end
  
  def calculate string
    characters = tokenize string
    convert_to_postfix characters
    print "postfix chars before being evaluated are: #{@post_fix}"
    evaluate @post_fix
  end

end

describe EasierCalculator do
  it "can calculate two operators" do
    calc = EasierCalculator.new
    calc.calculate("1 + 2").must_equal(3)
  end
  it "can calculate three operators" do
    calc = EasierCalculator.new
    calc.calculate("15 / 3 + 4").must_equal(9)
  end
  it "can calculate four operators" do
    calc = EasierCalculator.new
    calc.calculate("1 + 2 * 3 + 4").must_equal(11)
  end
end
