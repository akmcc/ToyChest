require "minitest/autorun"

class ArithmeticInterpreter
  def initialize
    @operator_stack = []
    @post_fix_expression = []
  end

  #splits string into array of integers and strings
  def tokenize string
    string.split(" ").map do |blob|
      blob.match(/\d/) ? blob.to_i : blob
    end
  end

  #to facilitate order of operations
  def precedence_of operator
    case operator
    when "**" then 3
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
        @post_fix_expression << token
      elsif token == "("
        @operator_stack << token
      elsif is_op?(token)
        while @operator_stack.last && is_op?(@operator_stack.last) && (precedence_of(token) <= precedence_of(@operator_stack.last))
          @post_fix_expression << @operator_stack.pop
        end
        @operator_stack << token
      elsif token == ")"
        until @operator_stack.last == "("
          @post_fix_expression << @operator_stack.pop
        end
        @operator_stack.pop #throw away the left paren that was stored in the stack
      end
    end 
    until @operator_stack.empty?
      @post_fix_expression << @operator_stack.pop
    end 
  end

  def is_op?(token)
    token.match(/[\*\/\+\-]/)
  end
  
  #takes an array of tokens in post-fix notation
  def evaluate post_fix_expression
    stack = []
    while !post_fix_expression.empty? 
      top = post_fix_expression.shift
      if ["*", "**", "+", "-", "/"].include? top
        y, x = stack.pop, stack.pop
        stack.push(x.send(top, y))
      else
        stack.push(top)
      end
    end
    stack.pop
  end
  
  def calculate string
    characters = tokenize string
    convert_to_postfix characters
    evaluate @post_fix_expression
  end
end

#tests
describe ArithmeticInterpreter do
  it "can calculate two operands" do
    calculator = ArithmeticInterpreter.new
    calculator.calculate("1 + 2").must_equal(3)
  end
  it "can calculate three operands" do
    calculator = ArithmeticInterpreter.new
    calculator.calculate("15 / 3 + 4").must_equal(9)
  end
  it "can calculate exponents" do
    calculator = ArithmeticInterpreter.new
    calculator.calculate("2 ** 3").must_equal(8)
  end
  it "can calculate four operands" do
    calculator = ArithmeticInterpreter.new
    calculator.calculate("1 + 2 ** 3 * 4").must_equal(33)
  end
  it "can calculate with parens" do
    calculator = ArithmeticInterpreter.new
    calculator.calculate("( 1 + 2 ) ** 3").must_equal(27)
  end
  it "can calculate with nested parens" do
    calculator = ArithmeticInterpreter.new
    calculator.calculate("( 2 + ( 1 + 2 ) ) * 2").must_equal(10)
  end
end
